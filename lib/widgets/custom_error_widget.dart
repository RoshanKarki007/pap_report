import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  const CustomErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: ColorConstant.shadowColor,
              spreadRadius: 0,
              blurRadius: 16.r,
              offset: const Offset(0, 6))
        ],
        borderRadius: BorderRadius.circular(12.r),
        color: ColorConstant.whiteColor,
      ),
      height: 390.h,
      width: double.infinity,
      child: Text(
        error,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: ColorConstant.normalGreyText.withAlpha(200)),
      ),
    );
  }
}
