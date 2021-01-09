import 'dart:async';

import 'package:dharmaline/Model/chantTopicModel.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'chapterListView.dart';

class ListPrayerVC extends StatefulWidget {
  const ListPrayerVC({
    Key key,
    @required this.topic,
  });

  final ChantTopicModel topic;

  @override
  State<StatefulWidget> createState() {
    return _ListPrayerState();
  }
}

class _ListPrayerState extends State<ListPrayerVC> {
  ChantTopicModel get topic => widget.topic;
  AssetsAudioPlayer get audioPlayer => AssetsAudioPlayer.withId("music");
  ScrollController scrollController = ScrollController();
  double fontSize = 24;
  double jumpTo = 1;
  bool isPauseScroll = false;
  bool isStopTimer = false;

  @override
  void initState() {
    super.initState();

    playAudio('assets/audio/1.mp3');
  }

  @override
  void dispose() {
    super.dispose();

    audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      _onEndScroll(scrollNotification.metrics);
                    }
                    return true;
                  },
                  child: ChapterListViewWidget(
                    scrollController: scrollController,
                    items: createListViewItem(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 80,
                    child: RaisedButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: () {
                        audioPlayer.play();
                        if (isPauseScroll) {
                          isPauseScroll = false;
                        } else {
                          Future.delayed(const Duration(milliseconds: 5000),
                              () {
                            setupTimer();
                          });
                        }
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 80,
                    child: RaisedButton(
                        child: Icon(Icons.pause),
                        onPressed: () {
                          isPauseScroll = true;
                          audioPlayer.pause();
                        }),
                  ),
                  ButtonTheme(
                    minWidth: 80,
                    child: RaisedButton(
                      child: Icon(Icons.zoom_in),
                      onPressed: () => incrementFontSize(),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 80,
                    child: RaisedButton(
                      child: Icon(Icons.zoom_out),
                      onPressed: () => decrementFontSize(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void playAudio(String path) {
    audioPlayer.open(Audio(path), autoStart: false);
  }

  void incrementFontSize() {
    fontSize += 2;
    setState(() {});
  }

  void decrementFontSize() {
    fontSize -= 2;
    setState(() {});
  }

  void setupTimer() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (isStopTimer) {
        timer.cancel();
      }
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (!isPauseScroll) {
      scrollController.jumpTo(jumpTo++);
    }
  }

  void _onEndScroll(ScrollMetrics metrics) {
    if (scrollController.offset >= metrics.maxScrollExtent) {
      isStopTimer = true;
    }
  }

  List<ListItem> createListViewItem() {
    List<ListItem> items = [];
    topic.chapterModel.forEach((model) {
      items.add(HeadingItem(model.title));

      for (int index = 0; index < model.chapters.length; index++) {
        items.add(MessageItem(
            model.chapters[index], model.meanings[index], fontSize));
      }
    });
    return items;
  }
}
