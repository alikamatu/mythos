import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';
import 'interactive_3d_card.dart';

class RealmPortal {
  final String title;
  final String greekSubtitle;
  final String description;
  final String svgKey;
  final Color accentColor;
  final int count;
  final String countLabel;

  const RealmPortal({
    required this.title,
    required this.greekSubtitle,
    required this.description,
    required this.svgKey,
    required this.accentColor,
    required this.count,
    required this.countLabel,
  });
}

class RealmsGrid extends StatelessWidget {
  final ValueChanged<int> onSelectRealm;

  const RealmsGrid({super.key, required this.onSelectRealm});

  static const List<RealmPortal> portals = [
    RealmPortal(
      title: 'Chronicles',
      greekSubtitle: 'Χρονικά',
      description: 'Illustrated 5-min Epics & Heroic Quests',
      svgKey: 'temple',
      accentColor: MythosColors.goldPrimary,
      count: 42,
      countLabel: 'Tales',
    ),
    RealmPortal(
      title: 'Echoes of Olympus',
      greekSubtitle: 'Ἠχώ',
      description: 'Audio Dramas with Ancient Lyre & Voice',
      svgKey: 'lyre',
      accentColor: MythosColors.aegeanLight,
      count: 18,
      countLabel: 'Hymns',
    ),
    RealmPortal(
      title: 'Pantheon & Tree',
      greekSubtitle: 'Πάνθεον',
      description: 'Genealogy, Artifacts & Classical History',
      svgKey: 'shield',
      accentColor: MythosColors.laurelGlow,
      count: 12,
      countLabel: 'Olympians',
    ),
    RealmPortal(
      title: 'Trials of Delphi',
      greekSubtitle: 'Δελφικοί Ἀγῶνες',
      description: 'Mythology Quizzes & Classroom Study',
      svgKey: 'lightning',
      accentColor: MythosColors.goldAmber,
      count: 150,
      countLabel: 'Trials',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: portals.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.92,
        ),
        itemBuilder: (context, index) {
          final portal = portals[index];
          final svg = GreekSvgBank.getSvgByKey(portal.svgKey);

          return Interactive3DCard(
            borderRadius: 20,
            glowColor: portal.accentColor,
            maxTiltAngle: 0.1,
            onTap: () => onSelectRealm(index),
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
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Row: SVG Emblem & Counter pill
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: portal.accentColor.withValues(alpha: 0.15),
                          border: Border.all(
                            color: portal.accentColor.withValues(alpha: 0.5),
                            width: 1.2,
                          ),
                        ),
                        child: SvgPicture.string(svg),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2.5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: portal.accentColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            '${portal.count} ${portal.countLabel}',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: portal.accentColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Middle Titles
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        portal.greekSubtitle,
                        style: GoogleFonts.ebGaramond(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: portal.accentColor,
                        ),
                      ),
                      Text(
                        portal.title,
                        style: GoogleFonts.cinzel(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: MythosColors.marbleWhite,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        portal.description,
                        style: MythosTypography.bodyMedium.copyWith(
                          fontSize: 10.5,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
