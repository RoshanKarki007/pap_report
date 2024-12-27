import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';

class InfoListtile extends StatelessWidget {
  final Color color;
  final String title;
  final String value;
  const InfoListtile({
    super.key,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15.r)),
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 12.h),
        child: Row(children: [
          Container(
            height: 12.r,
            width: 12.r,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2, color: ColorConstant.whiteColor.withAlpha(180))),
          ),
          SizedBox(width: 5.w),
          Expanded(
              child: Text(
            title,
            maxLines: 1,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
                color: ColorConstant.normalGreyText),
          )),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5.h),
              constraints: BoxConstraints(minWidth: 80.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: ColorConstant.whiteColor.withAlpha(180)),
              child: Text(
                value,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    color: ColorConstant.normalGreyText.withAlpha(200)),
              ))
        ]));
  }
}
