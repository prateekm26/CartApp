import 'package:cartapp/src/data_layer/res/app_colors.dart';
import 'package:cartapp/src/data_layer/res/numbers.dart';
import 'package:cartapp/src/data_layer/res/route_names.dart';
import 'package:flutter/material.dart';

import '../../feed_app.dart';

class Loader {
  /// Method used to display circular progress bar
  static display() {
    navigatorKey.currentState?.push(
      PageRouteBuilder(
          opaque: false,
          barrierDismissible: true,
          pageBuilder: (BuildContext context, _, __) {
            return const ProgressDialog();
          },
          settings: const RouteSettings(
            arguments: RouteNames.loadingScreen,
          )),
    );
  }

  /// Method used to stop loader
  static close() {
    navigatorKey.currentState?.pop();
  }
}

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(i_80),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(d_30),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height / i_6,
                  )),
                  const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
                  ),
                  const SizedBox(height: d_15),
                  const Text(
                    "Please wait...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: d_16,
                      fontWeight: FontWeight.w700,
                      //fontFamily: CIRCULAR_STD
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
