package greeter

object HelloScalaWorksheet {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  
  val x = 1                                       //> x  : Int = 1
  println(x)                                      //> 1
  def increase(i : Int) = i + 1                   //> increase: (i: Int)Int
  val y = increase(x)                             //> y  : Int = 2
  println(y)                                      //> 2
}