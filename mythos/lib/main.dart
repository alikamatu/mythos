import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/mythos_data.dart';
import 'models/mythos_models.dart';
import 'theme/mythos_theme.dart';
import 'widgets/deity_detail_sheet.dart';
import 'widgets/deity_showcase.dart';
import 'widgets/floating_audio_bar.dart';
import 'widgets/greek_ornaments.dart';
import 'widgets/hero_story_carousel.dart';
import 'widgets/oracle_banner.dart';
import 'widgets/particle_background.dart';
import 'widgets/realms_grid.dart';
import 'widgets/relic_card.dart';
import 'widgets/relic_detail_sheet.dart';
import 'widgets/story_detail_sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'models/user_profile.dart';
import 'screens/auth_screen.dart';
import 'screens/chronicles_screen.dart';
import 'screens/hellas_map_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/trials_screen.dart';
import 'services/auth_service.dart';
import 'widgets/user_profile_sheet.dart';
import 'widgets/story_shelf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.instance.initialize();
  runApp(const MythosApp());
}

class MythosApp extends StatelessWidget {
  const MythosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mythos • Ancient Greek Mythology',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: MythosColors.background,
        primaryColor: MythosColors.goldPrimary,
        colorScheme: ColorScheme.dark(
          primary: MythosColors.goldPrimary,
          secondary: MythosColors.aegeanLight,
        ),
      ),
      home: const MythosHomePage(),
    );
  }
}

class MythosHomePage extends StatefulWidget {
  const MythosHomePage({super.key});

  @override
  State<MythosHomePage> createState() => _MythosHomePageState();
}

class _MythosHomePageState extends State<MythosHomePage> {
  int _currentNavIndex = 0;
  bool _isAudioPlaying = false;
  String _currentAudioTitle = 'Hymn to Apollo • Ancient Lyre & Voice';
  String _currentAudioNarrator = 'Nikolaos of Rhodes • Delphi Choir';
  bool _showAudioBar = true;

