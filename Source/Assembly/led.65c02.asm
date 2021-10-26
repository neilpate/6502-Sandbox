	.target "6502"

	

	.org $8000
	
reset:	
	lda #$ff	;Want to set DDRB to all output
	sta $6002	;This is register 2 of the VIA

	lda #$55	;Some nice alternating bit pattern
	sta $6000	;Output register B

	lda #$aa	;Some nice alternating bit pattern
	sta $6000	;Output register B

	jmp reset

	.org $fffc
	.word reset
	.word $0000
