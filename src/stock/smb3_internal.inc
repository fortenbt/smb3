.ifndef __SMB3_INTERNAL_INC__
__SMB3_INTERNAL_INC__ = 1

.macro STOCK_FREE_SPACE amt, val, align
    .ifnblank val
        .res amt, val
    .else
        .res amt, $ff
    .endif
    .ifnblank align
        .align align
    .endif
.endmacro

.endif ; include guard
