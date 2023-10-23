import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../../data_layer/res/numbers.dart';

class ScreenNavigation {
  /// Function used to create custom animated route
  static Route createRoute(
      {required Widget widget,
      required String routeNames,
      bool showPageRoute = false}) {
    if (Platform.isAndroid || showPageRoute) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(d_0, d_0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(
            CurveTween(
              curve: curve,
            ),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: RouteSettings(name: routeNames),
      );
    } else {
      return CupertinoPageRoute(
        builder: (BuildContext context) {
          return widget;
        },
        settings: RouteSettings(name: routeNames),
      );
    }
  }
}
