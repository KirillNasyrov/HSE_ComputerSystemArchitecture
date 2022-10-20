# DWORD PTR -36[rbp] -> r12d
# QWORD PTR -48[rbp] -> r13
# DWORD PTR -8[rbp] -> ebx
# QWORD PTR -16[rbp] -> r14
# DWORD PTR -4[rbp] -> r10d
# QWORD PTR -24[rbp] -> r15
    .intel_syntax noprefix
    .text
    .comm	A,4194304,32
    .comm	B,4194304,32
    .section	.rodata
.LC0:
    .string	"-f"
.LC1:
    .string	"r"
.LC2:
    .string	"%d"
.LC3:
    .string	"w"
.LC4:
    .string	"%d "
.LC5:
    .string	"-h"
.LC6:
    .string	"-r"
.LC8:
    .string	"end"
.LC7:
    .string	"error"
    .text
    .globl	main
    .type	main, @function
main:
    push rbp		                    # пролог
    mov rbp, rsp
    sub rsp, 8                          # выделение памяти в стеке

    push r12                            #
    push r13                            #
    push rbx                            # сохранение calee-saved регистров
    push r14                            # на стеке
    push r15                            #

    mov r12d, edi                       # r12d = edi = int argc
    mov r13, rsi                        # r13 = rsi = указатель на начало argv[]
    cmp r12d, 1                         # сравнение argc с 1
    jle .end                            # если argc <= 1, перейте в .end
    mov rdi, r13                        # rdi = указатель на начало argv[]
    add rdi, 8                          # rdi = указатель argv[1]
    mov rdi, qword ptr [rdi]            # rdi = argv[1]
    lea rsi, .LC0[rip]                  # rsi = "-f"
    call strcmp@PLT	                    # eax = compare(argv[1], "-f")
    test eax, eax                       # if (eax == 0)
    jne .if_hand                        # если не равно 0, идём в .if_hand
    
    mov rdi, r13                        # rdi = указатель на начало argv[]  
    add rdi, 32                         # rdi = указатель на argv[4] 
    mov rdi, qword ptr [rdi]            # rdi = argv[4]
    call atoi@PLT                       # eax = int(n)
    
    mov ebx, eax                        # ebx = int(n)
    mov rdi, r13                        # rdi = указатель на начало argv[]
    add rdi, 16                         # rdi = указатель на argv[2] 
    mov rdi, qword ptr [rdi]            # rdi = argv[2]
    lea rsi, .LC1[rip]                  # rsi = "r"
    call fopen@PLT                      # fopen(argv[2], "r")
    
    mov r14, rax                        # r14 = input
    mov r10d, 0                         # r10d = i = 0
    .loop1_start:
        cmp r10d, ebx
        jge .loop1_end                  # if (i >= n) : цикл заканчивается

        lea	rdx, 0[0+r10*4]             # rdx = [i * 4]
        lea	rax, A[rip]                 # rax = указатель на начало массива A
        add	rdx, rax                    # rdx = указатель на A[i]
        mov rdi, r14                    # rdi = input
        lea	rsi, .LC2[rip]              # rsi = "%d"
        mov dword ptr -4[rbp], r10d     # [rbp-4] = i
        call __isoc99_fscanf@PLT        # fscanf(input, "%d", &A[i])

        mov r10d, dword ptr -4[rbp]     # i = [rbp-4]
        lea rdx, 0[0+r10*4]             # rdx = [i * 4]            
        lea rax, A[rip]                 # rax = указатель на начало массива A
        mov eax, dword ptr[rdx + rax]   # eax = A[i]

        movsx r10, r10d				    # r10 = i
        lea rcx, 0[0+r10*4]             # rcx = [i * 4] 
        lea rdx, B[rip]                 # rdx = указатель на начало массива B
        mov dword ptr[rcx + rdx], eax   # B[i] = A[i]
        add r10d, 1                     # ++i
        jmp .loop1_start
    .loop1_end:

    mov edi, ebx                        # edi = n
    call InsertionSort@PLT		        # InsertionSort(n)
    mov	rax, r13		                # rax = указатель на начало argv[]
    add	rax, 24						    # rax = указатель на argv[3]
    mov rdi, qword ptr[rax]             # rdi = argv[3]
    lea	rsi, .LC3[rip]				    # rsi = "w"
    call fopen@PLT				        # fopen(argv[3], "w")
    mov r15, rax                        # r15 = output
    mov r10d, 0                         # i = 0

    .loop2_start:
        cmp r10d, ebx
        jge .loop2_end                  # if (i >= n) : цикл заканчивается

        lea rdx, 0[0+r10*4]             # rdx = [i * 4]
        lea rax, B[rip]                 # rax = указатель на начало массива B
        mov edx, dword ptr[rdx + rax]   # edx = B[i]
        mov rdi, r15                    # rdi = output
        lea	rsi, .LC4[rip]				# rsi = "%d "
        mov dword ptr -4[rbp], r10d     # [rbp - 4] = i

        call fprintf@PLT				# fprintf(output, "%d ", B[i])
        mov r10d, dword ptr -4[rbp]     # i = [rbp - 4]
        add r10d, 1                     # ++i
        jmp .loop2_start
    .loop2_end:
    jmp .end

