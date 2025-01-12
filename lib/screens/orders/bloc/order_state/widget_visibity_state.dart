// State
import 'package:equatable/equatable.dart';

abstract class WidgetVisibilityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DefaultWidgetsState extends WidgetVisibilityState {}

class ExchangeOrReturnWidgetState extends WidgetVisibilityState {}
