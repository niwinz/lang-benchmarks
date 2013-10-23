package test

import java.util.Random

public class App {
    ArrayList<Integer> generateRandomList(num) {
        Random rand = new Random()
        ArrayList<Integer> list = new ArrayList<Integer>()

        (1..num).each {
            list << rand.nextInt(num+1)
        }

        return list
    }

    ArrayList<ArrayList<Integer>> getTestList() {
        ArrayList<ArrayList<Integer>> list = new ArrayList<ArrayList<Integer>>()

        (1..100).each {
            list << generateRandomList(500)
        }

        return list
    }

    int benchFn1(data) {
        return data.collect({ it.sum() }).sum()
    }


    int benchFn2(data) {
        return data.flatten().sum()
    }

    public static void main(String[] args) {
        App appInstance = new App()
        ArrayList<ArrayList<Integer>> testList = appInstance.getTestList()

        long start = System.nanoTime()
        int result = appInstance.benchFn1(testList)
        println("[Groovy 01 ! Array Sum]  Elapsed time: " + ((System.nanoTime() - start) / 1000000.0 ) + " msecs ( Result: " + result + " )")

        start = System.nanoTime()
        result = appInstance.benchFn2(testList)
        println("[Groovy 02 ! Array Sum]  Elapsed time: " + ((System.nanoTime() - start) / 1000000.0 ) + " msecs ( Result: " + result + " )")
    }
}
