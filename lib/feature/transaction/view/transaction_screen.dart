import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';
import 'package:pap_report/feature/outlet/model/outlet_model.dart';
import 'package:pap_report/feature/transaction/bloc/transaction_bloc.dart';
import 'package:pap_report/feature/transaction/model/transaction_model.dart';
import 'package:pap_report/utils/ui_state_handler/ui_state_handler.dart';
import 'package:pap_report/widgets/custom_donut_chart.dart';
import 'package:pap_report/widgets/custom_expansion_tile.dart';
import 'package:pap_report/widgets/custom_widget_switcher.dart';
import 'package:shimmer/shimmer.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UiStateHandler<TransactionModel, TransactionBloc>(
      emptyWidget: Text('No data'),
      errorWidget: (error) => Text(error.message),
      loadingWidget: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.white,
            ),
            height: 390.h,
            width: double.infinity,
          ),
        ),
      ),
      onSuccess: (onSuccess) => Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CustomWidgetSwitcher(
            title: 'Transactions',
            front: CustomExpansionTileCard(
              borderRadius: BorderRadius.circular(0.r),
              trailing: SizedBox.shrink(),
              title: Container(
                padding: EdgeInsets.only(
                    left: 22.w, right: 22.w, top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(color: ColorConstant.whiteColor),
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InfoListtile(
                          color: getGraphColor(index),
                          title: onSuccess.data!.items[index].type!.toString(),
                          value: onSuccess.data!.items[index].value!
                              .toInt()
                              .toString(),
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemCount: min(onSuccess.data!.items.length, 4)),
              ),
              children: [
                if (onSuccess.data!.items.length > 4)
                  Padding(
                    padding:
                        EdgeInsets.only(left: 22.w, right: 22.w, bottom: 10.h),
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var newIndex = 4 + index;
                          return InfoListtile(
                            color: getGraphColor(newIndex),
                            title: onSuccess.data!.items[newIndex].type!
                                .toString(),
                            value: onSuccess.data!.items[newIndex].value!
                                .toInt()
                                .toString(),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8.h),
                        itemCount: onSuccess.data!.items.length - 4),
                  )
              ],
            ),
            back: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorConstant.shadowColor,
                        spreadRadius: 0,
                        blurRadius: 16.r,
                        offset: const Offset(0, 6))
                  ],
                  color: ColorConstant.whiteColor,
                  borderRadius: BorderRadius.circular(16.r)),
              child: CustomSemiDonutChart<Item>(
                selectedBuilder: (p0) {
                  return Container(
                    constraints: BoxConstraints(minWidth: 100.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color:
                          ColorConstant.normalGreyText.withValues(alpha: 233),
                    ),
                    child: Text.rich(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        TextSpan(children: [
                          TextSpan(text: p0.type.toString()),
                          TextSpan(text: '\n'),
                          TextSpan(
                              text: p0.value?.toInt().toString(),
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                  color: ColorConstant.normalGreyText
                                      .withAlpha(200))),
                        ]),
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            color:
                                ColorConstant.normalGreyText.withAlpha(200))),
                  );
                },
                data: onSuccess.data!.items,
                xValueMapper: (Item data, num value) => data.type ?? '',
                yValueMapper: (Item data, num value) => data.value,
                title: 'Sales done by the user in a graphical view',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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

getGraphColor(int index) {
  var colorList = ColorConstant.graphColorList;
  int listLength = colorList.length;
  if (index < listLength) {
    return colorList[index];
  } else {
    int wrappedIndex = index % listLength;
    Color baseColor = colorList[wrappedIndex];

    return ColorConstant().darkenColor(baseColor);
  }
}
