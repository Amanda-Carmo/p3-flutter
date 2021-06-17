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
                ValueListenableBuilder<String>(
                  valueListenable: _pageManager.songTitleNotifier,
                  builder: (_, title, __) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(title, style: TextStyle(fontSize: 40)),
                    );
                  },
                ),
                SizedBox(height: 25),
                // ------------------------- Player ----------------------------
                ValueListenableBuilder<ProgressBarState>(
                  valueListenable: _pageManager.progressNotifier,
                  builder: (_, value, __) {
                    return ProgressBar(
                      onSeek: _pageManager.seek,
                      progress: value.current,
                      buffered: value.buffered,
                      total: value.total,
                    );
                  },
                ),
                ButtonBar(
                  children: <Widget>[
                    ValueListenableBuilder<bool>(
                      valueListenable: _pageManager.firstNotifier,
                      builder: (_, isFirst, __) {
                        return IconButton(
                          icon: Icon(Icons.skip_previous),
                          onPressed: (isFirst)
                              ? null
                              : _pageManager.onPreviousSongButtonPressed,
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
                      // ------------------------------------------------------------
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _pageManager.lastNotifier,
                      builder: (_, isLast, __) {
                        return IconButton(
                          icon: Icon(Icons.skip_next),
                          onPressed: (isLast)
                              ? null
                              : _pageManager.onNextSongButtonPressed,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
