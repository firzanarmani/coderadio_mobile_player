import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

enum PlayerStatus { playing, stopped, loading }

void main() => runApp(CodeRadioApp());

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

class CodeRadioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Radio',
      theme: ThemeData(
          primarySwatch: MaterialColor(0xFF0a0a23, primaryColorSwatch),
          fontFamily: "SaxMono"),
      home: HomePage(title: 'Code Radio'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer _player;
  PlayerStatus _playerStatus = PlayerStatus.stopped;

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
      body: Center(
          child: _playerStatus == PlayerStatus.loading
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
                )),
    );
  }
}
