.ifdef BHOP

.segment "MUS_02" ; 2 - 5
    MODULE_W1:
        .include "music/world1.asm"
    .export MODULE_W1

.segment "MUS_05" ; solely in 5
    MODULE_COURSE_CLEAR:
        .include "music/end-of-level.asm"
    .export MODULE_COURSE_CLEAR

.segment "MUS_05" ; solely in 5
    MODULE_DEATH:
        .include "music/death.asm"
    .export MODULE_DEATH

.segment "MUS_05" ; 5 - 6
    MODULE_W1_1:
        .include "music/w1-1.asm"
    .export MODULE_W1_1

.segment "MUS_06" ; 6 - 9
    MODULE_W1_2:
        .include "music/w1-2.asm"
    .export MODULE_W1_2

.segment "MUS_0A" ; solely in A
    MODULE_REVENGE:
        .include "music/revenge.asm"
    .export MODULE_REVENGE

.segment "MUS_0A" ; solely in A
    MODULE_BRINSTAR:
        .include "music/brinstar.asm"
    .export MODULE_BRINSTAR

.segment "MUS_0A" ; A - B
    MODULE_GUILE:
        .include "music/guile.asm"
    .export MODULE_GUILE

.segment "MUS_0B"
    MODULE_SUMMIT:
        .include "music/summit.asm"
    .export MODULE_SUMMIT

.segment "MUS_0E"
    MODULE_NUMA:
        .include "music/numa-numa.asm"
    .export MODULE_NUMA

.endif ; BHOP
