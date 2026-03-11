.ifndef __RAM_PRG_INTERNAL_INC__
__RAM_PRG_INTERNAL_INC__ = 1

; =======================================================================
; PRG RAM linear "allocator" for the stock ROM uses __PRGRAM_OFFSET__
; to get the correct spacing between PRG RAM variables, whereas the
; expanded ROM ignores all the spacing to maximize available PRG RAM
; variable space.
; =======================================================================
__PRGRAM_OFFSET__ .set 0
.macro PRGRAM_NOINC name
    .export name = PRGRAM_BASE + __PRGRAM_OFFSET__
.endmacro
.macro PRGRAM name, size
    .if (__PRGRAM_OFFSET__ + (size)) > $2000
        .error "PRGRAM overflow: name"
    .endif
    .export name = PRGRAM_BASE + __PRGRAM_OFFSET__
    __PRGRAM_OFFSET__ .set __PRGRAM_OFFSET__ + (size)
.endmacro

; This is required to properly base the variables that are aliased for multiple modes
.macro PRG_SET_LOC loc
    __PRGRAM_OFFSET__ .set loc
.endmacro

.endif ; include guard
