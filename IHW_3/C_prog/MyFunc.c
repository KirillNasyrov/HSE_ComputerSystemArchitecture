#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <math.h>

int64_t timespecDiff(struct timespec timeA, struct timespec timeB) {
    int64_t nsecA, nsecB;

    nsecA = timeA.tv_sec;
    nsecA *= 1000000000;
    nsecA += timeA.tv_nsec;


    nsecB = timeB.tv_sec;
    nsecB *= 1000000000;
    nsecB += timeB.tv_nsec;

    return nsecA - nsecB;
}


double MyFunc(double x) {
    struct timespec start;
    struct timespec end;
    int64_t elapsed_ns;

    double correct = log(1 - x);
    double result = 0;
    double n = 1;

    printf("correct result: %lf\n", correct);

    clock_gettime(CLOCK_MONOTONIC, &start);
    while (fabs(correct - result) > 0.001 * fabs(correct)) {
        result += pow(-1, n - 1) * pow(-x, n) / n;
        ++n;
    }
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespecDiff(end, start);
    printf("our result: %lf\n", result);
    printf("Time of program: %ld nanoseconds\n", elapsed_ns);
    return result;
}