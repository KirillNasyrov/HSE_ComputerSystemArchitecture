	.file	"main.c"
	.intel_syntax noprefix
	.text
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
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 1
	jle	.L2
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L3
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L4
	lea	rdi, .LC3[rip]
	call	perror@PLT
	mov	edi, 0
	call	exit@PLT
.L4:
	lea	rdx, -32[rbp]
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	call	MyFunc@PLT
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rdx
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L2
.L3:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC6[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L5
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, -40[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strtod@PLT
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	call	MyFunc@PLT
	jmp	.L2
.L5:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC7[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L6
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	cvtsi2sd	xmm0, eax
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	addsd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC9[rip]
	subsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	lea	rdi, .LC10[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	call	MyFunc@PLT
	jmp	.L2
.L6:
	lea	rdi, .LC11[rip]
	call	puts@PLT
	mov	eax, 1
	jmp	.L8
.L2:
	mov	eax, 0
.L8:
	leave
	ret
	.size	main, .-main
	.section	.rodata
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
