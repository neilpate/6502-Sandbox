    .org $0
    nop

    .org $2    

somefunc:
    nop
    rts



reset:
    jsr somefunc

	.org $14
	.word reset