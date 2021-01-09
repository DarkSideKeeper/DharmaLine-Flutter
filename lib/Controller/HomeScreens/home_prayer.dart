import 'package:dharmaline/Model/chantTopicModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../TabPrayer/listPrayerVC.dart';
import '../../Common/loadingView.dart';

class HomePrayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePrayerState();
  }
}

class _HomePrayerState extends State<HomePrayer> {
  final CollectionReference chants =
      FirebaseFirestore.instance.collection('ChantTopic');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chants.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return ProgressIndicatorDemo();
        }

        return Scaffold(
          body: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.all(8),
            childAspectRatio: 1,
            children: snapshot.data.docs.map(
              (DocumentSnapshot document) {
                return new _GridView(
                  item: _GridItem(
                    topic: ChantTopicModel(
                      document.data()['Title'],
                      document.data()['ImageName'],
                      List.from(document.data()['Chapters']),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}

class _GridItem {
  _GridItem({
    this.topic,
  });

  final ChantTopicModel topic;
}

class _GridView extends StatelessWidget {
  _GridView({
    Key key,
    @required this.item,
  }) : super(key: key);

  final _GridItem item;

  @override
  Widget build(BuildContext context) {
    var gestureDetector = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListPrayerVC(
              topic: item.topic,
            ),
          ),
        );
      },
      child: Image.asset(
        item.topic.getImageFile(),
        fit: BoxFit.cover,
      ),
    );
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: gestureDetector,
    );
    return image;
  }
}
