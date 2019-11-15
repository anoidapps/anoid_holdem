import 'Card.dart';
import 'Deck.dart';
import 'Hand.dart';
import 'RankCompartor.dart';


class CardUtil
{

  static scoreHand (List <Card> passedHand)
  {
    Hand hand = Hand();
    while (passedHand.isNotEmpty)
      {
        hand.add(passedHand.removeAt(0));
      }

    var score = 0;

    // If it matches one it will not match another
    // This is done to keep the score from wildly growing when you
    // get a full house or straight flush.
    if (isStraightFlush(hand) > 0)
    {
      score = 1000 + isStraightFlush(hand);
    }

    else if (isFourKind(hand) > 0)
    {
      score = 900 + isFourKind(hand);
    }

    else if (isFullHouse(hand) [0] > 0 && isFullHouse(hand) [1] > 0)
    {
      int i = isFullHouse(hand) [0];
      int j = isFullHouse(hand) [1];
      score = 800 + i + j;
    }

    else if (isFlush(hand) > 0)
    {
      score = 700 + isFlush(hand);
    }

    else if (isStraight(hand) > 0)
    {
      score = 600 + isStraight(hand);
    }

    else if (isThreeKind(hand) > 0)
    {
      score = 500 + isThreeKind(hand);
    }

    else if (isTwoPair(hand) [0] > 0 && isTwoPair(hand) [1] > 0)
    {
      int i = isTwoPair(hand) [0];
      int j = isTwoPair(hand) [1];
      score = 400 + i + j;
    }

    else if (isPair(hand) > 0)
    {
      score = 300 + isPair(hand);
    }

    else
    {
      hand.sort();
      score = 200 + hand.get(4).getValue();
    }

    return score;
  }

  /*
   * Checks for pair.
   * @param hand
   * @return integer
   */
  static isPair (Hand hand)
  {
    var pair = -1;
    hand.sort();

    print("Line 86 " + hand.toString() + "\n");

    if (hand.get(0).getValue() == hand.get(1).getValue())
    {
      pair = hand.get(6).getValue;
    }

    else if (hand.size() == 7)
    {
      if (hand.get(1).getValue() == hand.get(2).getValue())
      {
        pair = hand.get(6).getValue;
      }

      else if (hand.get(2).getValue() == hand.get(3).getValue())
      {
        pair = hand.get(6).getValue;
      }

      else if (hand.get(3).getValue() == hand.get(4).getValue())
      {
        pair = hand.get(6).getValue;
      }

      else if (hand.get(4).getValue() == hand.get(5).getValue())
      {
        pair = hand.get(6).getValue;
      }

      else if (hand.get(5).getValue() == hand.get(6).getValue())
      {
        pair = hand.get(6).getValue;
      }
    }

    return pair;
  }

  /*
   * Checks for Two Pairs
   * @param hand
   * @return integer Array
   */
  static isTwoPair (Hand hand)
  {
    Hand tempHand = new Hand();
    hand.sort();

    int i = 0;
    while (i < hand.size())
    {
      tempHand.add(hand.get(i));
      i++;
    }

    i = 0;
//    while (i < tempHand.size())
//    {
//      hand.add(tempHand.get(i));
//      i++;
//    }

    List<int> isTwoPair = new List(2);

    i = 0;
    int j = 0;

    isTwoPair[0] = -1;
    isTwoPair[1] = -1;

    i = isPair(tempHand);

    if (i > 0)
    {
      if (tempHand.get(0).getValue() == tempHand.get(1).getValue())
      {
        for (int k = 1; k > -1; k--)
        {
          tempHand.remove(k);
        }
      }

      else if (tempHand.get(1).getValue() == tempHand.get(2).getValue())
      {
        for (int k = 2; k > 0; k--)
        {
          tempHand.remove(k);
        }
      }

      else if (tempHand.get(2).getValue() == tempHand.get(3).getValue())
      {
        for (int k = 3; k > 1; k--)
        {
          tempHand.remove(k);
        }
      }

      else if (tempHand.get(3).getValue() == tempHand.get(4).getValue())
      {
        for (int k = 4; k > 2; k--)
        {
          tempHand.remove(k);
        }
      }
    }

    j = isPair(tempHand);

    if (i > 0 && j > 0)
    {
      isTwoPair [0] = i;
      isTwoPair [1] = j;

    }

    return isTwoPair;
  }

