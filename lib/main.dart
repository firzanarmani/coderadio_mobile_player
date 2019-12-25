import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Play',
            ),
          ],
        ),
      ),
    );
  }
}
