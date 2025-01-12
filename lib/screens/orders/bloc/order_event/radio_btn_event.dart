abstract class RadioButtonEvent {}

class SelectMainOptionEvent extends RadioButtonEvent {
  final String selectedValue;

  SelectMainOptionEvent(this.selectedValue);
}

class SelectSubOptionEvent extends RadioButtonEvent {
  final String selectedValue;

  SelectSubOptionEvent(this.selectedValue);
}
