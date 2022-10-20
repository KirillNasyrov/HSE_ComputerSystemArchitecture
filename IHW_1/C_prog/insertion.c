extern int B[];

void InsertionSort(int n)
{
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = (n - 1); j > i; j--) // для всех элементов после i-ого
        {
            if (B[j - 1] > B[j]) // если текущий элемент меньше предыдущего
            {
                int temp = B[j - 1]; // меняем их местами
                B[j - 1] = B[j];
                B[j] = temp;
            }
        }
    }
}