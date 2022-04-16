import 'dart:async';

import 'dart:developer';

enum OperationType {
  increment,
  decrement,
  reset,
}

class CounterBloc {
  int? count;
  // ignore: close_sinks
  final StreamController<int> _stateStreamController = StreamController<int>();
  // ignore: close_sinks
  final StreamController<OperationType> _eventStreanController =
      StreamController<OperationType>();

  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;
  StreamSink<OperationType> get eventSink => _eventStreanController.sink;
  Stream<OperationType> get eventStrean => _eventStreanController.stream;
  CounterBloc() {
    count = 0;
    eventStrean.listen((event) {
      if (event == OperationType.increment) {
        count = count! + 1;
      } else if (event == OperationType.decrement) {
        count = count! - 1;
      }
      counterSink.add(count!);
    });
  }
}
