	.target "6502"

	EEPROM 		.equ $2000

	.org $8000


reset:
	lda EEPROM
	lda EEPROM + 1
	lda EEPROM + 2
	lda EEPROM + 3
	lda EEPROM + 4

    jmp reset

	.org $fffc
	.word reset
	.word $0000
