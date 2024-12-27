import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomPieChart<T> extends StatelessWidget {
  final List<T> data;
  final ChartValueMapper<T, String> xValueMapper;
  final ChartValueMapper<T, num> yValueMapper;
  final String title;

  const CustomPieChart(
      {super.key,
      required this.data,
      required this.xValueMapper,
      required this.yValueMapper,
      required this.title});

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
        SfCircularChart(
            legend: Legend(
                alignment: ChartAlignment.far,
                isVisible: true,
                position: LegendPosition.left,
                orientation: LegendItemOrientation.vertical,
                overflowMode: LegendItemOverflowMode.scroll),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CircularSeries>[
              PieSeries<T, String>(
                  pointColorMapper: (datum, index) =>
                      ColorConstant().getGraphColor(index),
                  dataLabelMapper: (datum, index) => '',
                  dataSource: data,
                  xValueMapper: xValueMapper,
                  yValueMapper: yValueMapper,
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ]),
      ],
    );
  }
}
