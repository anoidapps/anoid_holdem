import 'package:flutter/material.dart';
import 'Deck.dart';
import 'Card.dart' as c;

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
  Deck deck;
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
    dealCards();
  }

  dealCards(){
    deck = new Deck();
    deck.shuffle();
    playerCards = [deck.deal(), deck.deal()];
    opponentCards = [deck.deal(), deck.deal()];
    flop = [deck.deal(), deck.deal(), deck.deal()];
    turn = deck.deal();
    river = deck.deal();
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

  Widget playingCardWidget(c.Card card, color){
    return Container(

        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Column(
            children: <Widget>[
              Text(
                card.getRankString(),
                style: TextStyle(color: color),
              ),
              Text(
                  card.getSuitString(),
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
