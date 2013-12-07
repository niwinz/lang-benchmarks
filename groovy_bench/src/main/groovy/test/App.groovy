package test

import static System.nanoTime
import groovyx.gpars.GParsPool


class App {
    static final TIME_FRACTION = 1000000.0

    static Integer benchFn1(data) {
        return data*.sum().sum()
    }

    static Integer benchFn2(data) {
        return data.flatten().sum()
    }

    static Integer benchFn3(data) {
        return data.sum { it.sum() }
    }

    static Integer benchFn4(data) {
        return GParsPool.withPool(1) {
            data*.sumParallel().sumParallel()
        }
    }

    static Integer benchFn5(data) {
        return GParsPool.withPool(1) {
            data.flatten().sumParallel()
        }
    }

    static Integer benchFn6(data) {
        int value = 0
        data.each { i ->
            i.each { j ->
                value += j
            }
        }
        return value
    }

    static List generateList(Integer listSize, Integer numbersSize) {
        // (1 .. listSize).collect { new Random().nextInt(it + 1) }.collate(numbersSize)
        def result = []
        listSize.times {
            def current = []
            numbersSize.times {
                current << new Random().nextInt(100)
            }
            result << current
        }
        return result
    }

    public static void main(String[] args) {
        def doBenchmark = { Integer order, Closure execution, List data ->
            def start = nanoTime()
            def result = execution(data)
            def end = (nanoTime() - start) / TIME_FRACTION
            println "[Groovy $order ! Array Sum]  Elapsed time: $end msecs ( Result: $result )"
        }

        def list = generateList(Integer.parseInt(args[0]), Integer.parseInt(args[1]))
        println list.size()
        (1..6).each { doBenchmark(it, App.&"benchFn$it", list) }
    }

}
