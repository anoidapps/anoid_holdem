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
  var potMoney = 0;
  var playerMoney = 1000;
  var opponentMoney = 1000;
  var newRound = true;

  initCards(){
    if(newRound){
      deck = new Deck();
      deck.shuffle();
      dealCards();
      newRound = false;
    }
  }

  dealCards(){
    c.Card card1 = deck.deal();
    c.Card card2 = deck.deal();
    card1.show();
    card2.show();
    playerCards = [card1, card2];
    opponentCards = [deck.deal(), deck.deal()];
  }

  dealFlop(){
    c.Card card1 = deck.deal();
    c.Card card2 = deck.deal();
    c.Card card3 = deck.deal();
    card1.show();
    card2.show();
    card3.show();
    return [card1, card2, card3];
  }

  dealTurn(){
    c.Card card = deck.deal();
    card.show();
    return card;
  }

  dealRiver(){
    c.Card card = deck.deal();
    card.show();
    showOpponentHand(); //move this later to after betting round
    return card;
  }

  showOpponentHand(){
    opponentCards[0].show();
    opponentCards[1].show();
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
    var content = <Widget>[];
    if(flop != null){
      content.add(cardWidget(flop[0]));
      content.add(SizedBox(width: 20));
      content.add(cardWidget(flop[1]));
      content.add(SizedBox(width: 20));
      content.add(cardWidget(flop[2]));
    }
    if(turn != null){
      content.add(SizedBox(width: 20));
      content.add(cardWidget(turn));
    }
    if(river != null){
      content.add(SizedBox(width: 20));
      content.add(cardWidget(river));
    }
    return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: content
        )
    );
  }

  Widget cardHandWidget(cards){
    var content = <Widget>[];
    if(cards != null){
      content.add(cardWidget(cards[0]));
      content.add(SizedBox(width: 20));
      content.add(cardWidget(cards[1]));
    }
    return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: content
        )
    );
  }

  Widget cardWidget(c.Card card){
    var opacity = 0.0;
    if(card.getVisible()){
      opacity = 1.0;
    }
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Opacity(
            opacity: opacity,
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
                var cards = dealFlop();
                setState((){
                  flop = cards;
                });
              },
              child: Text("Show Flop")
          ),
          SizedBox(width: 20),
          FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                var card = dealTurn();
                setState((){
                  turn = card;
                });
              },
              child: Text("Show Turn")
          ),
          SizedBox(width: 20),
          FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                var card = dealRiver();
                setState((){
                  river = card;
                });
              },
              child: Text("Show River")
          ),
        ]
    );
  }
}
