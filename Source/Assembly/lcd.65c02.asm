	.target "6502"

	VIA 				.equ $6000
	LCD_DATA			.equ VIA + 0
	LCD_CONTROL			.equ VIA + 1
	LCD_DATA_DIR 		.equ VIA + 2
	LCD_CONTROL_DIR 	.equ VIA + 3
	

	;LCD
	LCD_RS		.equ $80	;PORTA_7	
	LCD_RWB		.equ $40	;PORTA_6
	LCD_E		.equ $20	;PORTA_5

	BUTTON_STATE	.equ	$00

	.org $8000

helloAlexis:	.byte  "Hello Alexis", $0
helloLucas:		.byte  "Hello Lucas", $0	

check_button:
	lda LCD_CONTROL
	and #$01		//Check only the lowest bit
	sta BUTTON_STATE			//Using $00 to store the button state
	rts


lcd_clear_display:
	lda #%00000001		
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

lcd_output_hello:
	ldx #$0		//X will be used to index over the string, reset to the first position

lcd_output_hello_inner:
	lda BUTTON_STATE	//1 when button is released
						//0 when button is pressed
	beq button_pressed
	lda helloAlexis, x	
	jmp continue

button_pressed:				
	lda helloLucas, x 			
	
continue:	
	//the string is terminated with a null character
	//jump out if this is detected (the Z flag will be set)
	beq lcd_output_done	
	sta LCD_DATA
	jsr lcd_pulse_e_data

	inx		//X is being used to track the index into the string

	jmp lcd_output_hello_inner

lcd_output_done: 
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

setup_via:	
	//Port B is the 8 data lines
	lda #$ff	;Want to set DDRB to all output
	sta LCD_DATA_DIR

	//Port A is the 3 control lines 
	lda #$e0	;Want to set top three pins of PORTA as output
	sta LCD_CONTROL_DIR
	rts


reset:	
	jsr setup_via
	jsr lcd_configure_display
	//jsr lcd_function_set
	jsr lcd_clear_display

main_loop:
	jsr check_button
	jsr lcd_clear_display
	jsr lcd_output_hello
	jmp main_loop

	.org $fffc
	.word reset
	.word $0000
