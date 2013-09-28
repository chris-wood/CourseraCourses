package funsets

object Main extends App {
  import FunSets._
  println(contains(singletonSet(1), 1))
  
  // cool!
  def s = union(union(union(union(singletonSet(1), singletonSet(2)), singletonSet(3)), singletonSet(4)), singletonSet(5))
  println(contains(s, 1))
  println(contains(s, 2))
  println(contains(s, 3))
  println(contains(s, 4))
  println(contains(s, 5))
  println(contains(s, 6))
  
  def s1 = diff(s, singletonSet(1))
  println(contains(s1, 1))
  
  def s2 = intersect(s, singletonSet(1))
  println(contains(s2, 1))
  println(contains(s2, 2))
  
  def sp = filter(s, (x : Int) => x > 2)
  println(contains(sp, 1))
  println(contains(sp, 2))
  println(contains(sp, 3))
  
  println("testing for all!")
  println(forall(s, (x : Int) => x < 10))
  printSet(s)
  
  printSet(map(s, (x : Int) => x * x))
}
