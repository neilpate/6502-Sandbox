	.org $0
	.word $0

	.org $8000
	
reset:	
	lda #$0		;Store 0 in accumulator
	ldx #$0		;X will hold the current count
	jmp start

first:
	jmp first


start:
	inx
	txa
	sta $00		;Store the current count in $00 just for debug
	
	cmp #5		;Compare accumulator value to 5		
	beq reset	;Zero flag will be set when the count reaches 5
				;Want to stop counting at this point, so branch out of the loop
	
	jmp start

	.org $fffc
	.word reset
	.word $0000
