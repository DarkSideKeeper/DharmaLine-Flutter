import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  static AppLocalizations shared = AppLocalizations();

  Locale locale;

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'Feed': 'New',
      'Prayer': 'Prayer',
      'Setting': 'Setting',
    },
    'th': {
      'Feed': 'ข่าวธรรมะ',
      'Prayer': 'บทสวดมนต์',
      'Setting': 'ตั้งค่า',
    },
  };

  getText(String key) {
    return _localizedValues[locale.languageCode][key];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'th'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    AppLocalizations.shared.locale = locale;
    return SynchronousFuture<AppLocalizations>(AppLocalizations.shared);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
