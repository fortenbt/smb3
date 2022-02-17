;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Identical to LoadLevel_TileMemNextRow from prg014
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LoadLevel_TileMemNextRow_40:
	; Y = TileAddr_Off

	TYA
	ADD #16
	TAY		 ; Y += 16

	LDA <Map_Tile_AddrH
	ADC #$00
	STA <Map_Tile_AddrH
	RTS		 ; Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Identical to LoadLevel_NextColumn from prg014
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LoadLevel_NextColumn_40:
	INY		 ; Y++
	TYA		 ; A = Y
	AND #$0f	 ; Check column
	BNE __PRG014_DFCC	 ; If on column 1-15, jump to PRG014_DFCC (RTS)

	; Otherwise, need to move over to the next screen (+$1B0)
	LDA <Map_Tile_AddrL
	ADD #$b0
	STA <Map_Tile_AddrL
	LDA <Map_Tile_AddrH
	ADC #$01
	STA <Map_Tile_AddrH

	; Get TileAddr_Off and only keep the row, but clear 'Y' lower bits since
	; we're going to column 0 on the same row, new screen...
	LDA TileAddr_Off
	AND #$f0
	TAY

__PRG014_DFCC:
	RTS		 ; Return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadLevel15_Generic_40:
    ;;; [ORANGE] This function handles loading the following custom
    ;;; tiles in TileSet 1 based on the value in PageCallVars:
    ;;; 0 = One-Way Solid Left
    ;;; 1 = One-Way Solid Right
    ;;; 2 = On block
    ;;; 3 = Off block
    LDA PageCallVars
    JSR DynJump
    .word LoadLevel_OneWays_40
    .word LoadLevel_OneWays_40
    .word LoadLevel_OnOffs_TS1
    .word LoadLevel_OnOffs_TS1


OneWayTileIDsByTSIdx:
	;;; $40 is the unsupported constant due to $40 always being a
	;;; coin tile. We'll never have $40 as our one-way tile ID
    ; solid L    R  ; solid L means object collides if XVel > 0
    .byte TILE1_ONEWAY_SL, TILE1_ONEWAY_SR	; 1 - Plains
    .byte $40, $40	; 2 - Mini fortress style
    .byte $40, $40	; 3 - Hills style
    .byte $40, $40	; 4 - High-Up style
    .byte $40, $40	; 5 - pipe world plant infestation
    .byte $40, $40	; 6 - Water world
    .byte $40, $40	; 7 - Toad house
    .byte $40, $40	; 8 - Vertical pipe maze
    .byte $40, $40	; 9 - desert level
    .byte $40, $40	; 10 - airship
    .byte $40, $40	; 11 - Giant World
    .byte $40, $40	; 12 - ice level
    .byte $40, $40	; 13 - coin heaven / sky level
    .byte $40, $40	; 14 - underground
    .byte $40, $40	; 15 - bonus game intro
    .byte $40, $40	; 16 - spade game sliders
    .byte $40, $40	; 17 - N-spade
    .byte $40, $40	; 18 - 2P Vs

CheckTileSolidness_FirstHalf_40:
    ;;; FirstHalf vs SecondHalf is which half of the Tile_AttrTable we're checking
    ;;; FirstHalf is for "only solid on ground" tiles
    ;;;     If we're a oneway tile, this is always nonsolid
    ;;;     Note that Level_Tile_GndL/R will be set to tiles above head if Player_YVel < 0
    ;;;     So if Player_YVel > 0 (moving downward), we'll check AttrTable
    ;;;     If Player_YVel < 0 (moving upward), we'll check AttrTable+4
    ;;; SecondHalf is for "solid all around" tiles
    LDX PageCallVars+2
    LDA Level_TilesetIdx
    ASL A
    TAY                             ; Y << 1
    LDA OneWayTileIDsByTSIdx,Y
    CMP #$40
    BEQ _norm_1h_solid_chk           ; if not supported, just do normal check
    LDA PageCallVars                ; tile we're checking against is stored in PageCallVars
    CMP OneWayTileIDsByTSIdx,Y      ; check oneway left
    BEQ _set_as_nonsolid
    CMP OneWayTileIDsByTSIdx+1,Y    ; check oneway right
    BEQ _set_as_nonsolid

_norm_1h_solid_chk:
    LDA PageCallVars
    LDY PageCallVars+1
    CMP Tile_AttrTable,Y
    RTS

