OneWayTileIDsByTSIdx:
	;;; $40 is the unsupported constant due to $40 always being a
	;;; coin tile. We'll never have $40 as our one-way tile ID
    ; solid L    R  ; solid L means object collides if XVel > 0
	.byte TILE1_LITTLE_BUSH, TILE1_DIAMOND	; 1 - Plains
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

CheckTileSolidness_40:
    ;;; First, check if this tile ID is one of our one-ways.
    ;;; If it is, we need to check Objects_XVel to see if we
    ;;; collide or not.
    ;;; If it isn't, then we do a normal solid tile check.
    ;;;
	;;; Object_TileWall = tile ID of potential wall tile
	;;; Object_AttrWall = quadrant of potential wall tile
    LDX SlotIndexBackup
    LDY Level_TilesetIdx
    LDA OneWayTileIDsByTSIdx,Y
    CMP #$40
    BEQ _norm_solid_check           ; if not supported, just do normal check
    LDA Object_TileWall
    CMP OneWayTileIDsByTSIdx,Y      ; check oneway left
    BEQ _oneway_check
    CMP OneWayTileIDsByTSIdx+1,Y    ; check oneway right
    BNE _norm_solid_check
_oneway_check:
    ; We collided with a one-way. Are we hitting its solid side?
    CMP OneWayTileIDsByTSIdx,Y      ; check solid left
    BEQ _solid_if_positive_vel
_solid_if_negative_vel:
    LDA <Objects_XVel,X
    BMI _set_as_solid
    BPL _set_as_nonsolid
_solid_if_positive_vel:
    LDA <Objects_XVel,X
    BPL _set_as_solid
_set_as_nonsolid:
    CLC ; carry clear means not solid
    RTS
_set_as_solid:
	SEC ; carry set means solid
	RTS
_norm_solid_check:
    LDA Object_TileWall
	LDY Object_AttrWall
	CMP Tile_AttrTable+4,Y
	RTS
