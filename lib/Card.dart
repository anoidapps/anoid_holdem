import 'CardSuit.dart';
import 'CardRank.dart';

class Card
{
  var _suit;
  var _rank;
  var _suitCharacter;

  String _name;
  bool _visible = false;

  Card (CardSuit suit, CardRank rank)
  {
    this._suit = suit;
    this._rank = rank;

    suitCharacterAssign (_suit);
  }

  // Returns Enum of Suit
  getSuit ()
  {
    return this._suit;
  }

  // Returns the suit character
  getSuitCharacter ()
  {
    return this._suitCharacter;
  }

  // Returns String of Suit
  getSuitString ()
  {
    return describeEnum(this._suit);
  }

  // Returns Enum of Rank
  getRank ()
  {
    return this._rank;
  }

  // Returns String Rank
  getRankString ()
  {
    return describeEnum(this._rank);
  }

  // Visible = True
  show ()
  {
    this._visible = true;
  }

  // Visible = False
  hide ()
  {
    this._visible = false;
  }

  // Returns visible value
  getVisible ()
  {
    return this._visible;
  }

  suitCharacterAssign (CardSuit suit)
  {
    if (suit == CardSuit.Spades)
      this._suitCharacter = '♠';

    else if (suit == CardSuit.Clubs)
      this._suitCharacter = '♣';

    else if (suit == CardSuit.Hearts)
      this._suitCharacter = '♥';

    else
      this._suitCharacter = '♦';
  }

  // Compares Cards based on index value;
  compare (Card card)
  {
    if (this._rank.index == card._rank.index)
      return 0;

    else if (this._rank.index < card._rank.index)
      return -1;

    else
      return 1;
  }

  // Returns String
  toString ()
  {
    String nameRank = describeEnum(this._rank);
    String nameSuit = describeEnum(this._suit);


    this._name = nameRank + " of " + nameSuit + ' ' + this._suitCharacter;
    return this._name;
  }

  // Parses the class name off of the enum
  // https://api.flutter.dev/flutter/foundation/describeEnum.html
  String describeEnum(Object enumEntry)
  {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

}