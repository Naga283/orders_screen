// stepper_state.dart
abstract class StepperState {}

class StepperInitial extends StepperState {
  final List<String> visibleSteps;
  final bool isExpanded;
  final int currentStep; // Track the current completed step
  final bool isLastStepCanceled;
  final bool isReturned;

  StepperInitial(
    this.visibleSteps,
    this.isExpanded,
    this.currentStep, {
    this.isLastStepCanceled = false, // Default to false
    this.isReturned = false,
  });
}
