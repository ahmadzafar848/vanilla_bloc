import 'dart:async';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc {
  final StreamController<CounterEvent> _counterEventStreamController =
      StreamController<CounterEvent>();
  final StreamController<CounterState> _counterStateStreamController =
      StreamController<CounterState>();
  final counterState = CounterState();
  CounterBloc() {
    counterEventStream.listen(_mapToEventStream);
  }
  StreamSink<CounterEvent> get counterEventSink =>
      _counterEventStreamController.sink;
  StreamSink<CounterState> get counterStateSink =>
      _counterStateStreamController.sink;
  Stream<CounterEvent> get counterEventStream =>
      _counterEventStreamController.stream;
  Stream<CounterState> get counterStateStream =>
      _counterStateStreamController.stream;

  void _mapToEventStream(CounterEvent event) {
    if (event is IncrementCounter) {
      counterStateSink.add(counterState..increment());
    } else {
      counterStateSink.add(counterState..decrement());
    }
  }
}
