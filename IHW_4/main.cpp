#include <pthread.h>
#include <iostream>
#include <cstdlib>
#include <atomic>
#include <unistd.h>
#include <fstream>
#include <cstring>

pthread_mutex_t mutex;
int height, length; //высота и длина поля
int **field; // поле в виде двумерного динамического массива

void *func1(void *arg) {
    auto arr = static_cast<std::atomic<int>*>(arg); // получение аргументов
    int count = 0; // счётчик пройденных клеток
    bool directionLeftToRight = true; // направление движение
    while (count != height * length) { // пока не прошли всё поле
        if (arr[0] == arr[2] && arr[1] == arr[3]) { // если садовники пересекаются
            pthread_mutex_lock(&mutex); // мьютекс лок
            if (field[arr[0]][arr[1]] == 0) {
                usleep(500000);
                printf("Первый садовник обработал клетку с координатами { %d; %d}\n", (int)arr[0], (int)arr[1]);
                field[arr[0]][arr[1]] = 1; // если клетка не обработана, то обрабатываем его
            } else {
                printf("Первый садовник пропустил клетку с координатами { %d; %d}\n", (int)arr[0], (int)arr[1]);
            }
            pthread_mutex_unlock(&mutex); // мьютекс анлок
        } else {
            if (field[arr[0]][arr[1]] == 0) {
                usleep(500000);
                printf("Первый садовник обработал клетку с координатами { %d; %d}\n", (int)arr[0], (int)arr[1]);
                field[arr[0]][arr[1]] = 1; // если клетка не обработана, то обрабатываем его
            } else {
                printf("Первый садовник пропустил клетку с координатами { %d; %d}\n", (int)arr[0], (int)arr[1]);
            }
        }
        usleep(500000);
        if (directionLeftToRight) { // переход садовника на следующую клетку
            if (arr[1] == length - 1) {
                ++arr[0];
                directionLeftToRight = false;
            } else {
                ++arr[1];
            }
        } else {
            if (arr[1] == 0) {
                ++arr[0];
                directionLeftToRight = true;
            } else {
                --arr[1];
            }
        }
        ++count;
    }
    return nullptr;
}

void *func2(void *arg) { // этот метод работает аналогично func1
    auto arr = static_cast<std::atomic<int>*>(arg);
    int count = 0;
    bool directionUp = true;
    while (count != height * length) {
        if (arr[0] == arr[2] && arr[1] == arr[3]) {
            pthread_mutex_lock(&mutex);
            if (field[arr[2]][arr[3]] == 0) {
                usleep(500000);
                printf("Второй садовник обработал клетку с координатами { %d; %d}\n", (int)arr[2], (int)arr[3]);
                field[arr[2]][arr[3]] = 1;
            } else {
                printf("Второй садовник пропустил клетку с координатами { %d; %d}\n", (int)arr[2], (int)arr[3]);
            }
            pthread_mutex_unlock(&mutex);
        } else {
            if (field[arr[2]][arr[3]] == 0) {
                usleep(500000);
                printf("Второй садовник обработал клетку с координатами { %d; %d}\n", (int)arr[2], (int)arr[3]);
                field[arr[2]][arr[3]] = 1;
            } else {
                printf("Второй садовник пропустил клетку с координатами { %d; %d}\n", (int)arr[2], (int)arr[3]);
            }
        }
        usleep(500000);
        if (directionUp) { // разница лишь в направлениях движения второго садовника
            if (arr[2] == 0) {
                --arr[3];
                directionUp = false;
            } else {
                --arr[2];
            }
        } else {
            if (arr[2] == height - 1) {
                --arr[3];
                directionUp = true;
            } else {
                ++arr[2];
            }
        }
        ++count;
    }
    return nullptr;
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        return 1;
    } else if (strcmp(argv[1], "-c") == 0) { // если пользователь выбрал ввод с консоли
        std::cin >> height >> length;
    } else if (strcmp(argv[1], "-f") == 0) { // если пользователь выбрал ввод с файла
        std::string line;
        std::string filename = argv[2];
        std::ifstream in("./" + filename);
        in >> line;
        height = std::stoi(line);
        in >> line;
        length = std::stoi(line);
    } else if (strcmp(argv[1], "-l") == 0) { // если пользователь выбрал ввод с командной строки
        height = std::stoi(argv[2]);
        length = std::stoi(argv[3]);
    } else if (strcmp(argv[1], "-r") == 0) { // если пользователь выбрал генерацию данных
        srand(time(nullptr));
        height = 10 + (int)random() % 31; // генерация длины и ширины от 10 до 40
        length = (int)random() % 40;
    } else {
        std::cout << argv[1] << "\n";
        return 2;
    }
    if (height > 40) { // ограничение на размеры поля в длину и ширину 40
        height = 10;
    }
    if (length > 40) {
        length = 10;
    }

    field = new int*[height]; // создание поля
    for (int i = 0; i < height; ++i) {
        field[i] = new int[length];
    }

    for (int i = 0; i < height; ++i) { // присвоим всем клеткам поля значение 0, что означает необработанная клетка
        for (int j = 0; j < length; ++j) {
            field[i][j] = 0;
        }
    }

    srand(time(nullptr));
    long x = 10 + random() % 21;
    int number = (int)x * height * length / 100; // случайное количество клеток (от 10 до 30%), которое нельзя обработать
    int randomX, randomY;

    for (int i = 0; i < number; ++i) {
        randomX = (int)random()% height;
        randomY = (int)random()% length;
        field[randomX][randomY] = -1; // выбираем случайным образом клетки, которые нельзя обработать
    }

    alignas(64) auto args = new std::atomic<int>[4]; // массив аргументов, которые представляют координаты первого и второго садовников
    args[0] = 0;
    args[1] = 0;
    args[2] = height - 1;
    args[3] = length - 1;

    pthread_t t1, t2; // создаём потоки и мьютекс
    pthread_mutex_init(&mutex, nullptr);

    pthread_create(&t1, nullptr, &func1, args);
    pthread_create(&t2, nullptr, &func2, args);

    pthread_join(t1, nullptr); // ждём окончание выполнения потоков
    pthread_join(t2, nullptr);

    pthread_mutex_destroy(&mutex);

    for (int i = 0; i < height; ++i) {
        delete field[i];
    }
    delete[] field; // очистка памяти
    delete[] args;
    return 0;
}
