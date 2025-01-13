import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/constants/image_constants.dart';
import 'package:freelancing/screens/orders/bloc/order_event/order_event.dart';
import 'package:freelancing/screens/orders/bloc/order_state/order_state.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/screens/orders/components/custom_elevated_button.dart';
import 'package:freelancing/utils/colors.dart';

void showCancelDailog(
  BuildContext context,
  StepperBloc fileDialogBloc, {
  required String orderId,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: fileDialogBloc,
        child: BlocBuilder<StepperBloc, StepperState>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: appColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: appColors.grey,
                        ),
                      )
                    ],
                  ),
                  Image.asset(cancelOrder),
                  SizedBox(height: 10),
                  Text(
                    "Do you really want to cancel the product?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: appColors.orderIdCol),
                      text: "Order ID: ",
                      children: [
                        TextSpan(
                          text: orderId,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: appColors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedBtn(
                      btnName: "No",
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: appColors.white,
                              ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 34, vertical: 14),
                      btnBorderColor: appColors.lightOrange,
                      bgColor: appColors.lightOrange,
                    ),
                    SizedBox(width: 20),
                    CustomElevatedBtn(
                      btnName: "Yes",
                      onTap: () {
                        context.read<StepperBloc>().add(CancelLastStep());
                        Navigator.pop(context);
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 34, vertical: 14),
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: appColors.lightOrange,
                              ),
                      btnBorderColor: appColors.lightOrange,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
