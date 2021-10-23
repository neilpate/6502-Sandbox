	.org $0
	.word $0

	.org $8000
	
reset:	
	lda #$0		;Store 0 in accumulator
	sta $00		;$00 will hold the current count just for display purposes
	ldx #$00	;X will hold the current count
	ldy #$09	;Y will hold the current count in the loop


loop:
	stx $00		;$00 will hold the X, just for debug
	sty $01		;$01 will hold the Y, just for debug
	inx
	dey			;Zero flag will get set if Y ever reaches zero
	;dey
	cpy #$07
	
	bne loop	;Branch if not equal to zero
				;Essentially loop back if not yet zero

	ldy $50		;Reset the counter in Y
	sty $01		;$01 will hold the Y, just for debug
	
;	jmp loop	;Start again


	;lda $00		;Store the counter in the accumulator
	;sta $01, X	;Store the counter into the A+X register

	;inc $00		;Increment the counter
	
	;inx


	;cmp #$5		;If A gets to 5 we want to loop around


	;ldx $00		;Store the counter in X

	;beq loop


	;jmp loop


	;jmp reset


	.org $fffc
	.word reset
	.word $0000
