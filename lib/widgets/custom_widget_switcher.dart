import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';
import 'package:pap_report/widgets/custom_dropdown_button.dart';

class CustomWidgetSwitcher extends StatefulWidget {
  final Widget front;
  final Widget back;
  final String title;
  const CustomWidgetSwitcher(
      {super.key,
      required this.front,
      required this.back,
      required this.title});

  @override
  State<CustomWidgetSwitcher> createState() => _CustomWidgetSwitcherState();
}

class _CustomWidgetSwitcherState extends State<CustomWidgetSwitcher> {
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          boxShadow: [
            BoxShadow(
                color: ColorConstant.shadowColor,
                spreadRadius: 0,
                blurRadius: 16.r,
                offset: const Offset(0, 6))
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Row(children: [
              Expanded(
                  child: Text(widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          color: ColorConstant.normalGreyText))),
              CustomDropdownButton(
                items: ['Transaction list', 'Transaction Chart'],
                onChanged: (p0) {
                  if (p0 == 0) {
                    isFlipped = false;
                  } else {
                    isFlipped = true;
                  }
                  setState(() {});
                },
              )
            ]),
            Divider(color: ColorConstant.textGreyColor),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final flipAnimation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(animation);

                return AnimatedBuilder(
                  animation: flipAnimation,
                  child: child,
                  builder: (context, child) {
                    final angle = flipAnimation.value * 3.14159;

                    final isFrontVisible =
                        isFlipped ? angle > 3.14159 / 2 : angle <= 3.14159 / 2;

                    final effectiveAngle = isFrontVisible
                        ? angle
                        : (angle > 3.14159 / 2 ? 3.14159 - angle : angle);

                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(effectiveAngle),
                      alignment: Alignment.center,
                      child: !isFrontVisible
                          ? widget.front
                          : Transform.flip(
                              flipX: true,
                              child: widget.back,
                            ),
                    );
                  },
                );
              },
              child: isFlipped ? widget.back : widget.front,
            ),
          ],
        ),
      ),
    );
  }
}
