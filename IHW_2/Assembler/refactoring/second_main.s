	.file	"main.c"
	.intel_syntax noprefix
	.text
	.comm	string,10001,32
	.section	.rodata
.LC0:
	.string	"-f"
.LC1:
	.string	"r"
.LC2:
	.string	"w"
	.align 8
.LC3:
	.string	"Error occured while opening file"
.LC4:
	.string	"result is in file"
.LC5:
	.string	"-h"
.LC6:
	.string	"result: %s\n"
.LC7:
	.string	"-r"
.LC8:
	.string	"generated string: %s\n"
.LC9:
	.string	"error"
	.text
	.globl	main
	.type	main, @function
main:                         
	push	rbp                         # пролог
	mov	rbp, rsp
	sub	rsp, 40
	push r12							# [rbp - 48] -> r12	
	push r13							# [rbp - 16] -> r13	
	push r14							# [rbp - 4] -> r14d	
	push r15							# [rbp - 24] -> r15
	push rbx							# [rbp - 8] -> ebx		

	mov	DWORD PTR -36[rbp], edi         # [rbp - 36] = argc
	mov	r12, rsi         				# r12 = указатель на начало argv    
	cmp	DWORD PTR -36[rbp], 1           # comparison(argc, 1)
	jle	.L2                             # if (argc <= 1) : переход в L2
	mov	rax, r12         				# rax = указатель на начало argv
	add	rax, 8                          # rax = указатель на argv[1]
	mov	rax, QWORD PTR [rax]            # rax = argv[1]
	lea	rsi, .LC0[rip]                  # rsi = "-f"
	mov	rdi, rax                        # rdi = argv[1]
	call	strcmp@PLT                  # strcmp(argv[1], "-f")
	test	eax, eax                    # if (strcmp(argv[1], "-f") == 0)
	jne	.L3                             # if false : переход в L3    
	mov	rax, r12         				# rax = указатель на начало argv
	add	rax, 16                         # rax = указатель на argv[2]
	mov	rax, QWORD PTR [rax]            # rax = argv[2]
	lea	rsi, .LC1[rip]                  # rsi = "r"
	mov	rdi, rax                        # rdi = argv[2]
	call	fopen@PLT                   # fopen(argv[2], "r")
	mov	r13, rax         				# r13 = input = fopen(argv[2], "r")
	mov	rax, r12         				# rax = указатель на начало argv
	add	rax, 24                         # rax = указатель на argv[3]
	mov	rax, QWORD PTR [rax]            # rax = argv[3]
	lea	rsi, .LC2[rip]                  # rsi = "w"
	mov	rdi, rax                        # rdi = argv[3]
	call	fopen@PLT                   # fopen(argv[3], "w")
	mov	r15, rax         				# r15 = output = fopen(argv[3], "w")
	cmp	r13, 0           				# comparison(input, NULL)
	jne	.L4                             # if (input != NULL) : переход в L4
	lea	rdi, .LC3[rip]                  # rdi = "Error occured while opening file"
	call	perror@PLT                  # perror("Error occured while opening file")
	mov	edi, 0                          # edi = 0
	call	exit@PLT                    # exit(0)
.L4:
	mov	r14d, 0            				# r14d = i = 0
	jmp	.L5                             # переход в L5
.L7:
	mov	eax, r14d          				# eax = i = 0
	lea	edx, 1[rax]                     # edx = [i + 1]
	mov	r14d, edx          				# i = i++
	lea	rcx, string[rip]                # rcx = указатель на начало string
	movzx	edx, BYTE PTR -25[rbp]      # edx = symbol
	mov	BYTE PTR [rax+rcx], dl          # string[i] = symbol
	cmp	r14d, 10000        				# comparison(i, 10000)
	jne	.L5                             # if (i != 10000) : переход в L5
	mov	eax, r14d          				# eax = i                                
	lea	rdx, string[rip]                # rdx = указатель на начало string
	mov	BYTE PTR [rax+rdx], 0           # string[i] = 0
	jmp	.L6                             # переход в L6
.L5:
	mov	rax, r13         				# rax = input
	mov	rdi, rax                        # rdi = input
	call	fgetc@PLT                   # fgetc(input)
	mov	BYTE PTR -25[rbp], al           # [rbp - 25] = symbol = fgetc(input)
	cmp	BYTE PTR -25[rbp], -1           # comparison(symbol, -1)
	jne	.L7                             # if (symbol != -1) : переход в L7
.L6:
	lea	rdi, string[rip]                # rdi = указатель на начало string
	call	MyFunc@PLT                  # MyFunc(string)
	mov	r14d, 0            				# i = 0
	jmp	.L8                             # переход в L8
.L9:
	mov	eax, r14d          				# eax = i
	lea	rdx, string[rip]                # rdx = указатель на начало string
	movzx	eax, BYTE PTR [rax+rdx]     # eax = string[i]
	movsx	eax, al
	mov	rdx, r15         				# rdx = output
	mov	rsi, rdx                        # rsi = output
	mov	edi, eax                        # edi = string[i]
	call	fputc@PLT                   # fputc(string[i], output)
	add	r14d, 1            				# ++i
