// Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/screens/orders/bloc/order_event/widgets_visible_events.dart';
import 'package:freelancing/screens/orders/bloc/order_state/widget_visibity_state.dart';

class WidgetVisibilityBloc
    extends Bloc<WidgetVisibilityEvent, WidgetVisibilityState> {
  WidgetVisibilityBloc() : super(DefaultWidgetsState()) {
    on<ShowExchangeOrReturnWidget>((event, emit) {
      emit(ExchangeOrReturnWidgetState());
    });

    on<ShowDefaultWidgets>((event, emit) {
      emit(DefaultWidgetsState());
    });
  }
}
