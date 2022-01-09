.org $e000

reset:	
  sei
  cld

  LDX #$FF
  TXS    
  
  
  
    tsx
    stx $0
   
  //  ldx #$ff
//	txs
    
 //   lda #$55
 //   pha

  //  tsx
  //  stx $0

	.org $fffc
	.word reset
	.word $0000
