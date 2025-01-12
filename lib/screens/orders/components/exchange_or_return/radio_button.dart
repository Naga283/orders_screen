import 'package:flutter/material.dart';
import 'package:freelancing/utils/colors.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    required this.btnName,
    required this.selectedVal,
    this.crossAxisAlignment,
  });

  final String value;
  final String? groupValue;
  final Function(String?)? onChanged;
  final String btnName;
  final String? selectedVal;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Radio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: appColors.lightOrange,
            fillColor: WidgetStatePropertyAll(selectedVal == value
                ? appColors.lightOrange
                : appColors.radioCol)),
        Flexible(
          child: Text(
            btnName,
            style: TextTheme.of(context).bodyMedium?.copyWith(
                  fontSize: 14,
                ),
          ),
        ),
      ],
    );
  }
}
