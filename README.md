# LANGUAGE BENCHMARK

The code in this repository try to measure the performance of different languages when programming
in an idiomatic way.

The current languages tested are:

| Language    | Interpreter/Compiler            |
|-------------|---------------------------------|
| C           | gcc C11                         |
| Clojure     | clojure 1.5.1                   |
| Elixir      | elixir 0.11.2                   |
| Erlang      | Erlang R16B02                   |
| Go          | go 1.2                          |
| Groovy      | Groovy 2.2.0, JVM: 1.7.0        |
| Haskel      | cabal 1.16.0                    |
| Java        | OpenJDK 1.7.0                   |
| Javascript  | node 0.10.22                    |
| Python      | Python2, Python3, PyPy, Jython  |
| Rust        | rust 0.8                        |

## Output
### Arch Linux. Intel(R) Core(TM)2 Duo CPU E7600 @3.06GHz
LIST_SIZE=1000
NUMBER_LISTS=10000

```
[Groovy 1 ! Array Sum]  Elapsed time: 3764.992617 msecs ( Result: 495042631 )
[Groovy 2 ! Array Sum]  Elapsed time: 4627.583343 msecs ( Result: 495042631 )
[Groovy 3 ! Array Sum]  Elapsed time: 3739.368574 msecs ( Result: 495042631 )
[Groovy 4 ! Array Sum]  Elapsed time: 4708.601231 msecs ( Result: 495042631 )
[Groovy 5 ! Array Sum]  Elapsed time: 5282.465129 msecs ( Result: 495042631 )
[Groovy 6 ! Array Sum]  Elapsed time: 3033.369863 msecs ( Result: 495042631 )
[Groovy 7 ! Array Sum]  Elapsed time: 1469.929187 msecs ( Result: 495042631 )
[Java 01 ! Array Sum]    Elapsed time: 537.382374 msecs ( Result: 50059523838 )
[Jython2 01 ! Array Sum] Elapsed time: 519.001 msecs ( Result: 500035495 )
[Clojure 01 ! Array Sum] Elapsed time: 863.430447 msecs ( Result: 494967995 )
[Clojure 02 ! Array Sum] Elapsed time: 660.660787 msecs ( Result: 494967995 )
[Clojure 03 ! Array Sum] Elapsed time: 531.265013 msecs ( Result: 494967995 )
[Clojure 04 ! Array Sum] Elapsed time: 327.644752 msecs ( Result: 494967995 )
[Python2 01 ! Array Sum] Elapsed time: 22584.221 msecs ( Result: 500096127 )
[Python3 01 ! Array Sum] Elapsed time: 32933.751000000004 msecs ( Result: 500059264 )
[PyPy 01 ! Array Sum] Elapsed time: 668.098 msecs ( Result: 499979811 )
[NodeJS ! Array Sum]:  Elapsed time: 455.697 msecs ( Result: 2499675115 )
[Erlang ! Array Sum]: Elapsed time: 392.452 msec ( Result: 505134592 )
[Erlang ! Parallel Sum]: Elapsed time: 1045.668 msec ( Result: 505134592 )
[Haskell ! Array Sum] Elapsed time: 3744.85 msecs ( Result: 499919842 )
[Elixir ! Array Sum] Elapsed time: 398.473 msec ( Result: 505699075 )
[Rust ! Array Sum] Elapsed time: 271.588227 msecs ( Result: 494974008 )
[C 01 ! Array Sum] Elapsed time: 0.007446 msecs (Result: 140764045566917)
[Go ! Array Sum]: Elapsed time: 28.562163 msec ( Result: 494973512 )
```
