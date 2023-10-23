import 'package:cartapp/src/business_layer/localization/translations.dart';
import 'package:flutter/material.dart';

class TranslationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'nl', 'es', 'de', 'fr'].contains(locale.languageCode);

  /// Load the translations of a certain locale.
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;

  /// English
  static const Locale enLocale = Locale('en');

  /// Dutch
  static const Locale nlLocale = Locale('nl');

  /// English
  static const Locale esLocale = Locale('es');

  /// English
  static const Locale deLocale = Locale('de');

  /// English
  static const Locale frLocale = Locale('fr');

  /// List of supported languages
  static List<Locale> get supportedLocales =>
      [enLocale, nlLocale, esLocale, deLocale, frLocale];
}
