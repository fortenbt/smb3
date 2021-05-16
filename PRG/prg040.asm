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

CheckTileSolidness_WithOneWays_40:
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
    BEQ _norm_solid_check           ; if not supported, just do normal check
    LDA PageCallVars                ; tile we're checking against is stored in PageCallVars
    CMP OneWayTileIDsByTSIdx,Y      ; check oneway left
    BEQ _oneway_check
    CMP OneWayTileIDsByTSIdx+1,Y    ; check oneway right
    BNE _norm_solid_check
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
_norm_solid_check:
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

    JSR CheckTileSolidness_WithOneWays_40
    BGE _gndlr_check_40_pla_rts

    PLA
    TAY                         ; Restore our original Y
    LDX Level_Tile_Quad,Y		; Get this particular "quad" (0-3) index
    STX PageCallVars+1
    LDA Level_Tile_GndL,Y		; Check the tile here
    STA PageCallVars
    LDA #$00
    STA PageCallVars+2
    JSR CheckTileSolidness_WithOneWays_40

    RTS

_gndlr_check_40_pla_rts:
    PLA
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