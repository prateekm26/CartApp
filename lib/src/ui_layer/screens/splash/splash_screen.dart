// ignore_for_file: use_build_context_synchronously
import 'package:cartapp/src/business_layer/localization/translations.dart';
import 'package:cartapp/src/business_layer/util/helper/device_info_helper.dart';
import 'package:cartapp/src/business_layer/util/helper/log_helper.dart';
import 'package:cartapp/src/business_layer/util/helper/screen_navigation_helper.dart';
import 'package:cartapp/src/business_layer/util/helper/util_helper.dart';
import 'package:cartapp/src/data_layer/res/route_names.dart';
import 'package:cartapp/src/feed_app.dart';
import 'package:cartapp/src/ui_layer/screens/Home/home_screen.dart';
import 'package:cartapp/src/ui_layer/screens/splash/splash_screen_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((value) async {
      _onAfterBuild();
    });
  }

  /// Main returning widget which returns the whole UI of screen
  @override
  Widget build(BuildContext context) {
    DeviceInfo.setDeviceInfo(context);
    return _mainWidget(context);
  }

  /// Main UI widget
  Widget _mainWidget(BuildContext context) {
    return const Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SplashScreenMainWidget(),
      ),
    );
  }

  /// Widget called after build one time
  void _onAfterBuild() async {
    Locale locale = Locale('en');
    UtilHelper.instance.languageCode = locale.languageCode;
    LogHelper.logData(
        "Selected Locale is =======> ${locale.languageCode}, ${locale.countryCode}");
    await AppLocalizations.load(locale);

    /// Handle after logged in
    navigatorKey.currentState?.pushReplacement(ScreenNavigation.createRoute(
        widget: HomeScreen(),
        routeNames: RouteNames.homeScreen,
        showPageRoute: true));
  }
}
