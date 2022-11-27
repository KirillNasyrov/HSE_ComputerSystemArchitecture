	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"-f"
.LC1:
	.string	"r"
.LC2:
	.string	"w"
.LC3:
	.string	"Error occured while opening file"
.LC4:
	.string	"%lf"
.LC5:
	.string	"result is in file"
.LC6:
	.string	"-h"
.LC7:
	.string	"-r"
.LC10:
	.string	"generated x: %lf\n"
.LC11:
	.string	"error"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
	push	r13								# пролог 
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 24									
	dec	edi									# argc -= 1
	jle	.L7									# if (argc <= 1) : переход в L7
	mov	rbp, QWORD PTR 8[rsi]				# rbp = argv[1]
	mov	rbx, rsi							# rbx = указатель на начало argv
	lea	rsi, .LC0[rip]						# rsi = "-f"
	mov	rdi, rbp							# rdi = argv[1]
	call	strcmp@PLT						# strcmp(argv[1], "-f")
	mov	r12d, eax							# r12d = strcmp(argv[1], "-f")
	test	eax, eax					    # comparison(strcmp(argv[1], "-f"), 0)
	jne	.L3									# # if (strcmp(argv[1], "-f") != 0) : переход в L3
	mov	rdi, QWORD PTR 16[rbx]				# rdi = argv[2]
	lea	rsi, .LC1[rip]						# rsi = "r"
	call	fopen@PLT						# fopen(argv[2], "r")
	mov	rdi, QWORD PTR 24[rbx]				# rdi = argv[3]
	lea	rsi, .LC2[rip]						# rsi = "w"
	mov	rbp, rax							# rbp = input
	call	fopen@PLT						# fopen(argv[3], "w")
	mov	r13, rax							# r13 = output
	test	rbp, rbp						# comparison(input, null)
	jne	.L4									# if (input != NULL) : переход в L4
	lea	rdi, .LC3[rip]						# rdi = "Error occured while opening file"
	call	perror@PLT						# perror("Error occured while opening file")
	xor	edi, edi							# edi = 0
	call	exit@PLT						# exit(0)
.L4:
	mov	rdx, rsp							# rdx = &number
	mov	rdi, rbp							# rdi = input
	lea	rsi, .LC4[rip]						# rsi = "%lf"
	xor	eax, eax							# eax = 0	
	call	__isoc99_fscanf@PLT				# fscanf(input, "%lf", &number)
	movsd	xmm0, QWORD PTR [rsp]			# xmm0 = number
	call	MyFunc@PLT						# MyFunc(number)
	mov	esi, 1								# esi = 1
	mov	rdi, r13							# rdi = output
	mov	al, 1								# al = 1
	lea	rdx, .LC4[rip]						# rdx = "%lf"
	call	__fprintf_chk@PLT				# fprintf(output, "%lf", result)	
	lea	rdi, .LC5[rip]						# rdi = "result is in file"
	call	puts@PLT						# printf("result is in file\n")	
	mov	rdi, rbp							# rdi = input
	call	fclose@PLT						# fclose(input)
	mov	rdi, r13							# rdi = output
	call	fclose@PLT						# fclose(output)
	jmp	.L1									# переход в L1
.L3:
	lea	rsi, .LC6[rip]						# rsi = "-h"
	mov	rdi, rbp							# rdi = argv[1]	
	call	strcmp@PLT						# strcmp(argv[1], "-h")
	mov	r12d, eax							# r12d = strcmp(argv[1], "-h")
	test	eax, eax						# comparison(strcmp(argv[1], "-h"), 0)
	jne	.L5									# if (strcmp(argv[1], "-h") != 0) : переход в L5
	mov	rdi, QWORD PTR 16[rbx]				# rdi = argv[2]
	lea	rsi, 8[rsp]							# rsi = *ptr
	call	strtod@PLT						# strtod(argv[2], &ptr)
	movsd	QWORD PTR [rsp], xmm0			# MyFunc(number)
	jmp	.L9
.L5:
	lea	rsi, .LC7[rip]						# rsi = "-r"
	mov	rdi, rbp							# rdi = argv[1]
	call	strcmp@PLT						# strcmp(argv[1], "-r")
	mov	r12d, eax							# r12d = strcmp(argv[1], "-r")
	test	eax, eax						# comparison(strcmp(argv[1], "-r"), 0)
	jne	.L6									# if (strcmp(argv[1], "-r") != 0) : переход в L6
	xor	edi, edi							# edi = 0
	call	time@PLT						# time(0)
	mov	rdi, rax							# rdi = time(0)
	call	srand@PLT						# srand(time(NULL))
	call	rand@PLT						# rand()
	lea	rsi, .LC10[rip]						# rsi = "generated x: %lf\n"
	mov	edi, 1								# 
	cvtsi2sd	xmm0, eax					# 
	divsd	xmm0, QWORD PTR .LC8[rip]		# 
	addsd	xmm0, xmm0						# 	number = rand() / (double)RAND_MAX * 2 - 1;
	mov	al, 1								# 
	subsd	xmm0, QWORD PTR .LC9[rip]		# 
	movsd	QWORD PTR [rsp], xmm0			# 
	call	__printf_chk@PLT				# printf("generated x: %lf\n", number)
	movsd	xmm0, QWORD PTR [rsp]			# xmm0 = number
.L9:
	call	MyFunc@PLT						# MyFunc(number)
	jmp	.L1									# переход в L1
.L6:
	lea	rdi, .LC11[rip]						# rdi = "error\n"
	mov	r12d, 1								# r12d = 1
	call	puts@PLT						# printf("error\n");
	jmp	.L1									# переход в L1
.L7:
	xor	r12d, r12d							# r12d = 0
.L1:
	add	rsp, 24
	mov	eax, r12d							# эпилог
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC8:
	.long	4290772992
	.long	1105199103
	.align 8
.LC9:
	.long	0
	.long	1072693248
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
