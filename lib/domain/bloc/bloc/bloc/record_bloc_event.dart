part of 'record_bloc_bloc.dart';

sealed class RecordBlocEvent {
  const RecordBlocEvent();

  @override
  List<Object> get props => [];
}

class Recorder extends RecordBlocEvent {}
