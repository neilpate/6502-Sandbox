	.target "6502"

	VIA 		.equ $6000
	VIA_REGB	.equ VIA + 0
	VIA_REGA	.equ VIA + 1
	VIA_DDRB 	.equ VIA + 2
	VIA_DDRA 	.equ VIA + 3
	

	.org $8000
	
reset:	
	lda #$ff	;Want to set DDRB to all output
	sta VIA_DDRB

	lda #$00	;Want to set DDRA to all input
	sta VIA_DDRA
	
	ldx #$00	;X is going to be used as the counter
		

loop:
	inx
	stx $0			;Store it in RAM $00, just for debugging
	
	lda VIA_REGA	;Read Port A

	and #$01		;Mask out all bits other than the lowest which 
					;is where the switch is attached to

	bne skipreset
	ldx #$00		;Reset the counter					

skipreset:
	stx VIA_REGB	;Output the counter to Port B

	jmp loop

	.org $fffc
	.word reset
	.word $0000