CheckTileSolidness_SecondHalf_40:
    ;;; First, check if this tile ID is one of our one-ways.
    ;;; If it is, we need to check Objects_XVel to see if we
    ;;; collide or not.
    ;;; If it isn't, then we do a normal solid tile check.
    ;;;
    ;;; tile ID of potential solid tile = PageCallVars
    ;;; quadrant of potential wall tile = PageCallVars+1
    ;;; offset from Player_XVel for this object (player = 0, objects = their index + 1) = PageCallVars+2
    LDX PageCallVars+2
    LDA Level_TilesetIdx
    ASL A
    TAY                             ; Y << 1
    LDA OneWayTileIDsByTSIdx,Y
    CMP #$40
    BEQ _norm_2h_solid_chk           ; if not supported, just do normal check
    LDA PageCallVars                ; tile we're checking against is stored in PageCallVars
    CMP OneWayTileIDsByTSIdx,Y      ; check oneway left
    BEQ _oneway_check
    CMP OneWayTileIDsByTSIdx+1,Y    ; check oneway right
    BNE _norm_2h_solid_chk
_oneway_check:
    ; We collided with a one-way. Are we hitting its solid side?
    CMP OneWayTileIDsByTSIdx,Y      ; check solid left
    BEQ _solid_if_positive_vel
_solid_if_negative_vel:
    LDA <Player_XVel,X
    BMI _set_as_solid
    BPL _set_as_nonsolid
_solid_if_positive_vel:
    LDA <Player_XVel,X
    BEQ _set_as_nonsolid
    BPL _set_as_solid
_set_as_nonsolid:
    CLC ; carry clear means not solid
    RTS
_set_as_solid:
    SEC ; carry set means solid
    RTS

_norm_2h_solid_chk:
    LDA PageCallVars
    LDY PageCallVars+1
    CMP Tile_AttrTable+4,Y
    RTS

Level_CheckGndLR_TileGTAttr_40:
    LDY PageCallVars
    TYA
    PHA                         ; Save off our original Y
    LDX Level_Tile_Quad+1,Y     ; Get this particular "quad" (0-3) index
    STX PageCallVars+1
    LDA Level_Tile_GndR,Y		; Check the tile here
    STA PageCallVars
    LDA #$00
    STA PageCallVars+2

    LDA <Player_YVel
    BPL _do1h2h_check
    LDA <Player_InAir
    BEQ _do1h2h_check
    ;;; if we're moving upward/in air, we do 2h
    BNE _2h_attr_check  ; branch always

_do1h2h_check:
    PLA
    PHA
    CMP #$00                    ; Offset of 0 means we're checking feet/head tiles
    BEQ _1h_attr_check          ; so we need to run FirstHalf
_2h_attr_check:
    JSR CheckTileSolidness_SecondHalf_40
    BGE _gndlr_check_40_pla_rts
    BCC _next_tile_attr_check
_1h_attr_check:
    JSR CheckTileSolidness_FirstHalf_40
    BCC _next_tile_attr_check

_gndlr_check_40_pla_rts:
    PLA
    RTS

_next_tile_attr_check:
    PLA
    PHA
    TAY                         ; Restore our original Y
    LDX Level_Tile_Quad,Y		; Get this particular "quad" (0-3) index
    STX PageCallVars+1
    LDA Level_Tile_GndL,Y		; Check the tile here
    STA PageCallVars
    LDA #$00
    STA PageCallVars+2

    LDA <Player_YVel
    BPL _do1h2h_check_2
    LDA <Player_InAir
    BEQ _do1h2h_check_2
    ;;; if we're moving upward/in air, we do 2h
    PLA ; just remove this
    JMP _2h_attr_check2

_do1h2h_check_2:
    PLA
    CMP #$00                    ; Offset of 0 means we're checking feet tiles
    BEQ _1h_attr_check2
_2h_attr_check2:
    JSR CheckTileSolidness_SecondHalf_40
    RTS
_1h_attr_check2:
    JSR CheckTileSolidness_FirstHalf_40
    RTS


LoadLevel_OneWays_40:
    ; PageCallVars contains our one-way ID (0 or 1)
    LDA LL_ShapeDef
    AND #$0f
    STA <Temp_Var4				; Temp_Var4 = lower 4 bits of LL_ShapeDef (height of run)

    LDA Level_Tileset
    SUB #$01                    ; You actually can't use Level_TilesetIdx outside of gameplay context,
                                ; as it is set in Player_DoGameplay
    ASL A
    ADD PageCallVars
    TAX

    LDY TileAddr_Off
