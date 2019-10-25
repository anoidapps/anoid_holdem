import 'Card.dart';
import 'Deck.dart';

class Hand
{
  List<Card> _hand = new List();

  Hand ();

  // Used to add a card to the Deck;
  add (Card card)
  {
    this._hand.add(card);
  }

  // Used to remove a specific Card;
  remove (Card card)
  {
    Card tempCard = card;
    this._hand.remove(card);

    return tempCard;
  }

  // Returns the size of the Deck
  size ()
  {
    return this._hand.length;
  }

  // Returns the card specified, without removing it;
  // This is done by index;
  getCard (int i)
  {
    return this._hand[i];
  }

  // Allows the retrieval of a card without removing it.
  // Returns index number
  getCardIndex (Card card)
  {
    return (this._hand.indexOf(card));
  }

}