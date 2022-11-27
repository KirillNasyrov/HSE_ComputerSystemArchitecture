	.file	"MyFunc.c"
	.intel_syntax noprefix
	.text
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:
	endbr64
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
	pop	rbp
	ret
	.size	timespecDiff, .-timespecDiff
	.section	.rodata
.LC2:
	.string	"correct result: %lf\n"
.LC7:
	.string	"our result: %lf\n"
	.align 8
.LC8:
	.string	"Time of program: %ld nanoseconds\n"
	.text
	.globl	MyFunc
	.type	MyFunc, @function
MyFunc:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	movsd	QWORD PTR -72[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	subsd	xmm0, QWORD PTR -72[rbp]
	call	log@PLT
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	rax, QWORD PTR -24[rbp]
	movq	xmm0, rax
	lea	rdi, .LC2[rip]
	mov	eax, 1
	call	printf@PLT
	lea	rax, -48[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	jmp	.L4
.L5:
	movsd	xmm0, QWORD PTR -16[rbp]
	movsd	xmm1, QWORD PTR .LC0[rip]
	subsd	xmm0, xmm1
	mov	rax, QWORD PTR .LC3[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movsd	QWORD PTR -80[rbp], xmm0
	movsd	xmm0, QWORD PTR -72[rbp]
	movq	xmm1, QWORD PTR .LC4[rip]
	xorpd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -16[rbp]
	call	pow@PLT
	mulsd	xmm0, QWORD PTR -80[rbp]
	divsd	xmm0, QWORD PTR -16[rbp]
	movsd	xmm1, QWORD PTR -8[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm1, QWORD PTR -16[rbp]
	movsd	xmm0, QWORD PTR .LC0[rip]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
.L4:
	movsd	xmm0, QWORD PTR -24[rbp]
	subsd	xmm0, QWORD PTR -8[rbp]
	movq	xmm1, QWORD PTR .LC5[rip]
	andpd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -24[rbp]
	movq	xmm2, QWORD PTR .LC5[rip]
	andpd	xmm2, xmm1
	movsd	xmm1, QWORD PTR .LC6[rip]
	mulsd	xmm1, xmm2
	comisd	xmm0, xmm1
	ja	.L5
	lea	rax, -64[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdx, QWORD PTR -40[rbp]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, QWORD PTR -56[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	timespecDiff
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rdi, .LC7[rip]
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rsi, rax
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT
	movsd	xmm0, QWORD PTR -8[rbp]
	leave
	ret
	.size	MyFunc, .-MyFunc
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC3:
	.long	0
	.long	-1074790400
	.align 16
.LC4:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 16
.LC5:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC6:
	.long	3539053052
	.long	1062232653
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
