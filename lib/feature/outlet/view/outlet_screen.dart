import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';
import 'package:pap_report/feature/outlet/bloc/outlet_bloc.dart';
import 'package:pap_report/feature/outlet/model/outlet_model.dart';
import 'package:pap_report/utils/ui_state_handler/ui_state_handler.dart';
import 'package:pap_report/widgets/custom_error_widget.dart';
import 'package:pap_report/widgets/custom_loading_widget.dart';
import 'package:pap_report/widgets/custom_pie_chart.dart';

class OutletScreen extends StatelessWidget {
  const OutletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UiStateHandler<OutletModel, OutletBloc>(
      emptyWidget: Text('No data'),
      errorWidget: (error) => CustomErrorWidget(error: error.message),
      loadingWidget: CustomLoadingWidget(),
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
