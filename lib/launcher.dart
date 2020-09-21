import 'package:flutter/material.dart';
import 'Controller/HomeScreens/home_feed.dart';
import 'Controller/HomeScreens/home_prayer.dart';
import 'Controller/HomeScreens/home_setting.dart';
import 'Common/localizations.dart';

class Launcher extends StatefulWidget {
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 1;
  List<Widget> _pageWidget = <Widget>[HomeFeed(), HomePrayer(), HomeSetting()];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.rss_feed),
      title: Text(AppLocalizations.shared.getText('Feed')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_library),
      title: Text(AppLocalizations.shared.getText('Prayer')),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text(AppLocalizations.shared.getText('Setting')),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: buildDrawer(), for V2
      appBar: AppBar(
        title: Text('สายธรรมะ'),
      ),
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
