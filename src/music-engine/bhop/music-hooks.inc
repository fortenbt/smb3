.ifndef __MUSIC_HOOKS_INC__
__MUSIC_HOOKS_INC__ = 1

.define TRACK_0 0

.macro SWAP_A000_TO_BHOP
    LDA #MMC3_8K_TO_PRG_A000    ; Changing PRG ROM at A000
    STA MMC3_COMMAND            ; Set MMC3 command
    LDA #<.bank(bhop_init)      ; Page 28
    STA MMC3_PAGE               ; Set MMC3 page
.endmacro

; (prg030.asm)
.macro SETUP_WORLD_MUSIC
    ; Get the MusicTrack pointer based on World_Num
    ldx World_Num ; index of the song
    lda World_BGM, x
    sta Sound_QMusic2
.endmacro

; (prg010.asm)
.macro RETURN_TO_WORLD_MUSIC
    .local end
    LDX World_Num       ; X = World_Num
    LDY World_BGM_Arrival,X ; Y = World_BGM_Arrival[X]
    LDA SndCur_Music2
    BNE end     ; If SndCur_Music2 <> 0 (a song from set 2 is playing), jump to PRG010_C3F2
    ; Otherwise, queue the requested song!
    STY Sound_QMusic2
end:
.endmacro

.macro STOP_MUSIC
    LDA #MUS1_STOPMUSIC
    STA Sound_QMusic1
.endmacro

; (prg031.asm)
.macro RUN_SOUND_ENGINE
    .importzp track_ptr
    .local done
    SWAP_A000_TO_BHOP
    JSR Sound_Engine_Process
    LDA track_ptr+1
    BNE done
    JSR bhop_play
done:
    JSR PRGROM_Change_Both
.endmacro

; (prg030.asm)
.macro EARLY_RESET_HOOK
    LDA #$5a
    STA Reset_Latch
    SWAP_A000_TO_BHOP
    jsr bhop_mute_all
    JSR PRGROM_Change_A000
.endmacro

; (prg022.asm)
.define RUN_SOUND_ENGINE_ROULETTE RUN_SOUND_ENGINE

.endif ; include guard
