package test

import static System.nanoTime

class App {

    static final TIME_FRACTION = 1000000.0
    static final LIST = (1..50000).collect { new Random().nextInt(it + 1) }.collate(500)

    static Integer benchFn1(data) {
        return data*.sum().sum()
    }

    static Integer benchFn2(data) {
        return data.flatten().sum()
    }

    static Integer benchFn3(data) {
        return data.sum{ it.sum() }
    }

    public static void main(String[] args) {

        def doBenchmark = { Integer order, Closure execution, List data ->
            def start = nanoTime()
            def result = execution(data)
            def end = (nanoTime() - start) / TIME_FRACTION
            println "[Groovy $order ! Array Sum]  Elapsed time: $end msecs ( Result: $result )"
        }

        (1..3).each { doBenchmark(it, App.&"benchFn$it", LIST) }

    }

}
