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
  PlayingCard(value, suite){
    this.value = value;
    this.suite = suite;
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
  var commCard1Color = Colors.white;
  var commCard2Color = Colors.white;
  var commCard3Color = Colors.white;
  var commCard4Color = Colors.white;
  var commCard5Color = Colors.white;

  initCards(){
    deck = [2,3,4,5,6,7,8,9,10,11,12,13,14];
    dealCards();
  }

  dealCards(){
    playerCards = [PlayingCard('3', 'Heart'), PlayingCard('4', 'Heart')];
    opponentCards = [PlayingCard('10', 'Spade'), PlayingCard('J', 'Spade')];
    flop = [PlayingCard('7', 'Heart'), PlayingCard('8', 'Spade'), PlayingCard('9', 'Spade')];
    turn = PlayingCard('5', 'Heart');
    river = PlayingCard('6', 'Heart');
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
          ),
          communityCardsWidget(flop, turn, river)
        ]
    );
  }

  Widget playerCardsWidget(){
    return Column(
        children: <Widget>[
          Text(
            'My Cards',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
          ),
          Container(
              alignment: Alignment.center,
              child: cardHandWidget(playerCards)
          )
        ]
    );
  }

  Widget communityCardsWidget(flop, turn, river){
    return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            playingCardWidget(flop[0], commCard1Color),
            SizedBox(width: 20),
            playingCardWidget(flop[1], commCard2Color),
            SizedBox(width: 20),
            playingCardWidget(flop[2], commCard3Color),
            SizedBox(width: 20),
            playingCardWidget(turn, commCard4Color),
            SizedBox(width: 20),
            playingCardWidget(river, commCard5Color),
          ],
        )
    );
  }

  Widget cardHandWidget(cards){
    return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            playingCardWidget(cards[0], Colors.black),
            SizedBox(width: 20),
            playingCardWidget(cards[1], Colors.black),
          ],
        )
    );
  }

  Widget playingCardWidget(card, color){
    return Container(

        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Column(
            children: <Widget>[
              Text(
                card.value,
                style: TextStyle(color: color),
              ),
              Text(
                  card.suite,
                  style: TextStyle(color: color),
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
                  commCard1Color = Colors.black;
                  commCard2Color = Colors.black;
                  commCard3Color = Colors.black;
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
                  commCard4Color = Colors.black;
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
                  commCard5Color = Colors.black;
                });
              },
              child: Text("Show River")
          ),
        ]
    );
  }
}
