; Super Mario Bros. 3 Full Disassembly by Southbird 2012
; For more info, see http://www.sonicepoch.com/sm3mix/
;
; PLEASE INCLUDE A CREDIT TO THE SOUTHBIRD DISASSEMBLY
; AND THE ABOVE LINK SOMEWHERE IN YOUR WORKS :)
;
; Original disassembler source generated by DCC6502 version v1.4
; (With labels, comments, and some syntax corrections for nesasm by Southbird)
; For more info about DCC6502, e-mail veilleux@ameth.org
;
; This source file last updated: 2012-01-04 18:58:32.468868255 -0600
; Distribution package date: Fri Apr  6 23:46:16 UTC 2012
;---------------------------------------------------------------------------
Tile_Layout_TS14:
	; This defines the individual 8x8 blocks used to construct one of the tiles
	; Referenced by Address_Per_Tileset, addressed by Level_Tileset
	; Stored by upper left, then lower left, then upper right, then lower right

	; Remember that palette is determined by the upper 2 bits of a TILE (not the PATTERN)
	; I.e. tiles starting at index $00, $40, $80, $C0 are each on that respective palette

	; Upper left 8x8 pattern per tile
	.byte $FC, $4E, $FE, $05, $05, $E8, $FF, $58, $FF, $FF, $5D, $5F, $FE, $FF, $FF, $FF ; Tiles $00 - $0F
	.byte $FF, $FF, $FF, $48, $4A, $26, $FC, $FC, $FC, $FC, $FC, $42, $FC, $33, $32, $05 ; Tiles $10 - $1F
	.byte $58, $05, $05, $5D, $5F, $FE, $4E, $42, $FE, $48, $4A, $FE, $39, $FF, $B8, $B8 ; Tiles $20 - $2F
	.byte $B8, $B8, $BC, $44, $34, $4E, $4C, $4C, $FD, $FD, $FE, $FF, $FF, $FF, $FF, $FF ; Tiles $30 - $3F
	.byte $DC, $05, $FE, $FE, $05, $05, $05, $05, $60, $D5, $B2, $FF, $FF, $FF, $FF, $FF ; Tiles $40 - $4F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $D0, $FF, $D8 ; Tiles $50 - $5F
	.byte $98, $98, $98, $98, $98, $98, $92, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4 ; Tiles $60 - $6F
	.byte $B4, $B8, $C0, $C0, $C0, $C0, $A4, $EC, $E4, $C0, $D5, $B2, $FF, $D0, $A0, $FF ; Tiles $70 - $7F
	.byte $05, $50, $54, $54, $50, $C4, $05, $7E, $7E, $04, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $80 - $8F
	.byte $68, $6A, $78, $7A, $6E, $FE, $6E, $FE, $F4, $05, $0E, $02, $05, $18, $1A, $05 ; Tiles $90 - $9F
	.byte $04, $77, $1C, $77, $77, $1E, $77, $10, $12, $0E, $77, $77, $12, $8C, $8E, $8C ; Tiles $A0 - $AF
	.byte $8E, $8C, $8E, $8C, $8E, $75, $75, $67, $4D, $65, $39, $AE, $B8, $8C, $8E, $77 ; Tiles $B0 - $BF
	.byte $76, $05, $3C, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $C0 - $CF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $B3, $CC, $FC, $C5, $C7, $D4, $FE, $FC ; Tiles $D0 - $DF
	.byte $AA, $AB, $FE, $2C, $20, $FE, $28, $2A, $FE, $30, $77, $24, $77, $77, $26, $3B ; Tiles $E0 - $EF
	.byte $60, $D7, $E0, $FF, $77, $72, $38, $2C, $77, $77, $38, $77, $FE, $FF, $F4, $FF ; Tiles $F0 - $FF

	; Lower left 8x8 pattern per tile
	.byte $FC, $4F, $FE, $06, $D6, $E9, $FF, $FD, $5B, $FF, $FF, $FF, $46, $FF, $FF, $FF ; Tiles $00 - $0F
	.byte $FF, $FF, $FF, $24, $FC, $26, $FC, $FC, $33, $45, $FC, $42, $FC, $FC, $FC, $06 ; Tiles $10 - $1F
	.byte $FD, $5B, $06, $06, $06, $40, $4C, $4C, $48, $4C, $4C, $4A, $4C, $FF, $B9, $B9 ; Tiles $20 - $2F
	.byte $B9, $B9, $BD, $34, $34, $4C, $4C, $4C, $FD, $4C, $FE, $FF, $FF, $FF, $FF, $FF ; Tiles $30 - $3F
	.byte $DD, $06, $FE, $FE, $06, $06, $06, $06, $61, $B2, $B2, $FF, $FF, $FF, $FF, $FF ; Tiles $40 - $4F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $D1, $FF, $D9 ; Tiles $50 - $5F
	.byte $99, $99, $99, $99, $99, $99, $93, $B5, $B5, $B5, $B5, $B5, $B5, $B5, $B5, $B5 ; Tiles $60 - $6F
	.byte $B5, $B9, $C1, $C1, $C1, $C1, $A5, $ED, $E4, $C1, $B2, $B2, $FF, $D1, $A1, $FF ; Tiles $70 - $7F
	.byte $06, $51, $55, $55, $51, $C4, $06, $FE, $FE, $76, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $80 - $8F
	.byte $6C, $FE, $7C, $FE, $6E, $FE, $6E, $FE, $F5, $00, $77, $77, $18, $77, $77, $1A ; Tiles $90 - $9F
	.byte $06, $0A, $06, $1C, $1E, $06, $0C, $13, $13, $77, $77, $77, $16, $35, $9E, $35 ; Tiles $A0 - $AF
	.byte $9E, $35, $9E, $35, $9E, $76, $76, $74, $64, $66, $39, $AE, $B9, $35, $9E, $0C ; Tiles $B0 - $BF
	.byte $76, $06, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $C0 - $CF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E6, $CD, $CD, $CD, $FE, $FE, $FE, $FE, $FE ; Tiles $D0 - $DF
	.byte $AB, $AB, $22, $77, $77, $28, $77, $77, $2A, $FE, $32, $FE, $24, $26, $FE, $77 ; Tiles $E0 - $EF
	.byte $61, $FF, $E1, $FF, $2E, $3A, $3A, $77, $77, $77, $7E, $2E, $FE, $FF, $F5, $FF ; Tiles $F0 - $FF

	; Upper right 8x8 pattern per tile	
	.byte $FC, $FC, $FE, $07, $07, $EA, $FF, $59, $FF, $5C, $5E, $FF, $FE, $FF, $FF, $FF ; Tiles $00 - $0F
	.byte $FF, $FF, $FF, $49, $4B, $FC, $27, $FC, $FC, $FC, $42, $FC, $40, $33, $FC, $07 ; Tiles $10 - $1F
	.byte $59, $07, $5C, $5E, $07, $40, $4F, $FE, $FE, $49, $4B, $FE, $39, $FF, $BA, $BA ; Tiles $20 - $2F
	.byte $BA, $BA, $BE, $4F, $4C, $45, $36, $4C, $FD, $4C, $FE, $FF, $FF, $FF, $FF, $FF ; Tiles $30 - $3F
	.byte $DE, $07, $FE, $FE, $07, $07, $07, $07, $62, $D5, $B2, $FF, $FF, $FF, $FF, $FF ; Tiles $40 - $4F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $D2, $FF, $DA ; Tiles $50 - $5F
	.byte $9A, $9A, $9A, $9A, $9A, $9A, $CA, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6 ; Tiles $60 - $6F
	.byte $B6, $BA, $C2, $C2, $C2, $C2, $A6, $EE, $E5, $C2, $D5, $B2, $FF, $D2, $A2, $FF ; Tiles $70 - $7F
	.byte $07, $52, $52, $56, $56, $C6, $07, $7F, $3E, $7E, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $80 - $8F
	.byte $69, $6B, $79, $7B, $FE, $6F, $FE, $6F, $F6, $01, $0F, $07, $07, $19, $1B, $07 ; Tiles $90 - $9F
	.byte $77, $0B, $1D, $77, $77, $1F, $77, $0F, $77, $11, $14, $77, $77, $8D, $8F, $8D ; Tiles $A0 - $AF
	.byte $8F, $8D, $8F, $8D, $8F, $41, $41, $3E, $4D, $65, $AD, $3B, $BA, $8D, $8F, $14 ; Tiles $B0 - $BF
	.byte $76, $07, $3C, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $C0 - $CF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $B3, $CE, $FC, $C5, $C7, $D4, $FE, $FC ; Tiles $D0 - $DF
	.byte $AA, $AB, $23, $2D, $FE, $FE, $29, $2B, $FE, $77, $33, $25, $77, $77, $27, $3B ; Tiles $E0 - $EF
	.byte $62, $D7, $E2, $FF, $77, $2D, $77, $73, $70, $77, $77, $70, $FE, $FF, $F6, $FF ; Tiles $F0 - $FF

	; Lower right 8x8 pattern per tile
	.byte $FC, $FC, $FE, $08, $D6, $EB, $5A, $FF, $FF, $FF, $FF, $FF, $47, $FF, $FF, $FF ; Tiles $00 - $0F
	.byte $FF, $FF, $FF, $FC, $25, $FC, $27, $44, $33, $FC, $42, $FC, $FC, $FC, $FC, $5A ; Tiles $10 - $1F
	.byte $FD, $08, $08, $08, $08, $4C, $4C, $42, $49, $4C, $4C, $4B, $4C, $FF, $BB, $BB ; Tiles $20 - $2F
	.byte $BB, $BB, $BF, $4C, $4C, $36, $36, $4C, $FD, $FE, $FE, $FF, $FF, $FF, $FF, $FF ; Tiles $30 - $3F
	.byte $DF, $08, $FE, $FE, $08, $08, $08, $08, $63, $B2, $B2, $FF, $FF, $FF, $FF, $FF ; Tiles $40 - $4F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $D3, $FF, $DB ; Tiles $50 - $5F
	.byte $9B, $9B, $9B, $9B, $9B, $9B, $CB, $B7, $B7, $B7, $B7, $B7, $B7, $B7, $B7, $B7 ; Tiles $60 - $6F
	.byte $B7, $BB, $C3, $C3, $C3, $C3, $A7, $EF, $E5, $C3, $B2, $B2, $FF, $D3, $A3, $FF ; Tiles $70 - $7F
	.byte $08, $53, $53, $57, $57, $C6, $08, $FE, $3F, $FE, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $80 - $8F
	.byte $FE, $6D, $FE, $7D, $FE, $6F, $FE, $6F, $F7, $77, $77, $03, $19, $77, $77, $1B ; Tiles $90 - $9F
	.byte $09, $08, $08, $1D, $1F, $08, $0D, $77, $77, $15, $15, $77, $0D, $9D, $37, $9D ; Tiles $A0 - $AF
	.byte $37, $9D, $37, $9D, $37, $43, $43, $3F, $64, $66, $AD, $3B, $BB, $9D, $37, $17 ; Tiles $B0 - $BF
	.byte $76, $08, $FE, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $C0 - $CF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E7, $CF, $CF, $CF, $FE, $FE, $FE, $FE, $FE ; Tiles $D0 - $DF
	.byte $AB, $AB, $77, $77, $21, $29, $77, $77, $2B, $31, $FE, $FE, $25, $27, $FE, $77 ; Tiles $E0 - $EF
	.byte $63, $FF, $E3, $FF, $2F, $77, $77, $71, $71, $77, $2F, $7F, $FE, $FF, $F7, $FF ; Tiles $F0 - $FF

