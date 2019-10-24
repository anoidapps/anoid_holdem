import 'Card.dart';
import 'CardSuit.dart';
import 'CardRank.dart';

class Deck
{

  List<Card> _deck = new List();

  Deck ()
  {
    for (CardSuit s in CardSuit.values)
      {
        for (CardRank r in CardRank.values)
          {
            Card temp = new Card(s, r);
            _deck.add(temp);
          }
      }
  }

  // Used to shuffle the Deck;
  shuffle ()
  {
    this.shuffle();
  }

  // Used to deal the top card of the Deck;
  deal ()
  {
    return this._deck.removeAt(0);
  }

  // Used to add a card to the Deck;
  add (Card card)
  {
    this._deck.add(card);
  }

  // Used to remove a specific Card;
  remove (Card card)
  {
    this._deck.remove(card);
  }

  // Returns the size of the Deck
  size ()
  {
    return this._deck.length;
  }

}