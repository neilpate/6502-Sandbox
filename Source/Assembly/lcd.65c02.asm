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

helloAlexis:	.byte  "Hello Alexis", $0
helloLucas:		.byte  "Hello Lucas", $0	

check_button:
	lda VIA_REGA
	sta $0
	rts


lcd_set_display_on:
	//        1DCB
	lda #%00001111		//(D)isplay on, (C)ursor off, (B)link off
	
	sta VIA_REGB
	jsr lcd_pulse_e
	rts

lcd_clear_display:
	lda #%00000001		
	sta VIA_REGB
	jsr lcd_pulse_e
	rts

lcd_output_hello:
	ldx #$0

lcd_output_hello_inner:
	lda helloLucas, x 			

	//the string is terminated with a null character
	//jump out if this is detected (the Z flag will be set)
	beq lcd_output_done	
	sta VIA_REGB
	jsr lcd_pulse_e_data

	inx		//X is being used to track the index into the string

	jmp lcd_output_hello_inner

lcd_output_done: 
	rts



lcd_pulse_e:
	lda #LCD_E
	sta VIA_REGA

	lda #LCD_E	
	sta VIA_REGA

	lda #$00
	sta VIA_REGA
	rts

lcd_pulse_e_data:
	lda #LCD_RS
	sta VIA_REGA

	lda #(LCD_E || LCD_RS)	
	
	lda #$a0
	sta VIA_REGA

	lda #LCD_RS
	sta VIA_REGA
	rts

reset:	
	lda #$ff	;Want to set DDRB to all output
	sta VIA_DDRB

	lda #$e0	;Want to set top three pins of PORTA as output
	 			;The rest should be inputs
	sta VIA_DDRA

	jsr lcd_set_display_on
	jsr lcd_clear_display

main_loop:
	jsr check_button
	jsr lcd_output_hello
	jmp main_loop

	.org $fffc
	.word reset
	.word $0000
