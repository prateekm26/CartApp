import 'dart:async';
import 'dart:io';

import 'package:cartapp/src/business_layer/network/api_constants.dart';
import 'package:cartapp/src/business_layer/util/helper/log_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum ConnectivityStatus { wifi, cellular, offline }

//Internet Connectivity
class NetworkConnection {
  NetworkConnection.__internal();
  static final NetworkConnection _instance = NetworkConnection.__internal();
  static NetworkConnection get instance => _instance;

  Future<bool> checkInternetConnection() async {
    bool checkConnection;
    try {
      final result = await InternetAddress.lookup(ApiConstants.googleLink)
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        checkConnection = true;
      } else {
        checkConnection = false;
      }
    } on TimeoutException catch (_) {
      checkConnection = false;
    } on SocketException catch (_) {
      checkConnection = false;
    } catch (e) {
      checkConnection = false;
    }
    return checkConnection;
  }
}

class MyConnectivity {
  MyConnectivity._internal();
  static final MyConnectivity _instance = MyConnectivity._internal();
  static MyConnectivity get instance => _instance;
  final Connectivity _connectivity = Connectivity();
  bool _isOnline = false;
  late StreamController<int> _onlineStatusController;
  late StreamController<int> _uiUpdateStream;
  Connectivity get connectivity => _connectivity;

  Future<void> initialise() async {
    _onlineStatusController = StreamController<int>.broadcast();
    _uiUpdateStream = StreamController<int>.broadcast();
    ConnectivityResult result = await _connectivity.checkConnectivity();
    checkStatus(result: result, isUpdateOnline: true);
    _connectivity.onConnectivityChanged.listen((result) async {
      await Future.delayed(const Duration(milliseconds: 500));
      checkStatus(result: result, isUpdateOnline: true);
    });
  }

  Future<void> checkStatus(
      {ConnectivityResult result = ConnectivityResult.mobile,
      bool isUpdateOnline = false}) async {
    try {
      final result = await InternetAddress.lookup(ApiConstants.googleLink)
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _addEventsInStream(1);
      } else {
        _addEventsInStream(0);
      }
    } on SocketException catch (_) {
      _addEventsInStream(0);
    } catch (_) {
      _addEventsInStream(0);
    }
  }

  void _addEventsInStream(int event) {
    try {
      _onlineStatusController.sink.add(event);
    } catch (e) {
      LogHelper.logError(e);
    }
    addEventsInUIUpdateStream(event);
  }

  Future<void> addEventsInUIUpdateStream(int event) async {
    try {
      // await Future.delayed(const Duration(seconds: 10));
      _uiUpdateStream.sink.add(event);
    } catch (e) {
      LogHelper.logError(e);
    }
  }

  void dispose() {
    _onlineStatusController.close();
  }

  Stream get onlineStatusSteam => _onlineStatusController.stream;
  Stream get updateUIStream => _uiUpdateStream.stream;
  bool get isOnline => _isOnline;
  StreamController<int> get onlineOfflineStatusController =>
      _onlineStatusController;
}

class ConnectivityService {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityService() {
    // Subscribe to the connectivity Changed Stream
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t
      connectionStatusController.sink.add(_getStatusFromResult(result));
    });
  }
  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }
}
