	.target "6502"

	VIA 				.equ $6000
	LCD_DATA			.equ VIA + 0
	LCD_CONTROL			.equ VIA + 1
	LCD_DATA_DIR 		.equ VIA + 2
	LCD_CONTROL_DIR 	.equ VIA + 3


	STATE	.equ	$00

	.org $8000


check_button:
	lda LCD_CONTROL
	and #$01		//Check only the lowest bit
	
	//If the button was pressed the value at the port is brought down to zero
	//The AND operation will essentially only look at this single pin 
	//The AND operation affects the Z flag, this can be used to branch
	//So the Z flag will be set when the button is pressed

	//BEQ
	//Branch on Z = 1
	beq button_pressed	//If the Z flag is set
	
	jmp check_button				//Button was not pressed

button_pressed:				
	
	lda STATE
	cmp #$00

	//If the value in the accumulator was the same as the CMP operation
	//then the zero flag will be set
	//Essentially the pattern
		// CMP <num>  
		// BEQ <label>
	//will branch to <label> if the accumulator had the value of <num>
	 	  
	beq state_was_zero
	
	//State was not zero at this point
	lda #$00
	sta STATE

	rts

state_was_zero	
	lda #$ff
	sta STATE

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

	lda #$ff
	sta STATE

main_loop:
	jsr check_button
	lda STATE
	sta LCD_DATA
	jmp main_loop

	.org $fffc
	.word reset
	.word $0000
