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
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	cmp	DWORD PTR -36[rbp], 1
	jle	.L2
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L3
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -24[rbp], rax
	cmp	QWORD PTR -16[rbp], 0
	jne	.L4
	lea	rdi, .LC3[rip]
	call	perror@PLT
	mov	edi, 0
	call	exit@PLT
.L4:
	mov	DWORD PTR -4[rbp], 0
	jmp	.L5
.L7:
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx
	cdqe
	lea	rcx, string[rip]
	movzx	edx, BYTE PTR -25[rbp]
	mov	BYTE PTR [rax+rcx], dl
	cmp	DWORD PTR -4[rbp], 10000
	jne	.L5
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, string[rip]
	mov	BYTE PTR [rax+rdx], 0
	jmp	.L6
.L5:
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -25[rbp], al
	cmp	BYTE PTR -25[rbp], -1
	jne	.L7
.L6:
	lea	rdi, string[rip]
	call	MyFunc@PLT
	mov	DWORD PTR -4[rbp], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, string[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	movsx	eax, al
	mov	rdx, QWORD PTR -24[rbp]
	mov	rsi, rdx
	mov	edi, eax
	call	fputc@PLT
	add	DWORD PTR -4[rbp], 1
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, string[rip]
	movzx	eax, BYTE PTR [rax+rdx]
	test	al, al
	jne	.L9
	lea	rdi, .LC4[rip]
	call	puts@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fclose@PLT
	jmp	.L2
.L3:
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L10
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	MyFunc@PLT
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC6[rip]
	mov	eax, 0
	call	printf@PLT
	jmp	.L2
.L10:
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC7[rip]
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L11
	mov	edi, 0
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, -2009080335
	shr	rdx, 32
	add	edx, eax
	mov	ecx, edx
	sar	ecx, 8
	cdq
	sub	ecx, edx
	mov	edx, ecx
	imul	edx, edx, 481
	sub	eax, edx
	mov	edx, eax
	lea	eax, 20[rdx]
	mov	DWORD PTR -8[rbp], eax
	mov	DWORD PTR -4[rbp], 0
	jmp	.L12
.L13:
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, -1401515643
	shr	rdx, 32
	add	edx, eax
	mov	ecx, edx
	sar	ecx, 6
	cdq
	sub	ecx, edx
	mov	edx, ecx
	imul	edx, edx, 95
	sub	eax, edx
	mov	edx, eax
	mov	eax, edx
	add	eax, 32
	mov	ecx, eax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, string[rip]
	mov	BYTE PTR [rax+rdx], cl
	add	DWORD PTR -4[rbp], 1
.L12:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -8[rbp]
	jl	.L13
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, string[rip]
	mov	BYTE PTR [rax+rdx], 0
	lea	rsi, string[rip]
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT
	lea	rdi, string[rip]
	call	MyFunc@PLT
	lea	rsi, string[rip]
	lea	rdi, .LC6[rip]
	mov	eax, 0
	call	printf@PLT
	jmp	.L2
.L11:
	lea	rdi, .LC9[rip]
	call	puts@PLT
	mov	eax, 1
	jmp	.L14
.L2:
	mov	eax, 0
.L14:
	leave
	ret
	.size	main, .-main
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
