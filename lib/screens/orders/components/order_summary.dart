import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/utils/colors.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 14.0, bottom: 10),
              child: Text(
                "Order Summary",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            OrderDetailsRow(
              title: 'MRP',
              value: "₹13,349.08",
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: OrderDetailsRow(
                title: 'Discount',
                value: "(20 %)",
                valueTextCol: appColors.redCol,
              ),
            ),
            OrderDetailsRow(
              title: 'Delivery',
              value: "FREE",
              valueTextCol: appColors.lightOrange,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: OrderDetailsRow(
                title: 'Tax',
                value: "₹ 149.54",
              ),
            ),
          ],
        ),
        DottedLine(
          dashColor: appColors.lightViolet,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
              Text(
                "₹ 11,139.33",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class OrderDetailsRow extends StatelessWidget {
  const OrderDetailsRow({
    super.key,
    required this.title,
    required this.value,
    this.valueTextCol,
  });
  final String title;
  final String value;
  final Color? valueTextCol;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: appColors.lightViolet,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: valueTextCol ?? appColors.lightViolet,
              ),
        ),
      ],
    );
  }
}
