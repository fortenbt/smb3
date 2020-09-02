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
; This source file last updated: 2011-11-18 21:50:34.000000000 -0600
; Distribution package date: Fri Apr  6 23:46:16 UTC 2012
;---------------------------------------------------------------------------
Tile_Layout_TS0:
	; This defines the individual 8x8 blocks used to construct one of the tiles
	; Referenced by Address_Per_Tileset, addressed by Level_Tileset
	; Stored by upper left, then lower left, then upper right, then lower right

	; Remember that palette is determined by the upper 2 bits of a TILE (not the PATTERN)
	; I.e. tiles starting at index $00, $40, $80, $C0 are each on that respective palette

	; RegEx S&R to replace addresses with tile counts (works from $A000-$A...)
	; \$A.(.)(.) - \$A..(.)
	; Tiles $\1\2 - $\1\3

	; Upper left 8x8 pattern per tile
	.byte $88, $DC, $FF, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C, $8C ; Tiles $00 - $0F
	.byte $8C, $8C, $8C, $8C, $8C, $8C, $8C, $FF, $C4, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $10 - $1F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $20 - $2F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $30 - $3F
	.byte $88, $DC, $FE, $CF, $FE, $FE, $FE, $FE, $FE, $FE, $FE, $5C, $FC, $FD, $FF, $FE ; Tiles $40 - $4F
	.byte $90, $0C, $0C, $0C, $B6, $58, $B6, $4B, $4A, $4A, $4B, $FE, $4A, $4A, $4A, $60 ; Tiles $50 - $5F
	.byte $20, $50, $54, $FE, $56, $FF, $FE, $C4, $04, $2E, $64, $FF, $C4, $16, $FF, $FF ; Tiles $60 - $6F
	.byte $50, $54, $FE, $70, $74, $78, $08, $44, $48, $4C, $68, $6C, $FF, $59, $40, $FF ; Tiles $70 - $7F
	.byte $88, $DC, $9F, $9E, $AC, $9E, $2B, $2C, $2B, $2A, $9B, $9F, $9B, $10, $10, $10 ; Tiles $80 - $8F
	.byte $9F, $9F, $10, $9F, $9B, $10, $10, $9B, $10, $AC, $9D, $9E, $9E, $9B, $9F, $10 ; Tiles $90 - $9F
	.byte $00, $AC, $9E, $9E, $9B, $9F, $99, $9F, $10, $9F, $9E, $10, $2A, $94, $2A, $2A ; Tiles $A0 - $AF
	.byte $2A, $32, $36, $D4, $00, $2A, $2A, $9B, $10, $FE, $9E, $2A, $E0, $00, $02, $00 ; Tiles $B0 - $BF
	.byte $88, $DC, $BE, $BE, $BE, $BE, $FE, $47, $FE, $B1, $70, $72, $78, $7A, $BE, $21 ; Tiles $C0 - $CF
	.byte $BE, $3A, $BE, $47, $3F, $FC, $BE, $FE, $FF, $FE, $FE, $FE, $FE, $FE, $FE, $60 ; Tiles $D0 - $DF
	.byte $90, $21, $6C, $68, $B6, $D0, $26, $FE, $A8, $58, $12, $C4, $60, $59, $FF, $FF ; Tiles $E0 - $EF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $F0 - $FF

	; Lower left 8x8 pattern per tile
	.byte $89, $DD, $FF, $8E, $8E, $8E, $8E, $8E, $8E, $8E, $8E, $8E, $8E, $BE, $BE, $BE ; Tiles $00 - $0F
	.byte $BE, $BE, $BE, $BE, $BE, $BE, $BE, $FF, $C5, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $10 - $1F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $20 - $2F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $30 - $3F
	.byte $89, $DD, $FE, $CF, $FE, $C2, $FE, $C2, $FE, $C2, $C2, $5D, $FC, $FD, $CE, $CE ; Tiles $40 - $4F
	.byte $91, $0D, $0D, $0D, $B7, $59, $B7, $48, $4A, $49, $4D, $4C, $49, $4A, $4A, $61 ; Tiles $50 - $5F
	.byte $BB, $51, $55, $42, $56, $42, $C2, $C5, $05, $2F, $65, $FF, $C5, $17, $FF, $FF ; Tiles $60 - $6F
	.byte $51, $55, $FE, $71, $75, $79, $09, $45, $49, $4D, $69, $6D, $FF, $5A, $41, $FF ; Tiles $70 - $7F
	.byte $89, $DD, $96, $97, $99, $1E, $2A, $2C, $2A, $2B, $99, $97, $99, $1E, $1E, $1E ; Tiles $80 - $8F
	.byte $1E, $1E, $1E, $97, $AE, $96, $96, $99, $97, $9B, $97, $1E, $97, $99, $1E, $97 ; Tiles $90 - $9F
	.byte $01, $AE, $96, $96, $99, $1E, $AE, $95, $96, $96, $1E, $95, $C2, $9C, $C2, $C2 ; Tiles $A0 - $AF
	.byte $2A, $33, $37, $D5, $01, $2A, $2A, $84, $C2, $C2, $95, $2A, $E2, $01, $03, $01 ; Tiles $B0 - $BF
	.byte $89, $DD, $BE, $1A, $45, $20, $3E, $BE, $B0, $B2, $74, $76, $7C, $7E, $BE, $FE ; Tiles $C0 - $CF
	.byte $45, $3B, $BE, $BE, $BE, $FC, $BE, $FE, $FF, $FE, $C2, $FE, $C2, $FE, $C2, $61 ; Tiles $D0 - $DF
	.byte $91, $23, $6D, $BB, $B7, $D1, $27, $CE, $A9, $59, $13, $C5, $61, $5A, $FF, $FF ; Tiles $E0 - $EF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $F0 - $FF

	; Upper right 8x8 pattern per tile	
	.byte $8A, $DE, $FF, $8D, $8D, $8D, $8D, $8D, $8D, $8D, $8D, $8D, $8D, $FB, $FB, $FB ; Tiles $00 - $0F
	.byte $FB, $FB, $FB, $FB, $FB, $FB, $FB, $FF, $C6, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $10 - $1F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $20 - $2F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $30 - $3F
	.byte $8A, $DE, $FE, $CF, $FE, $FE, $C0, $FE, $C0, $FE, $C0, $5E, $FC, $FD, $FF, $FE ; Tiles $40 - $4F
	.byte $92, $0E, $0E, $0E, $B8, $5A, $B8, $4A, $4B, $4A, $4A, $FE, $4B, $4A, $4A, $62 ; Tiles $50 - $5F
	.byte $21, $52, $54, $FE, $57, $FF, $FE, $C6, $06, $30, $66, $FF, $C6, $1C, $FF, $FF ; Tiles $60 - $6F
	.byte $52, $FE, $FE, $72, $76, $FE, $0A, $46, $4A, $4E, $6A, $6E, $FF, $5B, $42, $FF ; Tiles $70 - $7F
	.byte $8A, $DE, $9C, $9D, $9D, $9D, $2C, $2C, $2B, $2A, $9C, $9A, $11, $11, $9A, $9C ; Tiles $80 - $8F
	.byte $11, $9C, $9C, $11, $11, $11, $9A, $11, $9A, $9E, $AD, $9D, $9D, $9A, $11, $9C ; Tiles $90 - $9F
	.byte $2B, $9D, $9D, $AD, $9C, $9A, $9C, $98, $9C, $11, $86, $C0, $2A, $97, $2A, $C0 ; Tiles $A0 - $AF
	.byte $C0, $34, $38, $D6, $02, $C0, $2A, $11, $9A, $C0, $86, $2A, $EF, $00, $02, $FE ; Tiles $B0 - $BF
	.byte $8A, $DE, $BE, $BE, $BE, $BE, $46, $FE, $FE, $B4, $71, $73, $79, $7B, $19, $BE ; Tiles $C0 - $CF
	.byte $41, $3C, $41, $25, $BE, $FC, $BE, $FE, $FF, $FE, $FE, $C0, $FE, $C0, $C0, $62 ; Tiles $D0 - $DF
	.byte $92, $24, $6E, $69, $B8, $D2, $28, $FE, $AA, $5A, $14, $C6, $62, $5B, $FF, $FF ; Tiles $E0 - $EF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $F0 - $FF

	; Lower right 8x8 pattern per tile
	.byte $8B, $DF, $FF, $8F, $A4, $A5, $A6, $A7, $C8, $C9, $CA, $CB, $BF, $8F, $A4, $A5 ; Tiles $00 - $0F
	.byte $A6, $A7, $C8, $C9, $CA, $CB, $BF, $FF, $C7, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $10 - $1F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $20 - $2F
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $30 - $3F
	.byte $8B, $DF, $FE, $CF, $CD, $C2, $C0, $CD, $CD, $C2, $CD, $5F, $FC, $FD, $CE, $CE ; Tiles $40 - $4F
	.byte $93, $0F, $0F, $0F, $B9, $5B, $B9, $FE, $4F, $49, $4A, $49, $48, $4A, $4A, $63 ; Tiles $50 - $5F
	.byte $BD, $53, $55, $43, $57, $43, $CD, $C7, $07, $31, $67, $FF, $DF, $1D, $FF, $FF ; Tiles $60 - $6F
	.byte $53, $57, $FE, $73, $77, $7B, $0B, $47, $4B, $4F, $6B, $6F, $FF, $7A, $43, $FF ; Tiles $70 - $7F
	.byte $8B, $DF, $95, $94, $1F, $1F, $2C, $2B, $2A, $2B, $94, $98, $1F, $1F, $98, $1F ; Tiles $80 - $8F
	.byte $1F, $1F, $94, $1F, $95, $95, $AF, $94, $98, $94, $9A, $94, $1F, $98, $94, $1F ; Tiles $90 - $9F
	.byte $FE, $95, $95, $AF, $1F, $98, $96, $AF, $95, $95, $C0, $87, $C2, $9F, $CD, $CD ; Tiles $A0 - $AF
	.byte $C0, $35, $39, $D7, $03, $CD, $CD, $C2, $85, $CD, $87, $2A, $FA, $01, $03, $FE ; Tiles $B0 - $BF
	.byte $8B, $DF, $18, $1B, $44, $BE, $BE, $22, $B3, $B5, $75, $77, $7D, $7F, $40, $44 ; Tiles $C0 - $CF
	.byte $FE, $3D, $22, $BE, $BE, $FC, $BE, $FE, $FF, $CD, $C2, $C0, $CD, $CD, $CD, $63 ; Tiles $D0 - $DF
	.byte $93, $46, $6F, $BD, $B9, $D3, $29, $CE, $AB, $5B, $15, $C7, $63, $7A, $FF, $FF ; Tiles $E0 - $EF
	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF ; Tiles $F0 - $FF

