import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/mythos_theme.dart';
import '../widgets/greek_ornaments.dart';
import '../widgets/interactive_3d_card.dart';

class Landmark {
  final String id;
  final String name;
  final String greekName;
  final String region;
  final String patronDeity;
  final String mythicSignificance;
  final String historicalLore;
  final IconData icon;
  final Color accentColor;

  const Landmark({
    required this.id,
    required this.name,
    required this.greekName,
    required this.region,
    required this.patronDeity,
    required this.mythicSignificance,
    required this.historicalLore,
    required this.icon,
    required this.accentColor,
  });
}

class HellasMapScreen extends StatefulWidget {
  const HellasMapScreen({super.key});

  @override
  State<HellasMapScreen> createState() => _HellasMapScreenState();
}

class _HellasMapScreenState extends State<HellasMapScreen> {
  Landmark? _selectedLandmark;

  final List<Landmark> _landmarks = const [
    Landmark(
      id: 'olympus',
      name: 'Mount Olympus',
      greekName: 'Ὄλυμπος',
      region: 'Thessaly & Pieria Border',
      patronDeity: 'Zeus & The 12 Olympians',
      mythicSignificance: 'Throne of the Immortals & Mytikas Peak',
      historicalLore:
          'Rising to 2,917 meters above the Aegean Sea, snow-crested Olympus was perceived as the untouchable palace where gods consumed ambrosia and nectar, gazing down upon mortal fate.',
      icon: Icons.terrain_rounded,
      accentColor: MythosColors.goldPrimary,
    ),
    Landmark(
      id: 'delphi',
      name: 'Sanctuary of Delphi',
      greekName: 'Δελφοί',
      region: 'Mount Parnassus, Phocis',
      patronDeity: 'Phoebus Apollo',
      mythicSignificance: 'The Omphalos • Navel of the Ancient World',
      historicalLore:
          'Where Apollo slew the monstrous serpent Python and established his prophetic shrine. Through the Pythia, kings, generals, and wanderers from all Mediterranean poleis sought divine counsel before warfare or voyage.',
      icon: Icons.wb_sunny_rounded,
      accentColor: MythosColors.goldLight,
    ),
    Landmark(
      id: 'athens',
      name: 'The Acropolis of Athens',
      greekName: 'Ἀκρόπολις Ἀθηνῶν',
      region: 'Attica',
      patronDeity: 'Pallas Athena',
      mythicSignificance: 'The Parthenon & The First Sacred Olive Tree',
      historicalLore:
          'The sacred rocky hill where Athena and Poseidon contested for patronage. Crowned by the Parthenon built under Pericles, it became the beacon of classical philosophy, tragedy, and strategic wisdom.',
      icon: Icons.account_balance_rounded,
      accentColor: MythosColors.laurelGlow,
    ),
    Landmark(
      id: 'crete',
      name: 'The Labyrinth of Knossos',
      greekName: 'Κνωσός • Λαβύρινθος',
      region: 'Island of Crete',
      patronDeity: 'Poseidon & King Minos',
      mythicSignificance: 'The Cretan Bull, Daedalus & Minotaur',
      historicalLore:
          'Crafted by the master inventor Daedalus to imprison the half-man, half-bull Minotaur born of Queen Pasiphaë. From here, Daedalus and Icarus fashioned wings of wax and feathers to flee King Minos.',
      icon: Icons.explore_rounded,
      accentColor: MythosColors.goldAmber,
    ),
    Landmark(
      id: 'hades_gate',
      name: 'Cape Taenarum (Gates of Hades)',
      greekName: 'Ταίναρον • Πύλαι Ἅιδου',
      region: 'Mani Peninsula, Peloponnese',
      patronDeity: 'Lord Hades & Persephone',
      mythicSignificance: 'Cavernous Descent to the River Styx & Cerberus',
      historicalLore:
          'The southernmost point of mainland Greece, where deep sea-caves marked the portal to the Underworld. Heracles dragged the three-headed hound Cerberus into daylight here during his twelfth labor.',
      icon: Icons.dark_mode_rounded,
      accentColor: Color(0xFFC084FC),
    ),
    Landmark(
      id: 'troy',
      name: 'The Citadel of Troy (Ilium)',
      greekName: 'Ἴλιον • Τροία',
      region: 'Hellespont, Anatolia',
      patronDeity: 'Apollo & Poseidon',
      mythicSignificance: 'The High Ramparts of Priam & The Wooden Horse',
      historicalLore:
          'Fortified city whose walls were divinely constructed by Apollo and Poseidon. Site of the epic ten-year Trojan War recounted in Homer’s Iliad, fallen through the cunning wooden horse engineered by Odysseus.',
      icon: Icons.castle_rounded,
      accentColor: MythosColors.terracotta,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedLandmark = _landmarks.first;
  }

  @override
  Widget build(BuildContext context) {
    final active = _selectedLandmark ?? _landmarks.first;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ΧΑΡΤΗΣ ΤΗΣ ΕΛΛΑΔΟΣ • SACRED GEOGRAPHY',
                  style: GoogleFonts.cinzel(
                    fontSize: 11,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    color: MythosColors.goldPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'HELLAS MAP & REALMS',
                  style: GoogleFonts.cinzel(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: MythosColors.marbleWhite,
                  ),
                ),
                Text(
                  'Interactive map of ancient Greek sanctuaries, mountains & underworld gates',
                  style: MythosTypography.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 14),
            const GreekMeanderBanner(height: 5, color: Color(0x33D4AF37)),
            const SizedBox(height: 18),

            // Active 3D Landmark Hero Card
            Interactive3DCard(
              borderRadius: 22,
              glowColor: active.accentColor,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      active.accentColor.withValues(alpha: 0.22),
                      MythosColors.cardSurfaceHighlight,
                      MythosColors.cardSurface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: active.accentColor.withValues(alpha: 0.2),
                            border: Border.all(
                              color: active.accentColor,
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            active.icon,
                            color: active.accentColor,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                active.greekName,
                                style: GoogleFonts.ebGaramond(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: active.accentColor,
                                ),
                              ),
                              Text(
                                active.name,
                                style: GoogleFonts.cinzel(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: MythosColors.marbleWhite,
                                ),
                              ),
                              Text(
                                active.region,
                                style: MythosTypography.bodyMedium.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: MythosColors.cardSurface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MythosColors.borderGoldMuted),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.temple_buddhist_outlined,
                            size: 14,
                            color: MythosColors.goldLight,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Guardian: ${active.patronDeity}',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: MythosColors.goldLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      active.mythicSignificance,
                      style: GoogleFonts.ebGaramond(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: MythosColors.marbleWhite,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      active.historicalLore,
                      style: MythosTypography.bodyMedium.copyWith(
                        fontSize: 12,
                        height: 1.45,
                        color: MythosColors.parchmentText,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            const GreekColumnDivider(title: 'Ancient Greek Landmarks'),
            const SizedBox(height: 14),

            // Landmarks Grid
            ..._landmarks.map((l) {
              final isSelected = active.id == l.id;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedLandmark = l;
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? l.accentColor.withValues(alpha: 0.18)
                          : MythosColors.cardSurface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? l.accentColor
                            : MythosColors.borderGoldMuted,
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          l.icon,
                          color: isSelected
                              ? l.accentColor
                              : MythosColors.goldPrimary,
                          size: 22,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? MythosColors.marbleWhite
                                      : MythosColors.parchmentText,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${l.greekName} • ${l.region}',
                                style: GoogleFonts.ebGaramond(
                                  fontSize: 12,
                                  color: l.accentColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: MythosColors.parchmentMuted,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
