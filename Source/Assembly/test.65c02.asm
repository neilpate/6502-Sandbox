	.org $0
	.word $0

	.org $8000
	
reset:	
	lda #$55
	sta $0

	lda #$cc
	sta $0

	jmp reset


	.org $fffc
	.word reset
	.word $0000
