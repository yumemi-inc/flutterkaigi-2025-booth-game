import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutterkaigi_2025_booth_game/router/app_router.dart';

@RoutePage(name: 'TitleRoute')
class TitleView extends StatefulWidget {
  const TitleView({super.key});

  @override
  State<TitleView> createState() => _TitleViewState();
}

enum GameMode {
  light(30, 'ライト'),
  normal(40, 'ノーマル'),
  hard(50, 'ハード');

  const GameMode(this.shakeCount, this.label);
  final int shakeCount;
  final String label;
}

class _TitleViewState extends State<TitleView> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _zoomController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _zoomAnimation;
  GameMode _selectedMode = GameMode.normal;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _zoomController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _zoomAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeInOut),
    );

    _scaleController.forward();
    _zoomController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _zoomController.dispose();
    super.dispose();
  }

  void _showModeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'モード選択',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0097A7),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: GameMode.values.map((mode) {
              final isSelected = _selectedMode == mode;
              return ListTile(
                leading: isSelected
                    ? const Icon(Icons.check_circle, color: Color(0xFF00BCD4))
                    : const Icon(Icons.circle_outlined),
                title: Text(
                  mode.label,
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? const Color(0xFF0097A7)
                        : Colors.black87,
                  ),
                ),
                subtitle: Text('${mode.shakeCount}回'),
                selected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedMode = mode;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
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
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // タイトル
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
                        ),
                        borderRadius: BorderRadius.circular(20),
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
                      child: const Text(
                        '📱 シェイクゲーム 📱',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 4,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 100),

                    // スタートボタン（ズームアニメーション付き）
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        _scaleAnimation,
                        _zoomAnimation,
                      ]),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value * _zoomAnimation.value,
                          child: GestureDetector(
                            onTap: () {
                              context.router.push(
                                GameRoute(
                                  requiredShakeCount: _selectedMode.shakeCount,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00BCD4),
                                    Color(0xFF0097A7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF00BCD4,
                                    ).withValues(alpha: 0.4),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'ゲームスタート！',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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

                    // 遊び方の説明
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF00BCD4,
                            ).withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Column(
                        children: [
                          Text(
                            '🎮 遊び方 🎮',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0097A7),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            '決められた回数を超えると、\nガチャガチャの券がもらえるぞ！',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0097A7),
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'また、指定した回数を超えると\n特殊な演出があるかも？',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0097A7),
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '頑張ってシェイクしよう！',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0097A7),
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // モード選択ボタン（右下に配置）
              Positioned(
                bottom: 20,
                right: 20,
                child: TextButton(
                  onPressed: () => _showModeSelectionDialog(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.95),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: const Color(0xFF00BCD4).withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '${_selectedMode.label} (${_selectedMode.shakeCount}回)',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0097A7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
