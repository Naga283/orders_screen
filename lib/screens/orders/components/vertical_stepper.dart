import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/order_event.dart';
import 'package:freelancing/screens/orders/bloc/order_state/order_state.dart';
import 'package:freelancing/screens/orders/bloc/order_state/radio_state.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/utils/colors.dart';

class VerticalStepper extends StatelessWidget {
  final List<String> steps;
  final RadioButtonState radioBtnState;

  const VerticalStepper({
    super.key,
    required this.steps,
    required this.radioBtnState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepperBloc, StepperState>(
      builder: (context, state) {
        if (state is StepperInitial) {
          final visibleSteps = state.visibleSteps;
          final values = state.isLastStepCanceled;
          print("valuess :: $values");

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visibleSteps.length,
                itemBuilder: (context, index) {
                  final isActualLastStep = visibleSteps[index] == steps.last;
                  final isBelowCurrentStep = index > state.currentStep;
                  final isCurrentStep = index == state.currentStep;
                  final isCanceled =
                      state.isLastStepCanceled && isBelowCurrentStep;

                  // Set color logic based on the isReturned flag
                  Color stepColor;
                  if (state.isReturned) {
                    stepColor = (isCurrentStep || index < state.currentStep)
                        ? appColors.lightOrange
                        : appColors.lightViolet;
                  } else {
                    stepColor = (isCurrentStep || index < state.currentStep)
                        ? appColors.lightGreen
                        : appColors.lightViolet;
                  }

                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Circle and Line
                        Column(
                          children: [
                            // Step Circle
                            CircleAvatar(
                              radius: 8,
                              backgroundColor:
                                  isCanceled ? appColors.redCol : stepColor,
                              child: const Text(
                                '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            // Line (Only if not the last visible step)
                            if (index < visibleSteps.length - 1)
                              Expanded(
                                child: Container(
                                  width: 1,
                                  height: 24,
                                  color: isCanceled
                                      ? appColors.redCol
                                      : !isBelowCurrentStep
                                          ? appColors.lightGreen
                                          : Colors.grey,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        // Step Title
                        Expanded(
                          child: Text(
                            visibleSteps[index],
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: isCanceled
                                      ? appColors.redCol
                                      : !isBelowCurrentStep
                                          ? appColors.black
                                          : appColors.lightViolet,
                                  fontWeight: !isBelowCurrentStep || isCanceled
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: state.isExpanded
                    ? () {
                        context.read<StepperBloc>().add(ToggleViewMore());
                      }
                    : () {
                        context.read<StepperBloc>().add(ToggleViewMore());
                      },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0, top: 20),
                  child: Text(
                    state.isExpanded
                        ? 'Hide detailed tracking'
                        : 'View detailed tracking',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                          height: 1.2,
                          color: appColors.lightViolet,
                          decorationColor: appColors.lightViolet,
                        ),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
