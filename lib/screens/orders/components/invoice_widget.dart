import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/constants/image_constants.dart';
import 'package:freelancing/screens/orders/bloc/order_state/order_state.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/screens/orders/components/custom_elevated_button.dart';
import 'package:freelancing/utils/colors.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({
    super.key,
    required this.textStyle,
    required this.stepperBloc,
    required this.leftText,
  });

  final TextTheme textStyle;
  final StepperBloc stepperBloc;
  final String leftText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  leftText,
                  style: textStyle.bodyLarge?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: appColors.lightOrange,
                    decoration: TextDecoration.underline,
                    decorationColor: appColors.lightOrange,
                  ),
                ),
                CustomElevatedBtn(
                  btnName: 'Invoice',
                  onTap: () {},
                  textStyle: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: appColors.lightViolet,
                  ),
                  icon: Image.asset(doumentText),
                )
              ],
            ),
          ),
          DottedLine(
            dashLength: 8,
            dashGapLength: 5,
            dashColor: appColors.dashCol,
          ),
        ],
      ),
    );
  }
}
