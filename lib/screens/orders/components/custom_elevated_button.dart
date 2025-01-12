import 'package:flutter/material.dart';
import 'package:freelancing/utils/colors.dart';

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn({
    super.key,
    required this.btnName,
    required this.onTap,
    this.icon,
    this.textStyle,
    this.padding,
    this.btnBorderColor,
    this.bgColor,
  });
  final String btnName;
  final Function()? onTap;
  final Widget? icon;
  final TextStyle? textStyle;
  final Color? btnBorderColor;
  final Color? bgColor;
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: padding,
        elevation: WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(bgColor ?? appColors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: btnBorderColor ?? appColors.dashCol),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      onPressed: onTap,
      label: Text(
        btnName,
        style: textStyle,
      ),
      icon: icon,
    );
  }
}