Tile_Attributes_TS14:
	.byte $25, $5F, $99, $E2, $2E, $5F, $A6, $F0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LevelLoad_TS14
;
; Entry point for loading level layout data for Level_Tileset = 14
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LevelLoad_TS14:

	; Clear to sky
	LDY #$00
PRG013_A40A:
	LDA #TILE14_SKY
	JSR Tile_Mem_ClearB
	JSR Tile_Mem_ClearA
	CPY #$10
	BNE PRG013_A40A

PRG013_A416:
	LDA #TILE14_SKY
	JSR Tile_Mem_ClearB
	JSR Tile_Mem_ClearA
	CPY #$f0
	BNE PRG013_A416

	JMP LevelLoad	; Begin actual level loading!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LoadLevel_Generator_TS14
;
; Based on the values in Temp_Var15 and LL_ShapeDef, chooses an
; appropriate generator function to builds this piece of the
; level.  Tedious, but saves space and is paper-design friendly.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PRG013_A419:
	.byte 0, 15, 30, 45, 60, 75, 90, 105

LoadLevel_Generator_TS14:
	; From level loader function:
	; * Temp_Var15, Temp_Var16, and LL_ShapeDef are three bytes read from the data


	LDA <Temp_Var15
	AND #%11100000
	LSR A		
	LSR A		
	LSR A		
	LSR A		
	LSR A		
	TAX		 	; X = upper 3 bits of Temp_Var15 (0-7) (selects a multiple of 15 as the base)

	LDA LL_ShapeDef
	LSR A	
	LSR A	
	LSR A	
	LSR A			; A = upper 4 bits of LL_ShapeDef shifted down
	ADD PRG013_A419,X	; Add multiple of 15
	TAX
	DEX
	TXA		 ; A = ((LL_ShapeDef >> 4) + PRG013_A419[X]) - 1


	; PRG023_A419 provides values well in excess of ??, but only ??
	; addresses are defined here; reserved for expansion...

	JSR PRG13_DynJump_LLGen

	; THESE MUST FOLLOW DynJump FOR THE DYNAMIC JUMP TO WORK!!
	.word LoadLevel_Slope45T2B		;  0 - Above ground (UG only) 45 degree slope top-to-bottom
	.word LoadLevel_Slope45B2T		;  1 - Above ground (UG only) 45 degree slope bottom-to-top
	.word LoadLevel_Slope45T2BCeiling	;  2 - Above ground (UG only) 45 degree ceiling slope top-to-bottom
	.word LoadLevel_Slope45B2TCeiling	;  3 - Above ground (UG only) 45 degree ceiling slope bottom-to-top
	.word LoadLevel_Slope45T2B		;  4 - Underground/Hills normal 45 degree slope top-to-bottom
	.word LoadLevel_Slope45B2T		;  5 - Underground/Hills normal 45 degree slope bottom-to-top
	.word LoadLevel_Slope45T2BCeiling	;  6 - Underground/Hills normal 45 degree ceiling slope top-to-bottom
	.word LoadLevel_Slope45B2TCeiling	;  7 - Underground/Hills normal 45 degree ceiling slope bottom-to-top
	.word LoadLevel_Slope45T2B		;  8 - Underwater 45 degree slope top-to-bottom
	.word LoadLevel_Slope45B2T		;  9 - Underwater 45 degree slope bottom-to-top
	.word LoadLevel_Slope45T2BCeiling	; 10 - Underwater 45 degree ceiling slope top-to-bottom
	.word LoadLevel_Slope45B2TCeiling	; 11 - Underwater 45 degree ceiling slope bottom-to-top
	.word LoadLevel_VertGroundL		; 12 - Above ground (UG only) Left vertical edge tiles
	.word LoadLevel_VertGroundL		; 13 - Underground/Hills normal Left vertical edge tiles
	.word LoadLevel_VertGroundL		; 14 - Underwater Left vertical edge tiles
	.word LoadLevel_BlockRun		; 15 - Run of bricks
	.word LoadLevel_BlockRun		; 16 - Run of '?' blocks with a coin
	.word LoadLevel_BlockRun		; 17 - Run of bricks with a coin
	.word LoadLevel_BlockRun		; 18 - Run of wood blocks
	.word LoadLevel_BlockRun		; 19 - Run of green note blocks (?)
	.word LoadLevel_BlockRun		; 20 - Run of note blocks
	.word LoadLevel_BlockRun		; 21 - Run of bouncing wood blocks
	.word LoadLevel_BlockRun		; 22 - Run of coins
	.word LoadLevel_VGroundPipeRun		; 23 - Vertical ground pipe 1 (alt level)
	.word LoadLevel_VGroundPipeRun		; 24 - Vertical ground pipe 2 (Big [?] area)
	.word LoadLevel_VGroundPipeRun		; 25 - Vertical ground pipe 3 (no entrance)
	.word LoadLevel_VCeilingPipeRun		; 26 - Vertical ceiling pipe 1 (alt level)
	.word LoadLevel_VCeilingPipeRun		; 27 - Vertical ceiling pipe 2 (no entrance)
	.word LoadLevel_HRightWallPipeRun	; 28 - Horizontal right-hand wall pipe (bonus)
	.word LoadLevel_HRightWallPipeRun	; 29 - Horizontal right-hand wall pipe (no entrance)
	.word LoadLevel_HLeftWallPipeRun	; 30 - Horizontal left-hand wall pipe (bonus)
	.word LoadLevel_HLeftWallPipeRun	; 31 - Horizontal left-hand wall pipe (no entrance)
	.word LoadLevel_Cannon			; 32 - Bullet bill cannon
	.word LoadLevel_CCBridge		; 33 - Cheep-Cheep style 'oo' bridge
	.word LoadLevel_CCBridge		; 34 - Would result in empty tiles?  (form of 33)
	.word LoadLevel_TopDecoBlocks		; 35 - Top-Deco Rectangle Waterfall
	.word LoadLevel_TopDecoBlocks		; 36 - Top-Deco Rectangle Left waving water pool
	.word LoadLevel_TopDecoBlocks		; 37 - Top-Deco Rectangle No current waving water pool
	.word LoadLevel_TopDecoBlocks		; 38 - Top-Deco Rectangle Right waving water pool
	.word LoadLevel_TopDecoBlocks		; 39 - Top-Deco Rectangle Water wrong-way BG
	.word LoadLevel_TopDecoBlocks		; 40 - Top-Deco Rectangle Diamond blocks (not really any deco on top)
	.word LoadLevel_TopDecoBlocks		; 41 - Top-Deco Rectangle Sand ground 
	.word LoadLevel_TopDecoBlocks		; 42 - Top-Deco Rectangle orange block??
	.word LoadLevel_IceBricks		; 43 - Run of ice bricks
	.word LoadLevel_VTransitPipeRun		; 44 - Vertical in-level transit pipe
	.word LoadLevel_Slope225T2B		; 45 - Above ground (UG only) 22.5 degree slope top-to-bottom
	.word LoadLevel_Slope225B2T		; 46 - Above ground (UG only) 22.5 degree slope bottom-to-top
	.word LoadLevel_Slope225T2BCeiling	; 47 - Above ground (UG only) 22.5 degree ceiling slope top-to-bottom
	.word LoadLevel_Slope225B2TCeiling	; 47 - Above ground (UG only) 22.5 degree ceiling slope bottom-to-top
	.word LoadLevel_Slope225T2B		; 49 - Underground/Hills normal 22.5 degree slope top-to-bottom
	.word LoadLevel_Slope225B2T		; 50 - Underground/Hills normal 22.5 degree slope bottom-to-top
	.word LoadLevel_Slope225T2BCeiling	; 51 - Underground/Hills normal 22.5 degree ceiling slope top-to-bottom
	.word LoadLevel_Slope225B2TCeiling	; 52 - Underground/Hills normal 22.5 degree ceiling slope bottom-to-top
	.word LoadLevel_Slope225T2B		; 53 - Underwater 22.5 degree slope top-to-bottom
	.word LoadLevel_Slope225B2T		; 54 - Underwater 22.5 degree slope bottom-to-top
	.word LoadLevel_Slope225T2BCeiling	; 55 - Underwater 22.5 degree ceiling slope top-to-bottom
	.word LoadLevel_Slope225B2TCeiling	; 56 - Underwater 22.5 degree ceiling slope bottom-to-top
	.word LoadLevel_VertGroundR		; 57 - Above ground (UG only) right vertical edge tiles
	.word LoadLevel_VertGroundR		; 58 - Underground/Hills normal right vertical edge tiles
	.word LoadLevel_VertGroundR		; 59 - Underwater right vertical edge tiles
	.word LoadLevel_BGOrWater		; 60 - Above ground rectangle of sky
	.word LoadLevel_BGOrWater		; 61 - Underground rectangle of speckle
	.word LoadLevel_BGOrWater		; 62 - Underwater top or water fill
	.word LoadLevel_DecoGround		; 63 - Rectangle of Above Ground (UG only) middle ground fill
	.word LoadLevel_DecoGround		; 64 - Rectangle of Underground/Hills normal (UG only) middle ground fill
	.word LoadLevel_DecoGround		; 65 - Rectangle of Underwater middle ground fill
	.word LoadLevel_DecoGround		; 66 - Rectangle of Above Ground (UG only) horizontal ground topped middle ground fill
	.word LoadLevel_DecoGround		; 67 - Rectangle of Underground/Hills normal (UG only) horizontal ground topped middle ground fill
	.word LoadLevel_DecoGround		; 68 - Rectangle of Underwater horizontal ground topped middle ground fill
	.word LoadLevel_DecoCeiling		; 69 - Rectangle of Above Ground (UG only) ceiling fill
	.word LoadLevel_DecoCeiling		; 70 - Rectangle of Underground/Hills normal ceiling fill
	.word LoadLevel_DecoCeiling		; 71 - Rectangle of Underwater ceiling fill
	.word LoadLevel_BGBush			; 72 - Run of little background bushes
	.word LoadLevel_VGroundPipe5Run		; 73 - Vertical ground pipe 5 (exits to common end area)
	.word LoadLevel_CloudRun3		; 74 - Run of the clouds (alt tiles)
	.word LoadLevel_Tunnel			; 75 - Add a run of "tunnel" tiles
	.word LoadLevel_Tunnel			; 76 - DOES NOTHING, see LoadLevel_Tunnel
	.word LoadLevel_CloudRun		; 77 - Run of the clouds



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LeveLoad_FixedSizeGen_TS14
;
; Much simpler generators that are fixed-size, commonly used for 
; just single tile placement styles (although a couple relatively 
; complex ones exist in here as well)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LeveLoad_FixedSizeGen_TS14:
	; It is verified before calling this function that all of
	; the upper 4 bits of LL_ShapeDef are ZERO

	; So the upper 3 bits of Temp_Var15 serve as the most significant bits
	; to a value where LL_ShapeDef provide the 4 least significant bits

	LDA <Temp_Var15
	AND #%11100000
	LSR A		
	ADD LL_ShapeDef	
	TAX		 	; Resultant index is put into 'X'
	JSR DynJump	 

	; THESE MUST FOLLOW DynJump FOR THE DYNAMIC JUMP TO WORK!!
	.word LoadLevel_Corner			;  0 - Above Ground upper-left corner tile
	.word LoadLevel_Corner			;  1 - Underground/Hills normal upper-left corner tile
	.word LoadLevel_Corner			;  2 - Underwater upper-left corner tile
	.word LoadLevel_Corner			;  3 - Above Ground upper-right corner tile
	.word LoadLevel_Corner			;  4 - Underground/Hills normal upper-right corner tile
	.word LoadLevel_Corner			;  5 - Underwater upper-right corner tile
	.word LoadLevel_Corner			;  6 - Above Ground lower-left corner tile
	.word LoadLevel_Corner			;  7 - Underground/Hills normal lower-left corner tile
	.word LoadLevel_Corner			;  8 - Underwater lower-left corner tile
	.word LoadLevel_Corner			;  9 - Above Ground lower-right corner tile
	.word LoadLevel_Corner			; 10 - Underground/Hills normal lower-right corner tile
	.word LoadLevel_Corner			; 11 - Underwater lower-right corner tile
	.word LoadLevel_Nothing			; 12 - NOTHING!  (Old removed? unknown?)
	.word LoadLevel_Nothing			; 13 - NOTHING!  (Old removed? unknown?)
	.word LoadLevel_Nothing			; 14 - NOTHING!  (Old removed? unknown?)
	.word LoadLevel_Door2			; 15 - Door style 2
	.word LoadLevel_PowerBlock		; 16 - ? block with flower
	.word LoadLevel_PowerBlock		; 17 - ? block with leaf 
	.word LoadLevel_PowerBlock		; 18 - ? block with star
	.word LoadLevel_PowerBlock		; 19 - ? block with coin OR star
	.word LoadLevel_PowerBlock		; 20 - ? block with coin (??)
	.word LoadLevel_PowerBlock		; 21 - Muncher Plant!
	.word LoadLevel_PowerBlock		; 22 - Brick with flower
	.word LoadLevel_PowerBlock		; 23 - Brick with leaf
	.word LoadLevel_PowerBlock		; 24 - Brick with star
	.word LoadLevel_PowerBlock		; 25 - Brick with coin OR star
	.word LoadLevel_PowerBlock		; 26 - Brick with 10-coin
	.word LoadLevel_PowerBlock		; 27 - Brick with 1-up
	.word LoadLevel_PowerBlock		; 28 - Brick with vine
	.word LoadLevel_PowerBlock		; 29 - Brick with P-Switch
	.word LoadLevel_PowerBlock		; 30 - Invisible coin
	.word LoadLevel_PowerBlock		; 31 - Invisible 1-up
	.word LoadLevel_PowerBlock		; 32 - Invisible note
	.word LoadLevel_PowerBlock		; 33 - Note block with flower
	.word LoadLevel_PowerBlock		; 34 - Note block with leaf
	.word LoadLevel_PowerBlock		; 35 - Note block with star
	.word LoadLevel_PowerBlock		; 36 - Wood block with flower
	.word LoadLevel_PowerBlock		; 37 - Wood block with leaf
	.word LoadLevel_PowerBlock		; 38 - Wood block with star
	.word LoadLevel_PowerBlock		; 39 - Invisible note to coin heaven
	.word LoadLevel_PowerBlock		; 40 - P-Switch
	.word LoadLevel_EndGoal			; 41 - The end goal
	.word LoadLevel_MidSizeBush		; 42 - Place a mid-sized large green bush
	.word LoadLevel_SmallSizeBush		; 43 - Place a small sized large green bush
	.word LoadLevel_BigSizeBush		; 44 - Place a big sized large green bush
	.word LoadLevel_FillBackground		; 45 - Sky fill
	.word LoadLevel_FillBackground		; 46 - Underground speckle fill
	.word LoadLevel_FillBackground		; 47 - Unknown?? fill
	.word LoadLevel_PrefabBlock		; 48 - 8x7 prefab block (Entry 0)
	.word LoadLevel_PrefabBlock		; 49 - 8x7 prefab block (Entry 1)
	.word LoadLevel_PrefabBlock		; 50 - 8x7 prefab block (Entry 2)
	.word LoadLevel_PrefabBlock		; 51 - 8x7 prefab block (Entry 3)
	.word LoadLevel_PrefabBlock		; 52 - 8x7 prefab block (Entry 4)
	.word LoadLevel_PrefabBlock		; 53 - 8x7 prefab block (Entry 5)
	.word LoadLevel_PrefabBlock		; 54 - 8x7 prefab block (Entry 6)
	.word LoadLevel_PrefabBlock		; 55 - 8x7 prefab block (Entry 7) 
	.word LoadLevel_PrefabBlock		; 56 - 8x7 prefab block (Entry 8)
	.word LoadLevel_PrefabBlock		; 57 - 8x7 prefab block (Entry 9)
	.word LoadLevel_PrefabBlock		; 58 - 8x7 prefab block (Entry 10)
	.word LoadLevel_PrefabBlock		; 59 - 8x7 prefab block (Entry 11)
	.word LoadLevel_PrefabBlock		; 60 - 8x7 prefab block (Entry 12)
	.word LoadLevel_PrefabBlock		; 61 - 8x7 prefab block (Entry 13)
	.word LoadLevel_PrefabBlock		; 62 - 8x7 prefab block (Entry 14)
	.word LoadLevel_PrefabBlock		; 63 - 8x7 prefab block (Entry 15)
	.word LoadLevel_MiscBG			; 64 - Add a little background cloud
	.word LoadLevel_MiscBG			; 65 - Add a little background Unknown???
	.word LoadLevel_MiscBG 			; 66 - Add a little background Unknown???

	; Broken into another file for ease of integration in NoDice editor
	.include "PRG/levels/Under.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;; BEGIN UNUSED PLAINS COPY DATA ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; The following are copied fragments from PRG015 ... THEY DO NOT BELONG HERE
