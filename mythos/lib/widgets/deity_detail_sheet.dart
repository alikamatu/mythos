import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';

class DeityDetailSheet extends StatelessWidget {
  final Deity deity;
  final VoidCallback onPlayHymn;

  const DeityDetailSheet({
    super.key,
    required this.deity,
    required this.onPlayHymn,
  });

  static void show(
    BuildContext context,
    Deity deity, {
    required VoidCallback onPlayHymn,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DeityDetailSheet(
        deity: deity,
        onPlayHymn: onPlayHymn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final svgString = GreekSvgBank.getSvgByKey(deity.iconKey);

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.45,
      maxChildSize: 0.94,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: MythosColors.modalBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: deity.accentColor.withValues(alpha: 0.35),
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
              // Top drag bar
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
                  color: deity.accentColor.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 10),

              // Scrollable content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  children: [
                    // Large 3D Deity Emblem Avatar
                    Center(
                      child: Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              deity.accentColor.withValues(alpha: 0.35),
                              deity.primaryColor,
                              MythosColors.cardSurface,
                            ],
                          ),
                          border: Border.all(
                            color: deity.accentColor,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: deity.accentColor.withValues(alpha: 0.35),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: SvgPicture.string(svgString),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        deity.greekName,
                        style: GoogleFonts.ebGaramond(
                          fontSize: 22,
                          letterSpacing: 2,
                          color: deity.accentColor,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        deity.name.toUpperCase(),
                        style: GoogleFonts.cinzel(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3,
                          color: MythosColors.marbleWhite,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        deity.title,
                        style: MythosTypography.bodyMedium.copyWith(
                          color: MythosColors.parchmentMuted,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Quick Attributes Table
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
                        children: [
                          _buildDetailRow(
                            'Domain',
                            deity.domain,
                            Icons.public,
                            deity.accentColor,
                          ),
                          const Divider(
                            color: Color(0x22D4AF37),
                            height: 16,
                          ),
                          _buildDetailRow(
                            'Sacred Relics',
                            deity.sacredSymbol,
                            Icons.workspace_premium,
                            deity.accentColor,
                          ),
                          const Divider(
                            color: Color(0x22D4AF37),
                            height: 16,
                          ),
                          _buildDetailRow(
                            'Roman Aspect',
                            deity.romanName,
                            Icons.account_balance,
                            deity.accentColor,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Hymn / Audio Invocation CTA
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deity.accentColor,
                        foregroundColor: MythosColors.background,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 6,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onPlayHymn();
                      },
                      icon: const Icon(Icons.music_note, size: 20),
                      label: Text(
                        'Listen to Homeric Hymn to ${deity.name}',
                        style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),
                    const GreekColumnDivider(title: 'Immortal Quote'),
                    const SizedBox(height: 14),

                    // Classical Quote
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: MythosColors.cardSurfaceHighlight,
                        borderRadius: BorderRadius.circular(14),
                        border: Border(
                          left: BorderSide(
                            color: deity.accentColor,
                            width: 3.5,
                          ),
                        ),
                      ),
                      child: Text(
                        '"${deity.quote}"',
                        style: GoogleFonts.ebGaramond(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: MythosColors.marbleWhite,
                          height: 1.45,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),
                    const GreekColumnDivider(title: 'Classical Lore'),
                    const SizedBox(height: 14),

                    Text(
                      deity.lore,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: MythosColors.parchmentText,
                        height: 1.65,
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

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon,
    Color accent,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: accent),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: MythosTypography.labelGold.copyWith(
              fontSize: 11,
              color: MythosColors.parchmentMuted,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: MythosTypography.bodyLarge.copyWith(
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
