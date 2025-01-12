// stepper_event.dart
abstract class StepperEvent {}

class ToggleViewMore extends StepperEvent {}

class UpdateCurrentStep extends StepperEvent {
  final int currentStep;

  UpdateCurrentStep(this.currentStep);
}

class ResetStepper extends StepperEvent {
  final List<String> visibleSteps;
  final bool isReturned;

  ResetStepper(
    this.visibleSteps,
    this.isReturned,
  );
}

class CancelLastStep extends StepperEvent {}
