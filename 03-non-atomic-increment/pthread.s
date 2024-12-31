	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 2
	.globl	_threadFunc                     ; -- Begin function threadFunc
	.p2align	2
_threadFunc:                            ; @threadFunc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	adrp	x9, _count@PAGE
	ldr	w8, [x9, _count@PAGEOFF]
	add	w8, w8, #1
	str	w8, [x9, _count@PAGEOFF]
	mov	x0, #0                          ; =0x0
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #0                          ; =0x0
	stur	w8, [x29, #-28]                 ; 4-byte Folded Spill
	stur	wzr, [x29, #-4]
	sub	x0, x29, #16
	mov	x3, #0                          ; =0x0
	str	x3, [sp, #24]                   ; 8-byte Folded Spill
	mov	x1, x3
	adrp	x2, _threadFunc@PAGE
	add	x2, x2, _threadFunc@PAGEOFF
	str	x2, [sp, #8]                    ; 8-byte Folded Spill
	bl	_pthread_create
	ldr	x2, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x3, [sp, #24]                   ; 8-byte Folded Reload
	sub	x0, x29, #24
	str	x0, [sp, #16]                   ; 8-byte Folded Spill
	mov	x1, x3
	bl	_pthread_create
	ldr	x1, [sp, #24]                   ; 8-byte Folded Reload
	ldur	x0, [x29, #-16]
	bl	_pthread_join
	ldr	x1, [sp, #24]                   ; 8-byte Folded Reload
	ldur	x0, [x29, #-24]
	bl	_pthread_join
	ldr	x2, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x3, [sp, #24]                   ; 8-byte Folded Reload
	ldr	x0, [sp, #16]                   ; 8-byte Folded Reload
	mov	x1, x3
	bl	_pthread_create
	ldr	x1, [sp, #24]                   ; 8-byte Folded Reload
	ldur	x0, [x29, #-16]
	bl	_pthread_join
	adrp	x8, _count@PAGE
	ldr	w9, [x8, _count@PAGEOFF]
                                        ; implicit-def: $x8
	mov	x8, x9
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str@PAGE
	add	x0, x0, l_.str@PAGEOFF
	bl	_printf
	ldur	w0, [x29, #-28]                 ; 4-byte Folded Reload
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count                          ; @count
.zerofill __DATA,__common,_count,4,2
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"count: %d\n"

.subsections_via_symbols
