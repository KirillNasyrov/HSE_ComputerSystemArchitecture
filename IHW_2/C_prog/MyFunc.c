#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int64_t timespecDiff(struct timespec timeA, struct timespec timeB) {
    int64_t nsecA, nsecB;

    nsecA = timeA.tv_sec;
    nsecA *= 1000000000;
    nsecA += timeA.tv_nsec;


    nsecB = timeB.tv_sec;
    nsecB *= 1000000000;
    nsecB += timeB.tv_nsec;

    return (nsecA - nsecB) / 1000;
}

char *letters = "aeiouy";

void MyFunc(char *str) {
    struct timespec start;
    struct timespec end;
    int64_t elapsed_ns;
    clock_gettime(CLOCK_MONOTONIC, &start);

    int i;
    for (i = 0; str[i] != 0 && i != 10000; i++) {
        if (strchr(letters, str[i]) != NULL) {
            str[i] = toupper(str[i]);
        }
    }

    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespecDiff(end, start);
    printf("Time of program: %ld microseconds\n", elapsed_ns);
}