Tile_Attributes_TS0:
	; These are defining base ranges to check if a tile is "enterable" on the map
	; Essentially, for a given "range" of tile on the map ($00, $40, $80, $C0),
	; the corresponding value is indexed (take the previous value >> 6) and returns
	; a "quick failure", i.e. "You're standing on a tile in [that range] and it
	; has a value less than [retrieved from below]; you can't possibly enter it!"

	; NOTE: The pool and star are both "enterable"...
	.byte TILE_MARIOCOMP_P, TILE_FORT, TILE_POOL, TILE_WORLD5STAR

	; These values (equivalent to above) also pulled in via Level_Tileset_LUT??
	.byte TILE_MARIOCOMP_P, TILE_FORT, TILE_POOL, TILE_WORLD5STAR

	.byte $20, $0E, $A4, $4C, $B7, $97

Tile_Mem_Clear:	; A40E
	; The following loop clears all of the tile memory space to $02 (an all-black tile)
	LDY #$00	
PRG012_A410:
	LDA #$02	
	JSR Tile_Mem_ClearB
	JSR Tile_Mem_ClearA
	CPY #$f0	 
	BNE PRG012_A410	 ; If Y <> $F0, loop! (increments happen in ClearA)

	RTS		 ; Return

Map_Tile_ColorSets:
	.byte $00, $01, $00, $03, $04, $05, $06, $07, $02

Map_Object_ColorSets:
	.byte $08, $08, $08, $08, $08, $08, $08, $09, $08

Map_Complete_Bits:
	; Quick LUT to get the bit for this completion row
	.byte $80, $40, $20, $10, $08, $04, $02, $01

Map_Removable_Tiles:
	.byte TILE_ROCKBREAKH, TILE_ROCKBREAKV, TILE_LOCKVERT, TILE_FORT, TILE_ALTFORT, TILE_ALTLOCK, TILE_LOCKHORZ, TILE_RIVERVERT
MRT_END	; marker to calculate size -- allows user expansion of Map_Removable_Tiles

Map_RemoveTo_Tiles:
	; These specify tiles that coorespond to the tile placed when the above is removed
	; (NOTE: First two are for rock; see also PRG026 RockBreak_Replace)
	; NOTE: Must have as many elements as Map_Removable_Tiles!
	.byte TILE_HORZPATH, TILE_VERTPATH, TILE_VERTPATH, TILE_FORTRUBBLE, TILE_ALTRUBBLE, TILE_HORZPATHSKY, TILE_HORZPATH, TILE_BRIDGE

Map_Completable_Tiles:
	; These tiles are simply marked with the M/L
	; NOTE: The Dancing Flower is a "completable tile"...
	.byte TILE_TOADHOUSE, TILE_SPADEBONUS, TILE_HANDTRAP, TILE_DANCINGFLOWER, TILE_ALTTOADHOUSE
MCT_END	; marker to calculate size -- allows user expansion of Map_Completable_Tiles

