package week1

// Lecture 1.5 worksheet
object lecture15 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(102); 
  println("Welcome to the Scala worksheet");$skip(33); val res$0 = 

  // Try the worksheet!
  1 + 2;System.out.println("""res0: Int(3) = """ + $show(res$0));$skip(78); 

  // Try absolute value function
  def abs(x: Double) = if (x < 0) -x else x;System.out.println("""abs: (x: Double)Double""");$skip(130); 

  def sqrtIter(guess: Double, x: Double): Double =
    if (isGoodEnough(guess, x)) guess
    else sqrtIter(improve(guess, x), x);System.out.println("""sqrtIter: (guess: Double, x: Double)Double""");$skip(113); 

  def isGoodEnough(guess: Double, x: Double): Boolean =
    abs(guess * guess - x) < 0.001;System.out.println("""isGoodEnough: (guess: Double, x: Double)Boolean""");$skip(81);  // the error handler

  def improve(guess: Double, x: Double): Double =
    (guess + (x / guess)) / 2;System.out.println("""improve: (guess: Double, x: Double)Double""");$skip(75); 

  // Initial guess is set to 1.0
  def sqrt(x: Double) = sqrtIter(1.0, x);System.out.println("""sqrt: (x: Double)Double""");$skip(21); val res$1 = 

  // Test
  sqrt(2);System.out.println("""res1: Double = """ + $show(res$1));$skip(10); val res$2 = 
  sqrt(4);System.out.println("""res2: Double = """ + $show(res$2));$skip(13); val res$3 = 
  sqrt(1e-6);System.out.println("""res3: Double = """ + $show(res$3))}
}

/*
- Q: why is isGoodEnough bad for small numbers?



- Q: why does isGoodEnough not terminate for large numbers?
*/
