	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 2
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	adrp	x9, _count@PAGE
	ldr	w8, [x9, _count@PAGEOFF]
	add	w8, w8, #1
	str	w8, [x9, _count@PAGEOFF]
	mov	w0, #0                          ; =0x0
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_count                          ; @count
.zerofill __DATA,__common,_count,4,2
.subsections_via_symbols
