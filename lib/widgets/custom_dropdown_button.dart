import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pap_report/constants/colors.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> items;
  final void Function(num?)? onChanged;

  const CustomDropdownButton({
    super.key,
    this.items = const [],
    this.onChanged,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final GlobalKey dropdownKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  String? selectedValue;

  void openDropdown() {
    if (_overlayEntry != null) return;

    final renderBox =
        dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    final size = renderBox?.size;
    final offset = renderBox?.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: (offset?.dx ?? 0) - 150.w,
        top: (offset?.dy ?? 0) + (size?.height ?? 0),
        width: 200.w,
        child: TapRegion(
          onTapOutside: (val) => closeDropdown(),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12.r),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: ColorConstant.textGreyColor,
                height: 0,
                thickness: 1,
              ),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (context, index) => ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                title: Text(
                  widget.items[index],
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                      color: ColorConstant.normalGreyText),
                ),
                onTap: () {
                  selectedValue = widget.items[index];
                  widget.onChanged?.call(index);
                  closeDropdown();
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: dropdownKey,
      icon: Icon(
        Icons.more_horiz_rounded,
        size: 18.r,
      ),
      onPressed: openDropdown,
    );
  }
}
