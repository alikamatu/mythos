import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/mythos_theme.dart';

class Interactive3DCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool enableAutopilot;
  final Color? glowColor;
  final double maxTiltAngle;

  const Interactive3DCard({
    super.key,
    required this.child,
    this.borderRadius = 22,
    this.onTap,
    this.enableAutopilot = true,
    this.glowColor,
    this.maxTiltAngle = 0.14,
  });

  @override
  State<Interactive3DCard> createState() => _Interactive3DCardState();
}

class _Interactive3DCardState extends State<Interactive3DCard>
    with SingleTickerProviderStateMixin {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  double _lightX = 0.5;
  double _lightY = 0.5;

  late AnimationController _idleController;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    if (widget.enableAutopilot) {
      _idleController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _idleController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details, Size size) {
    final localPos = details.localPosition;
    final normalizedX = (localPos.dx / size.width).clamp(0.0, 1.0);
    final normalizedY = (localPos.dy / size.height).clamp(0.0, 1.0);

    setState(() {
      _rotateY = (normalizedX - 0.5) * widget.maxTiltAngle * 2;
      _rotateX = -(normalizedY - 0.5) * widget.maxTiltAngle * 2;
      _lightX = normalizedX;
      _lightY = normalizedY;
    });
  }

  void _onPanEnd() {
    setState(() {
      _rotateX = 0.0;
      _rotateY = 0.0;
      _lightX = 0.5;
      _lightY = 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? MythosColors.goldPrimary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardSize = Size(
          constraints.maxWidth,
          constraints.maxHeight.isFinite ? constraints.maxHeight : 240,
        );

        return GestureDetector(
          onTap: widget.onTap,
          onPanUpdate: (d) => _onPanUpdate(d, cardSize),
          onPanEnd: (_) => _onPanEnd(),
          onPanCancel: _onPanEnd,
          child: AnimatedBuilder(
            animation: _idleController,
            builder: (context, child) {
              // Add gentle floating breathing when not user-dragged
              final idleAngleX = widget.enableAutopilot && _rotateX == 0
                  ? math.sin(_idleController.value * 2 * math.pi) * 0.03
                  : _rotateX;
              final idleAngleY = widget.enableAutopilot && _rotateY == 0
                  ? math.cos(_idleController.value * 2 * math.pi) * 0.04
                  : _rotateY;

              final matrix = Matrix4.identity()
                ..setEntry(3, 2, 0.0015) // Perspective depth
                ..rotateX(idleAngleX)
                ..rotateY(idleAngleY);

              return Transform(
                transform: matrix,
                alignment: FractionalOffset.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    boxShadow: [
                      // Deep 3D drop shadow
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.65),
                        offset: Offset(-idleAngleY * 40, 16 - idleAngleX * 30),
                        blurRadius: 28,
                        spreadRadius: -4,
                      ),
                      // Ambient Greek mythic glow
                      BoxShadow(
                        color: glow.withValues(alpha: 0.22),
                        offset: Offset.zero,
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Stack(
                      children: [
                        // Card base
                        widget.child,

                        // 3D Specular Light Sheen Highlight
                        Positioned.fill(
                          child: IgnorePointer(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  center: Alignment(
                                    (_lightX - 0.5) * 2,
                                    (_lightY - 0.5) * 2,
                                  ),
                                  radius: 0.85,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.16),
                                    Colors.white.withValues(alpha: 0.04),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 0.35, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Fine Greek Embossed Gold Border
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(widget.borderRadius),
                                border: Border.all(
                                  color: MythosColors.goldPrimary
                                      .withValues(alpha: 0.35),
                                  width: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
