import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/order_event.dart';
import 'package:freelancing/screens/orders/bloc/order_event/widgets_visible_events.dart';
import 'package:freelancing/screens/orders/bloc/order_state/order_state.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/screens/orders/bloc/widget_visibililty_bloc.dart';
import 'package:freelancing/screens/orders/components/custom_elevated_button.dart';
import 'package:freelancing/utils/colors.dart';

Future<dynamic> successfullySubmitDailog(
  BuildContext context,
  WidgetVisibilityBloc widgetsVisibleBloc,
  StepperBloc stepperBloc,
) {
  return showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: appColors.lightViolet,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Your request has been submitted. Our team will connect with you shortly regarding your return or exchange issue.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(
                height: 24,
              ),
              CustomElevatedBtn(
                btnBorderColor: appColors.lightOrange,
                btnName: "Continue Shopping",
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: appColors.lightOrange,
                    ),
                onTap: () {
                  List<String> returnSteps = [
                    "Return Applied, 11th Jan ‘25 12:43 AM",
                    "Return Approved by Seller",
                    "Pickup Completed",
                    "Refund Completed",
                  ];
                  Navigator.of(context).pop();
                  widgetsVisibleBloc.add(ShowDefaultWidgets());
                  stepperBloc.add(UpdateCurrentStep(0));
                  // Dispatch the initial Stepper state with initial values
                  // Dispatch the ResetStepper event to reset the stepper state
                  // Reset the stepper bloc state to its initial state
                  stepperBloc.add(
                    ResetStepper(
                      returnSteps, // Provide the list of steps
                      true,
                    ),
                  );

                  // Dispatch the ToggleViewMore to ensure the detailed tracking section is collapsed (or handle accordingly)
                  stepperBloc.add(ToggleViewMore());
                },
              ),
            ],
          ),
        );
      });
}
