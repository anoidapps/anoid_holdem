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

  static isTie (Hand hand, Hand opHand)
  {
    hand.sort();
    opHand.sort();

    if (hand.get(6).getValue() > opHand.get(6).getValue())
      {
        return 1;
      }

    if (hand.get(6).getValue() == opHand.get(6).getValue())
    {
      return 0;
    }

    if (hand.get(6).getValue() < opHand.get(6).getValue())
    {
      return -1;
    }
  }

  /*
   * Checks for pair.
   * @param hand
   * @return integer
   */
  static isPair (Hand hand)
  {
    var pair = 0;
    hand.sort();

    // print("Line 86 " + hand.toString() + "\n");
    // Pointless Comment
    if (hand.get(0).getValue() == hand.get(1).getValue())
    {
      pair = pair + hand.get(0).getValue();
    }

    if (hand.size() == 5)
    {
      if (hand.get(1).getValue() == hand.get(2).getValue())
      {
        pair = pair + hand.get(1).getValue();
      }

      else if (hand.get(2).getValue() == hand.get(3).getValue())
      {
        pair = pair + hand.get(2).getValue();
      }

      else if (hand.get(3).getValue() == hand.get(4).getValue())
      {
        pair = pair + hand.get(3).getValue();
      }
    }

    if (hand.size() == 7)
    {
      if (hand.get(1).getValue() == hand.get(2).getValue())
      {
        pair = pair + hand.get(1).getValue();
      }

      else if (hand.get(2).getValue() == hand.get(3).getValue())
      {
        pair = pair + hand.get(2).getValue();
      }

      else if (hand.get(3).getValue() == hand.get(4).getValue())
      {
        pair = pair + hand.get(3).getValue();
      }

      else if (hand.get(4).getValue() == hand.get(5).getValue())
      {
        pair = pair + hand.get(4).getValue();
      }

      else if (hand.get(5).getValue() == hand.get(6).getValue())
      {
        pair = pair + hand.get(5).getValue();
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

    tempHand.sort();
    i = 0;
//    while (i < tempHand.size())
//    {
//      hand.add(tempHand.get(i));
//      i++;
//    }

    List<int> isTwoPair = new List(2);

    i = 0;
    int j = 0;

    isTwoPair[0] = 0;
    isTwoPair[1] = 0;

    i = isPair(tempHand);

    if (i > 0)
    {
      if (tempHand.get(0).getValue() == tempHand.get(1).getValue())
      {
        tempHand.remove(0);
        tempHand.remove(0);
      }

      else if (tempHand.get(1).getValue() == tempHand.get(2).getValue())
      {
        tempHand.remove(1);
        tempHand.remove(1);
      }

      else if (tempHand.get(2).getValue() == tempHand.get(3).getValue())
      {
        tempHand.remove(2);
        tempHand.remove(2);
      }

      else if (tempHand.get(3).getValue() == tempHand.get(4).getValue())
      {
        tempHand.remove(3);
        tempHand.remove(3);
      }

      else if (tempHand.get(4).getValue() == tempHand.get(5).getValue())
      {
        tempHand.remove(4);
        tempHand.remove(4);
      }

      else if (tempHand.get(5).getValue() == tempHand.get(6).getValue())
      {
        tempHand.remove(5);
        tempHand.remove(5);
      }
    }

    j = isPair(tempHand);
    // print("Line 221: " + j.toString());

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
    int isThreeKind = 0;
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

    else if (hand.get(3).getValue() == hand.get(4).getValue() && hand.get(4).getValue() == hand.get(5).getValue())
    {
      isThreeKind = hand.get(3).getValue();
    }

    else if (hand.get(4).getValue() == hand.get(5).getValue() && hand.get(5).getValue() == hand.get(6).getValue())
    {
      isThreeKind = hand.get(4).getValue();
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
    int isStraight = 0;
    hand.sort();

    if (hand.get(0).getValue() == (hand.get(1).getValue() - 1)
        && hand.get(1).getValue() == (hand.get(2).getValue() - 1)
        && hand.get(2).getValue() == (hand.get(3).getValue() - 1)
        && hand.get(3).getValue() == (hand.get(4).getValue() - 1))
    {
      isStraight = hand.get(4).getValue();
    }

    else if (hand.get(1).getValue() == (hand.get(2).getValue() - 1)
        && hand.get(2).getValue() == (hand.get(3).getValue() - 1)
        && hand.get(3).getValue() == (hand.get(4).getValue() - 1)
        && hand.get(4).getValue() == (hand.get(5).getValue() - 1))
    {
      isStraight = hand.get(5).getValue();
    }

    else if (hand.get(2).getValue() == (hand.get(3).getValue() - 1)
        && hand.get(3).getValue() == (hand.get(4).getValue() - 1)
        && hand.get(4).getValue() == (hand.get(5).getValue() - 1)
        && hand.get(5).getValue() == (hand.get(6).getValue() - 1))
    {
      isStraight = hand.get(6).getValue();
    }

    else
    {
      if (hand.get(6).getValue() == 14)
        {
          Card tempCard6 = hand.get(6);
          Card tempCard0 = hand.get(0);

          hand.remove(6);
          hand.remove(0);
          hand.add(tempCard0);
          hand.addFront(tempCard6);

          if (hand.get(0).getValue() == (hand.get(1).getValue() - 1)
              && hand.get(1).getValue() == (hand.get(2).getValue() - 1)
              && hand.get(2).getValue() == (hand.get(3).getValue() - 1)
              && hand.get(3).getValue() == (hand.get(4).getValue() - 1))
          {
            isStraight = hand.get(4).getValue();
          }

          else if (hand.get(1).getValue() == (hand.get(2).getValue() - 1)
              && hand.get(2).getValue() == (hand.get(3).getValue() - 1)
              && hand.get(3).getValue() == (hand.get(4).getValue() - 1)
              && hand.get(4).getValue() == (hand.get(5).getValue() - 1))
          {
            isStraight = hand.get(5).getValue();
          }

          else if (hand.get(2).getValue() == (hand.get(3).getValue() - 1)
              && hand.get(3).getValue() == (hand.get(4).getValue() - 1)
              && hand.get(4).getValue() == (hand.get(5).getValue() - 1)
              && hand.get(5).getValue() == (hand.get(6).getValue() - 1))
          {
            isStraight = hand.get(6).getValue();
          }
        }
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

    else if (hand.get(1).getSuit() == hand.get(2).getSuit()
        && hand.get(2).getSuit() == hand.get(3).getSuit()
        && hand.get(3).getSuit() == hand.get(4).getSuit()
        && hand.get(4).getSuit() == hand.get(5).getSuit())
    {
      isFlush = hand.get(1).getSuitNumber();
    }

    else if (hand.get(2).getSuit() == hand.get(3).getSuit()
        && hand.get(3).getSuit() == hand.get(4).getSuit()
        && hand.get(4).getSuit() == hand.get(5).getSuit()
        && hand.get(5).getSuit() == hand.get(6).getSuit())
    {
      isFlush = hand.get(2).getSuitNumber();
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

      else if (tempHand.get(3).getValue() == tempHand.get(5).getValue())
      {
        for (int k = 5; k > 2; k--)
        {
          tempHand.remove(k);
        }
      }

      else if (tempHand.get(4).getValue() == tempHand.get(6).getValue())
      {
        for (int k = 6; k > 3; k--)
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

    else if (hand.get(2).getValue() == hand.get(3).getValue()
        && hand.get(3).getValue() == hand.get(4).getValue()
        && hand.get(4).getValue() == hand.get(5).getValue())
    {
      isFourKind = hand.get(2).getValue();
    }

    else if (hand.get(3).getValue() == hand.get(4).getValue()
        && hand.get(4).getValue() == hand.get(5).getValue()
        && hand.get(5).getValue() == hand.get(6).getValue())
    {
      isFourKind = hand.get(3).getValue();
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