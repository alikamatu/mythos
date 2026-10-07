import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../models/user_profile.dart';
import '../services/auth_service.dart';
import '../theme/mythos_theme.dart';
import '../widgets/greek_ornaments.dart';
import '../widgets/interactive_3d_card.dart';
import 'auth_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Audio narration settings
  String _selectedNarrator = 'Nikolaos of Rhodes (Epic Homeric)';
  double _lyreVolume = 0.75;
  bool _autoPlayAudio = true;

  // Reading settings
  double _fontSizeScale = 1.0;
  bool _showAncientDropCaps = true;
  bool _showGreekSubtitles = true;
  bool _classroomMode = false;

  // Backend test status
  String? _backendStatus;
  bool _isCheckingBackend = false;

  final List<(String, String, Color, String)> _patronDeities = const [
    ('Athena', 'Ἀθηνᾶ', MythosColors.laurelGlow, 'owl'),
    ('Zeus', 'Ζεύς', MythosColors.goldPrimary, 'lightning'),
    ('Apollo', 'Ἀπόλλων', MythosColors.goldLight, 'lyre'),
    ('Poseidon', 'Ποσειδῶν', MythosColors.aegeanLight, 'trident'),
    ('Artemis', 'Ἄρτεμις', Color(0xFFA5B4FC), 'moon'),
    ('Hades', 'Ἅιδης', Color(0xFFC084FC), 'helm'),
  ];

  Future<void> _switchPatron(String deity) async {
    final success = await AuthService.instance.updateProfile(patronDeity: deity);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: MythosColors.cardSurfaceHighlight,
          content: Text(
            success
                ? 'Thy soul is now consecrated to $deity!'
                : 'Patron deity updated locally.',
            style: const TextStyle(color: MythosColors.marbleWhite),
          ),
        ),
      );
    }
  }

  Future<void> _pingBackend() async {
    setState(() {
      _isCheckingBackend = true;
      _backendStatus = null;
    });

    try {
      final res = await http
          .get(Uri.parse('${AuthService.instance.baseUrl.replaceAll('/api/v1', '')}/health'))
          .timeout(const Duration(seconds: 4));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final isMongo = data['mongodb_live'] == true;
        setState(() {
          _backendStatus =
              'FastAPI Online • ${isMongo ? "Live MongoDB" : "In-Memory Store"}';
        });
      } else {
        setState(() {
          _backendStatus = 'HTTP ${res.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _backendStatus = 'Backend offline or unreachable';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingBackend = false;
        });
      }
    }
  }

  void _showEditNameDialog(UserProfile user) {
    final controller = TextEditingController(text: user.fullName ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: MythosColors.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: MythosColors.goldPrimary),
        ),
        title: Text(
          'Inscribe Mortal Name',
          style: GoogleFonts.cinzel(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: MythosColors.goldLight,
          ),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: MythosColors.marbleWhite),
          decoration: InputDecoration(
            hintText: 'e.g. Calliope of Athens',
            hintStyle: const TextStyle(color: MythosColors.parchmentMuted),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: MythosColors.borderGoldMuted),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: MythosColors.goldPrimary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: MythosColors.parchmentMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MythosColors.goldPrimary,
              foregroundColor: MythosColors.background,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await AuthService.instance.updateProfile(
                fullName: controller.text.trim(),
              );
            },
            child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  'ΠΡΟΤΙΜΗΣΕΙΣ • SANCTUARY CUSTOMIZATION',
                  style: GoogleFonts.cinzel(
                    fontSize: 11,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    color: MythosColors.goldPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'USER SETTINGS',
                  style: GoogleFonts.cinzel(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: MythosColors.marbleWhite,
                  ),
                ),
                Text(
                  'Patron deity selection, narrative voice, audio & classical codex',
                  style: MythosTypography.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 14),
            const GreekMeanderBanner(height: 5, color: Color(0x33D4AF37)),
            const SizedBox(height: 18),

            // Profile Card (Interactive 3D)
            ValueListenableBuilder<UserProfile?>(
              valueListenable: AuthService.instance.currentUser,
              builder: (context, user, _) {
                final patronSvgMap = {
                  'Zeus': 'lightning',
                  'Athena': 'owl',
                  'Apollo': 'lyre',
                  'Poseidon': 'trident',
                  'Artemis': 'moon',
                  'Hades': 'helm',
                };
                final patronKey = user != null
                    ? (patronSvgMap[user.patronDeity] ?? 'owl')
                    : 'temple';

                return Interactive3DCard(
                  borderRadius: 22,
                  glowColor: MythosColors.goldPrimary,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MythosColors.cardSurfaceHighlight,
                          MythosColors.cardSurface,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.35),
                            border: Border.all(
                              color: MythosColors.goldPrimary,
                              width: 1.8,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: MythosColors.goldPrimary
                                    .withValues(alpha: 0.3),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: SvgPicture.string(
                            GreekSvgBank.getSvgByKey(patronKey),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user != null
                                    ? (user.fullName ?? user.username)
                                    : 'Mortal Initiate (Guest)',
                                style: GoogleFonts.cinzel(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: MythosColors.marbleWhite,
                                ),
                              ),
                              Text(
                                user != null
                                    ? user.mythicTitle
                                    : 'Seeker of Wisdom',
                                style: GoogleFonts.ebGaramond(
                                  fontSize: 12.5,
                                  fontStyle: FontStyle.italic,
                                  color: MythosColors.goldLight,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user != null
                                    ? '${user.experiencePoints} XP • ${user.streakDays}d Spark • ${user.patronDeity}'
                                    : 'Explore without saved progression',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: MythosColors.parchmentMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (user != null)
                          IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: MythosColors.goldPrimary,
                              size: 20,
                            ),
                            onPressed: () => _showEditNameDialog(user),
                          )
                        else
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MythosColors.goldPrimary,
                              foregroundColor: MythosColors.background,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AuthScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Section 1: Patron Olympian Selection
            const GreekColumnDivider(title: 'Patron Olympian Deity'),
            const SizedBox(height: 12),
            ValueListenableBuilder<UserProfile?>(
              valueListenable: AuthService.instance.currentUser,
              builder: (context, user, _) {
                final currentDeity = user?.patronDeity ?? 'Athena';

                return SizedBox(
                  height: 70,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _patronDeities.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final p = _patronDeities[index];
                      final isSelected = currentDeity == p.$1;

                      return InkWell(
                        onTap: () => _switchPatron(p.$1),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? p.$3.withValues(alpha: 0.22)
                                : MythosColors.cardSurface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? p.$3
                                  : MythosColors.borderGoldMuted,
                              width: isSelected ? 1.8 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 28,
                                height: 28,
                                child: SvgPicture.string(
                                  GreekSvgBank.getSvgByKey(p.$4),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.$1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.5,
                                      color: isSelected
                                          ? MythosColors.marbleWhite
                                          : MythosColors.parchmentText,
                                    ),
                                  ),
                                  Text(
                                    p.$2,
                                    style: GoogleFonts.ebGaramond(
                                      fontSize: 10.5,
                                      color: p.$3,
                                      fontStyle: FontStyle.italic,
                                    ),
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
              },
            ),

            const SizedBox(height: 24),

            // Section 2: Narrative Audio Settings
            const GreekColumnDivider(title: 'Audio Narrator & Lyre'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MythosColors.cardSurface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: MythosColors.borderGoldMuted),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    'VOICE OF THE NARRATOR',
                    style: MythosTypography.labelGold.copyWith(fontSize: 10.5),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: _selectedNarrator,
                    dropdownColor: MythosColors.cardSurfaceHighlight,
                    style: const TextStyle(
                      color: MythosColors.marbleWhite,
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: MythosColors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: MythosColors.borderGoldMuted),
                      ),
                    ),
                    items: [
                      'Nikolaos of Rhodes (Epic Homeric)',
                      'Helena Cassander (Delphic Choirs)',
                      'Orion Valerius (Underworld Baritone)',
                      'Cassandra Dorian (Prophetic Verse)',
                    ].map((name) {
                      return DropdownMenuItem(
                        value: name,
                        child: Text(name, overflow: TextOverflow.ellipsis),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedNarrator = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Ancient Lyre & Kithara Ambiance',
                          style: MythosTypography.bodyLarge.copyWith(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(_lyreVolume * 100).toInt()}%',
                        style: const TextStyle(
                          color: MythosColors.goldLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _lyreVolume,
                    activeColor: MythosColors.goldPrimary,
                    inactiveColor: Colors.black.withValues(alpha: 0.5),
                    onChanged: (val) {
                      setState(() {
                        _lyreVolume = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Auto-Play Narration on Epic Open',
                      style: TextStyle(fontSize: 13, color: MythosColors.parchmentText),
                    ),
                    value: _autoPlayAudio,
                    activeThumbColor: MythosColors.goldPrimary,
                    onChanged: (val) {
                      setState(() {
                        _autoPlayAudio = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

            const SizedBox(height: 24),

            // Section 3: Classical Reading & Classroom Mode
            const GreekColumnDivider(title: 'Classics & Classroom Codex'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MythosColors.cardSurface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: MythosColors.borderGoldMuted),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Scripture Font Scale',
                          style: MythosTypography.bodyLarge.copyWith(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(_fontSizeScale * 100).toInt()}%',
                        style: const TextStyle(
                          color: MythosColors.goldLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _fontSizeScale,
                    min: 0.8,
                    max: 1.5,
                    divisions: 7,
                    activeColor: MythosColors.goldPrimary,
                    onChanged: (val) {
                      setState(() {
                        _fontSizeScale = val;
                      });
                    },
                  ),
                  const Divider(color: Color(0x22D4AF37)),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Classical Greek Subtitles & Polytonic Script',
                      style: TextStyle(fontSize: 13, color: MythosColors.parchmentText),
                    ),
                    subtitle: const Text(
                      'Display original ancient Greek alongside English',
                      style: TextStyle(fontSize: 11, color: MythosColors.parchmentMuted),
                    ),
                    value: _showGreekSubtitles,
                    activeThumbColor: MythosColors.goldPrimary,
                    onChanged: (val) {
                      setState(() {
                        _showGreekSubtitles = val;
                      });
                    },
                  ),
                  const Divider(color: Color(0x22D4AF37)),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Ancient Illuminated Drop Caps',
                      style: TextStyle(fontSize: 13, color: MythosColors.parchmentText),
                    ),
                    value: _showAncientDropCaps,
                    activeThumbColor: MythosColors.goldPrimary,
                    onChanged: (val) {
                      setState(() {
                        _showAncientDropCaps = val;
                      });
                    },
                  ),
                  const Divider(color: Color(0x22D4AF37)),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Educator & Classroom Mode',
                      style: TextStyle(fontSize: 13, color: MythosColors.parchmentText),
                    ),
                    subtitle: const Text(
                      'Reveals student study questions, historical context & footnotes',
                      style: TextStyle(fontSize: 11, color: MythosColors.parchmentMuted),
                    ),
                    value: _classroomMode,
                    activeThumbColor: MythosColors.laurelGlow,
                    onChanged: (val) {
                      setState(() {
                        _classroomMode = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

            const SizedBox(height: 24),

            // Section 4: Backend & Database Connection
            const GreekColumnDivider(title: 'Temple API & MongoDB Engine'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MythosColors.cardSurface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: MythosColors.borderGoldMuted),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Mount Olympus FastAPI Gateway',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: MythosColors.marbleWhite,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              AuthService.instance.baseUrl,
                              style: const TextStyle(
                                fontSize: 11,
                                color: MythosColors.parchmentMuted,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: MythosColors.goldPrimary),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                        ),
                        onPressed: _isCheckingBackend ? null : _pingBackend,
                        icon: _isCheckingBackend
                            ? const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(
                                Icons.refresh,
                                size: 14,
                                color: MythosColors.goldLight,
                              ),
                        label: Text(
                          'Ping',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            color: MythosColors.goldLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_backendStatus != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: MythosColors.laurelGreen.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MythosColors.laurelGlow),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 14,
                            color: MythosColors.laurelGlow,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _backendStatus!,
                            style: const TextStyle(
                              fontSize: 11,
                              color: MythosColors.marbleWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Logout / Sign in action
            ValueListenableBuilder<UserProfile?>(
              valueListenable: AuthService.instance.currentUser,
              builder: (context, user, _) {
                if (user != null) {
                  return OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: MythosColors.terracotta),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      await AuthService.instance.logout();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('Departed Mount Olympus sanctuary.'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: MythosColors.terracottaLight,
                    ),
                    label: Text(
                      'Depart Sanctuary (Sign Out)',
                      style: GoogleFonts.cinzel(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: MythosColors.terracottaLight,
                      ),
                    ),
                  );
                } else {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MythosColors.goldPrimary,
                      foregroundColor: MythosColors.background,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AuthScreen()),
                      );
                    },
                    child: Text(
                      'Begin Initiation (Sign In / Register)',
                      style: GoogleFonts.cinzel(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
