.ifndef __WORLD_INC__
__WORLD_INC__ = 1

.struct WorldMeta
    Magic       .byte 4    ; Signal to Foundry that this data is world metadata
    MusicEngine .word      ; Some of this metadata may signal music engine not applicable to the expanded ROM only,
    Reserved    .byte 6    ; but we may still use it for other reasons in the expanded ROM with the stock music engine.
.endstruct

.macro WORLD_METADATA
    .byte "WDAT"
    .word $0003
    .byte $00, $00, $00, $00, $00, $00
.endmacro

.endif ; include guard
