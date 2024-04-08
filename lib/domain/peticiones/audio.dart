import 'package:fluttertest/devices_info.dart';
import 'package:http/http.dart' as http;






class Peticiones {
//Enviar audio al servidor
  Future<void> sendAudio(audioFile) async {
    final url = Uri.parse(
        'http://192.168.1.41/phps-api/src/EndSubir/crear-alerta.php');

    final response = await http.post(
      url,
      body: {
        'codigo_panico': '12345676878',
        'incluye audio': 'AUDIO FILE',
        'latitud': '6535133163193',
        'longitud': '13144324234234',
        'departament': 'magdalena',
        'municipio': 'santa marta',
        'codigo_postal': '4780033',
        'barrio': 'pescaito',
        'direccion': 'calle falssioni 123',
        'numero': '73276478328',
        'marca': productNamee,
        'modelo': modelnamee,
        'imei': imei,
        'fileData': audioFile,
        'codigo': 'ID'
      },
    );

    print('Archivo Subido con exito  ${response.statusCode}');
  }
}
