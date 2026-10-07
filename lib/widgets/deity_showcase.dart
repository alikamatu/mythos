import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';
import 'interactive_3d_card.dart';

class DeityShowcase extends StatelessWidget {
  final List<Deity> deities;
  final ValueChanged<Deity> onSelectDeity;

  const DeityShowcase({
    super.key,
    required this.deities,
    required this.onSelectDeity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: deities.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final deity = deities[index];
          final svg = GreekSvgBank.getSvgByKey(deity.iconKey);

          return SizedBox(
            width: 140,
            child: Interactive3DCard(
              borderRadius: 20,
              glowColor: deity.accentColor,
              maxTiltAngle: 0.12,
              onTap: () => onSelectDeity(deity),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      deity.primaryColor,
                      MythosColors.cardSurface,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar Circle with SVG
                    Container(
                      width: 54,
                      height: 54,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.35),
                        border: Border.all(
                          color: deity.accentColor.withValues(alpha: 0.8),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: deity.accentColor.withValues(alpha: 0.35),
                            blurRadius: 14,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: SvgPicture.string(svg),
                    ),
                    const SizedBox(height: 10),

                    // Greek text
                    Text(
                      deity.greekName,
                      style: GoogleFonts.ebGaramond(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: deity.accentColor,
                      ),
                    ),

                    // English Name
                    Text(
                      deity.name.toUpperCase(),
                      style: GoogleFonts.cinzel(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                        color: MythosColors.marbleWhite,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Role / Subtitle
                    Text(
                      deity.title,
                      style: MythosTypography.bodyMedium.copyWith(
                        fontSize: 9.5,
                        color: MythosColors.parchmentMuted,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
