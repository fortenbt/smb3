.ifndef __RAM_ZP_INTERNAL_INC__
__RAM_ZP_INTERNAL_INC__ = 1

; =================================================================
; ZP RAM linear "allocator" for the stock ROM uses __ZP_OFFSET__
; to get the correct spacing between zero page variables, whereas
; the expanded ROM ignores all the spacing to maximize available
; zero page variable space.
; =================================================================
__ZP_OFFSET__ .set $0
.macro ZP_NOINC name
    .exportzp name = ZP_BASE + __ZP_OFFSET__
.endmacro
.macro ZP name, size
    .if (__ZP_OFFSET__ + (size)) > $100
        .error "ZP overflow name"
    .endif
    .exportzp name = ZP_BASE + __ZP_OFFSET__
    __ZP_OFFSET__ .set __ZP_OFFSET__ + (size)
.endmacro

; This is required to properly base the variables that are aliased for multiple modes
.macro ZP_SET_LOC loc
    __ZP_OFFSET__ .set loc
.endmacro

.macro BHOP_RSRV_ZP amt
.endmacro

.endif ; include guard
