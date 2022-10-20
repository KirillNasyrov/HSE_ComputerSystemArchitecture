# ИДЗ по АВС № 1
## **Изменения в дизассемблированном коде**
- ### **максимальное использование регистров**
  В исходном коде все локальные переменные сохранялись в стеке. В изменённой программе все данные помещаются в регистры `rbx`, `r12-r15`.<br>

  *запись данных в исходном методе `main`:*
  ```
    mov	QWORD PTR -48[rbp], rsi
    mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -24[rbp], rax
    mov	QWORD PTR -16[rbp], rax
    mov	DWORD PTR -8[rbp], eax
    mov	DWORD PTR -4[rbp], 0
  ```
  *использование регистров в исправленном методе `main`:*
  ```
    mov r12d, edi                   # r12d = edi = int argc
    mov r13, rsi                    # r13 = rsi = указатель на начало argv[]
    mov r14, rax                    # r14 = input
    mov r15, rax                    # r15 = output
  ```
