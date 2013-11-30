#!/bin/bash

LEIN_BIN="/usr/bin/lein"
NPM_BIN="/usr/bin/npm"

JAVA_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx6g -Xms6g -XX:+UseFastAccessorMethods -XX:+AggressiveOpts" # -XX:+UseG1GC"
JAVA_BIN="/usr/bin/java"
PYTHON2_BIN="/usr/bin/python2.7"
PYTHON3_BIN="/usr/bin/python3.3"
PYPY_BIN="/usr/bin/pypy"
NODE_BIN="/usr/bin/node"
ERLANG_BIN="/usr/bin/erl"
CABAL_BIN="/usr/bin/cabal"
ELIXIR_BIN="/usr/bin/elixir"
RUST_BIN="/usr/bin/rust"

CFLAGS="-O3 -funroll-all-loops -std=c11"
GCC_BIN="/usr/bin/gcc"
CLANG_BIN="/usr/bin/clang"

LIST_SIZE=1000
NUMBER_LISTS=10000


echo "Building..."

if [ -f $JAVA_BIN ];
then
    (cd groovy_bench; gradle build uberjar)
    (cd java_bench; gradle build uberjar)
    (cd jython_bench; gradle uberjar)
fi

if [ -f $LEIN_BIN ];
then
    (cd clojure_bench; lein uberjar)
fi

if [ -f $NPM_BIN ];
then
    (cd javascript_bench; npm install)
fi

if [ -f $ERLANG_BIN ];
then
    (cd erlang_bench; erl -compile bench)
    (cd erlang_bench; erl -compile bench_parallel)
fi

if [ -f $CABAL_BIN ];
then
    (cd haskell_bench; cabal configure && cabal build)
fi

if [ -f $RUST_BIN ];
then
    (cd rust_bench; $RUST_BIN build bench.rs)
fi

if [ -f $GCC_BIN ];
then
    (cd c_bench; $GCC_BIN $CFLAGS test.c -o gcc_test)
fi

if [ -f $CLANG_BIN ];
then
    (cd c_bench; $CLANG_BIN $CFLAGS test.c -o clang_test)
fi

echo "Benchmarking..."


if [ -f $JAVA_BIN ];
then
    $JAVA_BIN $JAVA_OPTS -jar groovy_bench/build/libs/bench-1.0.jar $LIST_SIZE $NUMBER_LISTS
    $JAVA_BIN $JAVA_OPTS -jar java_bench/build/libs/bench-1.0.jar $LIST_SIZE $NUMBER_LISTS
    $JAVA_BIN $JAVA_OPTS -jar jython_bench/build/libs/bench-1.0.jar $LIST_SIZE $NUMBER_LISTS
fi

if [ -f $LEIN_BIN ];
then
    $JAVA_BIN $JAVA_OPTS -jar clojure_bench/target/clojure_bench-0.1.0-standalone.jar $LIST_SIZE $NUMBER_LISTS
fi

if [ -f $PYTHON2_BIN ];
then
    $PYTHON2_BIN python_bench/test.py $LIST_SIZE $NUMBER_LISTS
fi

if [ -f $PYTHON3_BIN ];
then
    $PYTHON3_BIN python_bench/test.py $LIST_SIZE $NUMBER_LISTS
fi

if [ -f $PYPY_BIN ];
then
    $PYPY_BIN python_bench/test.py $LIST_SIZE $NUMBER_LISTS
fi

if [ -f $NPM_BIN ];
then
    (cd javascript_bench; $NODE_BIN test.js $LIST_SIZE $NUMBER_LISTS)
fi

if [ -f $ERLANG_BIN ];
then
    (cd erlang_bench ; erl -noshell -s bench main $LIST_SIZE $NUMBER_LISTS -s init stop)
    (cd erlang_bench ; erl -noshell -s bench_parallel main $LIST_SIZE $NUMBER_LISTS -s init stop)
fi

if [ -f $CABAL_BIN ];
then
    (cd haskell_bench; ./dist/build/haskell_bench/haskell_bench $LIST_SIZE $NUMBER_LISTS)
fi

if [ -f $ELIXIR_BIN ];
then
    (cd elixir_bench; elixir bench.ex $LIST_SIZE $NUMBER_LISTS)
fi

if [ -f $RUST_BIN ];
then
    ./rust_bench/bench $LIST_SIZE $NUMBER_LISTS
fi

if [ -f $GCC_BIN ];
then
    (cd c_bench; ./gcc_test $LIST_SIZE $NUMBER_LISTS)
fi

if [ -f $CLANG_BIN ];
then
    (cd c_bench; ./clang_test $LIST_SIZE $NUMBER_LISTS)
fi
