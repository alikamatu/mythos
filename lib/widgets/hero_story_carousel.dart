import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';
import 'interactive_3d_card.dart';

class HeroStoryCard extends StatelessWidget {
  final MythStory story;
  final VoidCallback onTap;
  final VoidCallback onPlayAudio;

  const HeroStoryCard({
    super.key,
    required this.story,
    required this.onTap,
    required this.onPlayAudio,
  });

  @override
  Widget build(BuildContext context) {
    final svgString = GreekSvgBank.getSvgByKey(story.emblemKey);

    return Interactive3DCard(
      borderRadius: 24,
      onTap: onTap,
      glowColor: story.highlightColor,
      child: Container(
        height: 290,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF231E3D),
              const Color(0xFF16152B),
              MythosColors.backgroundElevated,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Greek Meander Top Accent Border
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: GreekMeanderBanner(
                height: 7,
                color: Color(0x33D4AF37),
              ),
            ),

            // Large Watermarked SVG Motif in Background
            Positioned(
              right: -25,
              bottom: -25,
              width: 200,
              height: 200,
              child: Opacity(
                opacity: 0.08,
                child: SvgPicture.string(
                  svgString,
                  colorFilter: const ColorFilter.mode(
                    MythosColors.goldLight,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            // Card Foreground Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Row: Epoch & 3D Interactive Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: MythosColors.goldGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: MythosColors.goldPrimary
                                  .withValues(alpha: 0.4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.bolt,
                              size: 13,
                              color: MythosColors.background,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'MYTHIC EPOCH',
                              style: GoogleFonts.cinzel(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                                color: MythosColors.background,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: MythosColors.borderGoldMuted,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 12,
                              color: MythosColors.goldLight,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${story.readMinutes}m read',
                              style: const TextStyle(
                                fontSize: 11,
                                color: MythosColors.parchmentText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Middle Content: Greek Title & Main Headline
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  story.highlightColor.withValues(alpha: 0.35),
                                  MythosColors.cardSurface,
                                ],
                              ),
                              border: Border.all(
                                color: story.highlightColor,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: story.highlightColor
                                      .withValues(alpha: 0.3),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: SvgPicture.string(svgString),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  story.greekTitle,
                                  style: GoogleFonts.ebGaramond(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    color: MythosColors.goldPrimary,
                                  ),
                                ),
                                Text(
                                  story.title,
                                  style: GoogleFonts.cinzel(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: MythosColors.marbleWhite,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        story.subtitle,
                        style: MythosTypography.bodyMedium.copyWith(
                          fontSize: 12,
                          color: MythosColors.parchmentMuted,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // Bottom Action Strip: Audio preview & Read button
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: MythosColors.goldPrimary,
                              width: 1.2,
                            ),
                            backgroundColor:
                                MythosColors.cardSurfaceHighlight,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: onPlayAudio,
                          icon: const Icon(
                            Icons.play_circle_fill_rounded,
                            color: MythosColors.goldLight,
                            size: 18,
                          ),
                          label: Text(
                            'Hear Lyre (${story.audioMinutes}m)',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: MythosColors.goldLight,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MythosColors.goldPrimary,
                          foregroundColor: MythosColors.background,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 11,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                          shadowColor: MythosColors.goldPrimary
                              .withValues(alpha: 0.5),
                        ),
                        onPressed: onTap,
                        child: Row(
                          children: [
                            Text(
                              'Begin',
                              style: GoogleFonts.cinzel(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: MythosColors.background,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 11,
                              color: MythosColors.background,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
