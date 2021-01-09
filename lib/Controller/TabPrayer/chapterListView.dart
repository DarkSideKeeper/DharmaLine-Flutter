import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChapterListViewWidget extends StatelessWidget {
  const ChapterListViewWidget({
    Key key,
    @required ScrollController scrollController,
    @required this.items,
  })  : scrollController = scrollController,
        super(key: key);

  final ScrollController scrollController;
  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: items[index].buildTitle(context),
          subtitle: items[index].buildSubtitle(context),
        );
      },
    );
  }
}

abstract class ListItem {
  ListItem(HeadingItem headingItem);

  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 24,
        color: Theme.of(context).primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildSubtitle(BuildContext context) => null;
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String title;
  final String body;
  final double fontSize;

  MessageItem(this.title, this.body, this.fontSize);

  Widget buildTitle(BuildContext context) => Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      );

  Widget buildSubtitle(BuildContext context) {
    if (body.isEmpty) {
      return Text('');
    }

    return Text(
      body,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: fontSize - 8,
      ),
    );
  }
}
