import 'package:flutter/material.dart';

class ResultView extends StatefulWidget {
  final int shakeCount;

  const ResultView({super.key, required this.shakeCount});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> with TickerProviderStateMixin {
  late AnimationController _scoreController;
  late AnimationController _celebrationController;
  late Animation<double> _scoreAnimation;
  late Animation<double> _celebrationAnimation;

  @override
  void initState() {
    super.initState();

    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scoreAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.elasticOut),
    );

    _celebrationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _celebrationController, curve: Curves.bounceOut),
    );

    _scoreController.forward();
    _celebrationController.forward();
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  String _getResultMessage() {
    if (widget.shakeCount >= 50) {
      return '🏆 伝説のシェイカー！\nあなたは真のシェイクマスターです！';
    } else if (widget.shakeCount >= 30) {
      return '🥇 素晴らしい！\n完璧なシェイクテクニック！';
    } else if (widget.shakeCount >= 20) {
      return '🥈 いい感じ！\nなかなかのシェイク力です！';
    } else if (widget.shakeCount >= 10) {
      return '🥉 お疲れ様！\nまずまずのシェイクでした！';
    } else {
      return '💪 次はもっと頑張ろう！\nシェイクの練習を重ねて！';
    }
  }

  Color _getResultColor() {
    if (widget.shakeCount >= 50) {
      return const Color(0xFFFFD700); // ゴールド
    } else if (widget.shakeCount >= 30) {
      return const Color(0xFFC0C0C0); // シルバー
    } else if (widget.shakeCount >= 20) {
      return const Color(0xFFCD7F32); // ブロンズ
    } else {
      return const Color(0xFF00BCD4); // デフォルト
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // 結果アイコン
                AnimatedBuilder(
                  animation: _celebrationAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _celebrationAnimation.value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: _getResultColor().withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _getResultColor(),
                            width: 4,
                          ),
                        ),
                        child: Icon(
                          widget.shakeCount >= 30
                              ? Icons.emoji_events
                              : Icons.star,
                          size: 60,
                          color: _getResultColor(),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // 結果メッセージ
                AnimatedBuilder(
                  animation: _celebrationAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _celebrationAnimation.value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: _getResultColor().withValues(alpha: 0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Text(
                          _getResultMessage(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _getResultColor(),
                            height: 1.4,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // スコア表示
                AnimatedBuilder(
                  animation: _scoreAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scoreAnimation.value,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getResultColor(),
                              _getResultColor().withValues(alpha: 0.7),
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _getResultColor().withValues(alpha: 0.4),
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
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${widget.shakeCount}',
                                style: const TextStyle(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                '回',
                                style: TextStyle(
                                  fontSize: 16,
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

                const SizedBox(height: 50),

                // 戻るボタン
                Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00BCD4).withValues(alpha: 0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      },
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home, color: Colors.white, size: 24),
                            SizedBox(width: 10),
                            Text(
                              'タイトルに戻る',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ガチャ券メッセージ
                if (widget.shakeCount >= 10)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFFFD700),
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      '🎁 ガチャガチャ券を獲得しました！',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB8860B),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
