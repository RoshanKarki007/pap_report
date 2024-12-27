import 'package:flutter/material.dart';
import 'package:pap_report/constants/colors.dart';
import 'package:pap_report/utils/custom_toast.dart';

class CustomScaffold extends StatefulWidget {
  final Widget? appBar;
  final Widget body;
  final String? message;
  final Widget? floatingActionButton;
  final Color? appbarColor;
  final Function? onPopInvoked;
  final Color? backgroundColor;
  final Widget? drawer;
  final bool shadowEnabled;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final bool canDoubleBackPop;
  final LinearGradient? gradient;
  final bool hasStatusBarHeight;
  final bool? resizeToAvoidBottomInset;
  const CustomScaffold(
      {super.key,
      this.message,
      this.resizeToAvoidBottomInset,
      this.shadowEnabled = false,
      this.onPopInvoked,
      this.appBar,
      this.floatingActionButton,
      this.appbarColor,
      this.backgroundColor,
      required this.body,
      this.drawer,
      this.floatingActionButtonLocation,
      this.bottomNavigationBar,
      this.canDoubleBackPop = false,
      this.gradient,
      this.hasStatusBarHeight = true})
      : assert(
            appbarColor == null && gradient != null ||
                gradient == null && appbarColor != null ||
                appbarColor == null && gradient == null,
            'Background color and linear gradient cannot be used at the same, either one should be unassigned');

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  void initState() {
    super.initState();
    CustomToast(context);
  }

  DateTime? currentBackPressTime;

  ValueNotifier<bool> canPopNow = ValueNotifier<bool>(false);
  void onPopInvoked(bool didPop) {
    if (!widget.canDoubleBackPop) {
      return;
    }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        (currentBackPressTime != null
            ? now.difference(currentBackPressTime!) >
                const Duration(milliseconds: 5000)
            : false)) {
      currentBackPressTime = now;

      CustomToast.instance
          .showCustomWarningToast(widget.message ?? "Tab again to exit");
      Future.delayed(
        const Duration(milliseconds: 5500),
        () {
          canPopNow.value = false;
        },
      );

      canPopNow.value = true;
    } else {
      if (widget.onPopInvoked != null) {
        widget.onPopInvoked?.call();
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: canPopNow,
        builder: (context, state, child) {
          return PopScope(
              canPop: !widget.canDoubleBackPop ? true : state,
              onPopInvokedWithResult: (didPop, result) => onPopInvoked(didPop),
              child: AnimatedContainer(
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 150),
                  child: Scaffold(
                      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                      body: Stack(children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              gradient: widget.gradient,
                              color: widget.gradient == null
                                  ? widget.appbarColor ??
                                      ColorConstant.scaffoldBackgroundColor
                                  : null),
                        ),
                        Positioned.fill(
                            top: widget.hasStatusBarHeight
                                ? MediaQuery.of(context).padding.top
                                : 0,
                            child: Column(children: [
                              widget.appBar ?? const SizedBox(),
                              Expanded(
                                  child: Container(
                                      color: widget.backgroundColor ??
                                          ColorConstant.scaffoldBackgroundColor,
                                      width: double.infinity,
                                      child: widget.body))
                            ]))
                      ]),
                      floatingActionButton: widget.floatingActionButton,
                      backgroundColor: widget.appbarColor ?? Colors.transparent,
                      drawer: widget.drawer,
                      floatingActionButtonLocation:
                          widget.floatingActionButtonLocation,
                      bottomNavigationBar: widget.bottomNavigationBar,
                      extendBody: true)));
        });
  }
}
