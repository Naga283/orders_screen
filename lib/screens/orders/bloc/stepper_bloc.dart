// stepper_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/order_event.dart';
import 'package:freelancing/screens/orders/bloc/order_state/order_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  final List<String> allSteps;
  final List<String> returnSteps;

  StepperBloc(
    this.allSteps,
    this.returnSteps,
  ) : super(StepperInitial(
          [allSteps.first, allSteps.last],
          false,
          0,
          isReturned: false, // Default to 'not returned'
        )) {
    on<ToggleViewMore>((event, emit) {
      if (state is StepperInitial) {
        StepperInitial currentState = state as StepperInitial;

        List<String> updatedVisibleSteps = [];

        if (currentState.isReturned) {
          // Handle the "return" case
          updatedVisibleSteps = currentState.isExpanded
              ? [
                  returnSteps.first,
                  returnSteps.last
                ] // Show first and last when collapsed
              : returnSteps; // Show full return steps when expanded
        } else {
          // Handle the "non-return" case
          updatedVisibleSteps = currentState.isExpanded
              ? [
                  allSteps.first,
                  allSteps.last
                ] // Show first and last when collapsed
              : allSteps; // Show full steps when expanded
        }

        emit(StepperInitial(
          updatedVisibleSteps, // Update the visible steps based on the expansion
          !currentState.isExpanded, // Toggle expanded/collapsed state
          currentState.currentStep,
          isLastStepCanceled: currentState.isLastStepCanceled,
          isReturned: currentState.isReturned, // Maintain the returned flag
        ));
      }
    });

    on<UpdateCurrentStep>((event, emit) {
      if (state is StepperInitial) {
        final currentState = state as StepperInitial;

        // Update the current step
        emit(StepperInitial(
          currentState.visibleSteps,
          currentState.isExpanded,
          event.currentStep,
          isLastStepCanceled: currentState.isLastStepCanceled,
          isReturned: currentState.isReturned,
        ));
      }
    });

    on<CancelLastStep>((event, emit) {
      if (state is StepperInitial) {
        final currentState = state as StepperInitial;
        final updatedSteps = List<String>.from(currentState.visibleSteps);
        updatedSteps[updatedSteps.length - 1] =
            "Cancelled, Wed 25th Dec 24, at 6:12 PM"; // Update last step to "Cancelled"

        emit(StepperInitial(
          updatedSteps,
          currentState.isExpanded,
          currentState.currentStep,
          isLastStepCanceled: true,
          isReturned: currentState.isReturned,
        ));
      }
    });

    // Reset event to reset the state with new visible steps
    on<ResetStepper>((event, emit) {
      emit(StepperInitial(
        event.visibleSteps, // Set to the steps passed in the event
        false, // Collapse the expanded view by default
        0, // Set the first step to be active
        isLastStepCanceled: false, // Make sure cancellation flag is reset
        isReturned:
            event.isReturned, // Set the 'isReturned' flag based on the event
      ));
    });
  }
}
