import 'package:flutter/material.dart';

class HomeSetting extends StatefulWidget {
  static const routeName = '/setting';

  @override
  State<StatefulWidget> createState() {
    return _HomeSettingState();
  }
}

class _HomeSettingState extends State<HomeSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Setting Screen'),
        ],
      )),
    );
  }
}
