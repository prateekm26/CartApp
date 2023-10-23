import 'dart:developer' as developer;

import 'package:cartapp/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogHelper {
  static void logData(var message, {String logName = ""}) {
    if (!AppSettings.isProduction || !kReleaseMode) {
      Logger().d(message);
      developer.log(message.toString(), name: logName);
    }
  }

  static void logError(var message, {String logName = ""}) {
    if (!AppSettings.isProduction || !kReleaseMode) {
      Logger().e(message);
      developer.log(message.toString(), name: logName);
    }
  }

  static void logMessage(String message, {String logName = ""}) {
    if (!AppSettings.isProduction || !kReleaseMode) {
      developer.log(message, name: logName);
    }
  }
}
