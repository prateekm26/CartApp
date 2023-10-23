import 'package:cartapp/src/data_layer/res/numbers.dart';
import 'package:flutter/cupertino.dart';

class DeviceInfo {
  static double height = 0.0;
  static double width = 0.0;
  static bool smallDevice = false;
  static bool extraLargeDevice = false;
  static String? release;
  static int? sdkInt;
  static String? manufacturer;
  static String? model;
  static String? deviceId = "abc";
  static String? systemName = "ios";
  static String? version;
  static String? name;
  static String data = "";

  /// Method used to set device information's
  static void setDeviceInfo(BuildContext context) async {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    smallDevice = getDeviceSize() == DeviceSize.small ||
        getDeviceSize() == DeviceSize.medium;
    extraLargeDevice = getDeviceSize() == DeviceSize.xlarge ||
        getDeviceSize() == DeviceSize.large;
  }

  static bool isGreaterAndroid12() {
    if (sdkInt != null && sdkInt! > 32) {
      return true;
    }
    return false;
  }

  static bool isBelowAndroid12() {
    if (sdkInt != null && sdkInt! < 31) {
      return true;
    }
    return false;
  }

  /// Method used to return device sizes
  static DeviceSize getDeviceSize() {
    if (height > d_850) {
      //iPhone 12 pro max
      return DeviceSize.xlarge;
    } else if (height > d_800) {
      //iPhone 12 pro
      return DeviceSize.large;
    } else if (height > d_750) {
      //iPhone 8
      return DeviceSize.medium;
    } else {
      //iPhone SE
      return DeviceSize.small;
    }
  }

  /// Method used to check should keyboard open or not
  static bool isKeyBoardOpen(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom > d_0) return true;
    return false;
  }
}

enum DeviceSize { small, medium, large, xlarge }
