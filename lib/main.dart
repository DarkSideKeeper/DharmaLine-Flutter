import 'package:flutter/material.dart';
import 'launcher.dart';
import 'Common/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'ธรรมะ';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('th', ''),
      title: _title,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('th', ''),
        const Locale('en', ''),
      ],
      home: Launcher(),
    );
  }
}
