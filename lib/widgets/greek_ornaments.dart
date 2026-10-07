import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/mythos_theme.dart';

class GreekSvgBank {
  // Greek Meander Key Pattern (SVG)
  static const String greekMeander = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 20" fill="none" stroke="#D4AF37" stroke-width="2" stroke-linecap="square">
  <path d="M0 18 H20 V4 H6 V14 H14 V8" />
  <path d="M20 18 H40 V4 H26 V14 H34 V8" />
  <path d="M40 18 H60 V4 H46 V14 H54 V8" />
  <path d="M60 18 H80 V4 H66 V14 H74 V8" />
  <path d="M80 18 H100 V4 H86 V14 H94 V8" />
  <path d="M100 18 H120 V4 H106 V14 H114 V8" />
  <path d="M120 18 H140 V4 H126 V14 H134 V8" />
  <path d="M140 18 H160 V4 H146 V14 H154 V8" />
</svg>
''';

  // Temple Parthenon Façade
  static const String templeFacade = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#D4AF37" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <polygon points="32 6 6 22 58 22" fill="#D4AF37" fill-opacity="0.15" />
  <rect x="4" y="22" width="56" height="5" rx="1" fill="#D4AF37" fill-opacity="0.2" />
  <rect x="8" y="27" width="5" height="28" fill="#D4AF37" fill-opacity="0.15" />
  <rect x="21" y="27" width="5" height="28" fill="#D4AF37" fill-opacity="0.15" />
  <rect x="38" y="27" width="5" height="28" fill="#D4AF37" fill-opacity="0.15" />
  <rect x="51" y="27" width="5" height="28" fill="#D4AF37" fill-opacity="0.15" />
  <rect x="2" y="55" width="60" height="5" rx="1" fill="#D4AF37" fill-opacity="0.3" />
  <circle cx="32" cy="16" r="3" fill="#D4AF37" />
</svg>
''';

  // Lightning of Zeus
  static const String lightning = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
  <path d="M38 4 L14 34 H32 L26 60 L50 28 H32 L38 4Z" fill="url(#goldGrad)" stroke="#FFE898" stroke-width="2" stroke-linejoin="round" />
  <defs>
    <linearGradient id="goldGrad" x1="14" y1="4" x2="50" y2="60" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#FFF4B8" />
      <stop offset="40%" stop-color="#EAB308" />
      <stop offset="100%" stop-color="#A16207" />
    </linearGradient>
  </defs>
</svg>
''';

  // Owl of Athena
  static const String owl = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#D4AF37" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M16 20 C16 12, 24 8, 32 8 C40 8, 48 12, 48 20 C48 38, 44 54, 32 58 C20 54, 16 38, 16 20 Z" fill="#D4AF37" fill-opacity="0.1" />
  <circle cx="25" cy="22" r="6" fill="#0E1626" stroke="#84CC16" stroke-width="2" />
  <circle cx="39" cy="22" r="6" fill="#0E1626" stroke="#84CC16" stroke-width="2" />
  <circle cx="25" cy="22" r="2" fill="#FACC15" />
  <circle cx="39" cy="22" r="2" fill="#FACC15" />
  <polygon points="32 26 29 32 35 32" fill="#D4AF37" />
  <path d="M22 8 L18 4" />
  <path d="M42 8 L46 4" />
  <path d="M20 38 C24 44, 40 44, 44 38" />
</svg>
''';

