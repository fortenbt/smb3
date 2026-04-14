.ifndef __MUSIC_HOOKS_INC__
__MUSIC_HOOKS_INC__ = 1

; ----- MUSIC HOOKS -----
; NOTE: All these music hooks exist in order to modify code within the stock game
; while still allowing the stock ROM to be assembled byte-for-byte identical.
; So all the hooks are defined under stock to be identical to the code that was
; there originally.
; -----

; ----- (prg030.asm) -----
; EARLY_RESET_HOOK
;
; One of the first things done after clearing RAM after reset
; -----
.macro EARLY_RESET_HOOK
    LDA #$5a
    STA Reset_Latch
.endmacro

; ----- (prg030.asm) -----
; SETUP_WORLD_MUSIC
;
; Where we initially queue up the music on the map for this world
; -----
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

; ----- (prg030.asm) -----
.macro STOP_MUSIC
    LDA #MUS1_STOPMUSIC
    STA Sound_QMusic1
.endmacro

; ----- (prg010.asm) -----
; RETURN_TO_WORLD_MUSIC
;
; When Map_Operation is in normal operation, this is called out to to get the music running again
; if it isn't already.
; -----
.macro RETURN_TO_WORLD_MUSIC
    .local PRG010_C3E3, PRG010_C3EA
    LDX World_Num       ; X = World_Num
    LDY World_BGM_Arrival,X ; Y = World_BGM_Arrival[X]

    CPX #$04
    BNE PRG010_C3E3     ; If X <> 4 (not on World 5), jump to PRG010_C3E3

    LDX Player_Current  ; X = Player_Current
    LDA World_Map_XHi,X
    BEQ PRG010_C3E3     ; If not on the high part of World 5, jump to PRG010_C3E3

    LDY #MUS2A_SKY      ; High part of World 5 uses alternate song
    JMP PRG010_C3EA     ; Jump to PRG010_C3EA

PRG010_C3E3:
    LDA Map_MusicBox_Cnt
    BEQ PRG010_C3EA     ; If Map_MusicBox_Cnt = 0 (music box not active), jump to PRG010_C3EA

    LDY #MUS2A_MUSICBOX  ; Otherwise, Y = $C (music box song)

PRG010_C3EA:
    LDA SndCur_Music2
    BNE PRG010_C3F2     ; If SndCur_Music2 <> 0 (a song from set 2 is playing), jump to PRG010_C3F2

    ; Otherwise, queue the requested song!
    STY Sound_QMusic2
.endmacro

; ----- (prg031.asm) -----
; RUN_SOUND_ENGINE
;
; This is the normal, every-frame callout to run the sound engine
; -----
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

; ----- (prg022.asm) -----
; RUN_SOUND_ENGINE_ROULETTE
;
; Stupid that we have to have two of these, but that's what stock did.
; For whatever reason, this only changes out page 28.
; -----
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
