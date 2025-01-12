abstract class RadioButtonState {
  final String? mainSelectedValue;
  final String? subSelectedValue;

  RadioButtonState({this.mainSelectedValue, this.subSelectedValue});
}

class DisplaySubOptionsState extends RadioButtonState {
  DisplaySubOptionsState({String? mainSelectedValue, String? subSelectedValue})
      : super(
            mainSelectedValue: mainSelectedValue,
            subSelectedValue: subSelectedValue);
}
