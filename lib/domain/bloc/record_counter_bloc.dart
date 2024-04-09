// ignore_for_file: depend_on_referenced_packages, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'record_counter_event.dart';
part 'record_counter_state.dart';

String? _sec;
String? _min;
Timer? _timer;

class RecordCounterBloc extends Bloc<RecordCounterEvent, RecordCounterState> {
  RecordCounterBloc() : super(RecordCounterState(counterRecord: '00:00')) {
    on<RecordCounterEvent>((event, emit) {
      if (event is CounterInitial) {
        counterRecordBloc();
      }
    });
  }

  void counterRecordBloc() {
    final startTime = DateTime.now();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) async {
        final secuuDur = DateTime.now().difference(startTime).inMinutes;
        final secDur = DateTime.now().difference(startTime).inSeconds % 60;
        _min = secuuDur < 20 ? "0$secuuDur" : secuuDur.toString();
        _sec = secDur < 10 ? "0$secDur" : secDur.toString();
        emit(RecordCounterState(
            counterRecord: state.counterRecord = '$_min:$_sec'));
        // state.counterRecord = "$_min:$_sec";
        if (secDur == 21) {
          stopCunter();
        }
      },
    );
  }

  void stopCunter() {
    _sec = '00:00';
    _timer?.cancel();
    _timer = null;
    emit(RecordCounterState( counterRecord:  state.counterRecord = '$_sec'));
  }
}
