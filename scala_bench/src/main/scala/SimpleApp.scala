package test {
  object SampleApp extends App {
    override def main(args:Array[String]) = {
      var greeting = ""
      for (i <- 0 until args.length) {
        greeting += (args(i) + " ")
      }
      if (args.length > 0) greeting = greeting.substring(0, greeting.length - 1)

      println(greeting)
    }
  }
}