.L8:
	mov	eax, r14d          				# eax = i
	lea	rdx, string[rip]                # rdx = указатель на начало string
	movzx	eax, BYTE PTR [rax+rdx]     # eax = string[i]
	test	al, al                      # comparison(string[i], 0)
	jne	.L9                             # if (string[i] != 0) : переход в L9
	lea	rdi, .LC4[rip]                  # rdi = "result is in file"
	call	puts@PLT                    # printf("result is in file\n");
	mov	rax, r13         				# rax = input
	mov	rdi, rax                        # rdi = input
	call	fclose@PLT                  # fclose(input)
	mov	rax, r15         				# rax = output
	mov	rdi, rax                        # rdi = output
	call	fclose@PLT                  # fclose(output)
	jmp	.L2                             # переход в L2
.L3:
	mov	rax, r12         				# rax = указатель на начало argv
	add	rax, 8                          # rax = указатель на argv[1]
	mov	rax, QWORD PTR [rax]            # rax = argv[1]
	lea	rsi, .LC5[rip]                  # rsi = "-h"
	mov	rdi, rax                        # rdi = argv[1]
	call	strcmp@PLT                  # strcmp(argv[1], "-h")
	test	eax, eax                    # if (strcmp(argv[1], "-h") == 0)
	jne	.L10                            # if false : переход в L10
	mov	rax, r12         				# rax = указатель на начало argv
	add	rax, 16                         # rax = указатель на argv[2]
	mov	rax, QWORD PTR [rax]            # rax = argv[2]
	mov	rdi, rax                        # rdi = argv[2]
	call	MyFunc@PLT                  # MyFunc(argv[2])
	mov	rax, r12         				# rax = указатель на начало argv
	add	rax, 16                         # rax = указатель на argv[2]
	mov	rax, QWORD PTR [rax]            # rax = argv[2]
	mov	rsi, rax                        # rsi = argv[2]
	lea	rdi, .LC6[rip]                  # rdi = "result: %s\n"
	mov	eax, 0                          # eax = 0
	call	printf@PLT                  # printf("result: %s\n", argv[2])
	jmp	.L2                             # переход в L2
.L10:
	mov	rax, r12         				# rax = указатель на начало argv
	add	rax, 8                          # rax = указатель на argv[1]
	mov	rax, QWORD PTR [rax]            # rax = argv[1]
	lea	rsi, .LC7[rip]                  # rsi = "-r"
	mov	rdi, rax                        # rdi = argv[1]
	call	strcmp@PLT                  # strcmp(argv[1], "-r")
	test	eax, eax                    # if (strcmp(argv[1], "-r") == 0)
	jne	.L11                            # if false : переход в L11
	mov	edi, 0                          # edi = 0
	call	time@PLT                    # time(0)
	mov	edi, eax                        # edi = time(0)
	call	srand@PLT                   # srand(time(0))
	call	rand@PLT                    # rand()
	movsx	rdx, eax                    # rdx = rand()
	imul	rdx, rdx, -2009080335       # 
	shr	rdx, 32                         # 
	add	edx, eax                        # 
	mov	ecx, edx                        # 
	sar	ecx, 8                          # 
	cdq                                 # 
	sub	ecx, edx                        # 
	mov	edx, ecx                        # 
	imul	edx, edx, 481               # 
	sub	eax, edx                        # 
	mov	edx, eax                        # 
	lea	eax, 20[rdx]                    # 
	mov	ebx, eax          				# ebx = n = rand() % 481 + 20
	mov	r14d, 0            				# i = 0
	jmp	.L12                            # переход в L12
.L13:
	call	rand@PLT                    # rand()
	movsx	rdx, eax                    # rdx = rand()    
	imul	rdx, rdx, -1401515643       # 
	shr	rdx, 32                         # 
	add	edx, eax                        # 
	mov	ecx, edx                        #     
	sar	ecx, 6                          # 
	cdq                                 # 
	sub	ecx, edx                        # 
	mov	edx, ecx                        # 
	imul	edx, edx, 95                #     
	sub	eax, edx                        # string[i] = rand() % 95 + 32;
	mov	edx, eax                        # 
	mov	eax, edx                        # 
	add	eax, 32                         # 
	mov	ecx, eax                        #         
	mov	eax, r14d          				#                                 
	lea	rdx, string[rip]                # 
	mov	BYTE PTR [rax+rdx], cl          # 
	add	r14d, 1            				# ++i
.L12:
	mov	eax, r14d          				# eax = i
	cmp	eax, ebx          				# comparison(i, n)
	jl	.L13                            # if (i < n) : переход в L13
	mov	eax, ebx          				# eax = n
	lea	rdx, string[rip]                # rdx = указатель на начало string
	mov	BYTE PTR [rax+rdx], 0           # string[n] = 0
	lea	rsi, string[rip]                # rsi = указатель на начало string  
	lea	rdi, .LC8[rip]                  # rdi = "generated string: %s\n"
	mov	eax, 0                          # eax = 0
	call	printf@PLT                  # printf("generated string: %s\n", string);
	lea	rdi, string[rip]                # rdi = указатель на начало string
	call	MyFunc@PLT                  # MyFunc(string)    
	lea	rsi, string[rip]                # rsi = указатель на начало string
	lea	rdi, .LC6[rip]                  # rdi = "result: %s\n"
	mov	eax, 0                          # eax = 0
	call	printf@PLT                  # printf("result: %s\n", string)
	jmp	.L2                             # переход в L2
.L11:
	lea	rdi, .LC9[rip]                  # rdi = "error"
	call	puts@PLT                    # printf("error\n");
	mov	eax, 1                          # return 1
	jmp	.L14                            # переход в L14
.L2:
	mov	eax, 0                          # return 0
.L14:
	pop rbx
	pop r15
	pop r14
	pop r13
	pop r12
	leave                               # эпилог
	ret
