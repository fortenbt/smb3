.ifndef __RAM_ZP_INTERNAL_INC__
__RAM_ZP_INTERNAL_INC__ = 1

; =================================================================
; The expanded ROM ZP linear "allocator" ignores all the zero page
; stock spacing to maximize available zero page variable space.
; =================================================================
__ZP_OFFSET__ .set $0
__ZP_EXPD_OFFS__ .set $0
.macro ZP_NOINC name
    .exportzp name = ZP_BASE + __ZP_EXPD_OFFS__
.endmacro
.macro ZP name, size
    .if (__ZP_EXPD_OFFS__ + (size)) > $100
        .error "ZP overflow name"
    .endif
    .exportzp name = ZP_BASE + __ZP_EXPD_OFFS__
    __ZP_EXPD_OFFS__ .set __ZP_EXPD_OFFS__ + (size)
.endmacro

; This is required to properly base the variables that are aliased for multiple modes
.macro ZP_SET_LOC loc
    __ZP_EXPD_OFFS__ .set loc
.endmacro

.endif ; include guard
