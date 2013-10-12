#!/bin/bash

JAVA_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx6g -Xms6g -XX:+UseFastAccessorMethods -XX:+AggressiveOpts" # -XX:+UseG1GC"
JAVA_BIN="/usr/bin/java"
PYTHON2_BIN="/usr/bin/python2.7"
PYTHON3_BIN="/usr/bin/python3.3"
PYPY_BIN="/usr/bin/pypy"


echo "Building..."
(cd groovy_bench; gradle build uberjar)
(cd java_bench; gradle build uberjar)
(cd clojure_bench; lein uberjar)

echo "Benchmarking..."
$JAVA_BIN $JAVA_OPTS -jar groovy_bench/build/libs/bench-1.0.jar
$JAVA_BIN $JAVA_OPTS -jar java_bench/build/libs/bench-1.0.jar
$JAVA_BIN $JAVA_OPTS -jar clojure_bench/target/clojure_bench-0.1.0-standalone.jar
$PYTHON2_BIN python_bench/test.py
$PYTHON3_BIN python_bench/test.py
$PYPY_BIN python_bench/test.py
