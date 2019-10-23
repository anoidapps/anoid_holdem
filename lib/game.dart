import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anoid Poker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  var deck;
  var flop;
  var turn;
  var river;
  var playerCards;
  var opponentCards;
  var commCard1 = '?';
  var commCard2 = '?';
  var commCard3 = '?';
  var commCard4 = '?';
  var commCard5 = '?';

  initCards(){
    deck = [2,3,4,5,6,7,8,9,10,11,12,13,14];
    dealCards();
  }

  dealCards(){
    playerCards = [3,4];
    opponentCards = [10,11];
    flop = [7,8,9];
    turn = 5;
    river = 6;
  }

  @override
  Widget build(BuildContext context) {
    initCards();

    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            buildOpponentsCards(),

            SizedBox(height: 50),

            buildCommunityCards(),

            SizedBox(height: 50),

            buildPlayerCards(),

            SizedBox(height: 50),

            buildShowFlopButton(),
          ],
        ),
      ),

    );
  }

  Widget buildOpponentsCards(){
    return Column(
      children: <Widget>[
        Text(
          'Opponents Cards',
        ),
        Text(
            '[${opponentCards[0].toString()}] [${opponentCards[1].toString()}]'
        ),
      ]
    );
  }

  Widget buildCommunityCards(){
    return Column(
        children: <Widget>[
          Text(
            'Community Cards',
          ),
          Text(
              '[$commCard1] [$commCard2] [$commCard3] [$commCard4] [$commCard5]'
          ),
        ]
    );
  }

  Widget buildPlayerCards(){
    return Column(
        children: <Widget>[
          Text(
            'My Cards',
          ),
          Text(
              '[${playerCards[0].toString()}] [${playerCards[1].toString()}]'
          ),
        ]
    );
  }

  Widget buildShowFlopButton(){

    return Column(
        children: <Widget>[
          FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                setState((){
                  commCard1 = flop[0].toString();
                  commCard2 = flop[1].toString();
                  commCard3 = flop[2].toString();
                });
              },
              child: Text("Show Flop")
          ),
          FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                setState((){
                  commCard4 = turn.toString();
                });
              },
              child: Text("Show Turn")
          ),
          FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                setState((){
                  commCard5 = river.toString();
                });
              },
              child: Text("Show River")
          ),
        ]
    );
  }
}
