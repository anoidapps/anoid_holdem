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
  var commCard1Opacity = 0.0;
  var commCard2Opacity = 0.0;
  var commCard3Opacity = 0.0;
  var commCard4Opacity = 0.0;
  var commCard5Opacity = 0.0;
  var potMoney = 0;
  var playerMoney = 1000;
  var opponentMoney = 1000;
  var newRound = true;

  initCards(){
    if(newRound){
      dealCards();
      newRound = false;
    }
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
            playingCardWidget(flop[0], commCard1Opacity),
            SizedBox(width: 20),
            playingCardWidget(flop[1], commCard2Opacity),
            SizedBox(width: 20),
            playingCardWidget(flop[2], commCard3Opacity),
            SizedBox(width: 20),
            playingCardWidget(turn, commCard4Opacity),
            SizedBox(width: 20),
            playingCardWidget(river, commCard5Opacity),
          ],
        )
    );
  }

  Widget cardHandWidget(cards){
    return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            playingCardWidget(cards[0], 1.0),
            SizedBox(width: 20),
            playingCardWidget(cards[1], 1.0),
          ],
        )
    );
  }

  Widget playingCardWidget(c.Card card, double opacity){
    return Opacity(
        opacity: opacity,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5.0)
            ),
            child: Column(
                children: <Widget>[
                  Text(
                    card.getRankCharacter().toString(),
                  ),
                  Text(
                    card.getSuitCharacter(),
                  ),
                ]
            )
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
                  commCard1Opacity = 1.0;
                  commCard2Opacity = 1.0;
                  commCard3Opacity = 1.0;
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
                  commCard4Opacity = 1.0;
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
                  commCard5Opacity = 1.0;
                });
              },
              child: Text("Show River")
          ),
        ]
    );
  }
}
