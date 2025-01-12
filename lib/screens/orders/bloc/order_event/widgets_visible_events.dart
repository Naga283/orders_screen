import 'package:equatable/equatable.dart';

// Events
abstract class WidgetVisibilityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowExchangeOrReturnWidget extends WidgetVisibilityEvent {}

class ShowDefaultWidgets extends WidgetVisibilityEvent {}
