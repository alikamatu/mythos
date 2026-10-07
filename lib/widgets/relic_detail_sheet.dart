import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';

class RelicDetailSheet extends StatelessWidget {
  final ArtifactRelic relic;

  const RelicDetailSheet({super.key, required this.relic});

  static void show(BuildContext context, ArtifactRelic relic) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => RelicDetailSheet(relic: relic),
    );
  }

  @override
  Widget build(BuildContext context) {
    final svg = GreekSvgBank.getSvgByKey(relic.iconKey);

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: MythosColors.modalBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: MythosColors.goldAmber.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 32,
              ),
            ],
          ),
          child: Column(
            children: [
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: GreekMeanderBanner(
                  height: 8,
                  color: Color(0x55E89F2A),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF261505),
                          border: Border.all(
                            color: MythosColors.goldAmber,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: MythosColors.goldAmber
                                  .withValues(alpha: 0.35),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: SvgPicture.string(svg),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: Text(
                        relic.greekName,
                        style: GoogleFonts.ebGaramond(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: MythosColors.goldAmber,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        relic.name.toUpperCase(),
                        style: GoogleFonts.cinzel(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: MythosColors.marbleWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: MythosColors.cardSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: MythosColors.borderGoldMuted,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProp('Artisan', relic.craftsmaster),
                          const Divider(
                            color: Color(0x22D4AF37),
                            height: 16,
                          ),
                          _buildProp('Bearer', relic.bearer),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const GreekColumnDivider(title: 'Relic Power'),
                    const SizedBox(height: 12),
                    Text(
                      relic.powerDescription,
                      style: GoogleFonts.ebGaramond(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: MythosColors.marbleWhite,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const GreekColumnDivider(title: 'Ancient Lore'),
                    const SizedBox(height: 12),
                    Text(
                      relic.mythicLore,
                      style: MythosTypography.bodyLarge.copyWith(
                        fontSize: 13.5,
                        color: MythosColors.parchmentText,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProp(String title, String val) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: MythosTypography.labelGold.copyWith(
              fontSize: 11,
              color: MythosColors.parchmentMuted,
            ),
          ),
        ),
        Expanded(
          child: Text(
            val,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: MythosColors.marbleWhite,
            ),
          ),
        ),
      ],
    );
  }
}
