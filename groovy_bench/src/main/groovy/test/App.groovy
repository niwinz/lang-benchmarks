package test

import java.util.Random

public class App {
    static ArrayList<Integer> generateRandomList(num) {
        Random rand = new Random()
        ArrayList<Integer> list = new ArrayList<Integer>()

        (1..num).each {
            list << rand.nextInt(num+1)
        }

        return list
    }

    static ArrayList<ArrayList<Integer>> getTestList() {
        ArrayList<ArrayList<Integer>> list = new ArrayList<ArrayList<Integer>>()

        (1..100).each {
            list << App.generateRandomList(500)
        }

        return list
    }

    static void benchFn1(data) {
        def bench = {
            def sum1 = data.collect { it.inject(0) { acc, val -> acc + val } }
            return sum1.inject(0) { acc, val -> acc + val }
        }

        def start = System.nanoTime()
        def result = bench()
        println("[Groovy 01]  Elapsed time: " + ((System.nanoTime() - start) / 1000000.0 ) + " msecs ( Result: " + result + " )")
    }

    public static void main(String[] args) {
        def testList = App.getTestList()
        benchFn1(testList)
    }
}
