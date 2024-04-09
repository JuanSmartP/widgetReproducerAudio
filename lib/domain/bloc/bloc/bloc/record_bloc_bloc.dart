// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:fluttertest/domain/peticiones/audio.dart';
part 'record_bloc_event.dart';
part 'record_bloc_state.dart';

bool _isRecording = false;
final recor = AudioRecorder();
final date = DateTime.now().millisecond;
const _durarion = Duration(seconds: 20);
String path = '';

class RecordBlocBloc extends Bloc<RecordBlocEvent, RecordBlocState> {
  RecordBlocBloc() : super(Recording()) {
    on<RecordBlocEvent>(
      (event, emit) {
        recordpanicaudio();
      },
    );
  }

  //Funcion para iniciar y detener la grabacion
  Future<void> recordpanicaudio() async {
    String customPath =
        await getApplicationDocumentsDirectory().then((value) => value.path);

    path = '$customPath/${date}myfile.wav';

    if (!_isRecording && await recor.hasPermission()) {
      await recor.start(const RecordConfig(encoder: AudioEncoder.wav),
          path: path);

      // print(_isRecording);
      setTimeOut();
      _isRecording = true;

      // print('GraBANDO');
    } else if (_isRecording = false) {
      cancelRecording();
    }
  }

  //Funcion encargada de detener la grabacion
  void cancelRecording() async {
    recor.stop();
    convertBase64(path);
    _isRecording = false;
  }

  void setTimeOut() {
    Timer(_durarion, () async {
      recor.stop();
      // print('Se detiene la grabacion');
      // print('PATH TO CONVERT BASE64 ====================>>> $path');
      if (_isRecording == true) {
        convertBase64(path);
        // print('Entro en el convertidor $_isRecording');
      }
      // print('SE DETIENE LA GRABACION');
      _isRecording = false;
    });
  }

//Convertir audio a base64
  Future<void> convertBase64(path) async {
    File file = File(path);

    List<int> fileBytes = await file.readAsBytes();
    String base64String = base64.encode(fileBytes);

    log(' BASE64====> data:audio/mp3;base64, $base64String');

    final peticiones = Peticiones();
    peticiones.sendAudio('data:audio/mp3base64,$base64String');
  }
}
