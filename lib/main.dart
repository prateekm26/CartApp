import 'dart:async';

import 'package:cartapp/src/data_layer/local_db/hive_database_helper.dart';
import 'package:cartapp/src/data_layer/res/styles.dart';
import 'package:cartapp/src/feed_app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  /// Initialize the WidgetFlutterBinding if required
  WidgetsFlutterBinding.ensureInitialized();

  /// Sets the status bar color of the widget
  AppStyles.setStatusBarTheme();

  /// Ensuring Size of the phone in UI Design
  await ScreenUtil.ensureScreenSize();

  /// Sets the device orientation of application
  AppStyles.setDeviceOrientationOfApp();

  /// Used to initialize hive db and register adapters and generate encryption
  /// key for encrypted hive box
  await HiveHelper.initializeHiveAndRegisterAdapters();
  await SecureStorageHelper.instance.generateEncryptionKey();

  /// Runs the application in its own error zone
  runApp(const CartApp());
}
