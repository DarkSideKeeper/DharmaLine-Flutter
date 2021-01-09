import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Common/loadingView.dart';
import 'Common/localizations.dart';
import 'Controller/HomeScreens/home_feed.dart';
import 'Controller/HomeScreens/home_prayer.dart';
import 'Controller/HomeScreens/home_setting.dart';
import 'Model/chantChapterModel.dart';

class Launcher extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  final CollectionReference tableChantChapter =
      FirebaseFirestore.instance.collection('ChantChapter');
  final CollectionReference tableControlVersion =
      FirebaseFirestore.instance.collection('ControlVersion');

  bool _isChecking = false;
  int _selectedIndex = 1;
  List<Widget> _pageWidget = <Widget>[HomeFeed(), HomePrayer(), HomeSetting()];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.rss_feed),
      label: AppLocalizations.shared.getText('Feed'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_library),
      label: AppLocalizations.shared.getText('Prayer'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: AppLocalizations.shared.getText('Setting'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> isUpdate(int dbVersion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int localVersion = prefs.getInt('ChantChapterVersion');
    if (localVersion != dbVersion) {
      await prefs.setInt('ChantChapterVersion', 0);
      return Future.value(true);
    }
    return Future.value(false);
  }

  void getNewData() {
    tableChantChapter
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                TableChantChapterModel.shared.model.add(
                  ChantChapterModel(
                    id: doc.id,
                    title: doc.data()['Title'],
                    audioFileName: doc.data()['AudioFileName'],
                    chapters: List.from(doc.data()['Chapter']),
                    meanings: List.from(doc.data()['Meaning']),
                  ),
                );
              }),
            })
        .then((_) {
      resetUI();
    });
  }

  void resetUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return Scaffold(
        //drawer: buildDrawer(), for V2
        appBar: AppBar(
          title: Text(AppLocalizations.shared.getText('AppName')),
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
    } else {
      tableControlVersion
          .doc('ChapterVersion')
          .get()
          .then((DocumentSnapshot doc) async {
        _isChecking = true;
        if (await isUpdate(doc.data()['Version'])) {
          _isChecking = true;
          getNewData();
          return;
        } else {
          resetUI();
        }
      });
      return ProgressIndicatorDemo();
    }
  }
}
