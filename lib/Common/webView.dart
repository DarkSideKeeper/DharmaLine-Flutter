import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webfeed/webfeed.dart';
import 'loadingView.dart';

class WebView extends StatelessWidget {
  final RssItem item;

  const WebView({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข่าวธรรมะ'),
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(
        builder: (BuildContext context) {
          return WebviewScaffold(
            url: item.link,
            mediaPlaybackRequiresUserGesture: false,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: ProgressIndicatorDemo(),
          );
        },
      ),
    );
  }
}
