import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../color/color_bloc.dart';
import '../counter/counter_bloc.dart';

part 'color_counter_event.dart';
part 'color_counter_state.dart';

class ColorCounterBloc extends Bloc<ColorCounterEvent, ColorCounterState> {
  final ColorBloc colorBloc;
  final CounterBloc counterBloc;

  late final StreamSubscription colorSubscription;
  late final StreamSubscription counterSubscription;

  ColorCounterBloc({
    required this.colorBloc,
    required this.counterBloc,
  }) : super(ColorCounterInitial()) {
    colorSubscription = colorBloc.stream.listen((ColorState colorState) {
      print('colorState: $colorState');
      if (colorState.color == Colors.yellow) {
        counterBloc.add(const IncrementCounterEvent(counter: 10));
      } else if (colorState.color == Colors.blue) {
        counterBloc.add(const DecrementCounterEvent(counter: 5));
      }
    });

    counterSubscription =
        counterBloc.stream.listen((CounterState counterState) {
      print('counterState.counter: ${counterState.counter}');
      if (counterState.counter == 3) {
        colorBloc.add(ToggleColorEvent());
      }
    });
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();
    counterSubscription.cancel();
    return super.close();
  }
}
