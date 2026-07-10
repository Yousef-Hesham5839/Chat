import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ================= BRAND =================
  static const Color primary = Colors.indigo;
  static const Color primaryAccent = Colors.indigoAccent;
  static const Color primarySoft = Color(0xFFE8EAF6);

  // ================ Icons ==================
  static const Color headerColor = Color(0xFF515B92);

  // ================= ADMIN =================
  static const Color admin = Color(0xFFFFB300);

  // ================= BACKGROUND =================
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;
  static const Color card = Colors.white;
  static const Color inputFill = Color(0xFFF5F5F5);

  // ================= TEXT =================
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.grey;

  static const Color textMuted = Color(0xFF9E9E9E);

  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textSoft = Color(0xFF9E9E9E);
  static const Color textMedium = Color(0xFF757575);

  static const Color white = Colors.white;
  static const Color black = Colors.black87;

  // ================= STATUS =================
  static const Color success = Colors.green;
  static const Color successBg = Color(0xFFE8F5E9);

  static const Color error = Colors.red;
  static const Color errorBg = Color(0xFFFFEBEE);
  static const Color errorText = Color(0xFFD32F2F);

  static const Color online = Colors.green;
  static const Color offline = Colors.grey;

  // ================= INPUT =================
  static const Color border = Color(0xFFE0E0E0);
  static const Color focusedBorder = Colors.indigo;

  // ================= BUTTONS =================
  static const Color buttonPrimary = Colors.indigo;
  static const Color buttonText = Colors.white;
  static const Color adminButtonText = Colors.black;

  // ================= CHAT =================
  static const double messageRadius = 16;

  static const Color messageMe = Colors.indigo;
  static const Color messageOther = Colors.white;


  static const Color shadow = Color(0x0D000000); // 5%
  static const Color shadowStrong = Color(0x1A000000); // 10%

  static const Color iconBackground = Color(0x1A3F51B5); // indigo 10%

  static const Color messageTime = Color(0xB3FFFFFF); // white 70% (للرسائل)
  static const Color avatarHint = Color(0xFFE8EAF6); // بديل primary.withOpacity(0.1)
}