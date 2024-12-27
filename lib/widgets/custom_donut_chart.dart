import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';
import 'package:pap_report/feature/transaction/view/transaction_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomSemiDonutChart<T> extends StatefulWidget {
  final List<T> data;
  final ChartValueMapper<T, String> xValueMapper;
  final ChartValueMapper<T, num> yValueMapper;
  final String title;

  final Widget Function(T)? selectedBuilder;

  const CustomSemiDonutChart({
    super.key,
    required this.data,
    required this.xValueMapper,
    required this.yValueMapper,
    required this.title,
    this.selectedBuilder,
  });

  @override
  State<CustomSemiDonutChart<T>> createState() =>
      _CustomSemiDonutChartState<T>();
}

class _CustomSemiDonutChartState<T> extends State<CustomSemiDonutChart<T>> {
  late ValueNotifier<T> selectedValue;

  @override
  void initState() {
    selectedValue = ValueNotifier<T>(widget.data.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
                color: ColorConstant.normalGreyText.withAlpha(220)),
          ),
          SizedBox(height: 48.h),
          Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.6,
            child: Stack(
              children: [
                SfCircularChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries<T, String>>[
                    DoughnutSeries<T, String>(
                      onPointTap: (pointInteractionDetails) {
                        selectedValue.value =
                            widget.data[pointInteractionDetails.pointIndex!];
                      },
                      animationDuration: 0,
                      dataSource: widget.data,
                      xValueMapper: widget.xValueMapper,
                      yValueMapper: widget.yValueMapper,
                      pointColorMapper: (datum, index) => getGraphColor(index),
                      dataLabelMapper: (datum, index) => '',
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      radius: '90%', // Adjust the size of the donut
                      innerRadius: '60%', // Control the inner circle radius
                      startAngle: 270, // Start angle for the semi-donut
                      endAngle: 90, // End angle for the semi-donut
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  top: -50,
                  child: Center(
                    child: AnimatedBuilder(
                        animation: selectedValue,
                        builder: (context, child) {
                          return widget.selectedBuilder
                                  ?.call(selectedValue.value) ??
                              SizedBox.shrink();
                        }),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
