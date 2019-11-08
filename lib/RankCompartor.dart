
import 'Card.dart';
import 'CardRank.dart';


class RankComparator
{
//  compare (Card card1, Card card2)
//  {
//
//  }

  static compare (Card card1, Card card2)
  {
    int card1Value = _setCardScore(card1);
    int card2Value = _setCardScore(card2);

    if (card1Value > card2Value)
    {
      return 1;
    }

    if (card2Value > card1Value)
    {
      return -1;
    }

    if (card1Value == card2Value)
    {
      return 0;
    }

  }

  static _setCardScore (Card card)
  {
    int cardValue;

    switch (card.getRank())
    {
      case CardRank.Ace:
        {
          cardValue = 1;
          break;
        }

      case CardRank.Two:
        {
          cardValue = 2;
          break;
        }

      case CardRank.Three:
        {
          cardValue = 3;
          break;
        }

      case CardRank.Four:
        {
          cardValue = 4;
          break;
        }

      case CardRank.Five:
        {
          cardValue = 5;
          break;
        }

      case CardRank.Six:
        {
          cardValue = 6;
          break;
        }

      case CardRank.Seven:
        {
          cardValue = 7;
          break;
        }

      case CardRank.Eight:
        {
          cardValue = 8;
          break;
        }

      case CardRank.Nine:
        {
          cardValue = 9;
          break;
        }

      case CardRank.Ten:
        {
          cardValue = 10;
          break;
        }

      case CardRank.Jack:
        {
          cardValue = 11;
          break;
        }

      case CardRank.Queen:
        {
          cardValue = 12;
          break;
        }

      case CardRank.King:
        {
          cardValue = 13;
          break;
        }

      default:
        {
          break;
        }
    }

    return cardValue;
  }

}