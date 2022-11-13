	.file	"MyFunc.c"
	.intel_syntax noprefix
	.text
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:							# функция, которая считает время работы программы
	push	rbp											
	mov	rbp, rsp	
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	add	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	imul	rax, rax, 1000000000
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -40[rbp]
	add	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]
	mov	rcx, rax
	movabs	rdx, 2361183241434822607
	mov	rax, rcx
	imul	rdx
	sar	rdx, 7
	mov	rax, rcx
	sar	rax, 63
	sub	rdx, rax
	mov	rax, rdx
	pop	rbp
	ret
	.size	timespecDiff, .-timespecDiff
	.globl	letters
	.section	.rodata
.LC0:
	.string	"aeiouy"
	.section	.data.rel.local,"aw"
	.align 8
	.type	letters, @object
	.size	letters, 8
letters:
	.quad	.LC0
	.section	.rodata
	.align 8
.LC1:
	.string	"Time of program: %ld microseconds\n"
	.text
	.globl	MyFunc
	.type	MyFunc, @function
MyFunc:
	push	rbp							# пролог	
	mov	rbp, rsp
	sub	rsp, 72

	push r12							# [rbp - 4] -> r12d	
	push r13							# [rbp - 56] -> r13	
	push r14							# 	
	push r15							# 
	push rbx							# 	

	mov	r13, rdi						# r13 = указатель на начало str
	lea	rax, -32[rbp]					# rax = &strat
	mov	rsi, rax						# rsi = &start
	mov	edi, 1							# clock_id = 1					
	call	clock_gettime@PLT			# clock_gettime(1, &start)
	mov	r12d, 0							# r12d = i = 0
	jmp	.L4
.L7:
	mov	eax, r12d
	movsx	rdx, eax
	mov	rax, r13
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	edx, al
	mov	rax, QWORD PTR letters[rip]
	mov	esi, edx
	mov	rdi, rax
	call	strchr@PLT
	test	rax, rax
	je	.L5
	mov	eax, r12d
	movsx	rdx, eax
	mov	rax, r13
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	toupper@PLT
	mov	ecx, eax
	mov	eax, r12d
	movsx	rdx, eax
	mov	rax, r13
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
.L5:
	add	r12d, 1
.L4:
	mov	eax, r12d					# eax = i
	movsx	rdx, eax				# rdx = i
	mov	rax, r13					# rax = указатель на начало str
	add	rax, rdx					# rax = указатель на str[i]
	movzx	eax, BYTE PTR [rax]		# eax = str[i]
	test	al, al					# comparison(str[i], 0)
	je	.L6							# if (str[i] == 0) : переход в L6
	cmp	r12d, 10000					# comparison(i, 10000)
	jne	.L7							# if (i != 10000) : переход в L7
.L6:
	lea	rax, -48[rbp]				# rax = &end
	mov	rsi, rax					# rsi = &end
	mov	edi, 1						# clock_id = 1
	call	clock_gettime@PLT		# clock_gettime(1, &end)
	mov	rax, QWORD PTR -32[rbp]		# 
	mov	rdx, QWORD PTR -24[rbp]		# 
	mov	rdi, QWORD PTR -48[rbp]		# rdi = end
	mov	rsi, QWORD PTR -40[rbp]		# rsi = start
	mov	rcx, rdx
	mov	rdx, rax					
	call	timespecDiff			# timespecDiff(end, start)
	mov	QWORD PTR -16[rbp], rax		# elapsed_ns = timespecDiff(end, start)
	mov	rax, QWORD PTR -16[rbp]		# rax = elapsed_ns
	mov	rsi, rax					# rsi = elapsed_ns
	lea	rdi, .LC1[rip]				# rdi = "Time of program: %ld microseconds\n"
	mov	eax, 0						# eax = 0
	call	printf@PLT				# printf("Time of program: %ld microseconds\n", elapsed_ns)
	pop rbx
	pop r15
	pop r14							
	pop r13
	pop r12
	leave							# эпилог
	ret
