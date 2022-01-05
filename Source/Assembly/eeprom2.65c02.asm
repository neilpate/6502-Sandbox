	.target "6502"

	EEPROM 		.equ $E000

	.org $E000


reset:
	lda EEPROM
	lda EEPROM + 32
	lda EEPROM + 33
	lda EEPROM + 34

    jmp reset

	.org $fffc
	.word reset
	.word $0000
