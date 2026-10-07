import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import '../theme/mythos_theme.dart';
import '../widgets/greek_ornaments.dart';
import '../widgets/interactive_3d_card.dart';
import '../widgets/particle_background.dart';

class AuthScreen extends StatefulWidget {
  final VoidCallback? onAuthSuccess;

  const AuthScreen({super.key, this.onAuthSuccess});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignUp = true;
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Selected Patron Deity
  String _selectedPatron = 'Athena';

  final List<(String, String, Color, String)> _patronDeities = [
    ('Athena', 'Ἀθηνᾶ', MythosColors.laurelGlow, 'owl'),
    ('Zeus', 'Ζεύς', MythosColors.goldPrimary, 'lightning'),
    ('Apollo', 'Ἀπόλλων', MythosColors.goldLight, 'lyre'),
    ('Poseidon', 'Ποσειδῶν', MythosColors.aegeanLight, 'trident'),
    ('Artemis', 'Ἄρτεμις', Color(0xFFA5B4FC), 'moon'),
    ('Hades', 'Ἅιδης', Color(0xFFC084FC), 'helm'),
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_isSignUp) {
        final res = await AuthService.instance.register(
          email: _emailController.text,
          username: _usernameController.text,
          password: _passwordController.text,
          fullName: _fullNameController.text.isNotEmpty
              ? _fullNameController.text
              : null,
          patronDeity: _selectedPatron,
        );

        if (res.isSuccess) {
          if (mounted) {
            _onSuccess();
          }
        } else {
          setState(() {
            _errorMessage = res.errorMessage;
          });
        }
      } else {
        final res = await AuthService.instance.login(
          emailOrUsername: _emailController.text,
          password: _passwordController.text,
        );

        if (res.isSuccess) {
          if (mounted) {
            _onSuccess();
          }
        } else {
          setState(() {
            _errorMessage = res.errorMessage;
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: MythosColors.cardSurfaceHighlight,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(Icons.verified, color: MythosColors.laurelGlow),
            const SizedBox(width: 8),
            Text(
              _isSignUp
                  ? 'Welcome, Initiate of $_selectedPatron!'
                  : 'Welcome back to Mount Olympus!',
              style: const TextStyle(color: MythosColors.marbleWhite),
            ),
          ],
        ),
      ),
    );
    if (widget.onAuthSuccess != null) {
      widget.onAuthSuccess!();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final patronTuple = _patronDeities.firstWhere(
      (p) => p.$1 == _selectedPatron,
      orElse: () => _patronDeities.first,
    );

    return Scaffold(
      body: OlympusParticleBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar with back and title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: MythosColors.parchmentMuted,
                        size: 20,
                      ),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'TEMPLE OF DELPHI',
                          style: GoogleFonts.cinzel(
                            fontSize: 13,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w700,
                            color: MythosColors.goldLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.onAuthSuccess != null) {
                          widget.onAuthSuccess!();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Guest',
                        style: GoogleFonts.cinzel(
                          fontSize: 12,
                          color: MythosColors.goldPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const GreekMeanderBanner(height: 5, color: Color(0x33D4AF37)),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 3D Live Initiate Badge Preview Card
                        Interactive3DCard(
                          borderRadius: 22,
                          glowColor: patronTuple.$3,
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  patronTuple.$3.withValues(alpha: 0.25),
                                  MythosColors.cardSurfaceHighlight,
                                  MythosColors.cardSurface,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withValues(alpha: 0.4),
                                    border: Border.all(
                                      color: patronTuple.$3,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: patronTuple.$3.withValues(alpha: 0.3),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.string(
                                    GreekSvgBank.getSvgByKey(patronTuple.$4),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'OLYMPIAN INITIATE CREST',
                                        style: GoogleFonts.cinzel(
                                          fontSize: 9.5,
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w700,
                                          color: patronTuple.$3,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _usernameController.text.isNotEmpty
                                            ? _usernameController.text
                                            : 'Hero of Hellas',
                                        style: GoogleFonts.cinzel(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: MythosColors.marbleWhite,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Patron Deity: ${patronTuple.$1} (${patronTuple.$2})',
                                        style: GoogleFonts.ebGaramond(
                                          fontSize: 12.5,
                                          fontStyle: FontStyle.italic,
                                          color: MythosColors.parchmentText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Mode Toggle Pill
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: MythosColors.cardSurface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: MythosColors.borderGoldMuted,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isSignUp = true;
                                      _errorMessage = null;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: _isSignUp
                                          ? MythosColors.goldPrimary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Initiation (Sign Up)',
                                      style: GoogleFonts.cinzel(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: _isSignUp
                                            ? MythosColors.background
                                            : MythosColors.parchmentMuted,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isSignUp = false;
                                      _errorMessage = null;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: !_isSignUp
                                          ? MythosColors.goldPrimary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Sanctuary (Sign In)',
                                      style: GoogleFonts.cinzel(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: !_isSignUp
                                            ? MythosColors.background
                                            : MythosColors.parchmentMuted,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Error Banner if present
                        if (_errorMessage != null) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: MythosColors.terracotta.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: MythosColors.terracotta,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: MythosColors.terracottaLight,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(
                                      color: MythosColors.marbleWhite,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],

                        // Patron Deity Selection (Only on Sign Up)
                        if (_isSignUp) ...[
                          Text(
                            'CHOOSE THY PATRON OLYMPIAN',
                            style: MythosTypography.labelGold.copyWith(fontSize: 11),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 64,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _patronDeities.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                final p = _patronDeities[index];
                                final isSelected = _selectedPatron == p.$1;

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedPatron = p.$1;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? p.$3.withValues(alpha: 0.25)
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
                                          width: 26,
                                          height: 26,
                                          child: SvgPicture.string(
                                            GreekSvgBank.getSvgByKey(p.$4),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              p.$1,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: isSelected
                                                    ? MythosColors.marbleWhite
                                                    : MythosColors.parchmentText,
                                              ),
                                            ),
                                            Text(
                                              p.$2,
                                              style: GoogleFonts.ebGaramond(
                                                fontSize: 10,
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
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Email Field
                        _buildTextField(
                          controller: _emailController,
                          label: _isSignUp ? 'Sacred Scroll (Email)' : 'Email or Moniker',
                          hint: _isSignUp ? 'odysseus@ithaca.myth' : 'Moniker or email',
                          icon: Icons.alternate_email_rounded,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Enter your email or moniker';
                            }
                            if (_isSignUp && !val.contains('@')) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),

                        // Username Field (Sign Up Only)
                        if (_isSignUp) ...[
                          _buildTextField(
                            controller: _usernameController,
                            label: 'Heroic Moniker (Username)',
                            hint: 'achilles_swift',
                            icon: Icons.shield_outlined,
                            onChanged: (_) => setState(() {}),
                            validator: (val) {
                              if (val == null || val.trim().length < 3) {
                                return 'Moniker must be at least 3 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // Full Name (Optional)
                          _buildTextField(
                            controller: _fullNameController,
                            label: 'Mortal Name (Optional)',
                            hint: 'Achilles of Phthia',
                            icon: Icons.person_outline_rounded,
                          ),
                          const SizedBox(height: 14),
                        ],

                        // Password Field
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Sacred Passphrase (Password)',
                          hint: '••••••••',
                          icon: Icons.lock_outline_rounded,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: MythosColors.parchmentMuted,
                              size: 18,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (val) {
                            if (val == null || val.length < 6) {
                              return 'Passphrase must have at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // Submit Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MythosColors.goldPrimary,
                            foregroundColor: MythosColors.background,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                            shadowColor: MythosColors.goldPrimary.withValues(alpha: 0.5),
                          ),
                          onPressed: _isLoading ? null : _submit,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: MythosColors.background,
                                  ),
                                )
                              : Text(
                                  _isSignUp
                                      ? 'Enroll in the Pantheon'
                                      : 'Enter Mount Olympus',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                        ),

                        const SizedBox(height: 16),

                        // Switch Mode Text Button
                        Center(
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _isSignUp = !_isSignUp;
                                _errorMessage = null;
                              });
                            },
                            child: Text(
                              _isSignUp
                                  ? 'Already initiated? Enter Sanctuary here'
                                  : 'New to the Classical World? Begin Initiation',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: MythosColors.goldLight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.cinzel(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: MythosColors.parchmentText,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          style: const TextStyle(
            color: MythosColors.marbleWhite,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF5A6680),
              fontSize: 13,
            ),
            filled: true,
            fillColor: MythosColors.cardSurface,
            prefixIcon: Icon(icon, color: MythosColors.goldPrimary, size: 18),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: MythosColors.borderGoldMuted,
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: MythosColors.goldPrimary,
                width: 1.6,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: MythosColors.terracotta,
                width: 1.4,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: MythosColors.terracottaLight,
                width: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
