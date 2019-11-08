import 'package:flutter/material.dart';
import 'main.dart';
import 'CardUtil.dart';
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
  var currentWager = 0;
  var newRound = true;
  var showAnteQuitButtons = false;
  var showBetCheckFoldButtons = false;
  var showCallFoldButtons = false;
  var showCheckRaiseFoldButtons = false;
  var showRoundResult = false;
  var winner = false;
  var chatMessage = '';
  var showChatMessage = false;

  initCards(){
    if(newRound){
      deck = new Deck();
      deck.shuffle();
      newRound = false;
      potMoney = 0;
      currentWager = 0;
      showAnteQuitButtons = true;
      showCallFoldButtons = false;
      showBetCheckFoldButtons = false;
      showCheckRaiseFoldButtons = false;
      showRoundResult = false;
      flop = null;
      turn = null;
      river = null;
      playerCards = null;
      opponentCards = null;
      showChatMessage = false;
    }
  }

  doAnte(){
    playerMoney -= 5;
    opponentMoney -= 5;
    potMoney = 10;
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
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  opponentsCardsWidget(),
                  SizedBox(height: 50),
                  buildMoneyPot(potMoney),
                  SizedBox(height: 30),
                  buildCommunityCards(),
                  SizedBox(height: 50),
                  playerCardsWidget(),
                  SizedBox(height: 50),
                  actionButtonWidget(),
                  showRoundResult? roundResultWidget(): SizedBox(width: 0)
                ],
              ),
            ),
            Container(
              //this is the overlay container
              child: chatBubble(chatMessage),
            )
          ],
        )
      ),
    );
  }

  Widget chatBubble(msg){
    var content = <Widget>[];
    if(showChatMessage){
      content = <Widget>[
        SizedBox(height:100),
        Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: 80),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Text(' ' + chatMessage + ' '),
                )
              ],
            )
        )
      ];
    }
    return Container(
      child: Column(
          children: content
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
        cardHandWidget(opponentCards),
        Text(
            'Money: \$' + opponentMoney.toString(),
            style: TextStyle(color: Colors.white)
        )
      ]
    );
  }

  Widget buildMoneyPot(pot){
    return Column(
      children: <Widget>[
        Text(
          'Pot',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        Text(
          '\$'+pot.toString(),
            style: TextStyle(color: Colors.white)
        )
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
          ),
          Text(
            'Money: \$' + playerMoney.toString(),
              style: TextStyle(color: Colors.white)
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

  Widget roundResultWidget(){
    var resultPhrase = 'You ' + (winner? 'win!': 'lose!');
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(resultPhrase, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(width: 30),
          FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: (){
              setState((){
                newRound = true;
              });
            },
            child: Text("New Round")
          )
        ],
      ),
    );
  }

  Widget actionButtonWidget(){
    var buttons = <Widget>[];
    if(showAnteQuitButtons){
      buttons.add(anteButton());
      buttons.add(SizedBox(width: 20));
      buttons.add(quitButton());
    }
    if(showBetCheckFoldButtons){
      buttons.add(betButton());
      buttons.add(SizedBox(width: 20));
      buttons.add(checkButton());
      buttons.add(SizedBox(width: 20));
      buttons.add(foldButton());
    }
    if(showCallFoldButtons){
      buttons.add(callButton());
      buttons.add(SizedBox(width: 20));
      buttons.add(foldButton());
    }
    if(showCheckRaiseFoldButtons){
      buttons.add(checkButton());
      buttons.add(SizedBox(width: 20));
      buttons.add(raiseButton());
      buttons.add(SizedBox(width: 20));
      buttons.add(foldButton());
    }

    return Row(
        mainAxisSize: MainAxisSize.min,
        children: buttons
    );
  }

  Widget anteButton(){
    return FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: (){
          doAnte();
          dealCards();
          setState((){
            showAnteQuitButtons = false;
            showBetCheckFoldButtons = true;
          });
        },
        child: Text("Ante (\$5)")
    );
  }

  Widget quitButton(){
    return FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp())
          );
        },
        child: Text("Quit")
    );
  }

  Widget betButton(){
    return FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: (){
          playerMoney = playerMoney - 10;
          potMoney = potMoney + 10;
          currentWager = 10;
          hideButtons();
          Future.delayed(const Duration(milliseconds: 2000), () {
            doOpponentTurn();
            setState(() {
            });
          });
          setState((){
          });
        },
        child: Text("Bet (\$10)")
    );
  }

  Widget callButton(){
    return FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: (){
          var newMoney = playerMoney - currentWager;
          potMoney = potMoney + currentWager;
          Future.delayed(const Duration(milliseconds: 2000), () {
            doOpponentTurn();
            setState(() {
            });
          });
          setState((){
            playerMoney = newMoney;
            potMoney = potMoney;
          });
        },
        child: Text("Call (\$" + currentWager.toString() + ")")
    );
  }

  Widget checkButton(){
    return FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: (){
          hideButtons();
          Future.delayed(const Duration(milliseconds: 2000), () {
            doOpponentTurn();
            setState(() {
            });
          });
          setState((){
          });
        },
        child: Text("Check")
    );
  }

  Widget raiseButton(){
    var raiseCost = currentWager + 10;
    return FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: (){
          var newMoney = playerMoney - raiseCost;
          var newPot = potMoney + raiseCost;
          setState((){
            currentWager = raiseCost;
            playerMoney = newMoney;
            potMoney = newPot;
          });
        },
        child: Text("Raise (\$" + raiseCost.toString() + ")")
    );
  }

  Widget foldButton(){
    return FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: (){
          setState((){
            opponentMoney = opponentMoney+potMoney;
            newRound = true;
          });
        },
        child: Text("Fold")
    );
  }

  doOpponentTurn(){
    if(currentWager > 0){
      doOpponentCall();
    }
    else{
      doOpponentCheck();
    }
  }

  doOpponentCheck(){
    showChatMessage = true;
    chatMessage = "Check";
    Future.delayed(const Duration(milliseconds: 2000), () {
      showChatMessage = false;
      setState(() {
      });
    });
    if(river != null){
      currentWager = 0;
      showAnteQuitButtons = false;
      showCallFoldButtons = false;
      showBetCheckFoldButtons = false;
      showCheckRaiseFoldButtons = false;
      showRoundResult = true;
      showOpponentHand();
      computeRoundResult();
    }
    else{
      if(flop == null){
        flop = dealFlop();
      }
      else if(turn == null){
        turn = dealTurn();
      }
      else if(river == null){
        river = dealRiver();
      }
      currentWager = 0;
      showAnteQuitButtons = false;
      showCallFoldButtons = false;
      showBetCheckFoldButtons = true;
      showCheckRaiseFoldButtons = false;
    }
  }

  doOpponentBet(){

  }

  doOpponentCall(){
    showChatMessage = true;
    chatMessage = "Call";
    Future.delayed(const Duration(milliseconds: 2000), () {
      showChatMessage = false;
      setState(() {
      });
    });
    if(river != null){
      potMoney = potMoney + currentWager;
      opponentMoney = opponentMoney - currentWager;
      currentWager = 0;
      showAnteQuitButtons = false;
      showCallFoldButtons = false;
      showBetCheckFoldButtons = false;
      showCheckRaiseFoldButtons = false;
      showRoundResult = true;
      showOpponentHand();
      computeRoundResult();
    }
    else{
      if(flop == null){
        flop = dealFlop();
      }
      else if(turn == null){
        turn = dealTurn();
      }
      else if(river == null){
        river = dealRiver();
      }
      potMoney = potMoney + currentWager;
      opponentMoney = opponentMoney - currentWager;
      currentWager = 0;
      showAnteQuitButtons = false;
      showCallFoldButtons = false;
      showBetCheckFoldButtons = true;
      showCheckRaiseFoldButtons = false;
    }
  }

  doOpponentRaise(){

  }

  doOpponentFold(){

  }

  hideButtons(){
    showAnteQuitButtons = false;
    showCallFoldButtons = false;
    showBetCheckFoldButtons = false;
    showCheckRaiseFoldButtons = false;
  }

  computeRoundResult(){
    List<c.Card> p1Hand = [playerCards[0], playerCards[1], flop[0], flop[1], flop[2], turn, river];
    List<c.Card> p2Hand = [opponentCards[0], opponentCards[1], flop[0], flop[1], flop[2], turn, river];
    var playerScore = CardUtil.scoreHand(p1Hand);
    var opponentScore = CardUtil.scoreHand(p2Hand);
    print('playerScore = ' + playerScore);
    print('opponentScore = ' + opponentScore);
    winner = playerScore > opponentScore? true: false;
    if(winner){
      playerMoney = playerMoney + potMoney;
    }
    else{
      opponentMoney = opponentMoney + potMoney;
    }
    potMoney = 0;
  }
}