.if_hand:
    mov rdi, r13                        # rdi = указатель на начало argv[]
    add rdi, 8                          # rdi = указатель на argv[1]
    mov rdi, qword ptr[rdi]             # rdi = argv[1]
    lea	rsi, .LC5[rip]				    # rsi = "-h"
    call strcmp@PLT				        # strcmp(argv[1], "-h")
    test eax, eax				        # if (eax == 0)
    jne .if_random                      # если не равно 0, идём в .if_random

    mov eax, r12d                       # eax = argc
    sub eax, 2                          # eax = argc - 2
    mov ebx, eax                        # ebx = n
    mov r10d, 0                         # i = 0

    .loop3_start:
        cmp r10d, ebx    
        jge .loop3_end                  # if (i >= n) : цикл заканчивается

        mov eax, r10d                   # eax = i
        add rax, 2                      # rax = i + 2
        lea	rdx, 0[0+rax*8]			    # rdx = [rax * 8] 
        mov rdi, r13                    # rdi = указатель на начало argv[]
        add rdi, rdx                    # rdi = указатель argv[i + 2]
        mov rdi, qword ptr [rdi]        # rdi = argv[i + 2]
        mov dword ptr -4[rbp], r10d     # [rbp - 4] = i

        call atoi@PLT				    # atoi(argv[i + 2])

        mov r10d, dword ptr -4[rbp]     # i = [rbp - 4]
        movsx r10, r10d
        lea rcx, 0[0+r10*4]				# rcx = [i * 4]
        lea rdx, A[rip]                 # rdx = указатель на начало массива A
        mov dword ptr[rcx + rdx], eax   # A[i] = atoi(argv[i + 2])

        lea rcx, 0[0+r10*4]				# rcx = [i * 4]
        lea rdx, B[rip]                 # rdx = указатель на начало массива B
        mov dword ptr[rcx + rdx], eax   # B[i] = atoi(argv[i + 2])
        add r10d, 1                     # ++i
        jmp .loop3_start
    .loop3_end:

    mov edi, ebx                        # edi = n
    call InsertionSort@PLT		        # InsertionSort(n)
    mov r10d, 0                         # i = 0

    .loop4_start:
        cmp r10d, ebx    
        jge .loop4_end                  # if (i >= n) : цикл заканчивается
        
        lea rdx, 0[0+r10*4]				# rdx = [i * 4]
        lea	rax, B[rip]					# rax = указатель на начало массива B
        mov esi, dword ptr [rdx + rax]  # esi = B[i]
        lea	rdi, .LC4[rip]				# rdi = "%d "
        mov dword ptr -4[rbp], r10d     # [rbp - 4] = i

        call printf@PLT				    # printf("%d ", B[i])
        mov r10d, dword ptr -4[rbp]     # i = [rbp - 4]
        add r10d, 1                     # ++i
        jmp .loop4_start
    .loop4_end: 

    mov	edi, 10						    # edi = 10
	call putchar@PLT				    # переход на новую строку
	jmp	.end						    # переход в end

.if_random:
    mov rdi, r13                        # rdi = указатель на начало argv[]
    add rdi, 8                          # rdi = указатель на argv[1]
    mov rdi, qword ptr[rdi]             # rdi = argv[1]
    lea	rsi, .LC6[rip]				    # rsi = "-r"
    call strcmp@PLT				        # strcmp(argv[1], "-r")
    test eax, eax				        # if (eax == 0)
    jne .error                          # если не равно 0, идём в .error

    mov	edi, 0						    # edi = 0
	call time@PLT				        # time(null)
	mov	edi, eax					    # edi = seed
	call srand@PLT				        # srand(seed)
	call rand@PLT				        # rand()
	cdq			
	shr	edx, 28						    # /
	add	eax, edx					    # |
	and	eax, 15						    # | eax = rand() % 16 + 5;
	sub	eax, edx  					    # |
	add	eax, 5						    # \
	mov	ebx, eax		                # ebx = n = rand() % 16 + 5;
	mov	r10d, 0		                    # [rpb - 4] = i = 0

    .loop5_start:
        cmp r10d, ebx    
        jge .loop5_end                  # if (i >= n) : цикл заканчивается

        mov dword ptr -4[rbp], r10d     # [rbp - 4] = i
        call rand@PLT				    # /	
        mov r10d, dword ptr -4[rbp]     # | i = [rbp - 4]
	    movsx rdx, eax				    # |
	    imul rdx, rdx, 42735993		    # |
	    shr	rdx, 32						# |
	    mov	ecx, edx					# |
	    sar	ecx							# |
	    cdq								# |
	    sub	ecx, edx					# |		
	    mov	edx, ecx					# |
	    imul edx, edx, 201			    # |	
	    sub	eax, edx					# | A[i] = rand() % 201 - 100;
	    mov	edx, eax					# |
	    lea	ecx, -100[rdx]				# |
	    mov	eax, r10d		            # |	
	    cdqe							# |
	    lea	rdx, 0[0+rax*4]				# |	
	    lea	rax, A[rip]					# |	
	    mov	DWORD PTR [rdx+rax], ecx	# \_

        mov	eax, r10d		            # |	
	    cdqe                            # |
	    lea	rdx, 0[0+rax*4]				# |
	    lea	rax, B[rip]					# | B[i] = A[i]
	    mov	DWORD PTR [rdx+rax], ecx	# \_

        add r10d, 1                     # ++i
        jmp .loop5_start
    .loop5_end:

    mov edi, ebx                        # edi = n
    call InsertionSort@PLT		        # InsertionSort(n)
    mov r10d, 0                         # i = 0

    jmp .loop4_start
    jmp .end

.error:
    lea	rdi, .LC7[rip]				# rdi = "error"
	call	puts@PLT				# printf("error\n")
.end:
    lea	rdi, .LC8[rip]				    # rdi = "end"
	call puts@PLT				        # printf("end\n")
    add rsp, 8
    mov	eax, 0                          # эпилог
    pop r15
    pop r14
    pop rbx
    pop r13
    pop r12
    leave
    ret
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        