import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';

class GradientAppBar extends StatelessWidget {
  final String title;

  const GradientAppBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusbarHeight, bottom: 10.h, left: 30.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [ColorConstant.graphColor3, ColorConstant.graphColor7],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
                color: ColorConstant.normalGreyText)),
      ),
    );
  }
}
