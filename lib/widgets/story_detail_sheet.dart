import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';

class StoryDetailSheet extends StatefulWidget {
  final MythStory story;
  final VoidCallback onStartAudio;

  const StoryDetailSheet({
    super.key,
    required this.story,
    required this.onStartAudio,
  });

  static void show(
    BuildContext context,
    MythStory story, {
    required VoidCallback onStartAudio,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StoryDetailSheet(
        story: story,
        onStartAudio: onStartAudio,
      ),
    );
  }

  @override
  State<StoryDetailSheet> createState() => _StoryDetailSheetState();
}

class _StoryDetailSheetState extends State<StoryDetailSheet> {
  int? _selectedQuizIndex;
  bool _quizSubmitted = false;
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final story = widget.story;
    final svgString = GreekSvgBank.getSvgByKey(story.emblemKey);

    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: MythosColors.modalBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: MythosColors.goldPrimary.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 32,
                spreadRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              // Top drag pill & Greek meander
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MythosColors.parchmentMuted.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GreekMeanderBanner(
                  height: 8,
                  color: MythosColors.goldPrimary.withValues(alpha: 0.35),
                ),
              ),
              const SizedBox(height: 8),

              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  children: [
                    // Top header row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mythic Emblem badge with 3D gradient
                        Container(
                          width: 64,
                          height: 64,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                story.highlightColor.withValues(alpha: 0.35),
                                MythosColors.cardSurface,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: story.highlightColor.withValues(alpha: 0.6),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: story.highlightColor.withValues(alpha: 0.25),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: SvgPicture.string(svgString),
                        ),
                        const SizedBox(width: 16),

                        // Title & Greek translation
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story.greekTitle,
                                style: GoogleFonts.ebGaramond(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: MythosColors.goldPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                story.title,
                                style: GoogleFonts.cinzel(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: MythosColors.marbleWhite,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                story.epoch,
                                style: MythosTypography.bodyMedium.copyWith(
                                  fontSize: 12,
                                  color: MythosColors.parchmentMuted,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bookmark action
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isBookmarked = !_isBookmarked;
                            });
                          },
                          icon: Icon(
                            _isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: _isBookmarked
                                ? MythosColors.goldPrimary
                                : MythosColors.parchmentMuted,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Quick metadata chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildBadge(Icons.auto_stories, '${story.readMinutes} min read'),
                        _buildBadge(Icons.headphones, '${story.audioMinutes} min audio drama'),
                        _buildBadge(Icons.record_voice_over, story.narrator),
                        _buildBadge(Icons.military_tech_outlined, story.category),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Listen Audio Drama CTA Banner
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MythosColors.goldPrimary.withValues(alpha: 0.15),
                            MythosColors.cardSurface,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: MythosColors.goldPrimary.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: MythosColors.goldPrimary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: MythosColors.goldPrimary.withValues(alpha: 0.4),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: MythosColors.background,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Echoes of Olympus Audio Drama',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: MythosColors.goldLight,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Narrated by ${story.narrator} with authentic ancient lyre & kithara',
                                  style: MythosTypography.bodyMedium.copyWith(
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MythosColors.goldPrimary,
                              foregroundColor: MythosColors.background,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              widget.onStartAudio();
                            },
                            child: const Text(
                              'Play',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    const GreekColumnDivider(title: 'Epic Text'),
                    const SizedBox(height: 16),

                    // Excerpt quote callout
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: MythosColors.cardSurfaceHighlight,
                        borderRadius: BorderRadius.circular(14),
                        border: const Border(
                          left: BorderSide(
                            color: MythosColors.goldPrimary,
                            width: 3.5,
                          ),
                        ),
                      ),
                      child: Text(
                        story.excerpt,
                        style: GoogleFonts.ebGaramond(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: MythosColors.parchmentText,
                          height: 1.45,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Full Story Paragraphs with Classical drop-cap styling
                    Text(
                      story.fullText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        height: 1.7,
                        color: MythosColors.parchmentText,
                      ),
                    ),

                    const SizedBox(height: 24),
                    const GreekColumnDivider(title: 'Delphic Trial'),
                    const SizedBox(height: 16),

                    // Interactive Comprehension Quiz
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MythosColors.cardSurface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: MythosColors.borderGoldMuted,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.help_outline_rounded,
                                color: MythosColors.goldLight,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Challenge Your Classical Lore (+50 XP)',
                                style: GoogleFonts.cinzel(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: MythosColors.goldLight,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            story.trialQuestion,
                            style: GoogleFonts.ebGaramond(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: MythosColors.marbleWhite,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Option buttons
                          ...List.generate(story.trialOptions.length, (index) {
                            final optionText = story.trialOptions[index];
                            final isSelected = _selectedQuizIndex == index;
                            final isCorrect =
                                index == story.correctOptionIndex;

                            Color btnColor = MythosColors.cardSurfaceHighlight;
                            Color borderColor = MythosColors.borderGoldMuted;

                            if (_quizSubmitted) {
                              if (isCorrect) {
                                btnColor = MythosColors.laurelGreen
                                    .withValues(alpha: 0.3);
                                borderColor = MythosColors.laurelGlow;
                              } else if (isSelected) {
                                btnColor = Colors.red.withValues(alpha: 0.25);
                                borderColor = Colors.redAccent;
                              }
                            } else if (isSelected) {
                              btnColor = MythosColors.goldPrimary
                                  .withValues(alpha: 0.2);
                              borderColor = MythosColors.goldPrimary;
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: _quizSubmitted
                                    ? null
                                    : () {
                                        setState(() {
                                          _selectedQuizIndex = index;
                                        });
                                      },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: btnColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: borderColor,
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${String.fromCharCode(65 + index)}. ',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MythosColors.goldPrimary,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          optionText,
                                          style: MythosTypography.bodyLarge
                                              .copyWith(
                                            fontSize: 13,
                                            color: MythosColors.marbleWhite,
                                          ),
                                        ),
                                      ),
                                      if (_quizSubmitted && isCorrect)
                                        const Icon(
                                          Icons.check_circle,
                                          color: MythosColors.laurelGlow,
                                          size: 18,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),

                          const SizedBox(height: 10),
                          if (!_quizSubmitted)
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MythosColors.goldPrimary,
                                  foregroundColor: MythosColors.background,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: _selectedQuizIndex == null
                                    ? null
                                    : () {
                                        setState(() {
                                          _quizSubmitted = true;
                                        });
                                      },
                                child: const Text(
                                  'Confirm Answer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _selectedQuizIndex ==
                                        story.correctOptionIndex
                                    ? MythosColors.laurelGreen
                                        .withValues(alpha: 0.2)
                                    : MythosColors.terracotta
                                        .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _selectedQuizIndex ==
                                            story.correctOptionIndex
                                        ? Icons.verified
                                        : Icons.info_outline,
                                    color: _selectedQuizIndex ==
                                            story.correctOptionIndex
                                        ? MythosColors.laurelGlow
                                        : MythosColors.terracottaLight,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _selectedQuizIndex ==
                                              story.correctOptionIndex
                                          ? 'Accurate! Lord Apollo smiles upon your wisdom.'
                                          : 'Incorrect. Re-read the counseling of Daedalus.',
                                      style: MythosTypography.bodyMedium
                                          .copyWith(
                                        color: MythosColors.parchmentText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: MythosColors.cardSurfaceHighlight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: MythosColors.borderGoldMuted,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: MythosColors.goldPrimary),
          const SizedBox(width: 5),
          Text(
            text,
            style: MythosTypography.bodyMedium.copyWith(
              fontSize: 11,
              color: MythosColors.parchmentText,
            ),
          ),
        ],
      ),
    );
  }
}
