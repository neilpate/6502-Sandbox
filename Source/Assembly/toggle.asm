	.target "6502"

	STATE	.equ	$00

	.org $8000

main_loop:

	lda #$56
	sta STATE
	
loop:	
	
	lda STATE
	cmp #$00
	beq was_zero
	
	//was not zero
	lda #$00
	sta STATE 
	jmp loop

was_zero:
	lda #$55
	sta STATE 
	jmp loop













	.org $fffc
	.word main_loop
	.word $0000
