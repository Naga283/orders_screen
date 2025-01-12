import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/radio_btn_event.dart';
import 'package:freelancing/screens/orders/bloc/order_state/radio_state.dart';

class RadioButtonBloc extends Bloc<RadioButtonEvent, RadioButtonState> {
  RadioButtonBloc()
      : super(DisplaySubOptionsState(mainSelectedValue: null, subSelectedValue: null)) {
    on<SelectMainOptionEvent>((event, emit) {
      emit(DisplaySubOptionsState(mainSelectedValue: event.selectedValue, subSelectedValue: null));
    });

    on<SelectSubOptionEvent>((event, emit) {
      if (state is DisplaySubOptionsState) {
        emit(DisplaySubOptionsState(
          mainSelectedValue: (state as DisplaySubOptionsState).mainSelectedValue,
          subSelectedValue: event.selectedValue,
        ));
      }
    });
  }
}