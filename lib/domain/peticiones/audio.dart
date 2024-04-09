import 'dart:convert';

import 'package:fluttertest/devices_info.dart';
import 'package:http/http.dart' as http;

class Peticiones {
//Enviar audio al servidor
  Future<void> sendAudio(audioFile) async {
    final url = Uri.parse(
        '');

    final response = await http.post(
      url,
      body: {
        'codigo_panico': '65475675757333',
        'incluye_audio': 'AUDIO_FILE',
        'latitud': '6535133163193',
        'longitud': '13144324234234',
        'departamento': 'magdalena',
        'municipio': 'santa marta',
        'codigo_postal': '4780033',
        'barrio': 'pescaito',
        'direccion': 'calle falssioni 123',
        'numero': '73276478328',
        'marca': productNamee,
        'modelo': modelnamee,
        'imei': imei,
        'fileData': audioFile,
        'ip': ipAddresss,
      },
    );
    print('Archivo Subido con exito  ${jsonEncode(response.body)}');
  }
}
