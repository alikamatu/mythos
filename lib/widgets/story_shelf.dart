import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';
import 'interactive_3d_card.dart';

class StoryShelf extends StatefulWidget {
  final List<MythStory> stories;
  final ValueChanged<MythStory> onSelectStory;
  final ValueChanged<MythStory> onPlayAudio;

  const StoryShelf({
    super.key,
    required this.stories,
    required this.onSelectStory,
    required this.onPlayAudio,
  });

  @override
  State<StoryShelf> createState() => _StoryShelfState();
}

class _StoryShelfState extends State<StoryShelf> {
  String _selectedCategory = 'All Epics';

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedCategory == 'All Epics'
        ? widget.stories
        : widget.stories
            .where((s) => s.category == _selectedCategory)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Chips
        SizedBox(
          height: 38,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: [
              'All Epics',
              'Heroic Quests',
              'Creation Myths',
              'Underworld',
              'The Trojan War'
            ].length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = [
                'All Epics',
                'Heroic Quests',
                'Creation Myths',
                'Underworld',
                'The Trojan War'
              ][index];
              final isSelected = _selectedCategory == cat;

              return ChoiceChip(
                label: Text(cat),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedCategory = cat;
                    });
                  }
                },
                selectedColor: MythosColors.goldPrimary,
                backgroundColor: MythosColors.cardSurface,
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? MythosColors.background
                      : MythosColors.parchmentText,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected
                        ? MythosColors.goldPrimary
                        : MythosColors.borderGoldMuted,
                  ),
                ),
                showCheckmark: false,
              );
            },
          ),
        ),

        const SizedBox(height: 14),

        // List of Story Cards
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: filtered.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final story = filtered[index];
            final svg = GreekSvgBank.getSvgByKey(story.emblemKey);

            return Interactive3DCard(
              borderRadius: 18,
              glowColor: story.highlightColor,
              maxTiltAngle: 0.08,
              onTap: () => widget.onSelectStory(story),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MythosColors.cardSurfaceHighlight,
                      MythosColors.cardSurface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Emblem Circle
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: story.highlightColor.withValues(alpha: 0.15),
                        border: Border.all(
                          color: story.highlightColor.withValues(alpha: 0.6),
                          width: 1.5,
                        ),
                      ),
                      child: SvgPicture.string(svg),
                    ),
                    const SizedBox(width: 14),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  story.greekTitle,
                                  style: GoogleFonts.ebGaramond(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: MythosColors.goldPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer_outlined,
                                    size: 12,
                                    color: MythosColors.parchmentMuted,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    '${story.readMinutes} min',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: MythosColors.parchmentMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            story.title,
                            style: GoogleFonts.cinzel(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: MythosColors.marbleWhite,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            story.excerpt,
                            style: MythosTypography.bodyMedium.copyWith(
                              fontSize: 11.5,
                              height: 1.35,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),

                          // Bottom audio pill & tag
                          Row(
                            children: [
                              InkWell(
                                onTap: () => widget.onPlayAudio(story),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MythosColors.goldPrimary
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: MythosColors.goldPrimary
                                          .withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.headphones,
                                        size: 11,
                                        color: MythosColors.goldLight,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Listen ${story.audioMinutes}m',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: MythosColors.goldLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  story.category,
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    color: MythosColors.parchmentMuted,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
          },
        ),
      ],
    );
  }
}
