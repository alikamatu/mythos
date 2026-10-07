import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mythos_data.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import '../widgets/greek_ornaments.dart';
import '../widgets/story_detail_sheet.dart';
import '../widgets/story_shelf.dart';

class ChroniclesScreen extends StatefulWidget {
  final ValueChanged<MythStory> onPlayAudio;

  const ChroniclesScreen({super.key, required this.onPlayAudio});

  @override
  State<ChroniclesScreen> createState() => _ChroniclesScreenState();
}

class _ChroniclesScreenState extends State<ChroniclesScreen> {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openStory(MythStory story) {
    StoryDetailSheet.show(
      context,
      story,
      onStartAudio: () => widget.onPlayAudio(story),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredStories = MythosData.featuredStories.where((s) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return s.title.toLowerCase().contains(q) ||
          s.greekTitle.toLowerCase().contains(q) ||
          s.category.toLowerCase().contains(q) ||
          s.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 90),
          children: [
            // Screen Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ΧΡΟΝΙΚΑ • EPICS OF HELLAS',
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w700,
                      color: MythosColors.goldPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'THE CHRONICLES',
                    style: GoogleFonts.cinzel(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      color: MythosColors.marbleWhite,
                    ),
                  ),
                  Text(
                    'Oral traditions, Homeric hymns & ancient classical epics',
                    style: MythosTypography.bodyMedium,
                  ),
                ],
              ),
            ),

            const GreekMeanderBanner(height: 5, color: Color(0x33D4AF37)),
            const SizedBox(height: 14),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: MythosColors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: MythosColors.borderGoldMuted),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: MythosColors.marbleWhite),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search heroes, titans, or epics...',
                    hintStyle: const TextStyle(
                      color: Color(0xFF5A6680),
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: MythosColors.goldPrimary,
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: MythosColors.parchmentMuted,
                              size: 18,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Reading Progress Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
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
                    color: MythosColors.goldPrimary.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: MythosColors.goldPrimary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.auto_stories_rounded,
                        color: MythosColors.goldLight,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Classical Mastery: 3 of 5 Epics Read',
                            style: GoogleFonts.cinzel(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: MythosColors.marbleWhite,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: 0.6,
                              minHeight: 5,
                              backgroundColor: Colors.black.withValues(alpha: 0.4),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                MythosColors.goldPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Story Shelf
            StoryShelf(
              stories: filteredStories,
              onSelectStory: _openStory,
              onPlayAudio: widget.onPlayAudio,
            ),
          ],
        ),
      ),
    );
  }
}
