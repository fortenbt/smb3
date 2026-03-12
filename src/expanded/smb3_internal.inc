.ifndef __SMB3_INTERNAL_INC__
__SMB3_INTERNAL_INC__ = 1

.macro STOCK_FREE_SPACE amt, align
    .ifnblank align
        .align align
    .endif
.endmacro

.endif ; include guard
