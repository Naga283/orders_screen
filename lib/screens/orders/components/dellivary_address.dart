import 'package:flutter/material.dart';
import 'package:freelancing/screens/orders/components/custom_elevated_button.dart';
import 'package:freelancing/utils/colors.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({
    super.key,
    required this.textStyle,
  });

  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delivery",
              style: textStyle.bodyLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomElevatedBtn(
              btnName: 'Change',
              onTap: () {},
              textStyle: textStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: appColors.lightViolet,
              ),
              padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 12, vertical: 6.4)),
            )
          ],
        ),
        Text(
          "Address",
          style: textStyle.bodySmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: appColors.lightViolet,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          "847 Jewess Bridge Apt. 174,London, UK 474-769-3919,    Mob:-7766449345",
          style: textStyle.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            height: 1.5,
            // fontSize: 12,
            color: appColors.lightViolet,
          ),
        )
      ],
    );
  }
}
