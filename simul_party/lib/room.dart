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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Simul Party'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ProgressBar(progress: Duration.zero, total: Duration.zero),
              IconButton(
                iconSize: 32.0,
                icon: Icon(Icons.play_arrow),
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
