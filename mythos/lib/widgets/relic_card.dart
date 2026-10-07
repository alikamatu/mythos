import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';
import 'interactive_3d_card.dart';

class RelicCard extends StatelessWidget {
  final ArtifactRelic relic;
  final VoidCallback onInspect;

  const RelicCard({
    super.key,
    required this.relic,
    required this.onInspect,
  });

  @override
  Widget build(BuildContext context) {
    final svg = GreekSvgBank.getSvgByKey(relic.iconKey);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Interactive3DCard(
        borderRadius: 22,
        glowColor: MythosColors.goldAmber,
        onTap: onInspect,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF2B1D12),
                const Color(0xFF1B1410),
                MythosColors.cardSurface,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.diamond_outlined,
                        size: 15,
                        color: MythosColors.goldAmber,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'MYTHIC RELIC CODEX',
                        style: MythosTypography.labelGold.copyWith(
                          fontSize: 10.5,
                          color: MythosColors.goldAmber,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    relic.greekName,
                    style: GoogleFonts.ebGaramond(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: MythosColors.goldPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  // 3D Relic circular pedestal
                  Container(
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          MythosColors.goldAmber.withValues(alpha: 0.35),
                          const Color(0xFF261505),
                        ],
                      ),
                      border: Border.all(
                        color: MythosColors.goldAmber,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: MythosColors.goldAmber.withValues(alpha: 0.3),
                          blurRadius: 18,
                        ),
                      ],
                    ),
                    child: SvgPicture.string(svg),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          relic.name,
                          style: GoogleFonts.cinzel(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: MythosColors.marbleWhite,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Forged by ${relic.craftsmaster}',
                          style: MythosTypography.bodyMedium.copyWith(
                            fontSize: 11,
                            color: MythosColors.parchmentMuted,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Bearer: ${relic.bearer}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: MythosColors.goldLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                relic.powerDescription,
                style: MythosTypography.bodyMedium.copyWith(
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
