import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'page_manager.dart';
import 'join.dart';
import 'main.dart';

class RoomGuestPage extends StatefulWidget {
  @override
  _RoomGuestPageState createState() => _RoomGuestPageState();
}

class _RoomGuestPageState extends State<RoomGuestPage> {
  late final PageManager _pageManager;
  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Simul Party'),
        ),
        body: new Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ValueListenableBuilder<ProgressBarState>(
                  valueListenable: _pageManager.progressNotifier,
                  builder: (_, value, __) {
                    return ProgressBar(
                      progress: value.current,
                      buffered: value.buffered,
                      total: value.total,
                    );
                  },
                ),
                ValueListenableBuilder<ButtonState>(
                  valueListenable: _pageManager.buttonNotifier,
                  builder: (_, value, __) {
                    switch (value) {
                      case ButtonState.loading:
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          width: 32.0,
                          height: 32.0,
                          child: CircularProgressIndicator(),
                        );
                      case ButtonState.paused:
                        return IconButton(
                          icon: Icon(Icons.play_arrow),
                          iconSize: 32.0,
                          onPressed: _pageManager.play,
                        );
                      case ButtonState.playing:
                        return IconButton(
                          icon: Icon(Icons.pause),
                          iconSize: 32.0,
                          onPressed: _pageManager.pause,
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
