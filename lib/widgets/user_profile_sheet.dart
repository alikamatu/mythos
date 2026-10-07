import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user_profile.dart';
import '../screens/auth_screen.dart';
import '../services/auth_service.dart';
import '../theme/mythos_theme.dart';
import 'greek_ornaments.dart';

class UserProfileSheet extends StatelessWidget {
  final UserProfile? user;

  const UserProfileSheet({super.key, this.user});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => ValueListenableBuilder<UserProfile?>(
        valueListenable: AuthService.instance.currentUser,
        builder: (context, user, _) => UserProfileSheet(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patronSvgMap = {
      'Zeus': 'lightning',
      'Athena': 'owl',
      'Apollo': 'lyre',
      'Poseidon': 'trident',
      'Artemis': 'moon',
      'Hades': 'helm',
    };

    final patronKey = user != null
        ? (patronSvgMap[user!.patronDeity] ?? 'owl')
        : 'temple';

    return Container(
      decoration: BoxDecoration(
        color: MythosColors.modalBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(
          color: MythosColors.borderGoldBright,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: MythosColors.parchmentMuted.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          const GreekMeanderBanner(height: 6, color: Color(0x33D4AF37)),
          const SizedBox(height: 16),

          if (user != null) ...[
            // Avatar
            Container(
              width: 72,
              height: 72,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    MythosColors.goldPrimary.withValues(alpha: 0.35),
                    MythosColors.cardSurface,
                  ],
                ),
                border: Border.all(
                  color: MythosColors.goldPrimary,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: MythosColors.goldPrimary.withValues(alpha: 0.3),
                    blurRadius: 18,
                  ),
                ],
              ),
              child: SvgPicture.string(GreekSvgBank.getSvgByKey(patronKey)),
            ),
            const SizedBox(height: 12),
            Text(
              user!.fullName ?? user!.username,
              style: GoogleFonts.cinzel(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: MythosColors.marbleWhite,
              ),
            ),
            Text(
              user!.mythicTitle,
              style: GoogleFonts.ebGaramond(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: MythosColors.goldLight,
              ),
            ),
            const SizedBox(height: 16),

            // Stats grid
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    Icons.bolt,
                    '${user!.experiencePoints} XP',
                    'Classical Lore',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    Icons.local_fire_department,
                    '${user!.streakDays} Days',
                    'Prometheus Spark',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    Icons.account_balance,
                    user!.patronDeity,
                    'Patron Olympian',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Logout button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: MythosColors.terracotta),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {
                await AuthService.instance.logout();
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Departed the sanctuary. Exploring as guest.'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.logout_rounded, color: MythosColors.terracottaLight, size: 18),
              label: Text(
                'Depart Sanctuary (Sign Out)',
                style: GoogleFonts.cinzel(
                  color: MythosColors.terracottaLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ] else ...[
            // Guest mode
            const Icon(
              Icons.temple_buddhist_outlined,
              size: 50,
              color: MythosColors.goldPrimary,
            ),
            const SizedBox(height: 12),
            Text(
              'Mortal Wanderer',
              style: GoogleFonts.cinzel(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: MythosColors.marbleWhite,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Enscribe thy name at the Temple of Delphi to save reading progress, earn mythic XP, and pledge loyalty to an Olympian deity.',
              style: MythosTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MythosColors.goldPrimary,
                foregroundColor: MythosColors.background,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                );
              },
              child: Text(
                'Begin Initiation (Sign In / Register)',
                style: GoogleFonts.cinzel(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: MythosColors.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MythosColors.borderGoldMuted),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18, color: MythosColors.goldLight),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: MythosColors.marbleWhite,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              color: MythosColors.parchmentMuted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
