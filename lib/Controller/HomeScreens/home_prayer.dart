import 'package:flutter/material.dart';
import '../TabPrayer/listPrayerVC.dart';

class HomePrayer extends StatefulWidget {
  static const routeName = '/prayer';

  @override
  State<StatefulWidget> createState() {
    return _HomePrayerState();
  }
}

class _HomePrayerState extends State<HomePrayer> {
  @override
  Widget build(BuildContext context) {
    List<_Photo> _photos(BuildContext context) {
      return [
        _Photo(
          assetName: 'assets/prayer/prayer1.jpg',
        ),
        _Photo(
          assetName: 'assets/prayer/prayer1.jpg',
        ),
        _Photo(
          assetName: 'assets/prayer/prayer1.jpg',
        ),
        _Photo(
          assetName: 'assets/prayer/prayer1.jpg',
        ),
        _Photo(
          assetName: 'assets/prayer/prayer1.jpg',
        ),
        _Photo(
          assetName: 'assets/prayer/prayer1.jpg',
        ),
      ];
    }

    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: _photos(context).map<Widget>((photo) {
          return _GridDemoPhotoItem(
            photo: photo,
          );
        }).toList(),
      ),
    );
  }
}

class _Photo {
  _Photo({
    this.assetName,
    this.title,
    this.subtitle,
  });

  final String assetName;
  final String title;
  final String subtitle;
}

class _GridDemoPhotoItem extends StatelessWidget {
  _GridDemoPhotoItem({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final _Photo photo;

  @override
  Widget build(BuildContext context) {
    var gestureDetector = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListPrayerVC()),
        );
      },
      child: Image.asset(
        photo.assetName,
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
