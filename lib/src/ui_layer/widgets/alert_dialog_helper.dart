import 'package:flutter/material.dart';

class AlertDialogHelper {
  /// Method used to help showing alert dialogs
  static Future<void> showAppDialogs(BuildContext context, Widget child) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: child,
        );
      },
    );
  }

}

