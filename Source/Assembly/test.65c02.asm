	.target "6502"

	.org $0
	.word $0

	.org $7000
	
reset:	
	ldx #$0		;X will hold the current count, this number will just go up
	ldy #$0		;Y will hold the current segment count, want this to reset

loop:
	inx
	stx $0		;Just for debug

	iny
	sty $1		;just for debug

	tya
	cmp #5		;Compare accumulator value to 5		
	beq resety	;Zero flag will be set when the count reaches 5
	jmp loop

resety:
	ldy #$0
	jmp loop

	.org $7ffc
	.word reset
	.word $0000
