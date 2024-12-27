import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomBarChart<T> extends StatelessWidget {
  final List<T> data;
  final ChartValueMapper<T, String> xValueMapper;
  final ChartValueMapper<T, num> yValueMapper;
  final String title;

  const CustomBarChart({
    super.key,
    required this.data,
    required this.xValueMapper,
    required this.yValueMapper,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
                color: ColorConstant.normalGreyText)),
        Divider(color: ColorConstant.textGreyColor),
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<T, String>>[
            BarSeries<T, String>(
              dataSource: data,
              xValueMapper: xValueMapper,
              yValueMapper: yValueMapper,
              pointColorMapper: (datum, index) =>
                  ColorConstant().getGraphColor(index),
              dataLabelMapper: (datum, index) => '',
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ],
    );
  }
}
