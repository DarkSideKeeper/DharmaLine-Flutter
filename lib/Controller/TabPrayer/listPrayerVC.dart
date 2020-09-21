import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class ListPrayerVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPrayerState();
  }
}

class _ListPrayerState extends State<ListPrayerVC> {
  AssetsAudioPlayer get audioPlayer => AssetsAudioPlayer.withId("music");
  ScrollController _scrollController = ScrollController();
  double fontSize = 24;
  double jumpTo = 1;
  bool isStopTimer = false;

  @override
  void initState() {
    super.initState();

    playAudio();
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
        title: Text("ListPrayerVC"),
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
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'ข้อความบทสวด',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                          ),
                        ),
                        subtitle: Text(
                          'ข้อความแปลบทสวด',
                          style: TextStyle(fontSize: fontSize),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonTheme(
                    child: RaisedButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: () {
                        audioPlayer.play();
                        Future.delayed(const Duration(milliseconds: 5000), () {
                          setupTimer();
                        });
                      },
                    ),
                  ),
                  ButtonTheme(
                    child: RaisedButton(
                      child: Icon(Icons.pause),
                      onPressed: () => audioPlayer.pause(),
                    ),
                  ),
                  ButtonTheme(
                    child: RaisedButton(
                      child: Icon(Icons.zoom_in),
                      onPressed: () => incrementFontSize(),
                    ),
                  ),
                  ButtonTheme(
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

  playAudio() {
    audioPlayer.open(Audio('assets/audios/1.mp3'), autoStart: false);
  }

  incrementFontSize() {
    fontSize += 2;
    setState(() {});
  }

  decrementFontSize() {
    fontSize -= 2;
    setState(() {});
  }

  setupTimer() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (isStopTimer) {
        timer.cancel();
      }
      _scrollToBottom();
    });
  }

  _scrollToBottom() {
    _scrollController.jumpTo(jumpTo++);
  }

  _onEndScroll(ScrollMetrics metrics) {
    if (_scrollController.offset >= metrics.maxScrollExtent) {
      isStopTimer = true;
    }
  }
}
