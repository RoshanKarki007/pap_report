import 'package:flutter/material.dart';

class ColorConstant {
  static const Color errorRed = Color(0xFFFF5630);
  static const Color leafGreen = Color(0xff0E7E43);
  static const Color warningToast = Color(0xFFFFBF00);
  static const Color whiteColor = Colors.white;
  static const Color primaryColor = Colors.blueAccent;
  static const Color normalGreyText = Color(0xFF484C52);
  static const Color shadowColor = Color.fromRGBO(158, 158, 158, 0.25);
  static const Color textGreyColor = Color(0xFFC6C6C6);
  static const Color scaffoldBackgroundColor = Color(0xFFF8F9F4);

  static const Color graphColor1 = Color(0xFFD6E2F9);
  static const Color graphColor2 = Color(0xFFE3D4F8);
  static const Color graphColor3 = Color(0xFFF5D2EE);
  static const Color graphColor4 = Color(0xFFFBF9C5);
  static const Color graphColor5 = Color.fromARGB(255, 150, 136, 218);
  static const Color graphColor6 = Color.fromARGB(255, 192, 206, 141);
  static const Color graphColor7 = Color.fromARGB(255, 243, 219, 175);
  static const Color graphColor8 = Color.fromARGB(255, 165, 228, 187);
  static const Color graphColor9 = Color.fromARGB(255, 84, 110, 115);
  static const Color graphColor10 = Color.fromARGB(255, 133, 137, 222);

  static const List<Color> graphColorList = [
    graphColor1,
    graphColor6,
    graphColor3,
    graphColor4,
    graphColor2,
    graphColor7,
    graphColor8,
    graphColor9,
    graphColor10,
    graphColor5,
  ];

  Color darkenColor(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount should be between 0 and 1');
    final factor = 1 - amount;
    return Color.fromARGB(
      color.alpha,
      (color.red * factor).clamp(0, 255).toInt(),
      (color.green * factor).clamp(0, 255).toInt(),
      (color.blue * factor).clamp(0, 255).toInt(),
    );
  }
}
