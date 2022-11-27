	.file	"MyFunc.c"
	.intel_syntax noprefix
	.text
	.globl	timespecDiff
	.type	timespecDiff, @function
timespecDiff:
	imul	rdi, rdi, 1000000000				# функция, считающая время
	imul	rdx, rdx, 1000000000				# работы программы	
	add	rdi, rsi
	add	rdx, rcx
	mov	rax, rdi
	sub	rax, rdx
	ret
	.size	timespecDiff, .-timespecDiff
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"correct result: %lf\n"
.LC7:
	.string	"our result: %lf\n"
.LC8:
	.string	"Time of program: %ld nanoseconds\n"
	.text
	.globl	MyFunc
	.type	MyFunc, @function
MyFunc:
	push	r12									# пролог
	sub	rsp, 80									# 	
	movsd	QWORD PTR 8[rsp], xmm0				# [rsp + 8] = x
	movsd	xmm0, QWORD PTR .LC0[rip]			# xmm0 = 1
	subsd	xmm0, QWORD PTR 8[rsp]				# xmm0 = 1 - x
	call	log@PLT								# log(1 - x)
	lea	rsi, .LC2[rip]							# rsi = "correct result: %lf\n"	
	mov	edi, 1									# edi = 1
	mov	al, 1									# al = 1
	movsd	QWORD PTR [rsp], xmm0				# [rsp] = correct
	call	__printf_chk@PLT					# printf("correct result: %lf\n", correct);
	lea	rsi, 48[rsp]							# rsi = &start
	mov	edi, 1									# edi = 1
	call	clock_gettime@PLT					# clock_gettime(CLOCK_MONOTONIC, &start)
	movsd	xmm2, QWORD PTR [rsp]				# 
	movq	xmm4, QWORD PTR .LC3[rip]           # 
	mov	QWORD PTR [rsp], 0x000000000            # 
	mov	rax, QWORD PTR .LC0[rip]                # 
	movapd	xmm0, xmm2                          # 
	andps	xmm0, xmm4                     		# 
	movq	xmm3, rax           				# 
	mulsd	xmm0, QWORD PTR .LC4[rip]     		#       
	movsd	QWORD PTR 24[rsp], xmm0      		#      
.L3:
	movapd	xmm0, xmm2							# 
	subsd	xmm0, QWORD PTR [rsp]				# 		
	andps	xmm0, xmm4							# 
	comisd	xmm0, QWORD PTR 24[rsp]				# 
	jbe	.L7
	movapd	xmm1, xmm3							# 
	subsd	xmm1, QWORD PTR .LC0[rip]			# 
	movsd	xmm0, QWORD PTR .LC5[rip]			# 	
	movsd	QWORD PTR 40[rsp], xmm2				# 
	movsd	QWORD PTR 32[rsp], xmm3				# while (fabs(correct - result) > 0.001 * fabs(correct)) {
	call	pow@PLT								# 	result += pow(-1, n - 1) * pow(-x, n) / n;
	movsd	xmm3, QWORD PTR 32[rsp]				# 	++n;
	movsd	QWORD PTR 16[rsp], xmm0				# }
	movsd	xmm0, QWORD PTR 8[rsp]				# 
	xorps	xmm0, XMMWORD PTR .LC6[rip]			# 
	movapd	xmm1, xmm3							# 
	call	pow@PLT								# 
	mulsd	xmm0, QWORD PTR 16[rsp]				# 
	movsd	xmm3, QWORD PTR 32[rsp]				# 
	movq	xmm4, QWORD PTR .LC3[rip]			# 
	movsd	xmm2, QWORD PTR 40[rsp]				# 
	divsd	xmm0, xmm3							# 
	addsd	xmm3, QWORD PTR .LC0[rip]			# 
	addsd	xmm0, QWORD PTR [rsp]				# 
	movsd	QWORD PTR [rsp], xmm0				# 	
	jmp	.L3
.L7:
	lea	rsi, 64[rsp]							# rsi = &end
	mov	edi, 1									# edi = 1
	call	clock_gettime@PLT					# clock_gettime(CLOCK_MONOTONIC, &end)
	mov	rdx, QWORD PTR 48[rsp]
	mov	rcx, QWORD PTR 56[rsp]
	mov	rdi, QWORD PTR 64[rsp]
	mov	rsi, QWORD PTR 72[rsp]
	call	timespecDiff						# elapsed_ns = timespecDiff(end, start)
	movsd	xmm0, QWORD PTR [rsp]				# xmm0 = result
	mov	edi, 1
	lea	rsi, .LC7[rip]							
	mov	r12, rax
	mov	al, 1
	call	__printf_chk@PLT					# printf("our result: %lf\n", result);
	mov	rdx, r12
	mov	edi, 1
	xor	eax, eax
	lea	rsi, .LC8[rip]
	call	__printf_chk@PLT					# printf("Time of program: %ld nanoseconds\n", elapsed_ns)
	movsd	xmm0, QWORD PTR [rsp]				# xmm0 = result
	add	rsp, 80
	pop	r12										# эпилог
	ret
	.size	MyFunc, .-MyFunc
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC3:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC4:
	.long	3539053052
	.long	1062232653
	.align 8
.LC5:
	.long	0
	.long	-1074790400
	.section	.rodata.cst16
	.align 16
.LC6:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
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
