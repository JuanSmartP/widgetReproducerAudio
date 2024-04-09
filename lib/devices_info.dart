import 'package:device_imei/device_imei.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:my_device_info_plus/my_device_info_plus.dart';

String? ipAddresss;
String? modelnamee;
String? productNamee;
String? osVersion;
String? imei;

Future getInfoDevice() async {
  final result = await MyDeviceInfoPlus.getDeviceInfo();
  final deviceImeiPlugin = DeviceImei();

  imei = await deviceImeiPlugin.getDeviceImei();

  modelnamee = result['model'];
  osVersion = result['os_version'];
  productNamee = result['platform'];

  if (result['platform'] == 'ios') {
    productNamee = 'Iphone';
  } else if (result['platform'] == 'android') {
    productNamee = 'Android';
  }
  // print('MODELO ====> $modelnamee');

  // print('$productNamee');

  // print('IMEIII =====> $imei');

  // print(osVersion);
}

Future getIpDevice() async {
  var ipAddress = IpAddress(type: RequestType.json);
  dynamic data = await ipAddress.getIpAddress();

  ipAddresss = data['ip'];
  print('IP ========>>>>> $ipAddresss');
}
// Future getImeiDevice() async {
//   final modelName = await DeviceInformation.deviceModel;
//   final productName = await DeviceInformation.productName;
//   final platformVersion = await DeviceInformation.platformVersion;
//   final imeiNo = await DeviceInformation.deviceIMEINumber;
//   modelnamee = modelName;
//   productNamee = productName;
//   platformVersiion = platformVersion;
//   imei = imeiNo;
// }
// Future getImei() async {
// }
