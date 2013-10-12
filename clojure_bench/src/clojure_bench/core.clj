(ns clojure-bench.core
  (:gen-class))

(defmacro bench
  [name & body]
  `(let [start# (. System (nanoTime))
         result# (do ~@body)]
     (let [elapsed# (/ (double (- (. System (nanoTime)) start#)) 1000000.0)]
       (println (str "[" ~name "]") "Elapsed time:" elapsed# "msecs ( Result:" result# ")"))))

(defn make-calls [^Integer n, func] (vec (take n (repeatedly func))))
(defn generate-random-list [^Integer x] (make-calls x #(rand-int 100)))

(defn reducer
  [x, y]
  (if (vector? y)
    (into x (reduce reducer y []))
    (into x [y])))

(defn ^Integer bench-fn1
  [data]
  (apply + (reduce reducer data)))

(defn ^Integer bench-fn2
  [data]
  (let [sum (atom 0)]
    (doseq [d data]
      (reset! sum (+ @sum (apply + d))))
    @sum))

(defn ^Integer bench-fn3
  [data]
  (let [sum1  (map (fn [d] (apply + d)) data)]
    (apply + sum1)))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (let [test-list (make-calls 100 #(generate-random-list 500))]
    (bench "Clojure 01"
      (bench-fn2 test-list))
    (bench "Clojure 02"
      (bench-fn3 test-list))))