  // Trident of Poseidon
  static const String trident = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#38BDF8" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
  <line x1="32" y1="8" x2="32" y2="60" stroke="#D4AF37" stroke-width="3" />
  <path d="M20 12 L20 28 C20 36, 44 36, 44 28 L44 12" />
  <polygon points="32 4 29 12 35 12" fill="#38BDF8" />
  <polygon points="20 8 17 15 23 15" fill="#38BDF8" />
  <polygon points="44 8 41 15 47 15" fill="#38BDF8" />
  <path d="M26 44 C29 42, 35 42, 38 44" stroke="#D4AF37" />
</svg>
''';

  // Golden Lyre of Apollo
  static const String lyre = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#D4AF37" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M18 16 C16 32, 20 48, 32 52 C44 48, 48 32, 46 16" fill="#D4AF37" fill-opacity="0.1" />
  <path d="M14 16 C20 18, 44 18, 50 16" stroke-width="3" />
  <line x1="26" y1="18" x2="26" y2="48" stroke="#FDE047" stroke-width="1.5" />
  <line x1="32" y1="18" x2="32" y2="51" stroke="#FDE047" stroke-width="1.5" />
  <line x1="38" y1="18" x2="38" y2="48" stroke="#FDE047" stroke-width="1.5" />
  <circle cx="14" cy="16" r="3" fill="#D4AF37" />
  <circle cx="50" cy="16" r="3" fill="#D4AF37" />
  <path d="M28 54 C30 56, 34 56, 36 54" stroke-width="3" />
</svg>
''';

  // Flame of Prometheus
  static const String flame = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
  <path d="M32 4 C32 4, 46 18, 46 34 C46 48, 38 58, 32 60 C26 58, 18 48, 18 34 C18 24, 26 14, 32 4 Z" fill="url(#fireOuter)" />
  <path d="M32 20 C32 20, 40 30, 40 40 C40 48, 36 54, 32 56 C28 54, 24 48, 24 40 C24 32, 29 26, 32 20 Z" fill="url(#fireInner)" />
  <defs>
    <linearGradient id="fireOuter" x1="32" y1="4" x2="32" y2="60" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#FDE047" />
      <stop offset="45%" stop-color="#EA580C" />
      <stop offset="100%" stop-color="#991B1B" />
    </linearGradient>
    <linearGradient id="fireInner" x1="32" y1="20" x2="32" y2="56" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#FFFFFF" />
      <stop offset="50%" stop-color="#FEF08A" />
      <stop offset="100%" stop-color="#F97316" />
    </linearGradient>
  </defs>
</svg>
''';

  // Sun & Wings of Icarus
  static const String sunWings = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#F59E0B" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <circle cx="32" cy="22" r="10" fill="#FEF3C7" fill-opacity="0.3" stroke="#F59E0B" stroke-width="2.5" />
  <path d="M32 6 L32 2" stroke-width="2" />
  <path d="M44 10 L47 7" stroke-width="2" />
  <path d="M20 10 L17 7" stroke-width="2" />
  <!-- Left Wing -->
  <path d="M24 28 C16 30, 4 38, 6 50 C12 50, 18 44, 26 38" fill="#D4AF37" fill-opacity="0.2" />
  <path d="M22 36 C16 38, 8 46, 12 54 C16 54, 20 48, 26 42" stroke="#D4AF37" />
  <!-- Right Wing -->
  <path d="M40 28 C48 30, 60 38, 58 50 C52 50, 46 44, 38 38" fill="#D4AF37" fill-opacity="0.2" />
  <path d="M42 36 C48 38, 56 46, 52 54 C48 54, 44 48, 38 42" stroke="#D4AF37" />
</svg>
''';

  // Aegis Gorgon Shield
  static const String shield = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#D4AF37" stroke-width="2">
  <circle cx="32" cy="32" r="26" fill="#1E293B" stroke="#D4AF37" stroke-width="3" />
  <circle cx="32" cy="32" r="20" stroke="#84CC16" stroke-width="1.5" stroke-dasharray="3 3" />
  <circle cx="32" cy="32" r="14" fill="#D4AF37" fill-opacity="0.2" />
  <circle cx="28" cy="30" r="2" fill="#FACC15" />
  <circle cx="36" cy="30" r="2" fill="#FACC15" />
  <path d="M28 38 C30 40, 34 40, 36 38" stroke="#FDE047" stroke-width="2" stroke-linecap="round" />
  <path d="M24 24 C26 20, 38 20, 40 24" stroke="#84CC16" stroke-width="2" stroke-linecap="round" />
</svg>
''';

  // Moon of Artemis
  static const String moon = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
  <path d="M38 10 C24 10, 14 20, 14 34 C14 48, 26 58, 40 58 C46 58, 51 56, 54 52 C42 50, 32 40, 32 28 C32 19, 36 13, 38 10 Z" fill="#C7D2FE" stroke="#818CF8" stroke-width="2" stroke-linejoin="round" />
  <circle cx="48" cy="18" r="1.5" fill="#E0E7FF" />
  <circle cx="52" cy="30" r="1" fill="#E0E7FF" />
  <circle cx="22" cy="38" r="1.5" fill="#A5B4FC" fill-opacity="0.6" />
</svg>
''';