_load_oneway_loop:
    LDA OneWayTileIDsByTSIdx,X
    STA [Map_Tile_AddrL],Y		; Put a one-way tile here

    JSR LoadLevel_TileMemNextRow_40
    DEC <Temp_Var4
    BPL _load_oneway_loop		; loop for all one-ways in this run

    RTS		 ; Return

LoadLevel_OnOffs_TS1:
    DEC PageCallVars    ; PageCallVars contains 2 or 3, and we need 0 or 1
    DEC PageCallVars
    ; Fall into LoadLevel_OnOffs_40

LoadLevel_OnOffs_40:
    ; PageCallVars contains our On/Off ID (0 or 1)
    LDA LL_ShapeDef
    AND #$0f
    STA <Temp_Var4			; Temp_Var4 = lower 4 bits of LL_ShapeDef (width of run)

    LDA Level_Tileset
    CMP #$06                    ; If this is a water tileset, we actually start our On/Off block IDs
                                ; at the previous tileset in order to support water and air on/offs
    BNE _post_water_sub
    SUB #$01
_post_water_sub:
    SUB #$01                    ; You actually can't use Level_TilesetIdx outside of gameplay context,
                                ; as it is set in Player_DoGameplay
    ASL A
    ASL A
    ADD PageCallVars
    TAX
    LDA PageCallVars
    SUB #$02                    ; If this was 2 or 3 (water tileset's air tiles), we need to add it again
                                ; to offset to the next tileset IDs rather than the off+ons
    BMI _post_id_offset
    INX
    INX
_post_id_offset:
    LDY TileAddr_Off		; Y = TileAddr_Off
_load_onoff_loop:
    LDA OnOffTileByTS,X		; One of our custom tiles
    STA [Map_Tile_AddrL],Y		; Store into tile mem
    JSR LoadLevel_NextColumn_40	; Next column
    DEC <Temp_Var4				; Temp_Var4--
    BPL _load_onoff_loop		; While Temp_Var4 >= 0, loop!
    RTS

NextRowColumn:
    JMP [Temp_Var1]

LoadLevel_CustomTile17Col:
    LDA #LOW(LoadLevel_TileMemNextRow_40)
    STA <Temp_Var1
    LDA #HIGH(LoadLevel_TileMemNextRow_40)
    STA <Temp_Var2
    JMP LoadLevel_CustomTile17
LoadLevel_CustomTile17Row:
    LDA #LOW(LoadLevel_NextColumn_40)
    STA <Temp_Var1
    LDA #HIGH(LoadLevel_NextColumn_40)
    STA <Temp_Var2
LoadLevel_CustomTile17:
    LDA LL_ShapeDef
    AND #$0f
    STA <Temp_Var4			; Temp_Var4 = lower 4 bits of LL_ShapeDef (width/height of run)
    TXA                     ; A = Custom tile
    PHA
    LDY TileAddr_Off		; Y = TileAddr_Off
_load_custom17_loop:
    PLA
    PHA
    STA [Map_Tile_AddrL],Y		; Store into tile mem
    JSR NextRowColumn
    DEC <Temp_Var4				; Temp_Var4--
    BPL _load_custom17_loop		; While Temp_Var4 >= 0, loop!
    PLA
    RTS

CustomTiles17:
    .byte TILE4_ON, TILE4_OFF_INACTIVE, TILE4_CEILINGMUNCH, TILE4_PILLAR_TOP_UD
    .byte TILE4_PILLAR_TOP, TILE4_PILLAR_MID, TILE4_HORZ_PILLAR, TILE4_RARCH_UD
    .byte TILE4_LARCH_UD

LoadLevel17_Generic_40:
    LDA PageCallVars
    TAY
    LDX CustomTiles17,Y
    JSR DynJump                     ; DynJump messes with Y, but not with X
    .word LoadLevel_OnOffs_40
    .word LoadLevel_OnOffs_40
    .word LoadLevel_CustomTile17Row   ; ceiling munchers
    .word LoadLevel_CustomTile17Row   ; upside down pillar top
    .word LoadLevel_CustomTile17Row   ; pillar top
    .word LoadLevel_CustomTile17Col   ; pillar mid
    .word LoadLevel_CustomTile17Row   ; pillar horizontal
    .word LoadLevel_CustomTile17Row   ; upside down pillar arch right
    .word LoadLevel_CustomTile17Row   ; upside down pillar arch left

