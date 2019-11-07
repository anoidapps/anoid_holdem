import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anoid Holdem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Anoid Hold\'em'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Anoid Hold\'em',
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Game())
                );
              },
              child: Text("Start new game")
            )

          ],
        ),
      ),

    );
  }
}
