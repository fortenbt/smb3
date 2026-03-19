.ifndef __MUSIC_HOOKS_INC__
__MUSIC_HOOKS_INC__ = 1

; This is taken directly from prg030.asm within INITIALIZATION OF WORLD MAP
.macro SETUP_WORLD_MUSIC
    LDX World_Num
    LDY World_BGM,X     ; Get BGM index for this world
    CPX #4
    BNE PRG030_8698     ; If we're NOT on world 5, jump to PRG030_8698

    ; World 5 special handling (Sky part different music)
    LDX Player_Current  ; X = Player_Current
    LDA World_Map_XHi,X    ; Get the high byte of this Player's X position
    BEQ PRG030_8698     ; If it's equal to 0 (the "lower" part of the Sky World), jump to PRG030_8698

    ; Otherwise...
    LDY #MUS2A_SKY   ; Use Sky music!
    JMP PRG030_869F

PRG030_8698:
    ; Either not world 5, or ground-side of world 5
    LDA Map_MusicBox_Cnt
    BEQ PRG030_869F     ; If Map_MusicBox_Cnt = 0, jump to PRG030_869F
    LDY #MUS2A_MUSICBOX     ; Otherwise, play the music box song

PRG030_869F:
    STY Sound_QMusic2   ; Play BGM!
.endmacro

.macro RUN_SOUND_ENGINE
    ; *** Bring the sound engine (page 28 and page 29) into ROM
    LDA #MMC3_8K_TO_PRG_C000    ; Changing PRG ROM at C000
    STA MMC3_COMMAND        ; Set MMC3 command
    LDA #29             ; Page 29
    STA MMC3_PAGE           ; Set MMC3 page

    LDA #MMC3_8K_TO_PRG_A000    ; Changing PRG ROM at A000
    STA MMC3_COMMAND        ; Set MMC3 command
    LDA #28             ; Page 28
    STA MMC3_PAGE           ; Set MMC3 page

    ; Jump to the sound engine, newly inserted at page A000!
    JSR Sound_Engine_Begin
    JSR PRGROM_Change_Both
.endmacro

; Stupid that we have to have two of these, but that's what stock did
.macro RUN_SOUND_ENGINE_ROULETTE
    ; Switch to page 28 @ A000
    LDA #MMC3_8K_TO_PRG_A000
    STA MMC3_COMMAND
    LDA #28
    STA MMC3_PAGE

    ; Jump to the sound engine, newly inserted at page A000!
    JSR Sound_Engine_Begin

    ; Change A000 back to whatever it was before the sound engine
    JSR PRGROM_Change_A000
.endmacro

.endif ; include guard
