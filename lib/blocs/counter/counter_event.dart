part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class IncrementCounterEvent extends CounterEvent {
  final int counter;
  const IncrementCounterEvent({
    required this.counter,
  });

  @override
  List<Object> get props => [counter];
}

class DecrementCounterEvent extends CounterEvent {
  final int counter;
  const DecrementCounterEvent({
    required this.counter,
  });

  @override
  List<Object> get props => [counter];
}
