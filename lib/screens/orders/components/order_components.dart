import 'package:flutter/material.dart';
import 'package:freelancing/constants/image_constants.dart';
import 'package:freelancing/utils/colors.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.textStyle,
  });

  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 252,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SAMSUNG",
                      style: textStyle.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 12,
                      ),
                      child: Text(
                        "SAMSUNG Galaxy F05 - Twilight Blue (64 GB, 4 GB RAM)",
                        style: textStyle.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "₹ 11,139.33",
                      style: textStyle.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: appColors.imgBorderCol,
                    )),
                child: Image.network(
                  height: 80,
                  width: 67,
                  phoneImg,
                ),
              )
            ],
          ),
        ),
        RichText(
            text: TextSpan(
          style: textStyle.bodyLarge?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: appColors.orderDatTextCol,
          ),
          text: "Order date: ",
          children: [
            TextSpan(
                text: "Dec 24,2024",
                style: textStyle.bodyLarge?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: appColors.black,
                )),
          ],
        ))
      ],
    );
  }
}
