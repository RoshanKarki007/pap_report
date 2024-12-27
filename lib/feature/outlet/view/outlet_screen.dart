import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';
import 'package:pap_report/feature/outlet/bloc/outlet_bloc.dart';
import 'package:pap_report/feature/outlet/model/outlet_model.dart';
import 'package:pap_report/utils/ui_state_handler/ui_state_handler.dart';
import 'package:pap_report/widgets/custom_pie_chart.dart';
import 'package:shimmer/shimmer.dart';

class OutletScreen extends StatelessWidget {
  const OutletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UiStateHandler<OutletModel, OutletBloc>(
      emptyWidget: Text('No data'),
      errorWidget: (error) => Text(error.message),
      loadingWidget: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white,
          ),
          height: 350.h,
          width: double.infinity,
        ),
      ),
      onSuccess: (onSuccess) => Column(
        children: [
          Container(
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
            child: CustomPieChart<Item>(
              data: onSuccess.data!.items,
              xValueMapper: (Item data, num value) => data.type ?? '',
              yValueMapper: (Item data, num value) => data.value,
              title: 'Outler chart',
            ),
          ),
        ],
      ),
    );
  }
}
