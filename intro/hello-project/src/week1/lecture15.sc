package week1

// Lecture 1.5 worksheet
object lecture15 {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet

  // Try the worksheet!
  1 + 2                                           //> res0: Int(3) = 3

  // Try absolute value function
  def abs(x: Double) = if (x < 0) -x else x       //> abs: (x: Double)Double

  def sqrtIter(guess: Double, x: Double): Double =
    if (isGoodEnough(guess, x)) guess
    else sqrtIter(improve(guess, x), x)           //> sqrtIter: (guess: Double, x: Double)Double

  def isGoodEnough(guess: Double, x: Double): Boolean =
    abs(guess * guess - x) < 0.001 // the error handler
                                                  //> isGoodEnough: (guess: Double, x: Double)Boolean

  def improve(guess: Double, x: Double): Double =
    (guess + (x / guess)) / 2                     //> improve: (guess: Double, x: Double)Double

  // Initial guess is set to 1.0
  def sqrt(x: Double) = sqrtIter(1.0, x)          //> sqrt: (x: Double)Double

  // Test
  sqrt(2)                                         //> res1: Double = 1.4142156862745097
  sqrt(4)                                         //> res2: Double = 2.0000000929222947
  sqrt(1e-6)                                      //> res3: Double = 0.031260655525445276
}

/*
- Q: why is isGoodEnough bad for small numbers?



- Q: why does isGoodEnough not terminate for large numbers?
*/