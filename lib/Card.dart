import 'CardSuit.dart';
import 'CardRank.dart';
import 'RankCompartor.dart';

class Card implements Comparable <Card>
{
  var _suit;
  var _rank;
  var _suitCharacter;
  var _rankCharacter;

  String _name;
  bool _visible = false;

  Card (CardSuit suit, CardRank rank)
  {
    this._suit = suit;
    this._rank = rank;

    suitCharacterAssign (_suit);
    rankCharacterAssign (_rank);
  }

  // Returns Enum of Suit
  getSuit ()
  {
    return this._suit;
  }

  getSuitNumber ()
  {
    if (this._suit == CardSuit.Diamonds)
      return 1;

    if (this._suit == CardSuit.Hearts)
      return 2;

    if (this._suit == CardSuit.Clubs)
      return 3;

    if (this._suit == CardSuit.Spades)
      return 4;

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

  getValue ()
  {
    int value = 0;

    if (this.getRank() == CardRank.Ace)
      value = 1;

    else if (this.getRank() == CardRank.Two)
      value = 2;

    else if (this.getRank() == CardRank.Three)
      value = 3;

    else if (this.getRank() == CardRank.Four)
      value = 4;

    else if (this.getRank() == CardRank.Five)
      value = 5;

    else if (this.getRank() == CardRank.Six)
      value = 6;

    else if (this.getRank() == CardRank.Seven)
      value = 7;

    else if (this.getRank() == CardRank.Eight)
      value = 8;

    else if (this.getRank() == CardRank.Nine)
      value = 9;

    else if (this.getRank() == CardRank.Ten)
      value = 10;

    else if (this.getRank() == CardRank.Jack)
      value = 11;

    else if (this.getRank() == CardRank.Queen)
      value = 12;

    else
      value = 13;
    return value;
  }

  getRankCharacter ()
  {
    return this._rankCharacter;
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

  rankCharacterAssign (CardRank rank)
  {
    if (rank == CardRank.Ace)
      this._rankCharacter = 'A';

    else if (rank == CardRank.Two)
      this._rankCharacter = '2';

    else if (rank == CardRank.Three)
      this._rankCharacter = '3';

    else if (rank == CardRank.Four)
      this._rankCharacter = '4';

    else if (rank == CardRank.Five)
      this._rankCharacter = '5';

    else if (rank == CardRank.Six)
      this._rankCharacter = '6';

    else if (rank == CardRank.Seven)
      this._rankCharacter = '7';

    else if (rank == CardRank.Eight)
      this._rankCharacter = '8';

    else if (rank == CardRank.Nine)
      this._rankCharacter = '9';

    else if (rank == CardRank.Ten)
      this._rankCharacter = '10';

    else if (rank == CardRank.Jack)
      this._rankCharacter = 'J';

    else if (rank == CardRank.Queen)
      this._rankCharacter = 'Q';

    else
      this._rankCharacter = 'K';
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

  @override
  int compareTo (Card card)
  {
    return RankComparator.compare(this, card);
  }

}