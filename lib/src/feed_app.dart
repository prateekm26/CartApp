// ignore_for_file: use_build_context_synchronously
import 'package:cartapp/src/business_layer/util/helper/internet_helper.dart';
import 'package:cartapp/src/business_layer/util/helper/log_helper.dart';
import 'package:cartapp/src/data_layer/res/numbers.dart';
import 'package:cartapp/src/data_layer/res/route_names.dart';
import 'package:cartapp/src/data_layer/res/styles.dart';
import 'package:cartapp/src/provider_registration.dart';
import 'package:cartapp/src/ui_layer/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'business_layer/localization/translations.dart';
import 'business_layer/localization/translations_delegate.dart';

/// Navigator key is to get the current context, state and widget of the
/// Material App
final navigatorKey = GlobalKey<NavigatorState>();

class CartApp extends StatefulWidget {
  const CartApp({super.key});

  @override
  State<CartApp> createState() => _CartAppState();
}

class _CartAppState extends State<CartApp> with WidgetsBindingObserver {
  final String _tag = "MyApp:";
  final String _locale = "en";
  final MyConnectivity _myConnectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _initializeConnectivity();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _initializeConnectivity() async {
    await _myConnectivity.initialise();
  }

  @override
  void dispose() {
    /// Remove observer before widget dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// State called after initState and also called every time when any
  /// dependency is changes like language
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    LogHelper.logData("$_tag AppLifecycleState ===> $state");
    _handleAppLifecycleState(state);
  }

  Future<void> _handleAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:

        /// Do something when app goes in background state
        break;
      case AppLifecycleState.resumed:

        /// Do something when app opens from background state

        break;
      case AppLifecycleState.inactive:

        /// Do something when app goes in minimized state
        break;
      case AppLifecycleState.detached:

        /// Do something when app goes in killed state
        break;
      default:

        /// Do nothing
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppStyles.setStatusBarTheme();
    return _todoMaterialApp(context);
  }

  /// Method used to set app locale and return locale in future
  /*Future<String> _setAppLocale() async {
    await Devicelocale.currentLocale.then((res) {
      _locale = UtilHelper.instance.getLocale(res!);
    });
    return _locale;
  }*/

  /// Method used to return go share material app
  Widget _todoMaterialApp(BuildContext context) {
    return MultiProvider(
      providers: RegisterProviders.providers(context),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        builder: (
          BuildContext context,
          Widget? child,
        ) {
          ScreenUtil.init(context, designSize: const Size(d_375, d_812));
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: d_1),
            child: child!,
          );
        },
        theme: AppStyles.getAppTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (BuildContext context) {
          return AppLocalizations.current.getTitle;
        },
        localizationsDelegates: const [
          TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale(_locale),
        supportedLocales: TranslationsDelegate.supportedLocales,
        home: const SplashScreen(),
        initialRoute: RouteNames.splashScreen,
        navigatorObservers: const <NavigatorObserver>[],
      ),
    );
  }
}
