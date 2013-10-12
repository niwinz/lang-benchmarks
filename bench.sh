#!/bin/bash

JAVA_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx6g -Xms6g -XX:+UseFastAccessorMethods -XX:+AggressiveOpts" # -XX:+UseG1GC"
JAVA_BIN="/usr/bin/java"

echo "Building..."
(cd groovy_bench; gradle build uberjar)
(cd java_bench; gradle build uberjar)
(cd clojure_bench; lein uberjar)

echo "Benchmarking..."
$JAVA_BIN $JAVA_OPTS -jar groovy_bench/build/libs/bench-1.0.jar
$JAVA_BIN $JAVA_OPTS -jar java_bench/build/libs/bench-1.0.jar
$JAVA_BIN $JAVA_OPTS -jar clojure_bench/target/clojure_bench-0.1.0-standalone.jar
