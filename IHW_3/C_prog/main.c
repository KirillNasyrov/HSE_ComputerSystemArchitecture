#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

extern double MyFunc(double x);

int main(int argc, char *argv[]) {
    double result;
    double number;
    if (argc > 1) {
        if (strcmp(argv[1], "-f") == 0) {
            FILE *input, *output;
            input = fopen(argv[2], "r");
            output = fopen(argv[3], "w");

            if (input == NULL) {
                perror("Error occured while opening file");
                exit(0);
            }

            fscanf(input, "%lf", &number);
            result = MyFunc(number);
            fprintf(output, "%lf", result);

            printf("result is in file\n");
            fclose(input);
            fclose(output);
        } else if (strcmp(argv[1], "-h") == 0) {
            char *ptr;
            number = strtod(argv[2], &ptr);
            MyFunc(number);
        } else if (strcmp(argv[1], "-r") == 0) {
            srand(time(NULL));
            number = rand() / (double)RAND_MAX * 2 - 1;
            printf("generated x: %lf\n", number);
            MyFunc(number);
        } else {
            printf("error\n");
            return 1;
        }
    }
    return 0;
}