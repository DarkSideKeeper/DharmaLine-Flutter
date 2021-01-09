import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import '../../Common/loadingView.dart';
import '../../Common/webView.dart';

class HomeFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeFeedState();
  }
}

class _HomeFeedState extends State<HomeFeed> {
  var client = new http.Client();

  List<RssItem> items;

  _HomeFeedState() {
    client
        .get(
            "https://www.ryt9.com/tag/%E0%B8%98%E0%B8%A3%E0%B8%A3%E0%B8%A1%E0%B8%B0/rss.xml")
        .then((response) {
      return response.body;
    }).then((bodyString) {
      var channel = new RssFeed.parse(bodyString);
      items = channel.items;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          itemBuilder: (context, index) {
            int row = index + 1;
            String title = items[index]
                .title
                .replaceAll('&ldquo;', '"')
                .replaceAll('&rdquo;', '"')
                .replaceAll('&hellip;', '…');
            return ListTile(
              leading: ExcludeSemantics(
                child: CircleAvatar(child: Text('$row')),
              ),
              title: Text(title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebView(item: items[index]),
                  ),
                );
              },
            );
          },
        ),
      );
    } else {
      return Scaffold(
        body: ProgressIndicatorDemo(),
      );
    }
  }
}
