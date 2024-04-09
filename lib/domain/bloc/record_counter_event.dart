part of 'record_counter_bloc.dart';

@immutable
sealed class RecordCounterEvent {}

class CounterInitial extends RecordCounterEvent {}