; They won't load correctly (if at all) under this bank anyway...
; My guess... massive copy/paste error? :D

	; This is (errorenously) the tail end of 1-1
;	.byte $80, $28, $6E, $80, $29, $6A, $80, $11, $67, $E4, $37, $64
;	.byte $40, $37, $68, $40, $38, $63, $41, $38, $68, $41, $39, $62, $42, $39, $68, $42
;	.byte $19, $6C, $92, $26, $71, $80, $28, $73, $80, $17, $76, $01, $38, $70, $A1, $37
;	.byte $74, $A2, $37, $7C, $12, $37, $7F, $0D, $38, $7B, $14, $39, $7A, $15, $27, $8D
;	.byte $9B, $33, $8D, $41, $37, $8D, $A2, $37, $8D, $41, $11, $88, $32, $17, $86, $22
;	.byte $39, $80, $10, $38, $83, $10, $39, $83, $11, $E8, $42, $80, $1A, $8B, $A2, $12
;	.byte $91, $E2, $38, $91, $A1, $12, $94, $02, $40, $9B, $09, $FF

	; These are duplicated from the 'Plains' bank (PRG015) and don't belong here!
	; Don't try to use these, and make sure you delete them...
;	.include "PRG/levels/Plains/1-1Bonus"	; 1-1 Bonus room
;	.include "PRG/levels/Plains/7-5"		; 7-5
;	.include "PRG/levels/Plains/3-8End"		; 3-8 Exit
;	.include "PRG/levels/Plains/5-3End"		; 5-3 Exit
;	.include "PRG/levels/Plains/Unused2E"	; "Unused level 2" exit
;	.include "PRG/levels/Plains/Generic4"	; Generic Exit for World 4 only
;	.include "PRG/levels/Plains/W3HBD"		; World 3 Hammer Bro battle area (out of water)
;	.include "PRG/levels/Plains/W3HBC"		; World 3 Hammer Bro battle area (in water, with powerup)
;	.include "PRG/levels/Plains/WxHBx"		; ?? Unknown Hammer Bro battle area
;	.include "PRG/levels/Plains/1-4End"		; 1-4 Exit pipe
;	.include "PRG/levels/Plains/3-3"		; 3-3
;	.include "PRG/levels/Plains/3-3End"		; 3-3 Exit

