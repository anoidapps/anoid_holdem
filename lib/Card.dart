import 'CardSuit.dart';
import 'CardRank.dart';

class Card
{
  var _suit;
  var _rank;
  String _name;
  bool _visible = false;

  Card (CardSuit suit, CardRank rank)
  {
    this._suit = suit;
    this._rank = rank;
  }

  getSuit ()
  {
    return this._suit;
  }

  getRank ()
  {
    return this._rank;
  }

  show ()
  {
    this._visible = true;
  }

  hide ()
  {
    this._visible = false;
  }

  getVisible ()
  {
    return this._visible;
  }

  toString ()
  {
    this._name = this.getRank() + " of " + this.getSuit();
    return this._name;
  }

}