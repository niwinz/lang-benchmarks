package main

import (
    "os"
    "fmt"
    "time"
    "math/rand"
    "strconv"
)

func generateLists(numberItems int, listSize int) [][]int{
    result := make([][]int, listSize)
    for i := range result {
        currentList := make([]int, numberItems)
        for j := range currentList {
            currentList[j] = rand.Intn(100)
        }
        result[i] = currentList
    }
    return result
}

func doBenchmark(benchList [][]int) int {
    result := 0
    for i := range benchList {
        for j := range benchList[i] {
            result = result + benchList[i][j]
        }
    }
    return result
}

func main() {
    listSize, _ := strconv.Atoi(os.Args[1])
    numberLists, _ := strconv.Atoi(os.Args[1])

    list := generateLists(listSize, numberLists)
    before := time.Now()
    result := doBenchmark(list)
    after := time.Now()
    elapsed := float64(after.Sub(before))/float64(time.Millisecond)

    fmt.Printf("[Go ! Array Sum]: Elapsed time: %f msec ( Result: %d )\n", elapsed, result)
}
