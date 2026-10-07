import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mythos_theme.dart';

class FloatingAudioBar extends StatefulWidget {
  final String title;
  final String narrator;
  final bool isPlaying;
  final VoidCallback onTogglePlay;
  final VoidCallback onClose;

  const FloatingAudioBar({
    super.key,
    required this.title,
    required this.narrator,
    required this.isPlaying,
    required this.onTogglePlay,
    required this.onClose,
  });

  @override
  State<FloatingAudioBar> createState() => _FloatingAudioBarState();
}

class _FloatingAudioBarState extends State<FloatingAudioBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    if (widget.isPlaying) {
      _waveController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant FloatingAudioBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_waveController.isAnimating) {
      _waveController.repeat();
    } else if (!widget.isPlaying && _waveController.isAnimating) {
      _waveController.stop();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: MythosColors.cardSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: MythosColors.goldPrimary,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: MythosColors.goldPrimary.withValues(alpha: 0.25),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.7),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        children: [
          // Play/Pause circle button
          InkWell(
            onTap: widget.onTogglePlay,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                gradient: MythosColors.goldGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: MythosColors.goldPrimary.withValues(alpha: 0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Icon(
                widget.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: MythosColors.background,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Track Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'ECHOES OF OLYMPUS',
                      style: GoogleFonts.cinzel(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: MythosColors.goldLight,
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Animated Equalizer sound wave bars
                    if (widget.isPlaying)
                      AnimatedBuilder(
                        animation: _waveController,
                        builder: (context, _) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(4, (i) {
                              final height = 4.0 +
                                  8.0 *
                                      (0.5 +
                                          0.5 *
                                              math.sin(
                                                (_waveController.value *
                                                        2 *
                                                        math.pi) +
                                                    (i * 1.5),
                                              ));
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                width: 2.2,
                                height: height,
                                decoration: BoxDecoration(
                                  color: MythosColors.goldLight,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  widget.title,
                  style: GoogleFonts.cinzel(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: MythosColors.marbleWhite,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.narrator,
                  style: MythosTypography.bodyMedium.copyWith(
                    fontSize: 10.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Close button
          IconButton(
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: MythosColors.parchmentMuted,
            ),
            onPressed: widget.onClose,
          ),
        ],
      ),
    );
  }
}