Custom_Tiles13:
	.byte TILE14_BOOTSPIKE, TILE14_ON, TILE14_OFF_INACTIVE

PRG13_DynJump_LLGen:
	CMP #78
	BCC _j_DynJump13

	; If we're generating our custom object, we need to JSR to DynJump with our new index
	SUB #78
	STA <Temp_Var1	; save A
	PLA	; eat our current return address
	PLA	; eat our current return address
	LDA <Temp_Var1	; restore A
	;;JMP LoadLevel_Custom13 ; just fall into LoadLevel_Custom13

LoadLevel_Custom13:
	LDA LL_ShapeDef
	AND #$0f
	STA <Temp_Var4		 ; Temp_Var4 = lower 4 bits of LL_ShapeDef (width of run)
	LDY TileAddr_Off	 ; Y = TileAddr_Off

	TXA
	SUB #78
	TAX
_bs_run_loop13:
	LDA Custom_Tiles13,X	 ; One of our custom tiles
	STA [Map_Tile_AddrL],Y	 ; Store into tile mem
	JSR LoadLevel_NextColumn ; Next column
	DEC <Temp_Var4		 ; Temp_Var4--
	BPL _bs_run_loop13	 ; While Temp_Var4 >= 0, loop!
	RTS			 ; Return...

_j_DynJump13:
	JMP DynJump


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The following has nothing to do with this bank, but this bank had a tonnnn of freespace
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PauseMenu_Sprites:
	.byte $48, $C1, $03, $78	; c
	.byte $48, $C3, $03, $80	; o +4
	.byte $48, $C5, $03, $88	; n +8
	.byte $48, $C7, $03, $90	; t +c
	.byte $48, $C9, $03, $98	; . +10
	.byte $58, $CB, $03, $78	; m +14
	.byte $58, $CD, $03, $80	; a +18
	.byte $58, $CF, $03, $88	; p +1c
	.byte $68, $D1, $03, $78	; r +20
	.byte $68, $D3, $03, $80	; e +24
	.byte $68, $D5, $03, $88	; s +28
	.byte $68, $C7, $03, $90	; t +2c
	.byte $68, $CD, $03, $98	; a +30
	.byte $68, $D1, $03, $A0	; r +34
	.byte $68, $C7, $03, $A8	; t +38
