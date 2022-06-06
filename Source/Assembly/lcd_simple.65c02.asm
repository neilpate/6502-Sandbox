	.target "6502"

	VIA 			.equ $6000
	LCD_DATA		.equ VIA + 0
	LCD_CONTROL		.equ VIA + 1
	LCD_DATA_DIR 	.equ VIA + 2
	LCD_CONTROL_DIR .equ VIA + 3

	;LCD
	LCD_RS		.equ $80	;PORTA_7	
	LCD_RWB		.equ $40	;PORTA_6
	LCD_E		.equ $20	;PORTA_5

	.org $8000

lcd_clear_display:
	//	         1
	lda #%00000001		
	sta LCD_DATA
	jsr lcd_pulse_e
	rts

lcd_return_home:
	//          1X 
	lda #%00000010		
	sta LCD_DATA
	jsr lcd_pulse_e
	rts

lcd_configure_display:
	//        1DCB
	lda #%00001100		//(D)isplay on, (C)ursor on/off, (B)link on/off
	sta LCD_DATA
	jsr lcd_pulse_e
	rts

lcd_function_set:
	//      1DNFXX
	lda #%00111000		//(D)8 bit mode, N 2 line mode, F font
	sta LCD_DATA
	jsr lcd_pulse_e
	rts

lcd_pulse_e:
	//This routines assumes E is low to start
	//Set E high
	lda #LCD_E
	sta LCD_CONTROL

	//Set E low
	lda #$00
	sta LCD_CONTROL
	rts

lcd_pulse_e_data:
	
	//First set RS high
	lda #LCD_RS
	sta LCD_CONTROL

	//Then while keeping RS high pulse the Enable
	lda #(LCD_E | LCD_RS)	
	sta LCD_CONTROL

	//Then bring E low while keeping RS high
	lda #LCD_RS
	sta LCD_CONTROL

	rts

lcd_write_hi:	
	lda #"H"
	sta LCD_DATA
	jsr lcd_pulse_e_data

	lda #"i"
	sta LCD_DATA
	jsr lcd_pulse_e_data

	lda #"!"
	sta LCD_DATA
	jsr lcd_pulse_e_data

	rts

setup_via:	
	//Port B is the 8 data lines
	lda #$ff	;Want to set DDRB to all output
	sta LCD_DATA_DIR

	//Port A is the 3 control lines 
	lda #$e0	;Want to set top three pins of PORTA as output
	sta LCD_CONTROL_DIR
	rts

reset:
	//Set the stack pointer to $ff
	ldx #$ff
	txs	

	sei	//Disable interrupts
	cld	//Turn decimal mode off

	jsr setup_via
	jsr lcd_configure_display
	jsr lcd_clear_display
	jsr lcd_return_home
	jsr lcd_write_hi
	jmp main_loop

main_loop:
	
	jmp *		//Infinite loop

	.org $fffc
	.word reset
	.word $0000
