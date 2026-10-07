import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/mythos_theme.dart';

class OlympusParticleBackground extends StatefulWidget {
  final Widget child;

  const OlympusParticleBackground({super.key, required this.child});

  @override
  State<OlympusParticleBackground> createState() =>
      _OlympusParticleBackgroundState();
}

class _OlympusParticleBackgroundState extends State<OlympusParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final math.Random _random = math.Random(42);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();

    for (int i = 0; i < 40; i++) {
      _particles.add(
        _Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: 1.0 + _random.nextDouble() * 2.5,
          speed: 0.2 + _random.nextDouble() * 0.8,
          opacity: 0.15 + _random.nextDouble() * 0.45,
          isGold: _random.nextBool(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Deep background gradient
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.3, -0.6),
                radius: 1.4,
                colors: [
                  Color(0xFF161F38),
                  Color(0xFF0F1527),
                  MythosColors.background,
                ],
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
        ),

        // Animated Olympus constellation specks
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ParticlePainter(
                    particles: _particles,
                    progress: _controller.value,
                  ),
                );
              },
            ),
          ),
        ),

        // Child content
        widget.child,
      ],
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final bool isGold;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.isGold,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticlePainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final goldPaint = Paint()..color = MythosColors.goldPrimary;
    final bluePaint = Paint()..color = MythosColors.aegeanLight;

    for (var p in particles) {
      final currentY = (p.y - progress * p.speed) % 1.0;
      final dx = p.x * size.width;
      final dy = currentY * size.height;

      final twinkle = 0.5 + 0.5 * math.sin((progress * 2 * math.pi) + (p.x * 10));
      final currentOpacity = (p.opacity * twinkle).clamp(0.05, 0.8);

      final paint = p.isGold ? goldPaint : bluePaint;
      paint.color = paint.color.withValues(alpha: currentOpacity);

      canvas.drawCircle(Offset(dx, dy), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
