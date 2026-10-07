import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';

class OracleBanner extends StatelessWidget {
  final DelphiWisdom wisdom;
  final VoidCallback onConsultOracle;

  const OracleBanner({
    super.key,
    required this.wisdom,
    required this.onConsultOracle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: MythosColors.cardSurface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: MythosColors.borderGoldBright,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: MythosColors.goldPrimary.withValues(alpha: 0.12),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              // Top meander pattern
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GreekMeanderBanner(
                  height: 6,
                  color: Color(0x33D4AF37),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.wb_sunny_outlined,
                                size: 16,
                                color: MythosColors.goldPrimary,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'ORACLE OF DELPHI',
                                  style: MythosTypography.labelGold.copyWith(
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: onConsultOracle,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: MythosColors.goldPrimary
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.refresh,
                                  size: 13,
                                  color: MythosColors.goldLight,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Contemplate',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: MythosColors.goldLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Greek text
                    Text(
                      wisdom.greekText,
                      style: GoogleFonts.ebGaramond(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.2,
                        color: MythosColors.goldPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Main Quote
                    Text(
                      '"${wisdom.quote}"',
                      style: GoogleFonts.cinzel(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                        color: MythosColors.marbleWhite,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Contemplation & Location
                    Text(
                      wisdom.contemplation,
                      style: MythosTypography.bodyMedium.copyWith(
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: MythosColors.goldLight,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            wisdom.temple,
                            style: MythosTypography.bodyMedium.copyWith(
                              fontSize: 11,
                              color: MythosColors.goldLight,
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
      ),
    );
  }
}
