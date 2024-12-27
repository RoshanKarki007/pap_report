import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';

class CustomExpansionTileCard extends StatefulWidget {
  const CustomExpansionTileCard({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.elevation = 2.0,
    this.initialElevation = 0.0,
    this.initiallyExpanded = false,
    this.initialPadding = EdgeInsets.zero,
    this.finalPadding = const EdgeInsets.only(bottom: 6.0),
    this.contentPadding,
    this.baseColor,
    this.expandedColor,
    this.expandedTextColor,
    this.duration = const Duration(milliseconds: 200),
    this.elevationCurve = Curves.easeOut,
    this.heightFactorCurve = Curves.easeIn,
    this.turnsCurve = Curves.easeIn,
    this.colorCurve = Curves.easeIn,
    this.paddingCurve = Curves.easeIn,
    this.isThreeLine = false,
    this.animateTrailing = false,
    this.boxShadow,
    this.shrinkTextColor,
  });

  final bool isThreeLine;
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Widget? trailing;
  final bool animateTrailing;
  final BorderRadiusGeometry borderRadius;
  final double elevation;
  final double initialElevation;
  final bool initiallyExpanded;
  final EdgeInsetsGeometry initialPadding;
  final EdgeInsetsGeometry finalPadding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? baseColor;
  final Color? expandedColor;
  final Color? expandedTextColor;
  final Color? shrinkTextColor;
  final Duration duration;
  final Curve elevationCurve;
  final Curve heightFactorCurve;
  final Curve turnsCurve;
  final Curve colorCurve;
  final Curve paddingCurve;
  final List<BoxShadow>? boxShadow;

  @override
  CustomExpansionTileCardState createState() => CustomExpansionTileCardState();
}

class CustomExpansionTileCardState extends State<CustomExpansionTileCard>
    with SingleTickerProviderStateMixin {
  late Animatable<double> _heightFactorTween;

  late AnimationController _controller;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _heightFactorTween = CurveTween(curve: widget.heightFactorCurve);

    _controller = AnimationController(duration: widget.duration, vsync: this);
    _heightFactor = _controller.drive(_heightFactorTween);

    _isExpanded = PageStorage.of(context).readState(context) as bool? ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setExpansion(bool shouldBeExpanded) {
    if (shouldBeExpanded != _isExpanded) {
      setState(() {
        _isExpanded = shouldBeExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((void value) {
            if (!mounted) return;
            setState(() {});
          });
        }
        PageStorage.of(context).writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged!(_isExpanded);
      }
    }
  }

  void expand() {
    _setExpansion(true);
  }

  void collapse() {
    _setExpansion(false);
  }

  void toggleExpansion() {
    _setExpansion(!_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: widget.boxShadow),
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Stack(
          children: [
            Container(
              padding: widget.contentPadding,
              decoration: BoxDecoration(color: ColorConstant.whiteColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.title,
                  ClipRect(
                      child: Container(
                          decoration:
                              BoxDecoration(color: ColorConstant.whiteColor),
                          child: Align(
                              heightFactor: _heightFactor.value,
                              child: child))),
                  if (widget.children.isNotEmpty)
                    AnimatedCrossFade(
                      crossFadeState: !_isExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 150),
                      firstChild: Container(
                          padding: EdgeInsets.only(
                              right: 22.w, top: 10.h, bottom: 10.h),
                          alignment: Alignment.centerRight,
                          child: Text('Show more',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: ColorConstant.normalGreyText
                                      .withAlpha(200)))),
                      secondChild: Container(
                          padding: EdgeInsets.only(
                              right: 22.w, top: 10.h, bottom: 10.h),
                          alignment: Alignment.centerRight,
                          child: Text('Show less',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: ColorConstant.normalGreyText
                                      .withAlpha(200)))),
                    ),
                ],
              ),
            ),
            Positioned.fill(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: widget.borderRadius)),
              onPressed: toggleExpansion,
              child: const SizedBox.shrink(),
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}
