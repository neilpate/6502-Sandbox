.org $e000

reset:	
    lda #$55
    ldx #$00

loop:
    inx 
    sta $00,x
    //sta $01
    //sta $02
    jmp loop


	.org $fffc
	.word reset
	.word $0000
