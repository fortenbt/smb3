.ifndef __WORLD_INC__
__WORLD_INC__ = 1

.macro WORLD_METADATA
    ; FIXME: Anybody want to claim this? Is this part of the above?
    ; $B0F3
    .byte $4A, $44, $47, $48, $AE, $AF, $B5, $B6, $DE, $D9, $DC, $DD
.endmacro

.endif ; include guard
