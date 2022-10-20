#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int A[1048576];
int B[1048576];

//сортировка вставками
extern void InsertionSort(int n);

int main(int argc, char *argv[]) {
    //ввод N
    int n, i;
    if (argc > 1) {
        if (strcmp(argv[1], "-f") == 0) {
            FILE *input, *output;
            n = atoi(argv[4]);
            input = fopen(argv[2], "r");
            for (i = 0; i < n; i++) {
                fscanf(input, "%d", &A[i]);
                B[i] = A[i];
            }
            InsertionSort(n);
            output = fopen(argv[3], "w");
            for (i = 0; i < n; i++) {
                fprintf(output, "%d ", B[i]);
            }
        } else if (strcmp(argv[1], "-h") == 0) {
            n = argc - 2;
            for (i = 0; i < n; i++) {
                A[i] = atoi(argv[i + 2]);
                B[i] = A[i];
            }
            InsertionSort(n);
            for (i = 0; i < n; i++) {
                printf("%d ", B[i]);
            }
            printf("\n");
        } else if (strcmp(argv[1], "-r") == 0) {
            srand(time(NULL));
            n = rand() % 16 + 5;
            for (i = 0; i < n; i++) {
                A[i] = rand() % 201 - 100;
                B[i] = A[i];
            }
            InsertionSort(n);
            for (i = 0; i < n; i++) {
                printf("%d ", B[i]);
            }
            printf("\n");
        } else {
            printf("error\n");
        }
    }
    return 0;
}