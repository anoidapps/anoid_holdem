import 'Hand.dart';

class Player
{
  var _name;
  Hand playerHand;

  Player (String name)
  {
    this._name = name;
    playerHand = new Hand();
  }

  // Returns player name
  getName ()
  {
    return this._name;
  }

  // Sets visible to True for all cards in hand;
  showHand ()
  {
    for (int i = 0; i < this.playerHand.size(); i++)
      {
        this.playerHand.getCard(i).show();
      }
  }

  // Sets visible to False for all cards in hand;
  hideHand ()
  {
    for (int i = 0; i < this.playerHand.size(); i++)
    {
      this.playerHand.getCard(i).hide();
    }
  }
}