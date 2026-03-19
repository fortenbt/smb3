.ifndef __MUSIC_HOOKS_INC__
__MUSIC_HOOKS_INC__ = 1

.macro SETUP_WORLD_MUSIC
    LDA #MMC3_8K_TO_PRG_A000    ; Changing PRG ROM at A000
    STA MMC3_COMMAND            ; Set MMC3 command
    LDA #<.bank(bhop_init)      ; Page 28
    STA MMC3_PAGE               ; Set MMC3 page
    lda #30
    jsr bhop_set_module_bank
    jsr bhop_apply_music_bank
    ldx #<MODULE_DOOM
    ldy #>MODULE_DOOM
    lda #0
    jsr bhop_init
    JSR PRGROM_Change_Both
.endmacro

.macro RUN_SOUND_ENGINE
    LDA #MMC3_8K_TO_PRG_A000    ; Changing PRG ROM at A000
    STA MMC3_COMMAND            ; Set MMC3 command
    LDA #<.bank(bhop_init)      ; Page 28
    STA MMC3_PAGE               ; Set MMC3 page
    JSR Sound_Engine_Process
    JSR bhop_play
    JSR PRGROM_Change_Both
.endmacro

.define RUN_SOUND_ENGINE_ROULETTE RUN_SOUND_ENGINE

.endif ; include guard