PauseMenu_CursorSprite:
	.byte $48, $D7, $01, $6F	; > +3c
PauseMenu_Sprites_End

PauseMenu_CursorY:
	.byte $48, $58, $68

RunPauseMenu:
	;; We have to do everything with sprites because calculating the center of the current scroll point
	;; is definitely not fun, and then we'd have to back up the background where we replaced it with the
	;; menu....basically far too much work for a simple menu.
	LDA #15
	STA PatTable_BankSel+5		; Set patterns needed for pause menu sprites
	JSR Sprite_RAM_Clear		; Clear other sprites

	; Set up our pause menu sprites
	LDY #(PauseMenu_Sprites_End - PauseMenu_Sprites - 1)
_load_pause_loop:
	LDA PauseMenu_Sprites,Y
	STA Sprite_RAM+$00,Y
	DEY
	BPL _load_pause_loop		;While Y >= 0, loop!

	; Fix the cursor's Y position based on selection
	LDY PauseMenuSel
	DEY
	LDA PauseMenu_CursorY,Y
	STA Sprite_RAM+(PauseMenu_CursorSprite-PauseMenu_Sprites)

	JSR DoMenuInput

	RTS

DoMenuInput:
	LDA <Pad_Input
	AND #PAD_DOWN
	BEQ _menu_chk_up
	INC PauseMenuSel
	LDA PauseMenuSel
	AND #%00000011
	BNE _set_menu_sel
	LDA #1				; When we overflow to 0, make our selection 1
	BNE _set_menu_sel
