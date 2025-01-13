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
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        // Set padding
        padding: WidgetStateProperty.all(padding ?? EdgeInsets.zero),

        // Remove default elevation
        elevation: WidgetStateProperty.all(0),

        // Set background color
        backgroundColor: WidgetStateProperty.all(bgColor ?? appColors.white),

        // Set the shape with a border and radius
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: btnBorderColor ?? appColors.dashCol),
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        // Override minimum size to remove constraints
        minimumSize: WidgetStateProperty.all(Size.zero),

        // Avoid extra padding around the button for smaller tap targets
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Only take up space needed
        children: [
          // If icon exists, add it
          if (icon != null) icon!,
          // Button label
          Padding(
            padding: EdgeInsets.only(
                left: icon != null
                    ? 8.0
                    : 0), // Adjust padding if icon is present
            child: Text(
              btnName,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
