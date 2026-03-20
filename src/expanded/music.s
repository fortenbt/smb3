.ifdef BHOP

.segment "MUS_01"
    MODULE_DOOM:
        .include "music/e1m1.asm"
    .export MODULE_DOOM

.segment "MUS_02"
    MODULE_W1:
        .include "music/world1bgm.asm"
    .export MODULE_W1

.segment "MUS_08"
    MODULE_VIRUS:
        .include "music/virus-busting.asm"
    .export MODULE_VIRUS

.endif ; BHOP
