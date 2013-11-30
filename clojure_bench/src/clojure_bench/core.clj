(ns clojure-bench.core
  (:require [clojure.core.reducers :as r])
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


;; (defn ^Integer bench-fn4
;;   [data]
;;   (let [reducer (fn
;;                   ([] 0)
;;                   ([x y] (+ (if (seq? y) (apply + y) y) x)))]
;;     (r/fold reducer data)))


(defn ^Integer bench-fn4
  [data]
  (r/fold + (r/map #(apply + %) data)))



(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (let [numberItems (read-string (first args))
        numberLists (read-string (second args))
        test-list (make-calls numberLists #(generate-random-list numberItems))]
    (bench "Clojure 01 ! Array Sum"
      (bench-fn1 test-list))
    (bench "Clojure 02 ! Array Sum"
      (bench-fn2 test-list))
    (bench "Clojure 03 ! Array Sum"
      (bench-fn3 test-list))
    (bench "Clojure 04 ! Array Sum"
      (bench-fn4 test-list))))