_menu_chk_up:
	LDA <Pad_Input
	AND #PAD_UP
	BEQ _menu_chk_a
	DEC PauseMenuSel
	LDA PauseMenuSel
	AND #%00000011
	BNE _set_menu_sel
	LDA #3				; When we underflow to 0, make our selection 3
	BNE _set_menu_sel
_menu_chk_a:
	LDA <Pad_Input
	AND #PAD_A
	BEQ _menu_input_rts
	LDY PauseMenuSel
	DEY
	TYA
	JSR DynJump
	.word PauseMenuCont			;  0 - cont. Do nothing, just return
	.word PauseMenuReturnToMap		;  1 - Return to map
	.word PauseMenuRestartLevel		;  2 - Restart Level
_set_menu_sel:
	STA PauseMenuSel
_menu_input_rts:
	RTS

PauseMenuRestartLevel:
	LDA #0
	STA Level_PauseFlag
	STA PauseMenuSel

	PLA
	PLA			; Remove the RunPauseMenu return address
	PLA
	PLA			; Remove the RunPauseMenu13 return address
	JMP RestartLevelPRG030

PauseMenuCont:
	LDA #0
	STA Sound_IsPaused
	STA Level_PauseFlag
	STA PauseMenuSel
	RTS

PauseMenuReturnToMap:
	; Transfer Player's current power up to the World Map counterpart
	LDA #0
	STA World_Map_Power

	;; TODO: remove orb/cards if returned to map after beating a level?
	;; Maybe don't allow returning to the map after getting the card?

	PLA
	PLA			; Remove the RunPauseMenu return address
	PLA
	PLA			; Remove the RunPauseMenu13 return address
	PLA			; Remove the saved PAGE_A000
	PLA
	PLA			; Remove the Level_MainLoop return address

	LDA #$01
	STA <Level_ExitToMap
	STA Map_ReturnStatus	 ; Map_ReturnStatus = 1 (Player died, level is not clear)

	JMP PRG030_8F42


