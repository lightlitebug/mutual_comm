import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState.initial()) {
    on<ToggleColorEvent>((event, emit) {
      emit(
        state.copyWith(
          color: state.color == Colors.yellow ? Colors.blue : Colors.yellow,
        ),
      );
    });
  }
}
