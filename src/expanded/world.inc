.ifndef __WORLD_INC__
__WORLD_INC__ = 1

; Available world metadata.
; Currently, the Magic and MusicEngine are the only fields defined. We have 6 other bytes to use for whatever we want.
; This World metadata was 12 unused bytes after the world map bytes located in prg012. We're replacing those unused
; bytes with stuff Foundry can find and use as world metadata.
.struct WorldMeta
    Magic       .byte 4    ; Signal to Foundry that this data is world metadata
    MusicEngine .word      ; MusicEngine is a 16-bit bitfield (only 9 are used right now) indicating if the world
                           ; uses the new (1) or old (0) music engine
    Reserved    .byte 6    ; Reserved for future use for things Foundry might be able to use
.endstruct

.macro WORLD_METADATA
    .byte "WDAT"
    .word %0000000000000011         ; Bitmask to use the BHOP engine for music for worlds 1 and 2
    .byte $00, $00, $00, $00, $00, $00
.endmacro

.endif ; include guard
