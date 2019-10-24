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

class PlayingCard{
  String suite = '';
  String value = '';
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
        title: Text("Poker Table"),
      ),
      body: Center(
        child: Container(
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              opponentsCardsWidget(),
              SizedBox(height: 50),
              buildCommunityCards(),
              SizedBox(height: 50),
              playerCardsWidget(),
              SizedBox(height: 50),
              actionButtonWidget(),
            ],
          ),
        )
      ),

    );
  }

  Widget opponentsCardsWidget(){
    return Column(
      children: <Widget>[
        Text(
          'Opponents Cards',
        ),
        cardHandWidget(opponentCards)
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

  Widget playerCardsWidget(){
    return Column(
        children: <Widget>[
          Text(
            'My Cards',
          ),
          Container(
              alignment: Alignment.center,
              child: cardHandWidget(playerCards)
          )
        ]
    );
  }

  Widget cardHandWidget(cards){
    return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            playingCardWidget(cards[0].toString(), "Heart"),
            SizedBox(width: 20),
            playingCardWidget(cards[1].toString(), "Heart"),
          ],
        )
    );
  }

  Widget playingCardWidget(value, suite){
    return Container(

        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Column(
            children: <Widget>[
              Text(
                value,
              ),
              Text(
                  suite
              ),
            ]
        )
    );
  }

  Widget actionButtonWidget(){
    return Row(
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(width: 20),
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
          SizedBox(width: 20),
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
