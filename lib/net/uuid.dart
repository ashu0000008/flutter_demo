import 'dart:io';

import 'package:device_id/device_id.dart';
import 'package:device_info/device_info.dart';

Future<String> GetDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
//    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
//    return androidDeviceInfo.androidId; // unique ID on Android
    return await DeviceId.getID;
  }
}
