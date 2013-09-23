package recfun
import common._

object Main {
  def main(args: Array[String]) {
    println("Pascal's Triangle")
    for (row <- 0 to 10) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
  }

  /**
   * Exercise 1
   */
  def pascal(c: Int, r: Int): Int = {
    if (c == 0 && r == 0) 1
    else if (c == r) pascal(c-1, r-1) // right side of triangle
    else if (c == 0) pascal(c, r-1)   // left side of triangle
    else pascal(c - 1, r - 1) + pascal(c, r - 1)
  }

  /**
   * Exercise 2
   */
  def balance(chars: List[Char]): Boolean = {
		  def innerBalance(chars: List[Char], acc: Int) : Int = {
		    if (chars.isEmpty) acc
		    else if (acc < 0) -1 // short circuit, can't ever be < 0 or we have mismatch!
		    else if (chars.head == '(') innerBalance(chars.tail, acc + 1)
		    else if (chars.head == ')') innerBalance(chars.tail, acc - 1)
		    else innerBalance(chars.tail, acc) // wasn't open or close, so just skip
		  }
    if (innerBalance(chars, 0) == 0) true
    else false
  }

  /**
   * Exercise 3
   */
  def countChange(money: Int, coins: List[Int]): Int = {
    def innerCount(sum: Int, money:Int, coins: List[Int]) : Int = {
      if (sum > money) 0 // didn't work
      else if (sum == money) 1 // worked
      else if (coins.isEmpty) 0 // no coins left to pick from, so it can't possibly work
      else innerCount(sum + coins.head, money, coins) + innerCount(sum, money, coins.tail)
    }
    innerCount(0, money, coins)
  }
}
