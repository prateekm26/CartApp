import 'package:cartapp/src/business_layer/localization/translations.dart';
import 'package:cartapp/src/business_layer/util/helper/device_info_helper.dart';
import 'package:flutter/material.dart';

import '../../../data_layer/res/numbers.dart';
import '../../../data_layer/res/strings.dart';

class UtilHelper {
  UtilHelper.__internal();

  static final UtilHelper _instance = UtilHelper.__internal();

  static UtilHelper get instance => _instance;

  String languageCode = LanguageConstants.englishLanguageCode;

  String getLocale(String locale) {
    if (locale.length > i_1) {
      return locale.substring(i_0, i_2);
    } else if (locale.length <= i_1) {
      return locale;
    } else {
      return "en";
    }
  }

  /// Method used to parse number
  num parseNumber(String? value) {
    if (value == null) return i_0;
    if (int.tryParse(value) != null) {
      return int.parse(value);
    } else if (double.tryParse(value) != null) {
      if (value.split(".").last.length == 1 &&
              value.split(".").last.contains("0") ||
          value.split(".").last.contains("00")) {
        return int.parse(value.split(".").first);
      } else {
        return double.parse(double.parse(value).toStringAsFixed(i_1));
      }
    } else {
      return i_0;
    }
  }

  /// Method used to returns a same same string first letter capitalization
  String capitalize(String? value) {
    if (value == null) {
      return AppLocalizations.current.getEmptyString;
    } else {
      return value.isNotEmpty
          ? '${value[i_0].toUpperCase()}${value.substring(i_1)}'
          : "";
    }
  }

  /// Methode used to close keyboard
  void closeKeyboard(BuildContext context) {
    if (DeviceInfo.isKeyBoardOpen(context)) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  String getError(String? message) {
    return message?.replaceAll("'", "") ?? "Something went wrong";
  }
}
