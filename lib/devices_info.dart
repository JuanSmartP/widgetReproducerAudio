import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_information/device_information.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:permission_handler/permission_handler.dart';

String? ipAddresss;
String? modelnamee;
String? productNamee;
String? platformVersiion;
String? imei;

List deviceInfo = [];

Future infoDevice() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  final deviceInfo = await deviceInfoPlugin.deviceInfo;
  final allInfo = deviceInfo.data;
  print(allInfo);
}

Future getIpDevice() async {
  var ipAddress = IpAddress(type: RequestType.json);
  dynamic data = await ipAddress.getIpAddress();

  ipAddresss = data['ip'];

  print(' IP  ${data['ip']}.');
  deviceInfo.add(ipAddress);
}

Future getImeiDevice() async {
  final modelName = await DeviceInformation.deviceModel;
  final productName = await DeviceInformation.productName;
  final platformVersion = await DeviceInformation.platformVersion;

  modelnamee = modelName;
  productNamee = productName;
  platformVersiion = platformVersion;

  deviceInfo.add(modelnamee);
  deviceInfo.add(productNamee);
  deviceInfo.add(platformVersiion);

  final status = await Permission.phone.status;

  final imeiNo = await DeviceInformation.deviceIMEINumber;

  imei = imeiNo;

  deviceInfo.add(imei);
}
