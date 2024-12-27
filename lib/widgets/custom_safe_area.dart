import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pap_report/utils/theme_data.dart';

class CustomSafeArea extends StatelessWidget {
  final Widget child;
  const CustomSafeArea({
    super.key,
    required this.child,
  });

  @override

  Widget build(BuildContext context) {
    if (kIsWeb) {
      return child;
    }
    return Theme(
      data: themeData(context).copyWith(),
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Platform.isIOS
              ? Brightness.light
              : Platform.isAndroid
                  ? Brightness.dark
                  : null,
          statusBarIconBrightness: Platform.isIOS
              ? Brightness.light
              : Platform.isAndroid
                  ? Brightness.dark
                  : null,
          systemNavigationBarIconBrightness: Platform.isIOS
              ? Brightness.light
              : Platform.isAndroid
                  ? Brightness.dark
                  : null,
          systemNavigationBarColor: Platform.isIOS
              ? null
              : Platform.isAndroid
                  ? Colors.white
                  : null,
        ),
        child: child,
      ),
    );
  }
}
