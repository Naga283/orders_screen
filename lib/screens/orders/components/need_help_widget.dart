import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/constants/image_constants.dart';
import 'package:freelancing/screens/orders/bloc/order_event/order_event.dart';
import 'package:freelancing/screens/orders/bloc/order_event/widgets_visible_events.dart';
import 'package:freelancing/screens/orders/bloc/order_state/order_state.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/screens/orders/bloc/widget_visibililty_bloc.dart';
import 'package:freelancing/screens/orders/components/show_cancel_dailog.dart';
import 'package:freelancing/utils/colors.dart';

class NeedHelpWidget extends StatelessWidget {
  const NeedHelpWidget({
    super.key,
    required this.textStyle,
    required this.orderId,
    required this.steps,
    required this.widgetVisibilityBloc,
  });

  final TextTheme textStyle;
  final String orderId;
  final List<String> steps;
  final WidgetVisibilityBloc widgetVisibilityBloc;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 10);

    return BlocBuilder<StepperBloc, StepperState>(
      builder: (context, state) {
        if (state is StepperInitial) {
          final isAllStepsCompleted = state.currentStep == steps.length - 1;

          return Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Need Help",
                  style: textStyle.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                sizedBox,
                HelpButtons(
                  imageName: chat,
                  name: "Chat with us",
                  onTap: () {},
                  textColor: appColors.lightViolet,
                ),
                sizedBox,
                if (isAllStepsCompleted)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: HelpButtons(
                      imageName: chat,
                      name: "Want to return product",
                      onTap: () {
                        // Trigger the event to show the exchange/return widget
                        widgetVisibilityBloc.add(ShowExchangeOrReturnWidget());
                      },
                      textColor: appColors.lightViolet,
                    ),
                  ),
                (state.isReturned)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: HelpButtons(
                          imageName: feedbackImage,
                          name: "Give your Feedback",
                          onTap: () {
                            // Trigger the event to show the exchange/return widget
                            widgetVisibilityBloc
                                .add(ShowExchangeOrReturnWidget());
                          },
                          textColor: appColors.lightViolet,
                        ),
                      )
                    : SizedBox.shrink(),
                (state.isLastStepCanceled || state.isReturned)
                    ? SizedBox.shrink()
                    : HelpButtons(
                        imageName: isAllStepsCompleted ? cancelDisable : cancel,
                        name: "Cancel Order",
                        onTap: isAllStepsCompleted
                            ? () {}
                            : () async {
                                showCancelDailog(
                                  context,
                                  context.read<StepperBloc>(),
                                  orderId: orderId,
                                );
                              },
                        textColor: isAllStepsCompleted
                            ? appColors.disableCol
                            : appColors.littleLightRed,
                      ),
                ElevatedButton(
                  onPressed: () {
                    if (state.currentStep < steps.length - 1) {
                      context
                          .read<StepperBloc>()
                          .add(UpdateCurrentStep(state.currentStep + 1));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.lightViolet),
                  child: Text(
                    "Next Step",
                    style: textStyle.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(); // Return an empty container if the state isn't StepperInitial
      },
    );
  }
}

class HelpButtons extends StatelessWidget {
  const HelpButtons({
    super.key,
    required this.imageName,
    required this.name,
    required this.onTap,
    required this.textColor,
  });

  final String imageName;
  final String name;
  final Function() onTap;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(imageName),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
            ),
          ),
          Icon(
            Icons.arrow_outward_rounded,
            size: 15,
            color: textColor,
          )
        ],
      ),
    );
  }
}
