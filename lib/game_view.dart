import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutterkaigi_2025_booth_game/router/app_router.dart';

@RoutePage(name: 'GameRoute')
class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> with TickerProviderStateMixin {
  late AnimationController _countdownController;
  late AnimationController _timerController;
  late AnimationController _shakeController;
  late Animation<double> _countdownAnimation;
  late ShakeDetector _shakeDetector;

  int _shakeCount = 0;
  int _countdown = 5;
  final int _gameTime = 10;
  int _remainingTime = 10;
  bool _isGameActive = false;
  bool _isCountdownActive = false;
  bool _isGameFinished = false;

  @override
  void initState() {
    super.initState();

    _countdownController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _timerController = AnimationController(
      duration: Duration(seconds: _gameTime),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 100), // アニメーション時間を短縮
      vsync: this,
    );

    _countdownAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _countdownController, curve: Curves.elasticOut),
    );

    _startCountdown();
  }

  @override
  void dispose() {
    _countdownController.dispose();
    _timerController.dispose();
    _shakeController.dispose();
    _shakeDetector.stopListening();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _isCountdownActive = true;
    });

    _countdownController.forward().then((_) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
        _countdownController.reset();
        _startCountdown();
      } else {
        _startGame();
      }
    });
  }

  void _startGame() {
    setState(() {
      _isCountdownActive = false;
      _isGameActive = true;
    });

    // シェイク検知を開始
    _shakeDetector = ShakeDetector.autoStart(
      shakeThresholdGravity: 1.1,
      shakeSlopTimeMS: 100,
      onPhoneShake: (ShakeEvent event) {
        if (_isGameActive && !_isGameFinished) {
          _shakeCount++;
          setState(() {});
          Future.microtask(() {
            _shakeController.reset();
            _shakeController.forward().then((_) {
              _shakeController.reverse();
            });
          });
        }
      },
    );

    // タイマーを開始
    _timerController.forward().then((_) {
      _endGame();
    });

    // 残り時間の更新
    _updateTimer();
  }

  void _updateTimer() {
    if (_isGameActive && !_isGameFinished) {
      setState(() {
        _remainingTime =
            _gameTime - (_timerController.value * _gameTime).round();
      });

      Future.delayed(const Duration(seconds: 1), () {
        if (_isGameActive && !_isGameFinished) {
          _updateTimer();
        }
      });
    }
  }

  void _endGame() {
    setState(() {
      _isGameActive = false;
      _isGameFinished = true;
    });

    // 結果画面への遷移（即座に遷移）
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.router.replaceAll([ResultRoute(shakeCount: _shakeCount)]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFFE8F4FD), Color(0xFFB8E6FF)],
              stops: [0.0, 0.7, 1.0],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // カウントダウン表示
                  if (_isCountdownActive)
                    AnimatedBuilder(
                      animation: _countdownAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _countdownAnimation.value,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF00BCD4,
                              ).withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF00BCD4),
                                width: 4,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$_countdown',
                                style: const TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00BCD4),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  // ゲーム中表示
                  if (_isGameActive && !_isCountdownActive)
                    Column(
                      children: [
                        // 残り時間
                        Builder(
                          builder: (context) {
                            Color timeColor;
                            if (_remainingTime <= 3) {
                              // 3秒以下は赤色
                              timeColor = Colors.red;
                            } else if (_remainingTime <= 5) {
                              // 5秒以下は黄色
                              timeColor = Colors.orange;
                            } else {
                              // それ以上は青色
                              timeColor = const Color(0xFF00BCD4);
                            }

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                color: timeColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: timeColor, width: 2),
                              ),
                              child: Text(
                                '残り時間: $_remainingTime秒',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: timeColor,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        // シェイクカウンター（アニメーション付き）
                        AnimatedBuilder(
                          animation: _shakeController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_shakeController.value * 0.2),
                              child: Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF00BCD4),
                                      Color(0xFF0097A7),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF00BCD4,
                                      ).withValues(alpha: 0.3),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'シェイク回数',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '$_shakeCount',
                                        style: const TextStyle(
                                          fontSize: 60,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        // 励ましメッセージ
                        const Text(
                          '📱 全力でシェイクしよう！ 📱',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0097A7),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
