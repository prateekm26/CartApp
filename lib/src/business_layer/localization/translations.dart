import 'package:cartapp/src/business_layer/localization/english_text.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  static late AppLocalizations current;
  static late Locale locale;

  AppLocalizations._(Locale appLocale) {
    current = this;
  }

  static Future<AppLocalizations> load(Locale appLocale) {
    locale = appLocale;
    return Future.value(AppLocalizations._(appLocale));
  }

  /// Localizations are usually accessed using the InheritedWidget "of" syntax.
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// Map of values of supported languages
  static final Map<String, Map<String, String>> _localizedValues = {
    /// English text
    "en": EnglishText.localizationValues,

    /// Dutch text
    'nl': {"title": "Virtual Tour System"},

    /// Dutch text
    'es': {"title": "Virtual Tour System"},

    /// Dutch text
    'de': {"title": "Virtual Tour System"},

    /// Dutch text
    'fr': {"title": "Virtual Tour System"}
  };

  /// Getters of all keys of supported language map
  String get getTitle => _localizedValues[locale.languageCode]?['title'] ?? "";

  String get getEmptyString =>
      _localizedValues[locale.languageCode]?['empty_string'] ?? "";

  String get getApiExceptionMessage =>
      _localizedValues[locale.languageCode]?['api_exception'] ?? "";

  String get getTimeoutExceptionMessage =>
      _localizedValues[locale.languageCode]?['timeout_exception'] ?? "";

  String get getRequestCancelErrorMessage =>
      _localizedValues[locale.languageCode]!['request_cancel_error_message'] ??
      "";

  String get getSocketExceptionMessage =>
      _localizedValues[locale.languageCode]?['socket_exception'] ?? "";

  String get getParseExceptionMessage =>
      _localizedValues[locale.languageCode]?['parse_exception'] ?? "";
}
