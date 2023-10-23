import 'package:cartapp/src/business_layer/localization/translations.dart';
import 'package:cartapp/src/business_layer/network/request_response_type.dart';
import 'package:cartapp/src/business_layer/util/helper/internet_helper.dart';
import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  /// Method used to check internet connection
  Future<bool> checkInternet() async {
    return await NetworkConnection.instance.checkInternetConnection();
  }

  /// Method used to get exception messages
  String? getExceptionMessage({required ExceptionType exceptionType}) {
    switch (exceptionType) {
      case ExceptionType.apiException:
        return AppLocalizations.current.getApiExceptionMessage;
      case ExceptionType.timeOutException:
        return AppLocalizations.current.getTimeoutExceptionMessage;
      case ExceptionType.socketException:
        return AppLocalizations.current.getSocketExceptionMessage;
      case ExceptionType.parseException:
        return AppLocalizations.current.getParseExceptionMessage;
      case ExceptionType.otherException:
        return "Something went wrong";
      case ExceptionType.cancelException:
        return AppLocalizations.current.getRequestCancelErrorMessage;
      case ExceptionType.noException:
        return "";
    }
  }

  /// Method used to notify for UI update
  void refreshState() {
    notifyListeners();
  }
}