Map_CompleteByML_Tiles:
	.byte TILE_MARIOCOMP_P, TILE_LUIGICOMP_P, TILE_MARIOCOMP_O, TILE_LUIGICOMP_O
	.byte TILE_MARIOCOMP_G, TILE_LUIGICOMP_G, TILE_MARIOCOMP_R, TILE_LUIGICOMP_R

Map_Bottom_Tiles:
	; This defines which tile covers the bottom horizontal border, per world
	.byte TILE_BORDER1, TILE_BORDER1, TILE_BORDER1, TILE_BORDER1, TILE_BORDER2
	.byte TILE_BORDER1, TILE_BORDER1, TILE_BORDER3, TILE_BORDER1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Map_Reload_with_Completions
;
; This very important subroutine actually loads in the map layout
; data and sets level panels which have been previously completed
; to their proper state (e.g. M/L for level panels, crumbled fort)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Map_Reload_with_Completions:
	; Clears all map tiles to $02 (all black tiles)
	JSR Tile_Mem_Clear

	; Fill 16x tile $4E every $1B0 (upper horizontal border)
	LDX #$30	 ; X = $30
PRG012_A462:
	TXA		 
	TAY		 
	LDA #$02	 
	JSR Tile_Mem_ClearB
	TYA		 
	ADD #$10	 
	TAY		 
	LDA #$4e	 
	JSR Tile_Mem_ClearB
	INX		 ; X++
	CPX #$40	 
	BNE PRG012_A462	 ; While X <> $40, loop!

	; After these two, Map_Tile_Addr = Tile_Mem_Addr + $110
	LDA Tile_Mem_Addr
	ADD #$10	 
	STA <Map_Tile_AddrL

	LDA Tile_Mem_Addr+1
	ADC #$01	 
	STA <Map_Tile_AddrH

	; Temp_Var1/2 will form an address pointing at the beginning of this world's map tile layout...
	LDA World_Num
	ASL A
	TAY		 ; Y = World_Num << 1 (index into Map_Tile_Layouts)
	LDA Map_Tile_Layouts,Y	
	STA <Temp_Var1		
	LDA Map_Tile_Layouts+1,Y
	STA <Temp_Var2		

	; This loop loads the layout data into the Tile_Mem
	; Note that it COULD terminate early via an $FF
	; at any time, but this is never used...
PRG012_A496:
	LDY #$00	 	; Y = 0
PRG012_A498:
	LDA [Temp_Var1],Y	; Get byte from tile layout
	CMP #$ff	 
	BEQ PRG012_A4C1	 	; If it's $FF (terminator), jump to PRG012_A4C1
	STA [Map_Tile_AddrL],Y	; Copy byte to RAM copy of tiles
	INY		 	; Y++

	; 144 supports a 16x9 map screen (the left and right columns
	; each contain a normally invisible-until-scrolled tile)
	CPY #144	 	
	BNE PRG012_A498	 	; If Y <> 144, loop!

	; This does a 16-bit addition of 144 to the
	; address stored at [Temp_Var2][Temp_Var1]
	TYA
	ADD <Temp_Var1	
	STA <Temp_Var1	
	LDA <Temp_Var2	
	ADC #$00	
	STA <Temp_Var2

	; The tile layout for the map actually has a lot of
	; unused vertical space (used for level layout) so
	; this needs to add a significant amount more ($1b0)
	; to the Map_Tile_Addr
	LDA <Map_Tile_AddrL
	ADD #$b0	
	STA <Map_Tile_AddrL
	LDA <Map_Tile_AddrH
	ADC #$01
	STA <Map_Tile_AddrH
	JMP PRG012_A496	 	; Do next 144 bytes...

PRG012_A4C1:
	; Layout is loaded!

	; This places the tiles along the bottom (lower horizontal border)
	LDY #$e0	 	; Offset to the bottom row
	LDX World_Num	 	; Current world
	LDA Map_Bottom_Tiles,X	; Get the appropriate tile for the bottom row
