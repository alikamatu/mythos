import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens, color palette, and styling for Mythos
class MythosColors {
  // Deep Mythic Backgrounds
  static const Color background = Color(0xFF090D16);
  static const Color backgroundElevated = Color(0xFF101626);
  static const Color cardSurface = Color(0xFF151D33);
  static const Color cardSurfaceHighlight = Color(0xFF1D2744);
  static const Color modalBackground = Color(0xFF0C1220);

  // Regal Olympian Gold Accents
  static const Color goldLight = Color(0xFFF9E498);
  static const Color goldPrimary = Color(0xFFD4AF37);
  static const Color goldDark = Color(0xFF9E7814);
  static const Color goldAmber = Color(0xFFE89F2A);

  // Ancient Terracotta & Attic Ceramic Red
  static const Color terracotta = Color(0xFFC85A32);
  static const Color terracottaLight = Color(0xFFE27B55);

  // Aegean Deep Blue & Azure
  static const Color aegeanBlue = Color(0xFF1E3A8A);
  static const Color aegeanLight = Color(0xFF38BDF8);
  static const Color seaGlow = Color(0xFF0EA5E9);

  // Sacred Laurel & Mythic Green
  static const Color laurelGreen = Color(0xFF4D7C0F);
  static const Color laurelGlow = Color(0xFF84CC16);

  // Marble Parchment Tones
  static const Color marbleWhite = Color(0xFFFBF8F2);
  static const Color parchmentText = Color(0xFFEDE4D3);
  static const Color parchmentMuted = Color(0xFFA8B2C8);
  static const Color borderGoldMuted = Color(0x33D4AF37);
  static const Color borderGoldBright = Color(0x80D4AF37);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFFF0B3), Color(0xFFD4AF37), Color(0xFFA57B18)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroCardGradient = LinearGradient(
    colors: [
      Color(0xFF231E3D),
      Color(0xFF17132B),
      Color(0xFF0F1528),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient olympusSkyGradient = LinearGradient(
    colors: [
      Color(0xFF0F172A),
      Color(0xFF090D16),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient terracottaGradient = LinearGradient(
    colors: [Color(0xFFE06F45), Color(0xFF9F3415)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class MythosTypography {
  static TextStyle displayLarge = GoogleFonts.cinzel(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 2.0,
    color: MythosColors.marbleWhite,
  );

  static TextStyle displayMedium = GoogleFonts.cinzel(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: MythosColors.marbleWhite,
  );

  static TextStyle displaySmall = GoogleFonts.cinzel(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: MythosColors.goldLight,
  );

  static TextStyle titleMedium = GoogleFonts.ebGaramond(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: MythosColors.marbleWhite,
  );

  static TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: MythosColors.parchmentText,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: MythosColors.parchmentMuted,
    height: 1.4,
  );

  static TextStyle labelGold = GoogleFonts.cinzel(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
    color: MythosColors.goldPrimary,
  );
}
