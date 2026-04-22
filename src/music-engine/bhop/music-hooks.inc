.ifndef __MUSIC_HOOKS_INC__
__MUSIC_HOOKS_INC__ = 1

.macro SWAP_A000_TO_SYM sym
    LDA #MMC3_8K_TO_PRG_A000    ; Changing PRG ROM at A000
    STA MMC3_COMMAND            ; Set MMC3 command
    LDA #<.bank(sym)            ; Page of sym
    STA MMC3_PAGE               ; Set MMC3 page
.endmacro

.macro CheckEngine sym
    LDA Cur_Music_Engine    ; Cur_Music_Engine of 0 is the stock music engine
    BEQ sym
.endmacro

; (prg030.asm)
.macro SETUP_WORLD_MUSIC
    .local stock, bhop, done
    CheckEngine stock
bhop:
    ; Get the MusicTrack pointer based on World_Num
    ldx World_Num ; index of the song
    lda World_BGM, x
    sta Sound_QMusic2
    jmp done
stock:
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
done:
.endmacro

; (prg010.asm)
.macro RETURN_TO_WORLD_MUSIC
    .local stock, bhop, done
    CheckEngine stock
bhop:
    LDX World_Num       ; X = World_Num
    LDY World_BGM_Arrival,X ; Y = World_BGM_Arrival[X]
    LDA SndCur_Music2
    BNE done     ; If SndCur_Music2 <> 0 (a song from set 2 is playing), jump to PRG010_C3F2
    ; Otherwise, queue the requested song!
    STY Sound_QMusic2
    BEQ done     ; done processing BHOP music engine, branch always
stock:
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
done:
.endmacro

.macro STOP_MUSIC
    LDA #MUS1_STOPMUSIC
    STA Sound_QMusic1
.endmacro

; (prg031.asm)
.macro RUN_SOUND_ENGINE
    .importzp track_ptr
    .local stock, bhop, done
    CheckEngine stock
bhop:
    SWAP_A000_TO_SYM Sound_Engine_Process
    JSR Sound_Engine_Process
    LDA track_ptr+1         ; track_ptr is set nonzero when we want to stop playing
    BNE done
    JSR bhop_play
    JMP done
stock:
    ; *** Bring the sound engine (page 28 and page 29) into ROM
    LDA #MMC3_8K_TO_PRG_C000    ; Changing PRG ROM at C000
    STA MMC3_COMMAND        ; Set MMC3 command
    LDA #29             ; Page 29
    STA MMC3_PAGE           ; Set MMC3 page

    SWAP_A000_TO_SYM Sound_Engine_Begin
    JSR Sound_Engine_Begin
done:
    JSR PRGROM_Change_Both
.endmacro

; (prg030.asm)
.macro EARLY_RESET_HOOK
    LDA #$5a
    STA Reset_Latch
    SWAP_A000_TO_SYM bhop_mute_all
    jsr bhop_mute_all
    JSR PRGROM_Change_A000
.endmacro

; (prg022.asm)
.define RUN_SOUND_ENGINE_ROULETTE RUN_SOUND_ENGINE

; (prg012.asm)
.macro CHECK_FOR_BHOP_MUSIC
    LDX World_Num
    LDY #WorldMeta::MusicEngine
    LDA World_Metadata+1,Y  ; high byte
    PHA                     ; save high byte to stack
    LDA World_Metadata,Y    ; low byte into A

    CPX #8
    BCC @check_low
    PLA                     ; pull high byte into A
    LSR A                   ; bit 0 -> carry
    JMP @done

@check_low:
@loop:
    CPX #0
    BEQ @result
    LSR A
    DEX
    JMP @loop

@result:
    LSR A                   ; final shift, target bit -> carry
    PLA                     ; discard high byte, carry unaffected

@done:
    ; Result: Carry set = bit is set, Carry clear = bit is not set
    BCC @exit
    INC Cur_Music_Engine
@exit:
.endmacro

.endif ; include guard