  // Helm of Darkness (Hades)
  static const String helm = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#C084FC" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M16 36 C16 22, 22 14, 32 14 C42 14, 48 22, 48 36 L48 46 L38 42 L32 48 L26 42 L16 46 Z" fill="#2E1065" fill-opacity="0.4" />
  <path d="M32 14 L32 6 L36 10 L42 8" stroke="#E9D5FF" />
  <line x1="22" y1="34" x2="28" y2="34" stroke="#F472B6" stroke-width="2.5" />
  <line x1="36" y1="34" x2="42" y2="34" stroke="#F472B6" stroke-width="2.5" />
  <path d="M32 34 L32 42" stroke="#A855F7" />
</svg>
''';

  // Golden Fleece
  static const String ram = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#F59E0B" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
  <path d="M22 24 C14 24, 10 32, 14 40 C18 48, 30 52, 40 48 C48 44, 52 34, 46 26 C42 20, 30 20, 26 26" fill="#FDE68A" fill-opacity="0.25" />
  <circle cx="24" cy="24" r="5" stroke="#D97706" stroke-width="2" />
  <circle cx="42" cy="24" r="5" stroke="#D97706" stroke-width="2" />
  <path d="M28 34 C30 38, 36 38, 38 34" stroke="#F59E0B" stroke-width="2" />
</svg>
''';

  // Laurel Wreath
  static const String laurel = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none" stroke="#84CC16" stroke-width="2" stroke-linecap="round">
  <path d="M18 48 C14 40, 14 26, 22 16 C24 20, 26 24, 24 28" />
  <path d="M16 38 C12 34, 14 28, 20 28" />
  <path d="M20 24 C18 18, 24 14, 28 18" />
  <path d="M46 48 C50 40, 50 26, 42 16 C40 20, 38 24, 40 28" />
  <path d="M48 38 C52 34, 50 28, 44 28" />
  <path d="M44 24 C46 18, 40 14, 36 18" />
  <circle cx="32" cy="50" r="3" fill="#D4AF37" stroke="#D4AF37" />
</svg>
''';

  static String getSvgByKey(String key) {
    switch (key) {
      case 'lightning':
        return lightning;
      case 'owl':
        return owl;
      case 'trident':
        return trident;
      case 'lyre':
        return lyre;
      case 'flame':
        return flame;
      case 'sun_wings':
        return sunWings;
      case 'shield':
        return shield;
      case 'moon':
        return moon;
      case 'helm':
        return helm;
      case 'ram':
        return ram;
      case 'temple':
        return templeFacade;
      case 'laurel':
      default:
        return laurel;
    }
  }
}

/// Greek Ornamental Meander Border Widget
class GreekMeanderBanner extends StatelessWidget {
  final double height;
  final Color? color;

  const GreekMeanderBanner({super.key, this.height = 14, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: SvgPicture.string(
        GreekSvgBank.greekMeander,
        fit: BoxFit.fill,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : const ColorFilter.mode(MythosColors.goldPrimary, BlendMode.srcIn),
      ),
    );
  }
}

/// Classical Greek Corinthian / Ionic Column Motif Divider
class GreekColumnDivider extends StatelessWidget {
  final String? title;

  const GreekColumnDivider({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, MythosColors.goldPrimary],
              ),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.auto_awesome,
                  size: 14,
                  color: MythosColors.goldPrimary,
                ),
                if (title != null) ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      title!.toUpperCase(),
                      style: MythosTypography.labelGold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.auto_awesome,
                    size: 14,
                    color: MythosColors.goldPrimary,
                  ),
                ],
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [MythosColors.goldPrimary, Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
