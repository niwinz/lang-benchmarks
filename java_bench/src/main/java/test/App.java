package test;

import java.util.Random;
import java.util.ArrayList;

public class App {
    static ArrayList<Integer> generateRandomList(int num) {
        Random rand = new Random();
        ArrayList<Integer> list = new ArrayList<Integer>();

        for(int i=0; i <= num; i++) {
            list.add(rand.nextInt(num+1));
        }

        return list;
    }

    static ArrayList<ArrayList<Integer>> getTestList() {
        ArrayList<ArrayList<Integer>> list = new ArrayList<ArrayList<Integer>>();

        for(int i=0; i <= 100; i++) {
            list.add(generateRandomList(500));
        }

        return list;
    }

    static void benchFn1(ArrayList<ArrayList<Integer>> data) {
        long start = System.nanoTime();
        long total = 0;

        for(int i=0; i < data.size(); i++) {
            ArrayList<Integer> list = data.get(i);

            for(int y=0; y < list.size(); y++) {
                total = total + list.get(y);
            }
        }

        System.out.println("[Java 01]    Elapsed time: " + ((System.nanoTime() - start) / 1000000.0 ) + " msecs ( Result: " + total + " )");
    }

    public static void main(String[] args) {
        ArrayList<ArrayList<Integer>> testList = getTestList();
        benchFn1(testList);
    }
}
