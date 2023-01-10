part of 'color_counter_bloc.dart';

abstract class ColorCounterState extends Equatable {
  const ColorCounterState();

  @override
  List<Object> get props => [];
}

class ColorCounterInitial extends ColorCounterState {}
