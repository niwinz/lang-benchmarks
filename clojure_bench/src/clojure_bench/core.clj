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

(defn ^Integer bench-fn4
  [data]
  (apply + (flatten data)))

(defn flatten2
  "Like `clojure.core/flatten` but better, stronger, faster.
  Takes any nested combination of sequential things (lists, vectors,
  etc.) and returns their contents as a single, flat, lazy sequence.
  If the argument is non-sequential (numbers, maps, strings, nil,
  etc.), returns the original argument."
  {:static true}
  [x]
  (letfn [(flat [coll]
                  (lazy-seq
                   (when-let [c (seq coll)]
                     (let [x (first c)]
                       (if (sequential? x)
                         (concat (flat x) (flat (rest c)))
                         (cons x (flat (rest c))))))))]
    (if (sequential? x) (flat x) x)))

(defn ^Integer bench-fn5
  [data]
  (apply + (flatten2 data)))


(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (let [test-list (make-calls 100 #(generate-random-list 500))]
    (bench "Clojure 01 ! Array Sum"
      (bench-fn1 test-list))
    (bench "Clojure 02 ! Array Sum"
      (bench-fn2 test-list))
    (bench "Clojure 03 ! Array Sum"
      (bench-fn3 test-list))
    (bench "Clojure 04 ! Array Sum"
      (bench-fn4 test-list))
    (bench "Clojure 05 ! Array Sum"
      (bench-fn5 test-list))))
