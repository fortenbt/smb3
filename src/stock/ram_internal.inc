.ifndef __RAM_INTERNAL_INC__
__RAM_INTERNAL_INC__ = 1

; =====================================
; RAM linear allocator
; =====================================
__RAM_OFFSET__ .set $0
.macro RAM_NOINC name
    .export name = RAM_BASE + __RAM_OFFSET__
.endmacro
.macro RAM name, size
    .if (__RAM_OFFSET__ + (size)) > $800
        .error "RAM overflow name"
    .endif
    .export name = RAM_BASE + __RAM_OFFSET__
    __RAM_OFFSET__ .set __RAM_OFFSET__ + (size)
.endmacro

; This is required to properly base the variables that are aliased for multiple modes
.macro RAM_SET_LOC loc
    __RAM_OFFSET__ .set loc
.endmacro

.macro EXPD_RSRV_RAM amt ; increments are handled by __RAM_OFFSET__ .set __RAM_OFFSET__ + x in stock
.endmacro

.endif ; include guard
