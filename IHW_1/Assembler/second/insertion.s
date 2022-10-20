# DWORD PTR -20[rbp] = r12d	
# DWORD PTR -4[rbp] -> r13d
# DWORD PTR -8[rbp] -> r13d
    
    .intel_syntax noprefix
	.text
	.globl	InsertionSort
	.type	InsertionSort, @function
InsertionSort:
	push	rbp							        # пролог
	mov	rbp, rsp	

    push r12                                    #
    push r13                                    # сохранение calee-saved регистров
    push r14                                    # на стеке
    push r15        

    mov r12d, edi                              # r12d = n
    mov r13d, 0                                # r13d = i = 0

    sub r12d, 1                                 # r12d = n - 1
    .loop1_start:   
        cmp r13d, r12d
        jge .loop1_end                          # if (i >= n - 1) : цикл заканчивается

        mov r14d, r12d                          # r14d = j = n - 1
        .loop2_start: 
            cmp r14d, r13d
            jle .loop2_end                      # if (j <= i) : цикл заканчивается   

            mov eax, r14d                       # eax = j
            sub	eax, 1							# eax = j - 1
	        lea	rdx, 0[0+rax*4]					# rdx = [rax  *4]
	        lea	rax, B[rip]						# rax = указатель на начало массива B
	        mov	edx, DWORD PTR [rdx+rax]		# edx = B[j - 1]
	        mov	eax, r14d			            # eax = j	
	        lea	rcx, 0[0+rax*4]					# rcx = [j * 4] 
	        lea	rax, B[rip]						# rax = указатель на начало массива B
	        mov	eax, DWORD PTR [rcx+rax]		# eax = B[j]
	        cmp	edx, eax						# compare(B[j - 1], B[j])

            jle	.if_not					        # if (B[j - 1] <= B[j]) : переход в if_not

            mov r15d, edx                       # temp = B[j - 1]
            mov	r10d, r14d			            # r10d = j
	        lea	ecx, -1[r10]					# ecx = [j - 1]
            movsx	r11, ecx					# r11 = [j - 1]
	        lea	rcx, 0[0+r11*4]					# rcx = [(j - 1) * 4]
	        lea	r11, B[rip]						# r11 = указатель на начало массива B
	        mov	DWORD PTR [rcx+r11], eax		# B[j - 1] = B[j]

            lea	rcx, 0[0+r10d*4]				# rcx = [j * 4]
	        mov	DWORD PTR [rcx+r11], r15d		# B[j] = temp = B[j - 1]
            
            .if_not:

            sub r14d, 1                         # --j
            jmp .loop2_start                          
        .loop2_end:


        add r13d, 1                             # ++i
        jmp .loop1_start
    .loop1_end:

    pop r15                                    #
    pop r14                                    # эпилог
    pop r13                                    # 
    pop r12
    leave
    ret
