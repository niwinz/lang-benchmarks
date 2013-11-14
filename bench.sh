#!/bin/bash

JAVA_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx6g -Xms6g -XX:+UseFastAccessorMethods -XX:+AggressiveOpts" # -XX:+UseG1GC"
JAVA_BIN="/usr/bin/java"
PYTHON2_BIN="/usr/bin/python2.7"
PYTHON3_BIN="/usr/bin/python3.3"
PYPY_BIN="/usr/bin/pypy"
NODE_BIN="/usr/bin/node"
ERLANG_BIN="/usr/bin/erl"


echo "Building..."
(cd groovy_bench; gradle build uberjar)
(cd java_bench; gradle build uberjar)
(cd clojure_bench; lein uberjar)
(cd jython_bench; gradle uberjar)
(cd javascript_bench; npm install)

if [ -f $ERLANG_BIN ];
then
    (cd erlang_bench; erl -compile bench)
    (cd erlang_bench; erl -compile bench_parallel)
fi

echo "Benchmarking..."
$JAVA_BIN $JAVA_OPTS -jar groovy_bench/build/libs/bench-1.0.jar
$JAVA_BIN $JAVA_OPTS -jar java_bench/build/libs/bench-1.0.jar
$JAVA_BIN $JAVA_OPTS -jar clojure_bench/target/clojure_bench-0.1.0-standalone.jar
$JAVA_BIN $JAVA_OPTS -jar jython_bench/build/libs/bench-1.0.jar
$PYTHON2_BIN python_bench/test.py
$PYTHON3_BIN python_bench/test.py
$PYPY_BIN python_bench/test.py
(cd javascript_bench; $NODE_BIN test.js)

if [ -f $ERLANG_BIN ];
then
    (cd erlang_bench ; erl -noshell -s bench main -s init stop)
    (cd erlang_bench ; erl -noshell -s bench_parallel main -s init stop)
fi
