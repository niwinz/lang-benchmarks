package test;

import java.util.Random;
import java.util.ArrayList;
import java.util.List;

public class App {
    private static int NUM_LISTS = 100;
    private static int NUM_NUMBERS = 500;

    private List<List<Integer>> testList;

    /*
     * Auxiliary methods to generate random lists
     */
    static List<Integer> generateRandomList(int num) {
        Random rand = new Random();
        List<Integer> list = new ArrayList<Integer>(num);

        for(int i=0; i <= num; i++) {
            int nextInt = rand.nextInt(num+1);
            list.add(nextInt);
        }

        return list;
    }

    static List<List<Integer>> getTestList() {
        List<List<Integer>> list = new ArrayList<List<Integer>>(NUM_LISTS);

        for(int i=0; i <= NUM_LISTS; i++) {
            list.add(generateRandomList(NUM_NUMBERS));
        }

        return list;
    }

    /*
     * Program code
     */
    public App(List<List<Integer>> testList) {
        this.testList = testList;
    }

    public long calculateSum() {
        long total = 0;

        for(List<Integer> curList: testList) {
            for(Integer curNumber: curList) {
                total = total + curNumber;
            }
        }

        return total;
    }

    public static void main(String[] args) {
        List<List<Integer>> testList = getTestList();
        long start = System.nanoTime();
        App app = new App(testList);
        long total = app.calculateSum();
        System.out.println("[Java 01 ! Array Sum]    Elapsed time: " + ((System.nanoTime() - start) / 1000000.0 ) + " msecs ( Result: " + total + " )");
    }
}
