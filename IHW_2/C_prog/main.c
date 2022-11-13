#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

char string[10001];

extern void MyFunc(char *string);

int main(int argc, char *argv[]) {
    int n, i;
    if (argc > 1) {
        if (strcmp(argv[1], "-f") == 0) {
            FILE *input, *output;
            input = fopen(argv[2], "r");
            output = fopen(argv[3], "w");

            if (input == NULL) {
                perror("Error occured while opening file");
                exit(0);
            }

            char symbol;
            i = 0;
            while ((symbol = fgetc(input)) != EOF) {
                string[i++] = symbol;
                if (i == 10000) {
                    string[i] = 0;
                    break;
                }
            }

            MyFunc(string);
            for (i = 0; string[i] != 0; i++) {
                fputc(string[i], output);
            }

            printf("result is in file\n");
            fclose(input);
            fclose(output);
        } else if (strcmp(argv[1], "-h") == 0) {
            MyFunc(argv[2]);
            printf("result: %s\n", argv[2]);
        } else if (strcmp(argv[1], "-r") == 0) {
            srand(time(NULL));
            n = rand() % 481 + 20;
            for (i = 0; i < n; i++) {
                string[i] = rand() % 95 + 32;
            }
            string[n] = 0;
            printf("generated string: %s\n", string);
            MyFunc(string);
            printf("result: %s\n", string);
        } else {
            printf("error\n");
            return 1;
        }
    }
    return 0;
}