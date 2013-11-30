#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>


int main(int argc, char *argv[]) {
    struct timeval tv;
    long double t_init, t_end;

    long long array_size = atoll(argv[2]);
    long long num_arrays  = atoll(argv[1]);

    int **arrays;
    long long sum, i, j;

    // Generate Arrays
    arrays = (int **) malloc(num_arrays * sizeof(int));
    for (i = 0; i < num_arrays; i++){
        arrays[i] = (int *) malloc(array_size * sizeof(int));
        for (j = 0; j < array_size; j++){
            arrays[i][j] = rand() % 100 + 1;
        }
    }

    // Calculate
    gettimeofday(&tv, NULL);
    t_init =  tv.tv_sec + (tv.tv_usec / 1000000.0);

    for (i = 0; i < num_arrays; i++)
        for (j = 0; j < array_size; j++)
            sum += arrays[i][j];

    gettimeofday(&tv, NULL);
    t_end = tv.tv_sec + (tv.tv_usec / 1000000.0);

    printf("[C 01 ! Array Sum] Elapsed time: %Lf msecs (Result: %lli)\n", t_end - t_init, sum);
}
