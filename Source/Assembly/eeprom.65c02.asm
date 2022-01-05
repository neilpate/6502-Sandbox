	.target "6502"

	EEPROM 		.equ $2000

	.org $2000


reset:
	lda EEPROM
	lda EEPROM + 32
	lda EEPROM + 33
	lda EEPROM + 34

    jmp reset

//	.org $fffc
//	.word reset
//	.word $0000
