package week1

// Lecture 1.5 worksheet
object lecture15 {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet

  // Try the worksheet!
  1 + 2                                           //> res0: Int(3) = 3

  // Try absolute value function
  def abs(x: Double) = if (x < 0) -x else x       //> abs: (x: Double)Double

  def sqrtIter(guess: Double, x: Double): Double =
    if (betterIsGoodEnough(guess, x)) guess
    else sqrtIter(improve(guess, x), x)           //> sqrtIter: (guess: Double, x: Double)Double

  def isGoodEnough(guess: Double, x: Double): Boolean =
    abs(guess * guess - x) < 0.001 // the error handler
                                                  //> isGoodEnough: (guess: Double, x: Double)Boolean
                                                  
	def betterIsGoodEnough(guess : Double, x : Double) : Boolean =
		abs(guess - (x / guess)) / x < 0.001
                                                  //> betterIsGoodEnough: (guess: Double, x: Double)Boolean

  def improve(guess: Double, x: Double): Double =
    (guess + (x / guess)) / 2                     //> improve: (guess: Double, x: Double)Double

  // Initial guess is set to 1.0
  def sqrt(x: Double) = sqrtIter(1.0, x)          //> sqrt: (x: Double)Double

  // Test
  sqrt(2)                                         //> res1: Double = 1.4142156862745097
  sqrt(4)                                         //> res2: Double = 2.000609756097561
  sqrt(1e-6)                                      //> res3: Double = 0.0010000001533016628
  
  sqrt(0.001)                                     //> res4: Double = 0.03162278245070105
  sqrt(0.1e-20)                                   //> res5: Double = 3.162277660168384E-11
  sqrt(1e20)                                      //> res6: Double = 9.7656250000000336E16
  sqrt(1e50)                                      //> res7: Double = 9.765625E46
}

/*
- Q: why is isGoodEnough bad for small numbers?

taking the mean of guess + x/guess quickly converges towards 0 because x/guess will be small, thus making fewer iterations happen

- Q: why does isGoodEnough not terminate for large numbers?

just the opposite - x/guess is huge, mean is still huge, therefore guess slowly converges towards the right answer
*/