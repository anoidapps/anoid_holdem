import 'Card.dart';
import 'RankCompartor.dart';

class Hand
{
  List<Card> _hand;

  Hand ()
  {
    this._hand = new List();
  }

  setHand (List<Card> cards){
    this._hand = cards;
  }

  // Used to add a card to the Deck;
  add (Card card)
  {
    this._hand.add(card);
  }

  addFront (Card card)
  {
    List<Card> tempHand = new List();
    tempHand.add(card);

    while (this._hand.isNotEmpty)
    {
      tempHand.add(this._hand.removeAt(0));
    }

    while (tempHand.isNotEmpty)
    {
      this.add(tempHand.removeAt(0));
    }
  }

  // Used to remove a specific Card;
  remove (int i)
  {
    Card tempCard = this._hand.removeAt(i);
    return tempCard;
  }

  // Used to remove a specific Card;
  removeCard (Card card)
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
  get (int i)
  {
    return this._hand[i];
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

  sort ()
  {
    Comparator<Card> cardComparator = (card1, card2) => card1.compare(card2);
    this._hand.sort(cardComparator);
  }

  @override
  String toString()
  {
    String handString = "";

    for (int i = 0; i < this.size(); i++)
      {
        handString = handString + this.get(i).toString() + " : ";
      }
    return handString;
  }
}