SetKickedNonIceblockVel:
	LDA <ThrowUpOrDown
	BEQ _non_iceblock_rts13
	TAX
	DEX			; normalize to a zero-base index
	BEQ _set_throw_vels	; if our index is 0, we're throwing upward
	LDA <Player_FlipBits	; otherwise, we're setting the shell down, so it needs to be nudged in the direction the player is facing
	BEQ _set_throw_vels	; facing left if 0, so leave the index alone
	INX			; facing right if non-zero, so inc the index
_set_throw_vels:
	TXA
	PHA			; Store which index we're using (up, downleft, or downright)
	LDA ShellThrowXVel,X
	LDY ShellThrowYVel,X
	LDX <SlotIndexBackup	; Restore X to the object slot index
	STA <Objects_XVel,X
	STY <Objects_YVel,X

	PLA			; Restore which index we used (up, downleft, or downright)
	PHA			; and store it again
	TAY
	LDA #OBJSTATE_SHELLED
	CPY #0			; Did we throw upward?
	BEQ _store_shell_state	; If so, just store the shelled state
	LDY <Player_XVel	; Otherwise, we dropped it downward...are we running?
	CPY #$30
	BPL _kick_the_shell	; If we're moving rightward fast, kick the shell
	CPY #-$2F
	BMI _kick_the_shell	; If we're moving leftward fast, kick the shell
	BPL _store_shell_state	; We're moving slow enough, just set the shell down
_kick_the_shell:
	PLA
	TAY
	LDA ShellDropXVel,Y	; We dropped the shell while moving quickly, so kick it instead
	STA <Objects_XVel,X
	LDA #OBJSTATE_KICKED	; And set as kicked
	PHA
_store_shell_state:
	STA Objects_State,X
	PLA			; Remove the index
	LDA #1
_non_iceblock_rts13:
	RTS

PRG013_MASSIVE_FREE_SPACE:
	.byte $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA
	.ds 0x161
	.byte $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA, $AA

; Rest of ROM bank was empty
