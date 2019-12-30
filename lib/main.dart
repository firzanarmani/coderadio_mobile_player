import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:web_socket_channel/io.dart';
import 'package:coderadio_mobile_player/models/radio_info.dart';
import 'package:coderadio_mobile_player/models/song.dart';

enum PlayerStatus { playing, stopped, loading }

Map<int, Color> primaryColorSwatch = {
  50: Color.fromRGBO(10, 10, 35, .1),
  100: Color.fromRGBO(10, 10, 35, .2),
  200: Color.fromRGBO(10, 10, 35, .3),
  300: Color.fromRGBO(10, 10, 35, .4),
  400: Color.fromRGBO(10, 10, 35, .5),
  500: Color.fromRGBO(10, 10, 35, .6),
  600: Color.fromRGBO(10, 10, 35, .7),
  700: Color.fromRGBO(10, 10, 35, .8),
  800: Color.fromRGBO(10, 10, 35, .9),
  900: Color.fromRGBO(10, 10, 35, 1),
};

void main() => runApp(CodeRadioApp());

class CodeRadioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Code Radio',
        theme: ThemeData(
            primarySwatch: MaterialColor(0xFF0a0a23, primaryColorSwatch),
            fontFamily: "SaxMono"),
        home: HomePage(
          title: 'Code Radio',
          channel: IOWebSocketChannel.connect(
              "wss://coderadio-admin.freecodecamp.org/api/live/nowplaying/coderadio?encoding=text"),
        ));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.channel}) : super(key: key);
  final String title;
  final IOWebSocketChannel channel;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer _player;
  PlayerStatus _playerStatus = PlayerStatus.stopped;

  // TODO: Find a better way to write this
  static Song _blankSong =
      new Song(album: "", art: "", artist: "", id: "", text: "", title: "");
  static AudioStream _blankStream = new AudioStream(
      bitrate: 0,
      id: 0,
      listeners: new Listeners(current: 0, unique: 0, total: 0),
      name: "",
      url: "");
  RadioInfo _initialData = new RadioInfo(
      station: new Station(
          id: 0, listenUrl: "", mounts: [_blankStream], relays: [_blankStream]),
      listeners: new Listeners(current: 0, unique: 0, total: 0),
      currentSong: new CurrentSong(
          duration: 0, elapsed: 0, playedAt: 0, remaining: 0, song: _blankSong),
      nextSong: new NextSong(song: _blankSong),
      songHistory: [new SongHistory(song: _blankSong)]);

  void _play() async {
    setState(() {
      _playerStatus = PlayerStatus.loading;
    });
    // TODO: Fetch available path
    _player = AudioPlayer();
    String _streamPath =
        "https://coderadio-admin.freecodecamp.org/radio/8010/radio.mp3";
    await _player.setUrl(_streamPath);
    _player.play();
    setState(() {
      _playerStatus = PlayerStatus.playing;
    });
  }

  void _stop() async {
    await _player.stop();
    setState(() {
      _playerStatus = PlayerStatus.stopped;
    });
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
    widget.channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.title,
              style: TextStyle(color: Color.fromARGB(255, 10, 10, 35))),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                _playerStatus == PlayerStatus.loading
                    ? CircularProgressIndicator()
                    : IconButton(
                        icon: _playerStatus == PlayerStatus.playing
                            ? Icon(Icons.stop)
                            : Icon(Icons.play_arrow),
                        onPressed: () {
                          if (_playerStatus == PlayerStatus.playing) {
                            _stop();
                          } else {
                            _play();
                          }
                        },
                      ),
                StreamBuilder(
                    stream: widget.channel.stream,
                    initialData: jsonEncode(_initialData),
                    builder: (context, snapshot) {
                      var radioInfo =
                          RadioInfo.fromJson(jsonDecode(snapshot.data));
                      return Column(children: <Widget>[
                        Text(radioInfo.currentSong.elapsed.toString() +
                            "/" +
                            radioInfo.currentSong.duration.toString()),
                        Text(radioInfo.currentSong.song.title),
                        Text(radioInfo.currentSong.song.artist),
                      ]);
                    })
              ],
            )));
  }
}
