package greeter

object HelloScalaWorksheet {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(89); 
  println("Welcome to the Scala worksheet");$skip(15); 
  
  val x = 1;System.out.println("""x  : Int = """ + $show(x ));$skip(13); 
  println(x);$skip(32); 
  def increase(i : Int) = i + 1;System.out.println("""increase: (i: Int)Int""");$skip(22); 
  val y = increase(x);System.out.println("""y  : Int = """ + $show(y ));$skip(13); 
  println(y)}
}
