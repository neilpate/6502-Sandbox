	.target "6502"

	VIA 		.equ $6000
	VIA_REGB	.equ VIA + 0
	VIA_REGA	.equ VIA + 1
	VIA_DDRB 	.equ VIA + 2
	VIA_DDRA 	.equ VIA + 3
	

	;LCD
	LCD_RS		.equ $80	;PORTA_7	
	LCD_RWB		.equ $40	;PORTA_6
	LCD_E		.equ $20	;PORTA_5



	.org $8000
	
lcd_e_demo:
	lda #LCD_E
	sta VIA_REGA
	rts

lcd_rs_demo:
	lda #LCD_RS
	sta VIA_REGA
	rts

lcd_rwb_demo:
	lda #LCD_RWB
	sta VIA_REGA
	rts

reset:	
	lda #$ff	;Want to set DDRB to all output
	sta VIA_DDRB

	lda #$e0	;Want to set top three pins of PORTA as output
	 			;The rest should be inputs
	sta VIA_DDRA

flip_flop:

	jsr lcd_rs_demo
	jsr lcd_rwb_demo
	jsr lcd_e_demo
	jmp flip_flop


//	lda #$ff
//	sta VIA_REGA
//	sta VIA_REGB

//	lda #LCD_E
//	sta VIA_REGA

	// lda #LCD_RS
	// sta VIA_REGA

	// lda #$4e	;'N'
	// sta VIA_REGA

	// ;Now pulse the Enable line
	// lda #(LCD_RS | LCD_E)
	// sta VIA_REGB
	
	// lda #LCD_RS
	// sta VIA_REGB


	.org $fffc
	.word reset
	.word $0000