PRG012_A4C9:
	JSR Tile_Mem_ClearB	; Place the tiles
	INY		 	; Y++
	CPY #$f0	 
	BNE PRG012_A4C9	 	; While Y <> $F0, jump to PRG012_A4C9

	LDA World_Num
	TAY		
	LDA Map_Tile_ColorSets,Y
	STA PalSel_Tile_Colors	 	; Store which colors to use on map tiles
	LDA Map_Object_ColorSets,Y
	STA PalSel_Obj_Colors	 	; Store which colors to use on map objects

	LDY #$00	
	STY <Temp_Var1	; Temp_Var1 = $00 (current completion column we're checking)
PRG012_A4E5:
	LDA #$80	
	STA <Temp_Var2	; Temp_Var2 = $80 (current completion bit/row we're checking)

PRG012_A4E9:
	LDY <Temp_Var1		; Get current offset
	LDA Map_Completions,Y	; Get this "Map Completion" value
	AND <Temp_Var2	 	; Check current completion bit
	BNE PRG012_A4F5	 	; If this row has a completion on this bit, jump to PRG012_A4F5
	JMP PRG012_A585	 	; Otherwise, jump to PRG012_A585

PRG012_A4F5:
	; Row completion on specified bit
	TYA		 ; A = Y (offset into Map_Completions, i.e. the current column of map data we're on)

	; Note: Loop goes through both Players sets of completion bits, but
	; this AND will basically cause 2 passes across the map...
	AND #$30	 ; Determine which screen we're on (every $10 is another screen of map data, $00, $10, $20, $30)

	; Provide X as an index into the Tile_Mem_Addr table
	LSR A
	LSR A
	LSR A
	TAX

	; This pulls the correct starting address for this map "screen"
	LDA Tile_Mem_Addr,X
	STA <Map_Tile_AddrL
	LDA Tile_Mem_Addr+1,X
	STA <Map_Tile_AddrH
	INC <Map_Tile_AddrH	; Because map is always one the "lower" screen (as far as tile memory goes)

	; The following loop determines what "index" cooresponds to this completion bit
	; that we're working with (only one!)
	LDX #$07		; X = 7
PRG012_A50A:
	LDA <Temp_Var2		; Current complete bit
	CMP Map_Complete_Bits,X	
	BEQ PRG012_A514	 	; If bitvalue matched, jump out of loop
	DEX		 	; X--
	BNE PRG012_A50A	 	; If X > 0, loop!

PRG012_A514:
	; X is now a value from 0 to 7

	TXA
	ASL A
	ASL A
	ASL A
	ASL A		 ; A = X * 16
	ADD #$10	 ; A += 16  (Thus: 16, 32, 48, 64, 80, 96, 112, 144; each row is another 16 bytes!)
	STA <Temp_Var3	 ; Store result into Temp_Var3

	TYA		 ; A = Y (the current "column" of completion we're working on)
	AND #$0f	 ; Make it relative within this screen only (0-15)
	ORA <Temp_Var3	 ; Merge with previous result; now its a direct offset within this screen to this row/col
	TAY		 ; Y now holds the aforementioned offset

PRG012_A524:
	LDA [Map_Tile_AddrL],Y	 ; Get this tile

	STY <Temp_Var5	 ; Y -> Temp_Var5
	STA <World_Map_Tile	 ; -> World_Map_Tile

	; Get tile quadrant -> 'X'
	AND #$c0
	CLC		 
	ROL A		 
	ROL A		 
	ROL A		 
	TAX

	; Check if this tile is one of the completable event tiles
	; $50 = Toad house  $E8 = Spade panel  $E6 = Hand trap (works anywhere!)  $BD = Enterable flower??  $E0 = Red Toad House
	LDY #(MCT_END-Map_Completable_Tiles-1)	 	; Y = 4 
	LDA <World_Map_Tile	; A = tile
PRG012_A535:
	CMP Map_Completable_Tiles,Y	
	BEQ PRG012_A570	 ; If tile match, jump to PRG012_A570
	DEY		 ; Y--
	BPL PRG012_A535	 ; While Y >= 0, loop!

	; Tile didn't match, loop finished...
	CMP #TILE_FORT 
	BEQ PRG012_A54A	 ; If tile is Mini-Fortress, jump to PRG012_A54A
	CMP #TILE_ALTFORT
	BEQ PRG012_A54A	 ; If tile is Reddish Mini-Fortress, jump to PRG012_A54A

	; SB: Irregular that they didn't use Tile_AttrTable here...
	CMP Tile_Attributes_TS0,X
	BGE PRG012_A570	; If this tile is a completable tile (as determined by quadrant and range), jump to PRG012_A570

PRG012_A54A:
	; Mini-fortresses or others here
	LDX #(MRT_END-Map_Removable_Tiles-1)	; X = 7
PRG031_A54C:
	CMP Map_Removable_Tiles,X	; Check this tile
	BEQ PRG031_A556	 		; If it matches this index, jump to PRG031_A556
	DEX		 		; X--
	BPL PRG031_A54C	 		; While X >=0, loop!
	BMI PRG012_A55C	 		; If matched nothing, jump to PRG012_A55C

PRG031_A556:
	LDA Map_RemoveTo_Tiles,X	; Get the replacement tile
	;;; [ORANGE] Always check our custom reload tiles
	;;;JMP PRG031_A581			; Jump to PRG031_A581
	JMP _check_custom_reload_tiles

PRG012_A55C:
	LDA <Temp_Var2
	CMP #$01
	BNE PRG012_A585	 ; If Temp_Var2 (current completion bit) <> 1, jump to PRG012_A585

	; Completion bit 1 appears one row lower than the other adjacent bits

	LDY <Temp_Var5
	CPY #$90
	BGE PRG012_A585	 ; If Temp_Var5 (offset to tile) >= $90, jump to PRG012_A585

	; Y += 16 (next tile row)
	TYA
	ADD #16
	TAY

	JMP PRG012_A524	 ; Jump to PRG012_A524

PRG012_A570:
	; Just about any "flippable" tile goes here, produces M/L
	TXA
	ASL A
	STA <Temp_Var4	 ; Temp_Var4 = X (tile quadrant) << 1

	LDA <Temp_Var1
	AND #$40
	BEQ PRG012_A57C	 ; If this is completion bit 6, jump to PRG012_A57C

	INC <Temp_Var4		 ; Otherwise, Temp_Var4++
PRG012_A57C:
	LDX <Temp_Var4		 ; X = (tile quadrant * 2) + 0/1

	;;; [ORANGE] We hook here so that when the map is reloaded, we can look at the
	;;; Level_Orbs bits to get the proper completed tile.
	LDA Map_CompleteByML_Tiles,X	; Get proper completion tile
	;PRG031_A581:
	;;LDY <Temp_Var5		 ; Y = Temp_Var5 (offset to tile)
	;;;STA [Map_Tile_AddrL],Y	 ; Set proper completion tile!
_check_custom_reload_tiles:
	JSR SetLevelCompleteTile_Reload
	NOP

PRG012_A585:
	LSR <Temp_Var2	 ; Temp_Var2 >>= 1
	BEQ PRG012_A58C	 ; If we've finished all row completion bits, jump to PRG012_A58C
	JMP PRG012_A4E9	 ; Jump to PRG012_A4E9

PRG012_A58C:
	INC <Temp_Var1	 ; Temp_Var1++
	LDA <Temp_Var1	 
	CMP #$80	 
	BEQ PRG012_A597	 ; If Temp_Var1 = 80 (completed through all column bytes), jump to PRG012_A597 (RTS)
	JMP PRG012_A4E5	 ; Otherwise, jump back around again...

PRG012_A597:
	RTS		 ; Return

Map_Tile_Layouts:
	; This points to the layout data for each world's map tile layout
	.word W1_Map_Layout, W2_Map_Layout, W3_Map_Layout, W4_Map_Layout, W5_Map_Layout
	.word W6_Map_Layout, W7_Map_Layout, W8_Map_Layout, W9_Map_Layout


	; Each world's layout; very simple data, specifies a linear list of tile bytes.
	; Every 144 bytes form a 16x9 single screen of world map.
	; The stream is terminated by $FF
W1_Map_Layout:	.include "PRG/maps/World1L"
W2_Map_Layout:	.include "PRG/maps/World2L"
W3_Map_Layout:	.include "PRG/maps/World3L"
W4_Map_Layout:	.include "PRG/maps/World4L"
W5_Map_Layout:	.include "PRG/maps/World5L"
W6_Map_Layout:	.include "PRG/maps/World6L"
W7_Map_Layout:	.include "PRG/maps/World7L"
W8_Map_Layout:	.include "PRG/maps/World8L"
W9_Map_Layout:	.include "PRG/maps/World9L"

; FIXME: Anybody want to claim this? Is this part of the above?
; $B0F3
	.byte $4A, $44, $47, $48, $AE, $AF, $B5, $B6, $DE, $D9, $DC, $DD
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Map_PrepareLevel
;
; Based on what spot of the map you entered, figure out which "level"
; you're entering ("level" means any enterable spot on the map including
; bonus games, etc.)
;
; The ultimate output is properly configured
; Level_ObjPtr_AddrL/H and Level_ObjPtrOrig_AddrL/H (object list pointer)
; Level_LayPtr_AddrL/H and Level_LayPtrOrig_AddrL/H (tile layout pointer)
; Level_Tileset
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Map_PrepareLevel:
	LDX Player_Current	; X = Player_Current
	LDA Player_FallToKing,X	; A = Player_FallToKing
	BEQ PRG012_B10A	 	; If Player_FallToKing = 0 (not falling into king's room), jump to PRG012_B10A
	JMP PRG012_B262	 	; Otherwise, jump to PRG012_B262

PRG012_B10A:
	LDA World_Num	 
	ASL A		 
	TAY		 	; Y = World_Num << 1 (2 bytes per world)

	; Temp_Var2/1 form an address to Map_ByRowType
	LDA Map_ByRowType,Y	 
	STA <Temp_Var1		 
	LDA Map_ByRowType+1,Y	 
	STA <Temp_Var2		 

	; Temp_Var4/3 form an address to Map_ByScrCol
	LDA Map_ByScrCol,Y	 
	STA <Temp_Var3		 
	LDA Map_ByScrCol+1,Y	 
	STA <Temp_Var4		 

	; Temp_Var6/5 form an address to Map_ObjSets
	LDA Map_ObjSets,Y	 
	STA <Temp_Var5		 
	LDA Map_ObjSets+1,Y	 
	STA <Temp_Var6		 

	; Temp_Var8/7 form an address to Map_LevelLayouts
	LDA Map_LevelLayouts,Y	 
	STA <Temp_Var7		 
	LDA Map_LevelLayouts+1,Y	 
	STA <Temp_Var8		 

	; Temp_Var10/9 form an address to Map_ByXHi_InitIndex
	LDA Map_ByXHi_InitIndex,Y	 
	STA <Temp_Var9		 
	LDA Map_ByXHi_InitIndex+1,Y	 
	STA <Temp_Var10		 


	LDX Player_Current
	LDY <World_Map_XHi,X
	LDA [Temp_Var9],Y	; get initial index based on the current "screen" of the map the Player was on
	TAY		 	; Y = the aforementioned index

	LDA #$00
	STA <Temp_Var15		; Temp_Var15 = 0 (will be a page change value)

	; Now we search, beginning from the specified index, and try to match the row the Player
	; is on with the upper 4 bits of the value we get from the next table
	; The index remains in the 'Y' register at completion
	LDX Player_Current
PRG012_B150:
	LDA [Temp_Var1],Y	
	AND #$f0	 	; Specifically only consider the "row" this specifies
	CMP <World_Map_Y,X	; Compare to the Player's Y position on the map
	BEQ PRG012_B162	 	; If this byte matches your Y position on the map, jump to PRG012_B162
	INY		 	; Y++
	BNE PRG012_B150	 	; While Y <> 0, loop!

	; Didn't find any matching position!  
	INC <Temp_Var2		; Move to the next address page
	INC <Temp_Var15		; Temp_Var15++ (to acknowledge the page change for the next part)
	JMP PRG012_B150	 	; Try again...

PRG012_B162:

	; Add the page change (if any) to Temp_Var4 (applies same page change here)
	LDA <Temp_Var4
	ADD <Temp_Var15
	STA <Temp_Var4

	LDA #$00
	STA <Temp_Var15		; Temp_Var15 = 0

	; Temp_Var9 will now be a value where the current "column" on the map is 
	; in the lower 4 bits and the current "screen" (XHi) is in the upper bits.
	LDA <World_Map_X,X
	LSR A		 
	LSR A		 
	LSR A		 
	LSR A		 
	STA <Temp_Var9		
	LDA <World_Map_XHi,X
	ASL A		 
	ASL A		 
	ASL A		 
	ASL A		 
	ORA <Temp_Var9

	; 'Y' was set by the last loop...
PRG012_B17D:
	CMP [Temp_Var3],Y	; See if this position matches
	BEQ PRG012_B18B	 	; If this matches, jump to PRG012_B18B
	INY			; Y++
	BNE PRG012_B17D	 	; While Y <> 0, loop!

	; Didn't find any matching position!  
	INC <Temp_Var4		; Move to the next address page
	INC <Temp_Var15		; Temp_Var15++ (to acknowledge the page change for the next part)
	JMP PRG012_B17D	 	; Try again...

PRG012_B18B:

	; Add the page change (if any) to Temp_Var2 (applies same page change here)
	LDA <Temp_Var2	
	ADD <Temp_Var15	
	STA <Temp_Var2	

	LDA World_Num
	CMP #$08	
	BNE PRG012_B1A1	 	; If World_Num <> 8 (World 9), jump to PRG012_B1A1

	; World 9 bypass
	LDA [Temp_Var1],Y	; Just goes to get the original value "type" ID, which in this case is world to enter
	AND #$0f

	; Destination world is fed back out through Map_Warp_PrevWorld
	STA Map_Warp_PrevWorld
	RTS		 ; Return

PRG012_B1A1:
	LDA [Temp_Var1],Y	
	AND #$0f	 	; Get "type" bits 
	STA Level_Tileset	; Store into Level_Tileset

	; Add the page change (if any) to Temp_Var6 (applies same page change here)
	LDA <Temp_Var6
	ADD <Temp_Var15
	STA <Temp_Var6

	TYA		 
	TAX		 ; X = Y (our sought after offset)
	ASL A		 
	TAY		 ; Y <<= 1
	BCC PRG012_B1BB	 ; Somewhat excessive skip to not add carry if we don't need to :P

	; Apply carry to Temp_Var6
	LDA <Temp_Var6
	ADC #$00	
	STA <Temp_Var6	

PRG012_B1BB:

	; Store address of object set into Level_ObjPtr_AddrL/H and Level_ObjPtrOrig_AddrL/H
	LDA [Temp_Var5],Y	 
	STA <Level_ObjPtr_AddrL
	STA Level_ObjPtrOrig_AddrL	 
	INY		 
	LDA [Temp_Var5],Y	 
	STA <Level_ObjPtr_AddrH		 
	STA Level_ObjPtrOrig_AddrH	 

	; Add the page change (if any) to Temp_Var6 (applies same page change here)
	LDA <Temp_Var8	
	ADD <Temp_Var15	
	STA <Temp_Var8	

	TXA
	ASL A		 
	TAY		 ; Y = X (the backed up index) << 1
	BCC PRG012_B1DC	 ; Somewhat excessive skip to not add carry if we don't need to :P

	; Apply carry to Temp_Var8
	LDA <Temp_Var8
	ADC #$00	
	STA <Temp_Var8	

PRG012_B1DC:
	STY <Temp_Var16	 ; Keep index in Temp_Var16

	; Store address of object set into Level_LayPtr_AddrL/H and Level_LayPtrOrig_AddrL/H
	LDA [Temp_Var7],Y	 
	STA <Level_LayPtr_AddrL		 
	STA Level_LayPtrOrig_AddrL	 
	INY		 
	LDA [Temp_Var7],Y	 
	STA <Level_LayPtr_AddrH		 
	STA Level_LayPtrOrig_AddrH	 

	LDA <Map_EnterViaID
	BNE Map_DoEnterViaID	 ; If Map_EnterViaID <> 0, jump to Map_DoEnterViaID

	LDA Level_Tileset
	CMP #15	 
	BNE PRG012_B1FB	 ; If Level_Tileset <> 15 (Bonus Game intro), jump to PRG012_B1FB

	JMP PRG012_B384	 ; Otherwise, jump to PRG012_B384

PRG012_B1FB:
	LDA #$03	 
	STA World_EnterState
	RTS		 ; Return


Map_DoEnterViaID:
	; Most "entry" on the world map uses your map position to pick out a 
	; pointer to a level.  Simple stuff.

	; But certain things like the airship, coin ship, white toad house, etc. 
	; must "override" the map placement to go to something specific; that's 
	; where Map_EnterViaID comes in; if set to a value, it jumps to a 
	; PARTICULAR place regardless of map placement.

	; Not all map objects go anywhere special though...

	JSR DynJump

	; THESE MUST FOLLOW DynJump FOR THE DYNAMIC JUMP TO WORK!!
	.word MO_Unused		; 0: (Not used, normal panel entry)
	.word MO_Unused		; 1: HELP (can't be "entered")
	.word MO_Airship	; 2: Airship
	.word MO_Unused		; 3: Hammer Bro battle
	.word MO_Unused		; 4: Boomerang Bro battle
	.word MO_Unused		; 5: Heavy Bro battle
	.word MO_Unused		; 6: Fire Bro battle
	.word MO_Unused		; 7: World 7 Plant
	.word MO_Unused		; 8: Unknown marching glitch object
	.word MO_NSpade		; 9: N-Spade game
	.word MO_Shop		; 10: Anchor/P-Wing house
	.word MO_CoinShip	; 11: Coin ship
	.word MO_UnusedMapObj	; 12: Unknown white colorization of World 8 Airship
	.word MO_Unused		; 13: World 8 Battleship
	.word MO_Unused		; 14: World 8 Tank
	.word MO_Unused		; 15: World 8 Airship
	.word MO_Unused		; 16: Canoe (can't be "entered")


; FIXME: Anybody want to claim this?
; This is a perfect clone of Map_GetTile from PRG010, but not used here...
; $B226 
	LDX Player_Current
	LDA <World_Map_XHi,X
	ASL A		 
	TAY		 

	; Store starting offset for this map screen into Map_Tile_AddrL/H
	LDA Tile_Mem_Addr,Y
	STA <Map_Tile_AddrL
	LDA Tile_Mem_Addr+1,Y
	STA <Map_Tile_AddrH

	INC <Map_Tile_AddrH	; Effectively adds $100 to the address (maps get loaded at screen base + $110)

	LDA <World_Map_X,X
	LSR A		 
	LSR A		 
	LSR A		 
	LSR A		 
	STA <Temp_Var1		; Temp_Var1 = World_Map_X / 16 (the current column of the current screen)

	LDA <World_Map_Y,X
	SUB #16
	AND #$f0
	ORA <Temp_Var1		; Temp_Var1 now holds the X column in the lower 4-bits and the Y row in the upper 4-bits

	TAY		 	; Store this offset value into 'Y'

	LDA [Map_Tile_AddrL],Y
	STA <World_Map_Tile	
	RTS		 ; Return

KingsRoomLayout_ByWorld:
	.word KNG1L	; World 1
	.word KNG2L	; World 2
	.word KNG3L	; World 3
	.word KNG4L	; World 4
	.word KNG5L	; World 5
	.word KNG6L	; World 6
	.word KNG7L	; World 7
	.word KNG1L	; World 8 (??)

KingsRoomObjLayout:
	.word Empty_ObjLayout


PRG012_B262:

	; Falling into King's room...

	LDA World_Num
	ASL A		
	TAX		 ; X = World_Num * 2 (2 byte index)

	LDA KingsRoomLayout_ByWorld,X
	STA <Level_LayPtr_AddrL
	LDA KingsRoomLayout_ByWorld+1,X
	STA <Level_LayPtr_AddrH

	LDA KingsRoomObjLayout
	STA <Level_ObjPtr_AddrL
	LDA KingsRoomObjLayout+1
	STA <Level_ObjPtr_AddrH

	; King's room tile set
	LDA #$02
	STA Level_Tileset

	RTS		 ; Return

	; Airship jump addresses for the map object version
Airship_Layouts:
	.word W1AirshipL
	.word W2AirshipL
	.word W3AirshipL
	.word W4AirshipL
	.word W5AirshipL
	.word W6AirshipL
	.word W7AirshipL
	.word W8AirshipL

Airship_Objects:
	.word W1AirshipO
	.word W2AirshipO
	.word W3AirshipO
	.word W4AirshipO
	.word W5AirshipO
	.word W6AirshipO
	.word W7AirshipO
	.word W8AirshipO


MO_Airship:
	LDA World_Num	; Get world number
	ASL A		 ; Turn into 2-byte index
	TAY		 ; -> 'Y'

	; Get proper airship layout
	LDA Airship_Layouts,Y
	STA <Level_LayPtr_AddrL
	LDA Airship_Layouts+1,Y
	STA <Level_LayPtr_AddrH

	; Get proper airship object set pointer
	LDA Airship_Objects,Y
	STA <Level_ObjPtr_AddrL
	LDA Airship_Objects+1,Y
	STA <Level_ObjPtr_AddrH

	; Force Level_Tileset = 10 (Airship)
	LDA #10
	STA Level_Tileset

	RTS		 ; Return

MO_Unused:
	; Tries to queue Hammer Bro battle music, but doesn't
	; really work, winds up being like no override at all

	; NOTE: The only difference is World_EnterState will
	; fail to be set to 3, which causes no discernable 
	; effect in SMB3-US, but probably would break the 
	; world entry "outro" in the original SMB3-J

	LDA #$70
	STA Level_MusicQueue

	RTS		 ; Return

MO_NSpade:
	; Level_Tileset = 15 (Bonus game intro)
	LDA #15
	STA Level_Tileset

	; Bonus_GameType = 2 (N-Spade)
	LDA #$02
	STA Bonus_GameType

	LDY #$00
	STY Bonus_KTPrize	; !!
	STY Bonus_GameHost	; Standard Toad Host


	; NOTE: This was probably going to vary by game type, 
	; but in final version, Y = 0 (see PRG022 for more)

	; Bonus game layout
	LDA Bonus_LayoutData,Y
	STA <Level_LayPtr_AddrL
	LDA Bonus_LayoutData+1,Y
	STA <Level_LayPtr_AddrH	

	; World_EnterState = 3
	LDA #$03
	STA World_EnterState

	RTS		 ; Return

	; White Toad House layouts
ToadShop_Layouts:
	.word TOAD_SpecL
	.word TOAD_SpecL
	.word TOAD_SpecL
	.word TOAD_SpecL
	.word TOAD_SpecL
	.word TOAD_SpecL
	.word TOAD_SpecL
	.word TOAD_SpecL

	; White Toad House configuration
	; NOTE: This is NOT actually an object layout pointer (which is always fixed in Toad Houses), 
	; this just defines what is in the lone chest in white Toad Houses (P-Wing / Anchor)
ToadShop_Objects:
	.word $0200
	.word $0A00
	.word $0200
	.word $0A00
	.word $0200
	.word $0A00
	.word $0200
	.word $0A00

MO_Shop:
	LDA World_Num	; Get world number
	ASL A		 ; Turn into 2-byte index
	TAY		 ; -> 'Y'

	; Load proper Toad Shop layout
	LDA ToadShop_Layouts,Y
	STA <Level_LayPtr_AddrL
	LDA ToadShop_Layouts+1,Y
	STA <Level_LayPtr_AddrH	

	; Load proper Toad Shop object set
	LDA ToadShop_Objects,Y
	STA <Level_ObjPtr_AddrL
	LDA ToadShop_Objects+1,Y
	STA <Level_ObjPtr_AddrH	

	; Level_Tileset = 7 (Toad House)
	LDA #$07
	STA Level_Tileset

	RTS		 ; Return

	; Possibly thinking of having per-world coin ships?
CoinShip_Layouts:
	.word CoinShipL
	.word CoinShipL
	.word CoinShipL
	.word CoinShipL
	.word CoinShipL
	.word CoinShipL
	.word CoinShipL
	.word CoinShipL

CoinShip_Objects:
	.word CoinShipO
	.word CoinShipO
	.word CoinShipO
	.word CoinShipO
	.word CoinShipO
	.word CoinShipO
	.word CoinShipO
	.word CoinShipO

MO_CoinShip:
	LDA World_Num	; Get world number
	ASL A		 ; Turn into 2-byte index
	TAY		 ; -> 'Y'

	; Get coin ship layout
	LDA CoinShip_Layouts,Y
	STA <Level_LayPtr_AddrL
	LDA CoinShip_Layouts+1,Y
	STA <Level_LayPtr_AddrH	

	; Get coin ship objects
	LDA CoinShip_Objects,Y
	STA <Level_ObjPtr_AddrL
	LDA CoinShip_Objects+1,Y
	STA <Level_ObjPtr_AddrH	

	; Set Level_Tileset = 10 (Airship)
	LDA #10
	STA Level_Tileset

	RTS		 ; Return


	; Wonder what this might have been?
	; Just goes to World 7-5 underground now...
UnusedMapObj_Layout:	.word W705_UnderL
UnusedMapObj_Objects:	.word W705_UnderO

MO_UnusedMapObj:

	; Set the layout
	LDA UnusedMapObj_Layout
	STA <Level_LayPtr_AddrL
	LDA UnusedMapObj_Layout+1
	STA <Level_LayPtr_AddrH

	; Set the objects
	LDA UnusedMapObj_Objects
	STA <Level_ObjPtr_AddrL
	LDA UnusedMapObj_Objects+1
	STA <Level_ObjPtr_AddrH

	; Level_Tileset = 1 (Plains style)
	LDA #$01
	STA Level_Tileset

	RTS		 ; Return


PRG012_B384:
	; Level_Tileset = 15 (Bonus Game intro!)

	; Copy Player map data into "Entered" vars
	LDY Player_Current
	LDA World_Map_Y,Y
	STA Map_Entered_Y,Y
	LDA World_Map_XHi,Y
	STA Map_Entered_XHi,Y
	LDA World_Map_X,Y	
	STA Map_Entered_X,Y	
	LDA Map_UnusedPlayerVal2,Y	
	STA Map_Previous_UnusedPVal2,Y	

	LDA #15
	STA Level_Tileset	 ; Re-affirming Level_Tileset = 15?

	LDY <Temp_Var16		 ; Index of level entered

	; Set Bonus_GameType (always 1 in actual game)
	LDA [Temp_Var5],Y
	STA Bonus_GameType

	; Set Bonus_KTPrize (always irrelevant in actual game)
	LDA [Temp_Var7],Y
	STA Bonus_KTPrize

	INY		 ; Y++

	; Set Bonus_GameHost (always 0 in actual game)
	LDA [Temp_Var5],Y
	STA Bonus_GameHost

	LDA [Temp_Var7],Y
	ASL A
	TAY		 ; -> 'Y'

	LDA Bonus_LayoutData,Y
	STA <Level_LayPtr_AddrL
	LDA Bonus_LayoutData+1,Y
	STA <Level_LayPtr_AddrH

	; World_EnterState = 3
	LDA #$03
	STA World_EnterState

	RTS		 ; Return



	; Each of these has an entry PER WORLD (0-8, Worlds 1-9)

	; This table specifies a lookup for the world that supplies an initial
	; offset value for the following table based on the "XHi" position the
	; Player was on the map.  Obviously for many worlds there is no valid
	; offset value on some of the higher map screens...
Map_ByXHi_InitIndex:
	.word W1_InitIndex, W2_InitIndex, W3_InitIndex, W4_InitIndex, W5_InitIndex, W6_InitIndex, W7_InitIndex, W8_InitIndex, W9_InitIndex

	; This table is initially indexed by the initial offset supplied by Map_ByXHi_InitIndex 
	; and provides a series of map row locations (upper 4 bits) and level tileset (lower 4 bits)
Map_ByRowType:
	.word W1_ByRowType, W2_ByRowType, W3_ByRowType, W4_ByRowType, W5_ByRowType, W6_ByRowType, W7_ByRowType, W8_ByRowType, W9_ByRowType

	; This table just maps the column positions of enterable level tiles
Map_ByScrCol:
	.word W1_ByScrCol, W2_ByScrCol, W3_ByScrCol, W4_ByScrCol, W5_ByScrCol, W6_ByScrCol, W7_ByScrCol, W8_ByScrCol, W9_ByScrCol

	; This table maps the relevant object layout pointers for the levels
Map_ObjSets:
	.word W1_ObjSets, W2_ObjSets, W3_ObjSets, W4_ObjSets, W5_ObjSets, W6_ObjSets, W7_ObjSets, W8_ObjSets, W9_ObjSets

	; This tbale maps the relevant level layout pointers for the levels
Map_LevelLayouts:
	.word W1_LevelLayout, W2_LevelLayout, W3_LevelLayout, W4_LevelLayout, W5_LevelLayout, W6_LevelLayout, W7_LevelLayout, W8_LevelLayout, W9_LevelLayout

	; "Structure" data files -- contains data that links levels to
	; their layout and objects by the rows and columns 
	.include "PRG/maps/World1S"
	.include "PRG/maps/World2S"
	.include "PRG/maps/World3S"
	.include "PRG/maps/World4S"
	.include "PRG/maps/World5S"
	.include "PRG/maps/World6S"
	.include "PRG/maps/World7S"
	.include "PRG/maps/World8S"
	.include "PRG/maps/World9S"


; FIXME: Anybody want to claim this??
; $BC54
	.byte $55, $15, $F5, $56, $25, $D4 ; $BC4A - $BC59
	.byte $F2, $07, $86, $E3, $2B, $F0, $FF, $3F, $00, $80, $FF, $7F, $00, $C0, $FF, $03 ; $BC5A - $BC69
	.byte $00, $F0, $FF, $03, $80, $FF, $62, $81, $FF, $22, $78, $BD, $24, $09, $BD, $DD ; $BC6A - $BC79
	.byte $4A, $08, $FA, $3F, $80, $D5, $4B, $B6, $2A, $2B, $4D, $24, $3F, $E8, $EF, $00 ; $BC7A - $BC89
	.byte $7C, $FF, $05, $00, $FF, $0F, $00, $C0, $FF, $1F, $00, $F0, $FF, $07, $F0, $1F ; $BC8A - $BC99
	.byte $28, $7E, $FE, $07, $00, $E0, $3F, $7E, $E0, $00, $8E, $FF, $00, $FE, $1F, $80 ; $BC9A - $BCA9
	.byte $2E, $FE, $E7, $07, $00, $FF, $8F, $1E, $00, $7E, $A0, $F8, $FF, $03, $00, $FE ; $BCAA - $BCB9
	.byte $A3, $00, $FF, $02, $EF, $7F, $01, $00, $F0, $FF, $07, $80, $FF, $27, $80, $EB ; $BCBA - $BCC9
	.byte $FF, $01, $00, $FD, $7F, $00, $F8, $7F, $02, $2C, $CE, $1F, $04, $46, $FE, $3F ; $BCCA - $BCD9
	.byte $00, $F0, $3F, $70, $BE, $07, $F8, $0B, $44, $8F, $FF, $C0, $7A, $00, $07, $FA ; $BCDA - $BCE9
	.byte $FF, $07, $00, $FC, $3F, $40, $FE, $40, $FF, $1F, $00, $80, $FF, $27, $00, $EC ; $BCEA - $BCF9
	.byte $BF, $7A, $80, $FF, $0B, $00, $FF, $81, $BF, $00, $A7, $42, $FF, $0B, $A0, $EA ; $BCFA - $BD09
	.byte $3F, $E0, $C4, $D1, $ED, $20, $F4, $9F, $00, $F7, $03, $FB, $0B, $E0, $D3, $07 ; $BD0A - $BD19
	.byte $E8, $EA, $57, $00, $7F, $C1, $AF, $78, $01, $A0, $FF, $2F, $E8, $00, $FE, $42 ; $BD1A - $BD29
	.byte $57, $B7, $49, $44, $55, $6D, $AF, $58, $01, $DA, $FF, $15, $80, $AA, $FD, $07 ; $BD2A - $BD39
	.byte $40, $FE, $52, $4B, $75, $2A, $B4, $55, $AB, $26, $A9, $BA, $58, $4A, $DB, $56 ; $BD3A - $BD49
	.byte $95, $D0, $A6, $17, $2B, $D9, $B2, $52, $D5, $92, $DA, $D1, $96, $98, $B4, $4A ; $BD4A - $BD59
	.byte $7B, $27, $89, $6C, $29, $EA, $FD, $0A, $01, $DA, $FE, $17, $00, $F5, $BD, $44 ; $BD5A - $BD69
	.byte $49, $ED, $AD, $04, $69, $FB, $04, $EA, $BD, $54, $92, $D0, $BE, $4B, $92, $DA ; $BD6A - $BD79
	.byte $92, $DA, $A4, $B6, $95, $A4, $AA, $DA, $5A, $12, $D5, $AA, $B7, $24, $29, $B5 ; $BD7A - $BD89
	.byte $AD, $26, $B1, $2D, $A5, $55, $2B, $25, $B5, $DD, $44, $AA, $6A, $2B, $69, $A5 ; $BD8A - $BD99
	.byte $DA, $B6, $24, $A8, $BD, $25, $A9, $B2, $DD, $48, $52, $6D, $AB, $52, $55, $25 ; $BD9A - $BDA9
	.byte $6D, $5B, $49, $AA, $AD, $2A, $49, $6D, $AB, $52, $53, $A5, $B2, $AD, $2A, $55 ; $BDAA - $BDB9
	.byte $55, $49, $6D, $57, $21, $B6  ; $BDBA - $BDBF



; Rest of ROM bank was empty

;;; NOTE This isn't a copy from prg030. This one uses the column num and row completion bit
;;; that are being checked in Map_Reload_with_Completions
; --------- TOP OF MAP
; $80
; $40
; $20
; $10
; $08
; $04
; $02
; INVALID
; $01
; --------- BOT OF MAP
Levels_Entered_XY_12:
	;.byte $04, $80	; stock level 1
	.byte $04, $08	; sorb level 1
	.byte $04, $01	; sorb level 2
	.byte $06, $01	; sorb level 3
	.byte $08, $02	; sorb level 4
	.byte $0A, $02	; sorb level 5
	.byte $0C, $02	; sorb level 6
	.byte $0A, $80	; sorb level 7
	.byte $06, $08	; sorb level 8
	.byte $06, $80	; sorb level 9
	.byte $04, $40	; sorb level 10
	.byte $06, $08	; sorb grimm (TODO)
	.byte $08, $20	; sorb fort
LEXY_END_12

SetLevelCompleteTile_Reload:
	;;; Temp_Var1 = X of level, Temp_Var2 = Y of level
	;;; A is the tile we need to use to replace the completed tile
	;;; if the tile is actually complete.
	PHA					; Save off our replacement tile
	LDX #0
_chk_loop12:
	LDA Levels_Entered_XY_12,X
	CMP Temp_Var1
	BNE _chk_cont12
	LDA Levels_Entered_XY_12+1,X
	CMP Temp_Var2
	BEQ _findorboffs_done12
_chk_cont12:
	INX
	INX
	CPX #(LEXY_END_12-Levels_Entered_XY_12-1)
	BCC _chk_loop12
_findorboffs_done12:
	TXA
	LSR A				; The offset we found is doubled, so divide by 2
	TAX
	CPX #12				; max offset is 11
	BCS _slct_orig_tile	; This isn't one of our tiles...
	; Found our level, check its Level_Orbs
	LDA Level_Orbs,X
	BEQ _slct_orig_tile	; If it's zero, the level is totally complete
	; Non-zero, so we need to get the re-enterable tile
	PLA					; Remove our stored tile from the stack
	CMP #TILE_FORTRUBBLE	; If this was a destroyed fort, we have a custom tile for the partially destroyed fort
	BNE _slct_non_fort
	LDA #$6C
	BNE _slct_set_tile	; always branch
_slct_non_fort:
	TXA
	ADC #13				; tile ID is 13 more than the index
	BNE _slct_set_tile	; always branch
_slct_orig_tile:
	PLA					; This is actually complete, restore our replacement tile
_slct_set_tile:
	LDY <Temp_Var5		 ; Y = Temp_Var5 (offset to tile)
	STA [Map_Tile_AddrL],Y	 ; Set proper completion tile!
	RTS