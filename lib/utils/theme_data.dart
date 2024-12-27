import 'package:flutter/material.dart';
import 'package:pap_report/constants/colors.dart';

ThemeData themeData(
  BuildContext context,
) {
  return ThemeData(
    primaryColor: ColorConstant.primaryColor,
    useMaterial3: true,
    scaffoldBackgroundColor: ColorConstant.scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light(primary: ColorConstant.primaryColor),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.white,
    ),
  );
}