  /*
   * Checks for Three of a kind
   * @param hand
   * @return integer
   */
 static isThreeKind (Hand hand)
  {
    int isThreeKind = -1;
    hand.sort();

    if (hand.get(0).getValue() == hand.get(1).getValue() && hand.get(1).getValue() == hand.get(2).getValue())
    {
      isThreeKind = hand.get(0).getValue();
    }

    else if (hand.get(1).getValue() == hand.get(2).getValue() && hand.get(2).getValue() == hand.get(3).getValue())
    {
      isThreeKind = hand.get(1).getValue();
    }

    else if (hand.get(2).getValue() == hand.get(3).getValue() && hand.get(3).getValue() == hand.get(4).getValue())
    {
      isThreeKind = hand.get(2).getValue();
    }

    return isThreeKind;
  }

  /*
   * Checks for Straight
   * @param hand
   * @return integer
   */
  static isStraight (Hand hand)
  {
    int isStraight = -1;
    hand.sort();

    if (hand.get(0).getValue() == (hand.get(1).getValue() - 1)
        && hand.get(1).getValue() == (hand.get(2).getValue() - 1)
        && hand.get(2).getValue() == (hand.get(3).getValue() - 1)
        && hand.get(3).getValue() == (hand.get(4).getValue() - 1))
    {
      isStraight = hand.get(4).getValue();
    }

    return isStraight;
  }

  /*
   * Checks for Flush
   * @param hand
   * @return integer
   */
 static isFlush (Hand hand)
  {
    int isFlush = -1;
    hand.sort();

    if (hand.get(0).getSuit() == hand.get(1).getSuit()
        && hand.get(1).getSuit() == hand.get(2).getSuit()
        && hand.get(2).getSuit() == hand.get(3).getSuit()
        && hand.get(3).getSuit() == hand.get(4).getSuit())
    {
      isFlush = hand.get(0).getSuitNumber();
    }

    return isFlush;
  }

  /*
   * Checks for full house
   * @param hand
   * @return integer Array
   */
  static isFullHouse (Hand hand)
  {
    Hand tempHand = new Hand();

    int i = 0;
    while (i < hand.size())
    {
      tempHand.add(hand.get(i));
      i++;
    }

//    i = 0;
//    while (i < tempHand.size())
//    {
//      hand.add(tempHand.get(i));
//      i++;
//    }

    List<int> isFullHouse = new List (2);

    i = -1;
    int j = -1;

    isFullHouse[0] = -1;
    isFullHouse[1] = -1;

    i = isThreeKind(tempHand);

    if (i > 0)
    {
      tempHand.sort();
      if (tempHand.get(0).getValue() == tempHand.get(2).getValue())
      {
        for (int k = 2; k > -1; k--)
        {
          tempHand.remove(k);
        }
      }
      else if (tempHand.get(1).getValue() == tempHand.get(3).getValue())
      {
        for (int k = 3; k > 0; k--)
        {
          tempHand.remove(k);
        }
      }
      else if (tempHand.get(2).getValue() == tempHand.get(4).getValue())
      {
        for (int k = 4; k > 1; k--)
        {
          tempHand.remove(k);
        }
      }
    }

    j = isPair(tempHand);

    if (i > 0 && j > 0)
    {
      isFullHouse[0] = i;
      isFullHouse[1] = j;
    }

    return isFullHouse;
  }

  /*
   * Checks for four of a kind
   * @param hand
   * @return integer
   */
  static isFourKind (Hand hand)
  {
    int isFourKind = -1;
    // Collections.sort(hand, new ValueComparator());
    hand.sort();

    if (hand.get(0).getValue() == hand.get(1).getValue()
        && hand.get(1).getValue() == hand.get(2).getValue()
        && hand.get(2).getValue() == hand.get(3).getValue())
    {
      isFourKind = hand.get(0).getValue();
    }

    else if (hand.get(1).getValue() == hand.get(2).getValue()
        && hand.get(2).getValue() == hand.get(3).getValue()
        && hand.get(3).getValue() == hand.get(4).getValue())
    {
      isFourKind = hand.get(1).getValue();
    }

    return isFourKind;
  }

  /*
   * Checks for Straight Flush
   * @param hand
   * @return integer
   */
  static isStraightFlush (Hand hand)
  {
    int i = 0;
    int j = 0;

    int isStraightFlush = -1;
    i = isStraight(hand);
    j = isFlush(hand);

    if (i > 0 && j > 0)
    {
      isStraightFlush = i;
    }

    return isStraightFlush;
  }
}