  // Active oracle quote index
  int _oracleQuoteIndex = 0;
  final List<DelphiWisdom> _oracleWisdoms = [
    MythosData.dailyWisdom,
    const DelphiWisdom(
      quote: 'Nothing in excess; observe due measure in all things.',
      greekText: 'Μηδὲν ἄγαν • Καιρὸς δ’ ἐπὶ πᾶσιν ἄριστος',
      attribution: 'Solon of Athens & Pittacus',
      temple: 'Temple of Apollo • Delphi',
      contemplation:
          'Harmonia governs both the music of the lyre and the moral strength of heroes.',
    ),
    const DelphiWisdom(
      quote: 'Pledge brings ruin; let truth anchor thy words.',
      greekText: 'Ἐγγύα πάρα δ\' ἄτα',
      attribution: 'Chilon of Sparta',
      temple: 'Inner Sanctum of the Pythia • Delphi',
      contemplation:
          'Before swearing upon the River Styx, know what thou canst sustain.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    AuthService.instance.currentUser.addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    AuthService.instance.currentUser.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    if (mounted) setState(() {});
  }

  void _playStoryAudio(MythStory story) {
    setState(() {
      _currentAudioTitle = '${story.title} • Ancient Recitation';
      _currentAudioNarrator = story.narrator;
      _isAudioPlaying = true;
      _showAudioBar = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MythosColors.cardSurfaceHighlight,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            const Icon(Icons.music_note, color: MythosColors.goldLight),
            const SizedBox(width: 8),
            Text(
              'Echoes of Olympus: "${story.title}" chanting begins.',
              style: const TextStyle(color: MythosColors.marbleWhite),
            ),
          ],
        ),
      ),
    );
  }

  void _playDeityHymn(Deity deity) {
    setState(() {
      _currentAudioTitle = 'Homeric Hymn to ${deity.name}';
      _currentAudioNarrator = 'Delphi Sacred Temple Choir';
      _isAudioPlaying = true;
      _showAudioBar = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MythosColors.cardSurfaceHighlight,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Icon(Icons.auto_awesome, color: deity.accentColor),
            const SizedBox(width: 8),
            Text(
              'Invoking Homeric Hymn to ${deity.name}...',
              style: const TextStyle(color: MythosColors.marbleWhite),
            ),
          ],
        ),
      ),
    );
  }

  void _openStory(MythStory story) {
    StoryDetailSheet.show(
      context,
      story,
      onStartAudio: () => _playStoryAudio(story),
    );
  }

  void _openDeity(Deity deity) {
    DeityDetailSheet.show(
      context,
      deity,
      onPlayHymn: () => _playDeityHymn(deity),
    );
  }

  void _openRelic(ArtifactRelic relic) {
    RelicDetailSheet.show(context, relic);
  }

  void _cycleOracle() {
    setState(() {
      _oracleQuoteIndex = (_oracleQuoteIndex + 1) % _oracleWisdoms.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final featuredStory = MythosData.featuredStories.first;
    final currentWisdom = _oracleWisdoms[_oracleQuoteIndex];
    final featuredRelic = MythosData.mythicRelics.first;

    return Scaffold(
      body: OlympusParticleBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top Classical Greek Header Bar
              _buildTopAppBar(),

              // Greek Meander Accent Line
              const GreekMeanderBanner(
                height: 5,
                color: Color(0x33D4AF37),
              ),

              // Multi-Screen Body Content
              Expanded(
                child: IndexedStack(
                  index: _currentNavIndex,
                  children: [
                    _buildSanctuaryTab(featuredStory, currentWisdom, featuredRelic),
                    ChroniclesScreen(onPlayAudio: _playStoryAudio),
                    const TrialsScreen(),
                    const HellasMapScreen(),
                    const SettingsScreen(),
                  ],
                ),
              ),

              // Mini Floating Audio Player
              if (_showAudioBar)
                FloatingAudioBar(
                  title: _currentAudioTitle,
                  narrator: _currentAudioNarrator,
                  isPlaying: _isAudioPlaying,
                  onTogglePlay: () {
                    setState(() {
                      _isAudioPlaying = !_isAudioPlaying;
                    });
                  },
                  onClose: () {
                    setState(() {
                      _showAudioBar = false;
                      _isAudioPlaying = false;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSanctuaryTab(
    MythStory featuredStory,
    DelphiWisdom currentWisdom,
    ArtifactRelic featuredRelic,
  ) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: HeroStoryCard(
                        story: featuredStory,
                        onTap: () => _openStory(featuredStory),
                        onPlayAudio: () => _playStoryAudio(featuredStory),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Section 2: Pythian Oracle Wisdom of Delphi
                    OracleBanner(
                      wisdom: currentWisdom,
                      onConsultOracle: _cycleOracle,
                    ),

                    const SizedBox(height: 24),

                    // Section 3: Four Realm Portals (Read, Audio, History, Quiz)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GreekColumnDivider(title: 'Realms of Antiquity'),
                    ),
                    const SizedBox(height: 14),
                    RealmsGrid(
                      onSelectRealm: (realmIndex) {
                        if (realmIndex == 0) {
                          // Chronicles
                          setState(() => _currentNavIndex = 1);
                        } else if (realmIndex == 1) {
                          // Audio Drama
                          _playStoryAudio(MythosData.featuredStories[2]);
                        } else if (realmIndex == 2) {
                          // Hellas Map & Sacred Sites
                          setState(() => _currentNavIndex = 3);
                        } else {
                          // Trials / Quiz Arena
                          setState(() => _currentNavIndex = 2);
                        }
                      },
                    ),

                    const SizedBox(height: 26),

                    // Section 4: The Olympian Pantheon (Deities)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ΔΩΔΕΚΑΘΕΟΝ',
                                  style: GoogleFonts.ebGaramond(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: MythosColors.goldPrimary,
                                  ),
                                ),
                                Text(
                                  'THE OLYMPIANS',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                    color: MythosColors.marbleWhite,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                _openDeity(MythosData.olympianDeities.first),
                            child: Text(
                              'View All 12',
                              style: GoogleFonts.cinzel(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: MythosColors.goldLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    DeityShowcase(
                      deities: MythosData.olympianDeities,
                      onSelectDeity: _openDeity,
                    ),

                    const SizedBox(height: 24),

                    // Section 5: Classical Artifact of the Day
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GreekColumnDivider(title: 'Relic Codex'),
                    ),
                    const SizedBox(height: 14),
                    RelicCard(
                      relic: featuredRelic,
                      onInspect: () => _openRelic(featuredRelic),
                    ),

                    const SizedBox(height: 26),

                    // Section 6: Tales in Verse & Fire (Story Shelf)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ΜΥΘΙΚΟΙ ΜΥΘΟΙ',
                                  style: GoogleFonts.ebGaramond(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: MythosColors.goldPrimary,
                                  ),
                                ),
                                Text(
                                  'TALES IN VERSE & FIRE',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                    color: MythosColors.marbleWhite,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: MythosColors.goldPrimary
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '5 Epics',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: MythosColors.goldLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    StoryShelf(
                      stories: MythosData.featuredStories,
                      onSelectStory: _openStory,
                      onPlayAudio: _playStoryAudio,
                    ),

                    const SizedBox(height: 28),

                    // Classical Bottom Colophon
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GreekMeanderBanner(
                        height: 6,
                        color: MythosColors.goldPrimary.withValues(alpha: 0.25),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: Text(
                        'MYTHOS • PRESERVING THE CLASSICAL WORLD',
                        style: GoogleFonts.cinzel(
                          fontSize: 10,
                          letterSpacing: 2,
                          color: MythosColors.parchmentMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                );
  }

  Widget _buildTopAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: MythosColors.background,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Greek Subtitle
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MythosColors.goldPrimary,
                      width: 1.5,
                    ),
                    gradient: RadialGradient(
                      colors: [
                        MythosColors.goldPrimary.withValues(alpha: 0.3),
                        MythosColors.cardSurface,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Μ',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MythosColors.goldLight,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'MYTHOS',
                        style: GoogleFonts.cinzel(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.5,
                          color: MythosColors.marbleWhite,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'CLASSICS & ORAL TRADITION',
                        style: GoogleFonts.cinzel(
                          fontSize: 7.5,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                          color: MythosColors.goldPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Right Actions: Prometheus Spark Streak & Search
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: MythosColors.cardSurfaceHighlight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: MythosColors.goldPrimary.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 15,
                      color: Color(0xFFF97316),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '7d Spark',
                      style: GoogleFonts.cinzel(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: MythosColors.goldLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.search_rounded,
                  color: MythosColors.marbleWhite,
                  size: 22,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Searching Greek myths, epics & heroes...'),
                    ),
                  );
                },
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () {
                  if (AuthService.instance.isAuthenticated) {
                    UserProfileSheet.show(context);
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AuthScreen(),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MythosColors.goldPrimary,
                      width: 1.4,
                    ),
                    color: MythosColors.cardSurfaceHighlight,
                  ),
                  child: ValueListenableBuilder<UserProfile?>(
                    valueListenable: AuthService.instance.currentUser,
                    builder: (context, user, _) {
                      if (user != null) {
                        final patronKey = {
                          'Zeus': 'lightning',
                          'Athena': 'owl',
                          'Apollo': 'lyre',
                          'Poseidon': 'trident',
                          'Artemis': 'moon',
                          'Hades': 'helm',
                        }[user.patronDeity] ?? 'temple';
                        return SizedBox(
                          width: 22,
                          height: 22,
                          child: SvgPicture.string(
                            GreekSvgBank.getSvgByKey(patronKey),
                          ),
                        );
                      }
                      return const Icon(
                        Icons.account_circle_outlined,
                        size: 22,
                        color: MythosColors.goldLight,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final navItems = [
      (Icons.account_balance_outlined, Icons.account_balance, 'Sanctuary'),
      (Icons.menu_book_outlined, Icons.menu_book, 'Chronicles'),
      (Icons.flash_on_outlined, Icons.flash_on, 'Trials'),
      (Icons.map_outlined, Icons.map, 'Hellas Map'),
      (Icons.settings_outlined, Icons.settings, 'Settings'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: MythosColors.cardSurface,
        border: const Border(
          top: BorderSide(
            color: MythosColors.borderGoldMuted,
            width: 1.2,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isSelected = _currentNavIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentNavIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 4,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? item.$2 : item.$1,
                          size: 20,
                          color: isSelected
                              ? MythosColors.goldPrimary
                              : MythosColors.parchmentMuted,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.$3,
                          style: GoogleFonts.cinzel(
                            fontSize: 9,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? MythosColors.goldLight
                                : MythosColors.parchmentMuted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Container(
                          width: 14,
                          height: 2,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? MythosColors.goldPrimary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
