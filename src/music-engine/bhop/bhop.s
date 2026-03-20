.autoimport +

_BHOP_ZP_START_ = $11 ; See ram_zp.s where we use BHOP_RSRV_ZP
bhop_ptr = _BHOP_ZP_START_
pattern_ptr = _BHOP_ZP_START_ + $2
channel_index = _BHOP_ZP_START_ + $4
scratch_byte = _BHOP_ZP_START_ + $5
track_ptr = _BHOP_ZP_START_ + $6
.exportzp track_ptr

.include "bhop/config.inc"
.if ::BHOP_ZSAW_ENABLED
.include "bhop/zsaw.asm"
.endif

BHOP_VER_MAJ = $00
BHOP_VER_MIN = $00

.include "smb3.inc"

.scope BHOP
.include "bhop/bhop_internal.inc"
.include "bhop/longbranch.inc"

.include "bhop/commands.asm"
.include "bhop/effects.asm"

; =====================================
; Allocator for PRGRAM space for BHOP
; =====================================
__PRGRAM_EXPD_OFFSET__ .set $1950 ; BHOP's reserved area starts after Tile_Mem (see ram_prg.s)
.macro BHPRGRAM name, size
    .if (__PRGRAM_EXPD_OFFSET__ + (size)) > ($1950 + $123) ; reserved size == $123 (see ram_prg.s)
        .error "BHOP PRGRAM overflow: name"
    .endif
    name = PRGRAM_BASE + __PRGRAM_EXPD_OFFSET__
    __PRGRAM_EXPD_OFFSET__ .set __PRGRAM_EXPD_OFFSET__ + (size)
.endmacro

	BHPRGRAM music_header_ptr, 2
	BHPRGRAM tempo_counter, 2
	BHPRGRAM tempo_cmp, 2
	BHPRGRAM tempo, 1
	BHPRGRAM row_counter, 1
	BHPRGRAM row_cmp, 1
	BHPRGRAM frame_counter, 1
	BHPRGRAM frame_cmp, 1

	BHPRGRAM module_flags, 1

.if ::BHOP_PATTERN_BANKING
	BHPRGRAM module_bank, 1
	BHPRGRAM current_music_bank, 1
.endif
	BHPRGRAM song_ptr, 2
	BHPRGRAM frame_ptr, 2

	BHPRGRAM shadow_pulse1_freq_hi, 1
	BHPRGRAM shadow_pulse2_freq_hi, 1


; channel state tables
	BHPRGRAM channel_pattern_ptr_low, BHOP::NUM_CHANNELS
	BHPRGRAM channel_pattern_ptr_high, BHOP::NUM_CHANNELS
.if ::BHOP_PATTERN_BANKING
	BHPRGRAM channel_pattern_bank, BHOP::NUM_CHANNELS
.endif
	BHPRGRAM channel_status, BHOP::NUM_CHANNELS
	BHPRGRAM channel_global_duration, BHOP::NUM_CHANNELS
	BHPRGRAM channel_row_delay_counter, BHOP::NUM_CHANNELS
	BHPRGRAM channel_base_note, BHOP::NUM_CHANNELS
	BHPRGRAM channel_relative_note_offset, BHOP::NUM_CHANNELS
	BHPRGRAM channel_base_frequency_low, BHOP::NUM_CHANNELS
	BHPRGRAM channel_base_frequency_high, BHOP::NUM_CHANNELS
	BHPRGRAM channel_relative_frequency_low, BHOP::NUM_CHANNELS
	BHPRGRAM channel_relative_frequency_high, BHOP::NUM_CHANNELS
	BHPRGRAM channel_detuned_frequency_low, BHOP::NUM_CHANNELS
	BHPRGRAM channel_detuned_frequency_high, BHOP::NUM_CHANNELS
	BHPRGRAM channel_volume, BHOP::NUM_CHANNELS
	BHPRGRAM channel_tremolo_volume, BHOP::NUM_CHANNELS
	BHPRGRAM channel_duty, BHOP::NUM_CHANNELS
	BHPRGRAM channel_instrument_volume, BHOP::NUM_CHANNELS
	BHPRGRAM channel_instrument_duty, BHOP::NUM_CHANNELS
	BHPRGRAM channel_selected_instrument, BHOP::NUM_CHANNELS
	BHPRGRAM channel_pitch_effects_active, BHOP::NUM_CHANNELS

	BHPRGRAM channel_volume_mode, BHOP::NUM_CHANNELS

; DPCM status
	BHPRGRAM dpcm_status, 1

; sequence state tables
	BHPRGRAM sequences_enabled, BHOP::NUM_CHANNELS
	BHPRGRAM sequences_active, BHOP::NUM_CHANNELS
	BHPRGRAM volume_sequence_ptr_low, BHOP::NUM_CHANNELS
	BHPRGRAM volume_sequence_ptr_high, BHOP::NUM_CHANNELS
	BHPRGRAM volume_sequence_index, BHOP::NUM_CHANNELS
	BHPRGRAM arpeggio_sequence_ptr_low, BHOP::NUM_CHANNELS
	BHPRGRAM arpeggio_sequence_ptr_high, BHOP::NUM_CHANNELS
	BHPRGRAM arpeggio_sequence_index, BHOP::NUM_CHANNELS
	BHPRGRAM pitch_sequence_ptr_low, BHOP::NUM_CHANNELS
	BHPRGRAM pitch_sequence_ptr_high, BHOP::NUM_CHANNELS
	BHPRGRAM pitch_sequence_index, BHOP::NUM_CHANNELS
	BHPRGRAM hipitch_sequence_ptr_low, BHOP::NUM_CHANNELS
	BHPRGRAM hipitch_sequence_ptr_high, BHOP::NUM_CHANNELS
	BHPRGRAM hipitch_sequence_index, BHOP::NUM_CHANNELS
	BHPRGRAM duty_sequence_ptr_low, BHOP::NUM_CHANNELS
	BHPRGRAM duty_sequence_ptr_high, BHOP::NUM_CHANNELS
	BHPRGRAM duty_sequence_index, BHOP::NUM_CHANNELS

; memory for various effects
	BHPRGRAM effect_note_delay, BHOP::NUM_CHANNELS
	BHPRGRAM effect_cut_delay, BHOP::NUM_CHANNELS
.if ::BHOP_DELAYED_RELEASE_ENABLED
	BHPRGRAM effect_release_delay, BHOP::NUM_CHANNELS
.endif
	BHPRGRAM effect_skip_target, 1

; Oxx
	BHPRGRAM groove_index, 1
	BHPRGRAM groove_position, 1

; Wxx
	BHPRGRAM effect_dpcm_pitch, 1

; Xxx
	BHPRGRAM effect_retrigger_period, 1
	BHPRGRAM effect_retrigger_counter, 1

; Yxx
	BHPRGRAM effect_dpcm_offset, 1

; Zxx
	BHPRGRAM effect_dac_buffer, 1

	BHPRGRAM channel_vibrato_settings, BHOP::NUM_CHANNELS
	BHPRGRAM channel_vibrato_accumulator, BHOP::NUM_CHANNELS
	BHPRGRAM channel_tuning, BHOP::NUM_CHANNELS
	BHPRGRAM channel_arpeggio_settings, BHOP::NUM_CHANNELS
	BHPRGRAM channel_arpeggio_counter, BHOP::NUM_CHANNELS
	BHPRGRAM channel_pitch_effect_settings, BHOP::NUM_CHANNELS
	BHPRGRAM channel_tremolo_settings, BHOP::NUM_CHANNELS
	BHPRGRAM channel_tremolo_accumulator, BHOP::NUM_CHANNELS
	BHPRGRAM channel_volume_slide_settings, BHOP::NUM_CHANNELS
	BHPRGRAM channel_volume_slide_accumulator, BHOP::NUM_CHANNELS

	BHPRGRAM scratch_target_frequency, 2


.segment BHOP_PLAYER_SEGMENT
; global
.export bhop_init, bhop_play, bhop_mute_channel, bhop_unmute_channel, bhop_set_module_bank, bhop_set_expansion_flags
.export bhop_unmute_all, bhop_mute_all

.include "bhop/midi_lut.inc"

.macro prepare_ptr address
        lda address
        sta bhop_ptr
        lda address+1
        sta bhop_ptr+1
.endmacro

.macro prepare_ptr_with_fixed_offset address, offset
        prepare_ptr address
        ldy #offset
        lda (bhop_ptr), y
        pha
        iny
        lda (bhop_ptr), y
        sta bhop_ptr+1
        pla
        sta bhop_ptr
.endmacro

; add a signed byte, stored in value, to a 16bit word
; addressed by (bhop_ptr), y
; this is used in a few places, notably pitch bend effects
; clobbers a, flags
; does *not* clobber y
.macro sadd16_ptr_y ptr, value
.scope
        ; handle the low byte normally
        clc
        lda value
        adc (ptr), y
        sta (ptr), y
        iny
        ; sign-extend the high bit into the high byte
        lda value
        and #$80 ;extract the high bit
        beq positive
        lda #$FF ; the high bit was high, so set high byte to 0xFF, then add that plus carry
        ; note: unless a signed overflow occurred, carry will usually be *set* in this case
positive:
        ; the high bit was low; a contains #$00, so add that plus carry
        adc (ptr), y
        sta (ptr), y
        dey
.endscope
.endmacro

.proc bhop_set_module_bank
.if ::BHOP_PATTERN_BANKING
        sta module_bank
.endif
        rts
.endproc


; param:    expansion audio flags of module (a)
;           format is the same as NSF expansion audio flags    
.proc bhop_set_expansion_flags
.if ::BHOP_MULTICHIP
        sta expansion_flags
.endif
        rts
.endproc

; param: song index (a)
;        Low byte pointer to the music data (x)
;        High byte pointer to the music data (y)
.proc bhop_init
        ; preserve parameters
        pha ; song index

        ; initialize bhop_ptr with the song header
        stx music_header_ptr
        sty music_header_ptr+1

.if ::BHOP_PATTERN_BANKING
        lda module_bank
        sta current_music_bank
        jsr BHOP_PATTERN_SWITCH_ROUTINE
.endif

        ; global initialization things
        lda #00
        sta tempo_counter
        sta tempo_counter+1
        sta row_counter
        sta frame_counter
        sta groove_index

        ; switch to the requested song
        prepare_ptr_with_fixed_offset music_header_ptr, FtModuleHeader::song_list

        pla
        asl ; song list is made of words
        tay
        lda (bhop_ptr), y
        sta song_ptr
        iny
        lda (bhop_ptr), y
        sta song_ptr+1

.if ::BHOP_PATTERN_BANKING
        ; load the module flags from the header before changing the pointer
        prepare_ptr music_header_ptr
        ldy #FtModuleHeader::flags
        lda (bhop_ptr), y
        sta module_flags
.endif

        ; load speed and tempo from the requested song
        prepare_ptr song_ptr
        ldy #SongInfo::speed
        lda (bhop_ptr), y
        beq song_uses_groove
song_uses_speed:
        tax
        jsr set_speed
song_uses_groove:
        ldy #SongInfo::groove_position
        lda (bhop_ptr), y
        sta groove_index
        sta groove_position
        ldy #SongInfo::tempo
        lda (bhop_ptr), y
        sta tempo
        ldy #SongInfo::frame_count
        lda (bhop_ptr), y
        sta frame_cmp
        ldy #SongInfo::pattern_length
        lda (bhop_ptr), y
        sta row_cmp

        ; If this song has grooves enabled, then apply the first groove right away
        jsr update_groove
        ; Now, to work around an off-by-one startup condition with when advance_pattern_rows
        ; gets called for the first time, reset the groove position
        lda groove_index
        sta groove_position

        ; initialize at the first frame, and prime our pattern pointers
        ldx #0
        jsr jump_to_frame
        jsr load_frame_patterns

        ; initialize every channel's volume to 15 (some songs seem to rely on this)
        lda #$0F
        sta channel_volume + PULSE_1_INDEX
        sta channel_volume + PULSE_2_INDEX
        sta channel_volume + TRIANGLE_INDEX
        sta channel_volume + NOISE_INDEX
        .if ::BHOP_ZSAW_ENABLED
        sta channel_volume + ZSAW_INDEX
        .endif
        .if ::BHOP_MMC5_ENABLED
        lda #$0F
        sta channel_volume + MMC5_PULSE_1_INDEX
        sta channel_volume + MMC5_PULSE_2_INDEX
        .endif
        .if ::BHOP_VRC6_ENABLED
        lda #$0F
        sta channel_volume + VRC6_PULSE_1_INDEX
        sta channel_volume + VRC6_PULSE_2_INDEX
        lda #$3F
        sta channel_volume + VRC6_SAWTOOTH_INDEX
        .endif

        ; disable any active effects
        lda #0
        sta channel_pitch_effects_active + PULSE_1_INDEX
        sta channel_pitch_effects_active + PULSE_2_INDEX
        sta channel_pitch_effects_active + TRIANGLE_INDEX
        sta channel_pitch_effects_active + NOISE_INDEX
        sta channel_pitch_effects_active + DPCM_INDEX
        .if ::BHOP_ZSAW_ENABLED
        sta channel_pitch_effects_active + ZSAW_INDEX
        .endif
        .if ::BHOP_MMC5_ENABLED
        sta channel_pitch_effects_active + MMC5_PULSE_1_INDEX
        sta channel_pitch_effects_active + MMC5_PULSE_2_INDEX
        .endif
        .if ::BHOP_VRC6_ENABLED
        sta channel_pitch_effects_active + VRC6_PULSE_1_INDEX
        sta channel_pitch_effects_active + VRC6_PULSE_2_INDEX
        sta channel_pitch_effects_active + VRC6_SAWTOOTH_INDEX
        .endif

        ; reset every channel's status
        lda #(CHANNEL_MUTED)
        sta channel_status + PULSE_1_INDEX
        sta channel_status + PULSE_2_INDEX
        sta channel_status + TRIANGLE_INDEX
        sta channel_status + NOISE_INDEX
        sta channel_status + DPCM_INDEX
        .if ::BHOP_ZSAW_ENABLED
        sta channel_status + ZSAW_INDEX
        .endif
        .if ::BHOP_MMC5_ENABLED
        sta channel_status + MMC5_PULSE_1_INDEX
        sta channel_status + MMC5_PULSE_2_INDEX
        .endif
        .if ::BHOP_VRC6_ENABLED
        sta channel_status + VRC6_PULSE_1_INDEX
        sta channel_status + VRC6_PULSE_2_INDEX
        sta channel_status + VRC6_SAWTOOTH_INDEX
        .endif
        
        ; reset DPCM status
        lda #$FF
        sta effect_dac_buffer

        ; DPCM is disabled by default
        lda #0
        sta dpcm_status

        ; clear out special effects
        lda #0
        ldx #NUM_CHANNELS
effect_init_loop:
        dex
        sta effect_note_delay, x
        sta sequences_enabled, x
        sta sequences_active, x
        sta channel_tuning, x
        sta channel_vibrato_settings, x
        sta channel_vibrato_accumulator, x
        sta channel_volume_slide_settings, x
        sta channel_tremolo_settings, x
        sta channel_duty, x
        bne effect_init_loop

        sta effect_skip_target
        sta effect_dpcm_offset

        sta effect_retrigger_period
        sta effect_retrigger_counter

        ; initialize registers

        ; if using virtual Z channels, enable by default
        .if ::BHOP_ZSAW_ENABLED
        ; if Z-Saw happens to be playing, silence it
        jsr zsaw_silence
        ; Now fully re-initialize Z-Saw just in case
        jsr zsaw_init
        jsr zsaw_enable
        .endif

        .if ::BHOP_ZPCM_ENABLED
        jsr zpcm_enable
        .endif

        jsr init_2a03

.if ::BHOP_MMC5_ENABLED
        jsr init_mmc5
.endif

.if ::BHOP_VRC6_ENABLED
        jsr init_vrc6
.endif

        ; enable any expansion audio chips here, if they can be disabled
        .if ::BHOP_VRC6_ENABLED
        jsr bhop_vrc6_init
        .endif

        rts
.endproc

; speed goes in x
.proc set_speed
        st16 tempo_cmp, $0000
loop:
        clc
        add16 tempo_cmp, #150
        dex
        bne loop
        rts
.endproc

.proc update_groove
        lda groove_index
        beq done

        prepare_ptr_with_fixed_offset music_header_ptr, FtModuleHeader::groove_list

        ldy groove_position
        lda (bhop_ptr), y
        bne apply_groove
reached_end_of_groove:
        ldy groove_index
        lda (bhop_ptr), y
apply_groove:
        iny
        sty groove_position
        tax
        jsr set_speed

done:
        rts
.endproc

; frame number goes in x
.proc jump_to_frame
        ; load the frame pointer list from the song data; we're going to rewrite
        ; frame_ptr here anyway, so use it as temp storage
        prepare_ptr song_ptr
        ldy #SongInfo::frame_list_ptr
        lda (bhop_ptr), y
        sta frame_ptr
        iny
        lda (bhop_ptr), y
        sta frame_ptr+1
        ; now add our target frame number to that
        txa
        clc
        add16a frame_ptr
        ; twice
        txa
        clc
        add16a frame_ptr
        ; now use this to load the actual frame pointer from the list
        prepare_ptr frame_ptr
        ldy #0
        lda (bhop_ptr), y
        sta frame_ptr
        iny
        lda (bhop_ptr), y
        sta frame_ptr+1
        rts
.endproc

.proc load_frame_patterns
        ;initialize all the pattern rows from the current frame pointer
        prepare_ptr frame_ptr
        ldy #0

        ; Pulse 1
        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+PULSE_1_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+PULSE_1_INDEX
        iny

        ; Pulse 2
        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+PULSE_2_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+PULSE_2_INDEX
        iny

        ; Triangle
        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+TRIANGLE_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+TRIANGLE_INDEX
        iny

        ; Noise
        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+NOISE_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+NOISE_INDEX
        iny

        .if ::BHOP_ZSAW_ENABLED
        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+ZSAW_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+ZSAW_INDEX
        iny
        .endif

        .if ::BHOP_MMC5_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_MMC5
            beq skip_mmc5
            .endif
        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+MMC5_PULSE_1_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+MMC5_PULSE_1_INDEX
        iny

        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+MMC5_PULSE_2_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+MMC5_PULSE_2_INDEX
        iny
            .if ::BHOP_MULTICHIP
skip_mmc5:
            .endif
        .endif

        .if ::BHOP_VRC6_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6
            .endif
        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+VRC6_PULSE_1_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+VRC6_PULSE_1_INDEX
        iny

        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+VRC6_PULSE_2_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+VRC6_PULSE_2_INDEX
        iny

        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+VRC6_SAWTOOTH_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+VRC6_SAWTOOTH_INDEX
        iny
            .if ::BHOP_MULTICHIP
skip_vrc6:
            .endif
        .endif

        .if ::BHOP_N163_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_N163
            beq skip_n163
            .endif
        ; TODO: implement N163
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
            .if ::BHOP_MULTICHIP
skip_n163:
            .endif
        .endif

        .if ::BHOP_FDS_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_FDS
            beq skip_fds
            .endif
        ; TODO: implement FDS
        iny
        iny
            .if ::BHOP_MULTICHIP
skip_fds:
            .endif
        .endif

        .if ::BHOP_S5B_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_S5B
            beq skip_s5b
            .endif
        ; TODO: implement S5B
        iny
        iny
        iny
        iny
        iny
        iny
            .if ::BHOP_MULTICHIP
skip_s5b:
            .endif
        .endif

        .if ::BHOP_VRC7_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC7
            beq skip_vrc7
            .endif
        ; TODO: implement VRC7
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
            .if ::BHOP_MULTICHIP
skip_vrc7:
            .endif
        .endif

        ; DPCM
        lda (bhop_ptr), y
        sta channel_pattern_ptr_low+DPCM_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_ptr_high+DPCM_INDEX
        iny

.if ::BHOP_PATTERN_BANKING
        lda module_flags
        and #MODULE_FLAGS_PATTERN_BANKING
        beq banking_not_enabled

        lda (bhop_ptr), y
        sta channel_pattern_bank+PULSE_1_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_bank+PULSE_2_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_bank+TRIANGLE_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_bank+NOISE_INDEX
        iny

        .if ::BHOP_ZSAW_ENABLED
        lda (bhop_ptr), y
        sta channel_pattern_bank+ZSAW_INDEX
        iny
        .endif

        .if ::BHOP_MMC5_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_MMC5
            beq skip_mmc5_bank
            .endif
        lda (bhop_ptr), y
        sta channel_pattern_bank+MMC5_PULSE_1_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_bank+MMC5_PULSE_2_INDEX
        iny
            .if ::BHOP_MULTICHIP
skip_mmc5_bank:
            .endif
        .endif

        .if ::BHOP_VRC6_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6_bank
            .endif
        lda (bhop_ptr), y
        sta channel_pattern_bank+VRC6_PULSE_1_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_bank+VRC6_PULSE_2_INDEX
        iny
        lda (bhop_ptr), y
        sta channel_pattern_bank+VRC6_SAWTOOTH_INDEX
        iny
            .if ::BHOP_MULTICHIP
skip_vrc6_bank:
            .endif
        .endif

        .if ::BHOP_N163_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_N163
            beq skip_n163_bank
            .endif
        ; TODO: implement N163
        iny
        iny
        iny
        iny
        iny
        iny
        iny
        iny
            .if ::BHOP_MULTICHIP
skip_n163_bank:
            .endif
        .endif

        .if ::BHOP_FDS_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_FDS
            beq skip_fds_bank
            .endif
        ; TODO: implement FDS
        iny
            .if ::BHOP_MULTICHIP
skip_fds_bank:
            .endif
        .endif

        .if ::BHOP_S5B_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_S5B
            beq skip_s5b_bank
            .endif
        ; TODO: implement S5B
        iny
        iny
        iny
            .if ::BHOP_MULTICHIP
skip_s5b_bank:
            .endif
        .endif

        .if ::BHOP_VRC7_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC7
            beq skip_vrc7_bank
            .endif
        ; TODO: implement VRC7
        iny
        iny
        iny
        iny
        iny
        iny
            .if ::BHOP_MULTICHIP
skip_vrc7_bank:
            .endif
        .endif

        lda (bhop_ptr), y
        sta channel_pattern_bank+DPCM_INDEX
        iny
        jmp done_with_banks
banking_not_enabled:
        ; this song doesn't use pattern banking, so it doesn't have valid bank
        ; data here. Default all patterns to the module bank instead.
        lda module_bank
        sta channel_pattern_bank + PULSE_1_INDEX
        sta channel_pattern_bank + PULSE_2_INDEX
        sta channel_pattern_bank + TRIANGLE_INDEX
        sta channel_pattern_bank + NOISE_INDEX

        .if ::BHOP_ZSAW_ENABLED
        sta channel_pattern_bank + ZSAW_INDEX
        .endif

        .if ::BHOP_MMC5_ENABLED
            .if ::BHOP_MULTICHIP
            pha
            lda expansion_flags
            and #EXPANSION_MMC5
            beq skip_mmc5_bank_disable
            pla
            .endif
        sta channel_pattern_bank + MMC5_PULSE_1_INDEX
        sta channel_pattern_bank + MMC5_PULSE_2_INDEX
            .if ::BHOP_MULTICHIP
            jmp done_mmc5_bank_disable
skip_mmc5_bank_disable:
            pla
done_mmc5_bank_disable:
            .endif
        .endif

        .if ::BHOP_VRC6_ENABLED
            .if ::BHOP_MULTICHIP
            pha
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6_bank_disable
            pla
            .endif
        sta channel_pattern_bank + VRC6_PULSE_1_INDEX
        sta channel_pattern_bank + VRC6_PULSE_2_INDEX
        sta channel_pattern_bank + VRC6_SAWTOOTH_INDEX
            .if ::BHOP_MULTICHIP
            jmp done_vrc6_bank_disable
skip_vrc6_bank_disable:
            pla
done_vrc6_bank_disable:
            .endif
        .endif

        sta channel_pattern_bank + DPCM_INDEX
done_with_banks:
.endif

        ; reset all the row counters to 0
        lda #0
        sta channel_row_delay_counter + PULSE_1_INDEX
        sta channel_row_delay_counter + PULSE_2_INDEX
        sta channel_row_delay_counter + TRIANGLE_INDEX
        sta channel_row_delay_counter + NOISE_INDEX

        .if ::BHOP_ZSAW_ENABLED
        sta channel_row_delay_counter + ZSAW_INDEX
        .endif

        .if ::BHOP_MMC5_ENABLED
            .if ::BHOP_MULTICHIP
            pha
            lda expansion_flags
            and #EXPANSION_MMC5
            beq skip_mmc5_row_reset
            pla
            .endif
        sta channel_row_delay_counter + MMC5_PULSE_1_INDEX
        sta channel_row_delay_counter + MMC5_PULSE_2_INDEX
            .if ::BHOP_MULTICHIP
            jmp done_mmc5_row_reset
skip_mmc5_row_reset:
            pla
done_mmc5_row_reset:
            .endif
        .endif

        .if ::BHOP_VRC6_ENABLED
            .if ::BHOP_MULTICHIP
            pha
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6_row_reset
            pla
            .endif
        sta channel_row_delay_counter + VRC6_PULSE_1_INDEX
        sta channel_row_delay_counter + VRC6_PULSE_2_INDEX
        sta channel_row_delay_counter + VRC6_SAWTOOTH_INDEX
            .if ::BHOP_MULTICHIP
            jmp done_vrc6_row_reset
skip_vrc6_row_reset:
            pla
done_vrc6_row_reset:
            .endif
        .endif

        sta channel_row_delay_counter + DPCM_INDEX

        rts
.endproc

.proc tick_frame_counter
        clc
        add16 tempo_counter, tempo
        ; have we exceeded the tempo_counter?
        lda tempo_counter+1
        cmp tempo_cmp+1
        bcc done_advancing_rows ; counter is lower than threshold (high byte)
        bne advance_row  ; should be impossible to take, because we only add 255 or less?
        lda tempo_counter
        cmp tempo_cmp
        bcc done_advancing_rows
        ; is either the same or higher; do the thing
advance_row:
        ; Dxx command processing: do we have a skip requested?
        lda effect_skip_target
        beq no_skip_requested
        ; we'll skip right away, so advance the frame pointer and load
        ; the next frame:
        jsr advance_frame
        lda #0
        sta row_counter
        dec effect_skip_target
        ; if the target is 00 at this point, we're done with the Dxx effect.
        ; Process the next row normally.
        beq no_frame_advance
        ; Otherwise, we now need to continually skip entire rows in a loop
dxx_loop:
        jsr skip_pattern_rows
        inc row_counter
        dec effect_skip_target
        bne dxx_loop
        ; now, finally we are done with the dxx command. Process the next
        ; row normally:
        jmp no_frame_advance

no_skip_requested:
        ; first off, have we reached the end of this pattern?
        ; if so, advance to the next frame here:
        lda row_counter
        cmp row_cmp
        bcc no_frame_advance
        jsr advance_frame
        lda #0
        sta row_counter
no_frame_advance:
        ; subtract tempo_cmp from tempo_counter
        sec
        lda tempo_counter
        sbc tempo_cmp
        sta tempo_counter
        lda tempo_counter+1
        sbc tempo_cmp+1
        sta tempo_counter+1
        ; process the bytecode for the next pattern row
        jsr advance_pattern_rows
        ; advance the row counter *after* running the bytecode
        inc row_counter
done_advancing_rows:
        rts
.endproc

; prep:
; - channel_index is set to desired channel
.proc advance_channel_row
        ; see CChannelHandler::PlayNote() in Dn-FT
        ; check first if we still have lingering delay from the previous row
        ldx channel_index
        lda effect_note_delay, x
        beq skip_handle_delay
        ; see CChannelHandler::HandleDelay() in Dn-FT
        ; if so, advance one row to sync
        lda #0
        sta effect_note_delay, x
        jsr advance_channel_row
skip_handle_delay:
        ldx channel_index ; the recursive call may have clobbered X
        lda channel_row_delay_counter, x
        cmp #0
        jne skip

.if ::BHOP_PATTERN_BANKING
        ; swap in the bank this pattern data lives in
        lda channel_pattern_bank, x
        switch_music_bank
        ; that clobbered all registers, so reload X before continuing
        ldx channel_index
.endif

        ; prep the pattern pointer for reading
        lda channel_pattern_ptr_low, x
        sta pattern_ptr
        lda channel_pattern_ptr_high, x
        sta pattern_ptr+1

        ; implementation note: x now holds channel_index, and lots of this code
        ; assumes it will not be clobbered. Take care when refactoring.

        ; continue reading bytecode, processing one command at a time,
        ; until a note is encountered. Any note command breaks out of the loop and
        ; signals the end of processing for this row.
bytecode_loop:
        fetch_pattern_byte
        cmp #0 ; needed to set negative flag based on command byte currently in a
        bpl handle_note ; if the high bit is clear, this is some kind of note
        tay ; preserve
        ; check for quick commands
        and #$F0
        cmp #$F0
        beq quick_volume_change
        cmp #$E0
        beq quick_instrument_change
process_extended_command:
        ; it's a *proper* command, restore the full command byte
        tya
        ; now use that to jump into the command procesisng table
        jsr dispatch_command

        ; did we activate a Gxx command? If we did, EXIT NOW.
        ; Do NOT pass Go, do NOT collect $200
        ; [ORANGE] This is broken in cases where multiple notes were meant to be delayed back-to-back
        ldx channel_index ; un-clobber, since we don't know what dispatch_command did to x
        lda effect_note_delay, x
        beq no_note_delay
        jmp cleanup_channel_ptr
no_note_delay:
        jmp bytecode_loop

quick_volume_change:
        tya ; un-preserve
        and #$0F ; a now contains new channel volume
        sta channel_volume, x
        ; ready to process the next bytecode
        jmp bytecode_loop

quick_instrument_change:
        tya ; un-preserve
        and #$0F ; a now contains instrument index
        sta channel_selected_instrument, x

.if ::BHOP_PATTERN_BANKING
        ; Instruments live in the module bank, so we need to swap that in before processing them
        lda module_bank
        switch_music_bank
.endif
        jsr load_instrument
.if ::BHOP_PATTERN_BANKING
        ; And now we need to switch back to the pattern bank before continuing
        ldx channel_index
        lda channel_pattern_bank, x
        switch_music_bank
        ldx channel_index ; un-clobber
.endif
        ; ready to process the next bytecode
        jmp bytecode_loop

handle_note:
        cmp #$00 ; note rest
        jeq done_with_bytecode
        cmp #$7F ; note off
        bne check_release
        ; a note off immediately mutes the channel
        lda channel_status, x
        ora #CHANNEL_MUTED
        sta channel_status, x
        ; we also clear the delayed cut/release; this *is* a cut, it wins
        lda #0
        sta effect_cut_delay, x
.if ::BHOP_DELAYED_RELEASE_ENABLED
        sta effect_release_delay, x
.endif
        jmp done_with_bytecode
check_release:
        cmp #$7E
        bne note_trigger
        lda channel_status, x
        ora #CHANNEL_RELEASED
        sta channel_status, x
.if ::BHOP_PATTERN_BANKING
        ; Instruments live in the module bank, so we need to swap that in before processing them
        lda module_bank
        switch_music_bank
.endif      
        jsr apply_release
.if ::BHOP_PATTERN_BANKING
        ; And now we need to switch back to the pattern bank before continuing
        ldx channel_index
        lda channel_pattern_bank, x
        switch_music_bank
        ldx channel_index ; un-clobber
.endif
.if ::BHOP_DELAYED_RELEASE_ENABLED
        ; clear delayed release if any
        lda #0
        sta effect_release_delay, x
.endif
        jmp done_with_bytecode
note_trigger:
        ; a contains the selected note at this point
        sta channel_base_note, x
        ; use a to read the LUT and apply base_frequency
        jsr set_channel_base_frequency

        ; if portamento is active AND we are not currently muted,
        ; then skip writing the relative frequency

        lda channel_status, x
        and #CHANNEL_MUTED
        bne write_relative_frequency

        lda channel_pitch_effects_active, x
        and #PITCH_EFFECT_PORTAMENTO
        bne portamento_active

write_relative_frequency:
        lda channel_base_frequency_low, x
        sta channel_relative_frequency_low, x
        lda channel_base_frequency_high, x
        sta channel_relative_frequency_high, x

        .if ::BHOP_ZSAW_ENABLED
        ; for Z-Saw only, we initialize the relative frequency here as a note index,
        ; since it does not do pitch bends

        cpx #ZSAW_INDEX
        bne portamento_active
        lda channel_base_note, x
        sta zsaw_relative_note
        .endif

portamento_active:
        ; if we have a delayed note cut queued up, cancel it. A new note takes priority,
        ; and we don't want the unexpired cut to silence it inappropriately.
        lda channel_status, x
        and #CHANNEL_FRESH_DELAYED_CUT
        bne preserve_fresh_cut
        lda #0
        sta effect_cut_delay, x
preserve_fresh_cut:
.if ::BHOP_DELAYED_RELEASE_ENABLED
        ; ditto with delayed release
        lda channel_status, x
        and #CHANNEL_FRESH_DELAYED_RELEASE
        bne preserve_release_delay
        lda #0
        sta effect_release_delay, x
preserve_release_delay:
.endif
        ; finally, set the channel status as triggered
        ; (this will be cleared after effects are processed)
        lda channel_status, x
        ora #CHANNEL_TRIGGERED
        ; also, un-mute  and un-release the channel
        and #($FF - (CHANNEL_MUTED | CHANNEL_RELEASED))
        sta channel_status, x
        cpx #DPCM_INDEX
        bne skip_sample_trigger
        ; see CDPCMChan::triggerSample() in Dn-FT
        jsr trigger_sample
        jsr queue_sample
skip_sample_trigger:
        ; reset the instrument envelopes to the beginning
        jsr reset_instrument ; clobbers a, y
        ; reset the instrument volume to 0xF (if this instrument has a volume
        ; sequence, this will be immediately overwritten with the first element)
        lda #$F
        sta channel_instrument_volume, x
        lda #0
        sta channel_volume_mode, x
        ; reset the instrument duty to the channel_duty (again, this will usually
        ; be overwritten by the instrument sequence)
        lda channel_duty, x
        sta channel_instrument_duty, x
        ; fall through to done_with_bytecode
done_with_bytecode:
        ; If we're still in global duration mode at this point,
        ; apply that to the row counter
        ldx channel_index
        lda channel_status, x
        and #CHANNEL_GLOBAL_DURATION
        beq read_duration_from_pattern

        lda channel_global_duration, x
        sta channel_row_delay_counter, x
        jmp cleanup_channel_ptr

read_duration_from_pattern:
        fetch_pattern_byte ; does not clobber x
        sta channel_row_delay_counter, x
        ; fall through to channel_cleanup_ptr
cleanup_channel_ptr:
        ; preserve pattern_ptr back to the channel status
        ldx channel_index
        lda pattern_ptr
        sta channel_pattern_ptr_low, x
        lda pattern_ptr+1
        sta channel_pattern_ptr_high, x

        ; finally done with this channel
        jmp done
skip:
        ; conveniently carry is already set
        ; a contains the counter
        sbc #1 ; decrement that counter
        sta channel_row_delay_counter, x
done:
        rts
.endproc

; if for whatever reason (usually Dxx with xx >= 0) we need to skip a channel
; row and *not* apply *any* of the bytecode, this is the way to go. Note that we
; still need to process the bytecode mostly normally, and apply duration changes
; and whatnot.
.proc skip_channel_row
        ldx channel_index
        lda channel_row_delay_counter, x
        cmp #0
        jne skip

        ; prep the pattern pointer for reading
        lda channel_pattern_ptr_low, x
        sta pattern_ptr
        lda channel_pattern_ptr_high, x
        sta pattern_ptr+1

        ; implementation note: x now holds channel_index, and lots of this code
        ; assumes it will not be clobbered. Take care when refactoring.

        ; continue reading bytecode, processing one command at a time,
        ; until a note is encountered. Any note command breaks out of the loop and
        ; signals the end of processing for this row.
bytecode_loop:
        fetch_pattern_byte
        cmp #0 ; needed to set negative flag based on command byte currently in a
        bpl handle_note ; if the high bit is clear, this is some kind of note
        tay ; preserve
        ; check for quick commands
        and #$F0
        cmp #$F0
        beq quick_volume_change
        cmp #$E0
        beq quick_instrument_change
process_extended_command:
        ; it's a *proper* command, restore the full command byte
        tya
        ; instead of applying the command, we just need to skip over it; unfortunately
        ; not all commands have a parameter byte, so we need to handle special cases. Note
        ; that the global duration affecting commands will NOT be skipped here!
        jsr skip_command
        ; note that we ignore Gxx commands, which means unlike the main loop above, we
        ; don't need to check if we enabled them here. (We didn't.)
        jmp bytecode_loop

quick_volume_change:
        ; do nothing
        jmp bytecode_loop

quick_instrument_change:
        ; also do nothing
        jmp bytecode_loop

handle_note:
        ; we don't care what kind of note this is, we're ignoring it. Proceed to be done
        ; processing bytecode for this row.
done_with_bytecode:
        ; If we're still in global duration mode at this point,
        ; apply that to the row counter
        ldx channel_index
        lda channel_status, x
        and #CHANNEL_GLOBAL_DURATION
        beq read_duration_from_pattern

        lda channel_global_duration, x
        sta channel_row_delay_counter, x
        jmp cleanup_channel_ptr

read_duration_from_pattern:
        fetch_pattern_byte ; does not clobber x
        sta channel_row_delay_counter, x
        ; fall through to channel_cleanup_ptr
cleanup_channel_ptr:
        ; preserve pattern_ptr back to the channel status
        ldx channel_index
        lda pattern_ptr
        sta channel_pattern_ptr_low, x
        lda pattern_ptr+1
        sta channel_pattern_ptr_high, x

        ; finally done with this channel
        jmp done
skip:
        ; conveniently carry is already set
        ; a contains the counter
        sbc #1 ; decrement that counter
        sta channel_row_delay_counter, x
done:
        rts
.endproc

.proc advance_pattern_rows
        ; PULSE 1
        lda #PULSE_1_INDEX
        sta channel_index
        jsr advance_channel_row

        ; PULSE 2
        lda #PULSE_2_INDEX
        sta channel_index
        jsr advance_channel_row

        ; TRIANGLE
        lda #TRIANGLE_INDEX
        sta channel_index
        jsr advance_channel_row

        ; NOISE
        lda #NOISE_INDEX
        sta channel_index
        jsr advance_channel_row
        jsr fix_noise_freq

        .if ::BHOP_ZSAW_ENABLED
        ; Z-Saw
        lda #ZSAW_INDEX
        sta channel_index
        jsr advance_channel_row
        .endif

        .if ::BHOP_MMC5_ENABLED
        ; MMC5
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_MMC5
            beq skip_mmc5
            .endif
        lda #MMC5_PULSE_1_INDEX
        sta channel_index
        jsr advance_channel_row

        lda #MMC5_PULSE_2_INDEX
        sta channel_index
        jsr advance_channel_row
            .if ::BHOP_MULTICHIP
skip_mmc5:
            .endif
        .endif

        .if ::BHOP_VRC6_ENABLED
        ; VRC6
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6
            .endif
        lda #VRC6_PULSE_1_INDEX
        sta channel_index
        jsr advance_channel_row

        lda #VRC6_PULSE_2_INDEX
        sta channel_index
        jsr advance_channel_row

        lda #VRC6_SAWTOOTH_INDEX
        sta channel_index
        jsr advance_channel_row
            .if ::BHOP_MULTICHIP
skip_vrc6:
            .endif
        .endif

        ; DPCM
        lda #DPCM_INDEX
        sta channel_index
        ; reset retrigger period and Wxx upon new row
        lda #0
        sta effect_retrigger_period
        lda #$FF
        sta effect_dpcm_pitch
        jsr advance_channel_row

.if ::BHOP_PATTERN_BANKING
        ; Now that we're done with patterns, restore the module bank before continuing
        lda module_bank
        switch_music_bank
.endif

        ; Every time we update the pattern rows, also advance the groove sequence if enabled
        jsr update_groove

        rts
.endproc

.proc skip_pattern_rows
        ; PULSE 1
        lda #PULSE_1_INDEX
        sta channel_index
        jsr skip_channel_row

        ; PULSE 2
        lda #PULSE_2_INDEX
        sta channel_index
        jsr skip_channel_row

        ; TRIANGLE
        lda #TRIANGLE_INDEX
        sta channel_index
        jsr skip_channel_row

        ; NOISE
        lda #NOISE_INDEX
        sta channel_index
        jsr skip_channel_row

        .if ::BHOP_ZSAW_ENABLED
        ; Z-Saw
        lda #ZSAW_INDEX
        sta channel_index
        jsr skip_channel_row
        .endif

        .if ::BHOP_MMC5_ENABLED
        ; MMC5
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_MMC5
            beq skip_mmc5
            .endif
        lda #MMC5_PULSE_1_INDEX
        sta channel_index
        jsr skip_channel_row

        lda #MMC5_PULSE_2_INDEX
        sta channel_index
        jsr skip_channel_row
            .if ::BHOP_MULTICHIP
skip_mmc5:
            .endif
        .endif

        .if ::BHOP_VRC6_ENABLED
        ; VRC6
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6
            .endif
        lda #VRC6_PULSE_1_INDEX
        sta channel_index
        jsr skip_channel_row

        lda #VRC6_PULSE_2_INDEX
        sta channel_index
        jsr skip_channel_row

        lda #VRC6_SAWTOOTH_INDEX
        sta channel_index
        jsr skip_channel_row
            .if ::BHOP_MULTICHIP
skip_vrc6:
            .endif
        .endif

        ; DPCM
        lda #DPCM_INDEX
        sta channel_index
        jsr skip_channel_row

        rts
.endproc

.proc tick_delayed_effects
        ; Gxx: delayed pattern row
        ldx channel_index
        lda effect_note_delay, x
        beq done_with_note_delay
        dec effect_note_delay, x
        bne done_with_note_delay
        ; we just decremented the effect counter from 1 -> 0,
        ; so apply a note delay. In this case, tick the bytecode reader
        ; one time:
        jsr advance_channel_row
.if ::BHOP_PATTERN_BANKING
        ; That might have clobbered the module bank, so restore it before continuing
        lda module_bank
        switch_music_bank
.endif
        ; if this is the noise channel, fix its frequency
        lda channel_index
        cmp #3
        bne done_with_note_delay
        jsr fix_noise_freq
done_with_note_delay:
        ; Sxx: delayed note cut
        ldx channel_index
        lda effect_cut_delay, x
        beq done_with_cut_delay
        dec effect_cut_delay, x
        bne done_with_cut_delay
        ; apply a note cut, immediately silencing this channel and cancel delayed release
.if ::BHOP_DELAYED_RELEASE_ENABLED
        lda #0
        sta effect_release_delay, x
.endif
        lda channel_status, x
        and #($FF - CHANNEL_FRESH_DELAYED_CUT - CHANNEL_FRESH_DELAYED_RELEASE)
        ora #CHANNEL_MUTED
        sta channel_status, x
        jne done_with_delays
done_with_cut_delay:
.if ::BHOP_DELAYED_RELEASE_ENABLED
        lda effect_release_delay, x
        beq done_with_delays
        dec effect_release_delay, x
        bne done_with_delays
        ; note release
        lda channel_status, x
        and #($FF - CHANNEL_FRESH_DELAYED_RELEASE)
        ora #CHANNEL_RELEASED
        sta channel_status, x
.if ::BHOP_PATTERN_BANKING
        ; Instruments live in the module bank, so we need to swap that in before processing them
        lda module_bank
        switch_music_bank
.endif      
        jsr apply_release
.if ::BHOP_PATTERN_BANKING
        ; And now we need to switch back to the pattern bank before continuing
        ldx channel_index
        lda channel_pattern_bank, x
        switch_music_bank
        ldx channel_index ; un-clobber
.endif
.endif
done_with_delays:
        rts
.endproc

.macro initialize_detuned_frequency
        ldx channel_index
        lda channel_relative_frequency_low, x
        sta channel_detuned_frequency_low, x
        lda channel_relative_frequency_high, x
        sta channel_detuned_frequency_high, x
.endmacro

.proc tick_envelopes_and_effects
        ; PULSE 1
        lda #PULSE_1_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope
        ; the order of pitch updates matters a lot to match FT behavior
        jsr update_arp
        jsr update_pitch_effects
        jsr update_volume_effects
        jsr tick_arp_envelope
        jsr tick_pitch_envelope
        initialize_detuned_frequency
        jsr update_vibrato
        jsr update_tuning

        ; PULSE 2
        lda #PULSE_2_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope
        jsr update_arp
        jsr update_pitch_effects
        jsr update_volume_effects
        jsr tick_arp_envelope
        jsr tick_pitch_envelope
        initialize_detuned_frequency
        jsr update_vibrato
        jsr update_tuning

        ; TRIANGLE
        lda #TRIANGLE_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr tick_volume_envelope
        jsr update_arp
        jsr update_pitch_effects
        jsr tick_arp_envelope
        jsr tick_pitch_envelope
        initialize_detuned_frequency
        jsr update_vibrato
        jsr update_tuning

        ; NOISE
        lda #NOISE_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr update_volume_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope
        jsr tick_noise_arp_envelope
        jsr tick_pitch_envelope

        ; DPCM
        lda #DPCM_INDEX
        sta channel_index
        jsr tick_delayed_effects

.if ::BHOP_ZSAW_ENABLED
        ; Z-Saw
        lda #ZSAW_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr update_volume_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope_zsaw
        jsr update_arp_zsaw
        jsr tick_arp_envelope_zsaw
.endif

.if ::BHOP_MMC5_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_MMC5
            jeq skip_mmc5
            .endif
        lda #MMC5_PULSE_1_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope
        jsr update_arp
        jsr update_pitch_effects
        jsr update_volume_effects
        jsr tick_arp_envelope
        jsr tick_pitch_envelope
        initialize_detuned_frequency
        jsr update_vibrato
        jsr update_tuning

        lda #MMC5_PULSE_2_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope
        jsr update_arp
        jsr update_pitch_effects
        jsr update_volume_effects
        jsr tick_arp_envelope
        jsr tick_pitch_envelope
        initialize_detuned_frequency
        jsr update_vibrato
        jsr update_tuning
            .if ::BHOP_MULTICHIP
skip_mmc5:
            .endif
.endif

.if ::BHOP_VRC6_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC6
            jeq skip_vrc6
            .endif
        lda #VRC6_PULSE_1_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope
        jsr update_arp
        jsr update_pitch_effects
        jsr update_volume_effects
        jsr tick_arp_envelope
        jsr tick_pitch_envelope
        initialize_detuned_frequency
        jsr update_vibrato
        jsr update_tuning

        lda #VRC6_PULSE_2_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope
        jsr update_arp
        jsr update_pitch_effects
        jsr update_volume_effects
        jsr tick_arp_envelope
        jsr tick_pitch_envelope
        initialize_detuned_frequency
        jsr update_vibrato
        jsr update_tuning

        lda #VRC6_SAWTOOTH_INDEX
        sta channel_index
        jsr tick_delayed_effects
        jsr tick_volume_envelope
        jsr tick_duty_envelope
        jsr update_arp
        jsr update_pitch_effects
        jsr update_volume_effects
        jsr tick_arp_envelope
        jsr tick_pitch_envelope
        initialize_detuned_frequency
        jsr update_vibrato
        jsr update_tuning
            .if ::BHOP_MULTICHIP
skip_vrc6:
            .endif
.endif

        rts
.endproc

.proc advance_frame
        inc frame_counter
        lda frame_counter
        cmp frame_cmp
        bcc no_wrap
        lda #0
        sta frame_counter
no_wrap:
        ldx frame_counter
        jsr jump_to_frame
        jsr load_frame_patterns
        rts
.endproc

; Initializes channel state for playback of a particular instrument.
; Loads sequence pointers (if enabled) and clears pointers to begin
; sequence playback from the beginning
; setup:
;   channel_index points to desired channel
;   channel_selected_instrument[channel_index] contains desired instrument index
.proc load_instrument
        prepare_ptr_with_fixed_offset music_header_ptr, FtModuleHeader::instrument_list
        ldx channel_index
        lda channel_selected_instrument, x
        asl ; select one word
        tay

        ; set bhop_ptr to the selected index
        lda (bhop_ptr), y
        tax
        iny
        lda (bhop_ptr), y
        sta bhop_ptr+1
        stx bhop_ptr

        ; bhop_ptr now addresses the selected InstrumentHeader
        ldy #InstrumentHeader::sequences_enabled
        lda (bhop_ptr), y
        ldx channel_index
        sta sequences_enabled, x
        sta scratch_byte ; we'll shift bits out of this later

        ; for every enabled sequence, load the appropriate pointer
        clc
        ldy #InstrumentHeader::sequence_ptr
check_volume:
        lsr scratch_byte
        bcc check_arp

        lda (bhop_ptr), y
        sta volume_sequence_ptr_low, x
        iny
        lda (bhop_ptr), y
        sta volume_sequence_ptr_high, x
        iny

check_arp:
        lsr scratch_byte
        bcc check_pitch

        lda (bhop_ptr), y
        sta arpeggio_sequence_ptr_low, x
        iny
        lda (bhop_ptr), y
        sta arpeggio_sequence_ptr_high, x
        iny

check_pitch:
        lsr scratch_byte
        bcc check_hipitch

        lda (bhop_ptr), y
        sta pitch_sequence_ptr_low, x
        iny
        lda (bhop_ptr), y
        sta pitch_sequence_ptr_high, x
        iny

check_hipitch:
        lsr scratch_byte
        bcc check_duty

        lda (bhop_ptr), y
        sta hipitch_sequence_ptr_low, x
        iny
        lda (bhop_ptr), y
        sta hipitch_sequence_ptr_high, x
        iny

check_duty:
        lsr scratch_byte
        bcc done_loading_sequences

        lda (bhop_ptr), y
        sta duty_sequence_ptr_low, x
        iny
        lda (bhop_ptr), y
        sta duty_sequence_ptr_high, x
        ; no more need to iny

done_loading_sequences:
        jsr reset_instrument
        rts
.endproc

; Re-initializes sequence pointers back to the beginning of their
; respective envelopes
; setup:
;   channel_index points to the active channel
.proc reset_instrument
        ldy channel_index
        lda #0
        sta volume_sequence_index, y
        sta arpeggio_sequence_index, y
        sta pitch_sequence_index, y
        sta hipitch_sequence_index, y
        sta duty_sequence_index, y

        ; when a sequence ends it terminates itself in sequences_active, so re-initialize
        ; that byte here

        lda sequences_enabled, y
        sta sequences_active, y

        rts
.endproc

; If this channel has a volume envelope active, process that
; envelope. Upon return, instrument_volume will have the current
; element in the sequence.
; setup:
;   channel_index points to channel structure
.proc tick_volume_envelope
        ldy channel_index
        lda sequences_active, y
        and #SEQUENCE_VOLUME
        beq done ; if volume sequence isn't enabled, bail fast

        ; prepare the volume pointer for reading
        lda volume_sequence_ptr_low, y
        sta bhop_ptr
        lda volume_sequence_ptr_high, y
        sta bhop_ptr + 1

.if ::BHOP_VRC6_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6
            .endif
        ; grab and stash the mode byte, which some expansion instruments need
        ldy #SequenceHeader::mode
        lda (bhop_ptr), y
        ldy channel_index
        sta channel_volume_mode, y
            .if ::BHOP_MULTICHIP
skip_vrc6:
            .endif
.endif

        ; read the current sequence byte, and set instrument_volume to this
        lda volume_sequence_index, y
        tax ; stash for later
        ; for reading the sequence, +4
        clc
        adc #4
        tay
        lda (bhop_ptr), y
        ldy channel_index
        sta channel_instrument_volume, y

        ; tick the sequence counter and exit
        jsr tick_sequence_counter

        ; have we reached the end of the sequence?
        ldy #SequenceHeader::length
        lda (bhop_ptr), y
        sta scratch_byte
        cpx scratch_byte
        bne end_not_reached

        ; this sequence is finished! Disable the sequence flag and exit
        ldy channel_index
        lda sequences_active, y
        and #($FF - SEQUENCE_VOLUME)
        sta sequences_active, y
        rts

end_not_reached:
        ; write the new sequence index (should be in x)
        ldy channel_index
        txa
        sta volume_sequence_index, y

done:
        rts
.endproc

; If this channel has a duty envelope active, process that
; envelope. Upon return, instrument_duty is set
; setup:
;   channel_index points to channel structure
.proc tick_duty_envelope
        ldy channel_index
        lda sequences_active, y
        and #SEQUENCE_DUTY
        beq done ; if sequence isn't enabled, bail fast

        ; prepare the duty pointer for reading
        lda duty_sequence_ptr_low, y
        sta bhop_ptr
        lda duty_sequence_ptr_high, y
        sta bhop_ptr + 1

        ; read the current sequence byte, and set instrument_volume to this
        lda duty_sequence_index, y
        tax ; stash for later
        ; for reading the sequence, +4
        clc
        adc #4
        tay
        lda (bhop_ptr), y
        ldy channel_index
        sta channel_instrument_duty, y

        ; tick the sequence counter and exit
        jsr tick_sequence_counter

        ; have we reached the end of the sequence?
        ldy #SequenceHeader::length
        lda (bhop_ptr), y
        sta scratch_byte
        cpx scratch_byte
        bne end_not_reached

        ; this sequence is finished! Disable the sequence flag and exit
        ldy channel_index
        lda sequences_active, y
        and #($FF - SEQUENCE_DUTY)
        sta sequences_active, y
        rts

end_not_reached:
        ; write the new sequence index (should still be in x)
        ldy channel_index
        txa
        sta duty_sequence_index, y

done:
        rts
.endproc

; If this channel has an arp envelope active, process that
; envelope. Upon return, base_note and relative_frequency are set
; setup:
;   channel_index, channel_index points to channel structure
.proc tick_arp_envelope
        ldx channel_index
        lda sequences_active, x
        and #SEQUENCE_ARP
        beq early_exit ; if sequence isn't enabled, bail fast

        ; prepare the arp pointer for reading
        lda arpeggio_sequence_ptr_low, x
        sta bhop_ptr
        lda arpeggio_sequence_ptr_high, x
        sta bhop_ptr + 1

        ; For fixed arps, we need to "reset" the channel if the envelope finishes, so we're doing
        ; the length check first thing

        lda arpeggio_sequence_index, x
        sta scratch_byte
        ; have we reached the end of the sequence?
        ldy #SequenceHeader::length
        lda (bhop_ptr), y
        cmp scratch_byte
        bne end_not_reached

        ; this sequence is finished! Disable the sequence flag
        lda sequences_active, x
        and #($FF - SEQUENCE_ARP)
        sta sequences_active, x

        ; is this a fixed arp?
        ldy #SequenceHeader::mode
        lda (bhop_ptr), y
        cmp #ARP_MODE_FIXED
        bne early_exit

        ; apply the current base note as the channel frequency,
        ; then exit:
        lda channel_base_note, x
        jsr set_channel_relative_frequency

early_exit:
        rts

end_not_reached:
        ; read the current sequence byte, and set instrument_volume to this
        lda arpeggio_sequence_index, x
        pha ; stash for later
        ; for reading the sequence, +4
        clc
        adc #4
        tay
        lda (bhop_ptr), y
        sta scratch_byte ; will affect the note, depending on mode
        clc

        ; what we actually *do* with the arp byte depends on the mode
        ldy #SequenceHeader::mode
        lda (bhop_ptr), y
        cmp #ARP_MODE_ABSOLUTE
        beq arp_absolute
        cmp #ARP_MODE_RELATIVE
        beq arp_relative
        cmp #ARP_MODE_FIXED
        beq arp_fixed
        ; ARP SCHEME, unimplemented! for now, treat this just like absolute
arp_absolute:
        ; arp is an offset from base note to apply each frame
        lda channel_base_note, x
        clc
        adc scratch_byte
        jmp apply_arp
arp_relative:
        ; were we just triggered? if so, reset the relative offset
        lda channel_status, x
        and #CHANNEL_TRIGGERED
        beq not_triggered
        lda #0
        sta channel_relative_note_offset, x
not_triggered:
        ; arp accumulates an offset each frame, from the previous frame
        lda channel_relative_note_offset, x
        clc
        adc scratch_byte
        sta channel_relative_note_offset, x
        ; this offset is then applied to base_note
        lda channel_base_note, x
        clc
        adc channel_relative_note_offset, x
        ; stuff that result in y, and apply it
        jmp apply_arp
arp_fixed:
        ; the arp value +1 is the note to apply
        lda scratch_byte
        clc
        adc #1
        ; fall through to apply_arp
apply_arp:
        jsr set_channel_relative_frequency

done_applying_arp:
        pla ; unstash the sequence counter
        tax ; move into x, which tick_sequence_counter expects

        ; tick the sequence counter and exit
        jsr tick_sequence_counter

        ; write the new sequence index (should still be in x)
        ldy channel_index
        txa
        sta arpeggio_sequence_index, y

done:
        rts
.endproc

; If this channel has a pitch envelope active, process that
; envelope. Upon return, relative_pitch is set
; setup:
;   channel_index points to channel structure
.proc tick_pitch_envelope
        ldy channel_index
        lda sequences_active, y
        and #SEQUENCE_PITCH
        jeq done ; if sequence isn't enabled, bail fast

        ; prepare the pitch pointer for reading
        lda pitch_sequence_ptr_low, y
        sta bhop_ptr
        lda pitch_sequence_ptr_high, y
        sta bhop_ptr + 1

        ; read the current sequence byte, and set instrument_volume to this
        lda pitch_sequence_index, y
        tax ; stash for later
        ; for reading the sequence, +4
        clc
        adc #4
        tay
        lda (bhop_ptr), y
        sta scratch_byte

        ; what we do here depends on the mode
        ldy #SequenceHeader::mode
        lda (bhop_ptr), y
        cmp #PITCH_MODE_RELATIVE
        beq relative_pitch_mode
absolute_pitch_mode:
        ; additional guard: if we are currently running an arp
        ; envelope, then temporarily pretend to be in relative_pitch mode
        ; (otherwise we cancel out the arp)
        ldy channel_index
        lda sequences_active, y
        and #SEQUENCE_ARP
        bne relative_pitch_mode

        ; in absolute mode, reset to base_frequency before
        ; performing the addition
        lda channel_base_frequency_low, y
        sta channel_relative_frequency_low, y
        lda channel_base_frequency_high, y
        sta channel_relative_frequency_high, y
relative_pitch_mode:
        ; add this data to relative_pitch
        ldy channel_index
        sadd16_split_y channel_relative_frequency_low, channel_relative_frequency_high, scratch_byte
        ; clamp pitch within range
        clamp_detune_pitch_split_y channel_relative_frequency_low, channel_relative_frequency_high

done_applying_pitch:
        ; tick the sequence counter and exit
        jsr tick_sequence_counter

        ; have we reached the end of the sequence?
        ldy #SequenceHeader::length
        lda (bhop_ptr), y
        sta scratch_byte
        cpx scratch_byte
        bne end_not_reached

        ; this sequence is finished! Disable the sequence flag and exit
        ldy channel_index
        lda sequences_active, y
        and #($FF - SEQUENCE_PITCH)
        sta sequences_active, y
        rts

end_not_reached:
        ; write the new sequence index (should still be in x)
        ldy channel_index
        txa
        sta pitch_sequence_index, y

done:
        rts
.endproc

; setup:
;   channel_index points to channel structure
;   bhop_ptr points to start of sequence data
;   x - current sequence pointer
; return: new sequence counter in x
; side effects: sequences_active altered
.proc tick_sequence_counter
        ; increment the index we stashed earlier
        inx
        ; have we reached the end of the loop?
        ldy #SequenceHeader::length
        lda (bhop_ptr), y
        sta scratch_byte
        cpx scratch_byte
        bne end_not_reached

end_reached:
        ; Do we have a loop point defined?
        ldy #SequenceHeader::loop_point
        lda (bhop_ptr), y
        cmp #$FF
        beq end_reached_without_loop
        ; Is this loop point *after* the release point?
        ldy #SequenceHeader::release_point
        cmp (bhop_ptr), y ; A=loop point, M=release point
        bcc end_reached_without_loop
        jmp apply_loop_point

end_reached_without_loop:
        ; do nothing, and exit; the calling function will check to see if
        ; the sequence pointer is at the end, and deactivate the sequence
        rts

end_not_reached:
        ; have we reached the release point?
        ldy #SequenceHeader::release_point
        lda (bhop_ptr), y
        sta scratch_byte
        cpx scratch_byte
        bne release_point_not_reached
        
        ; are we released?
        ldy channel_index
        lda channel_status, y
        and #CHANNEL_RELEASED
        bne done

        ; is there a loop point?
        ldy #SequenceHeader::loop_point
        lda (bhop_ptr), y
        cmp #$FF ; magic value, means there is no loop defined
        beq release_without_loop
        ; is the loop point *before* the release point?
        cmp scratch_byte ; A=loop point, M=release point
        bcs release_without_loop

apply_loop_point:
        ; a contains our loop point, so jump there and exit
        tax
        rts

release_without_loop:
        ; otherwise, hold position and exit
        dex
        rts

release_point_not_reached:
        ; no jumps needed, so stash our new sequence value and exit
done:
        rts
.endproc

.macro release_sequence sequence_type, sequence_ptr_low, sequence_ptr_high, pitch_sequence_index
.scope
        lda sequences_active, x
        and #sequence_type
        beq done_with_sequence ; if sequence isn't enabled, bail fast

        ; prepare the pitch pointer for reading
        lda sequence_ptr_low, x
        sta bhop_ptr
        lda sequence_ptr_high, x
        sta bhop_ptr + 1

        ; do we have a release point enabled?
        ldy #SequenceHeader::release_point
        lda (bhop_ptr), y
        beq done_with_sequence
        ; set the sequence index to the release point immediately
        ; (it will be ticked *past* this point on the next cycle)
        sec
        sbc #1
        sta pitch_sequence_index, x
done_with_sequence:
.endscope
.endmacro

; If this channel has any envelopes, and those envelopes
; have a release point, jump to it immediately
; setup:
;   channel_index points to channel structure
;   x contains channel_index
.proc apply_release
        ; note: channel_index is conveniently already in X
release_sequence SEQUENCE_VOLUME, volume_sequence_ptr_low, volume_sequence_ptr_high, volume_sequence_index
release_sequence SEQUENCE_PITCH, pitch_sequence_ptr_low, pitch_sequence_ptr_high, pitch_sequence_index
release_sequence SEQUENCE_ARP, arpeggio_sequence_ptr_low, arpeggio_sequence_ptr_high, arpeggio_sequence_index
release_sequence SEQUENCE_DUTY, duty_sequence_ptr_low, duty_sequence_ptr_high, duty_sequence_index
        rts
.endproc

.proc tick_registers
tick_pulse1:
        lda #CHANNEL_SUPPRESSED
        bit channel_status + PULSE_1_INDEX
        bne tick_pulse2
        bmi pulse1_muted

        ; add in the duty
        lda channel_instrument_duty + PULSE_1_INDEX
        ror
        ror
        ror
        and #%11000000
        sta scratch_byte
        
        ; apply the combined channel and instrument volume
        lda channel_tremolo_volume + PULSE_1_INDEX
        asl
        asl
        asl
        asl
        ora channel_instrument_volume + PULSE_1_INDEX
        tax
        lda volume_table, x
        ora #%00110000 ; disable length counter and envelope
        ora scratch_byte
        sta $4000

        ; disable the sweep unit
        lda #$08
        sta $4001

        lda channel_detuned_frequency_low + PULSE_1_INDEX
        sta $4002

        ; If we triggered this frame, write unconditionally
        lda channel_status + PULSE_1_INDEX
        and #CHANNEL_TRIGGERED
        bne write_pulse1

        ; otherwise, to avoid resetting the sequence counter, only
        ; write if the high byte has changed since the last time
        lda channel_detuned_frequency_high + PULSE_1_INDEX
        cmp shadow_pulse1_freq_hi
        beq tick_pulse2

write_pulse1:
        lda channel_detuned_frequency_high + PULSE_1_INDEX
        sta shadow_pulse1_freq_hi
        ora #%11111000
        sta $4003
        jmp tick_pulse2
pulse1_muted:
        ; if the channel is muted, little else matters, but ensure
        ; we set the volume to 0
        lda #%00110000
        sta $4000

tick_pulse2:
        lda #CHANNEL_SUPPRESSED
        bit channel_status + PULSE_2_INDEX
        bne tick_triangle
        bmi pulse2_muted

        ; add in the duty
        lda channel_instrument_duty + PULSE_2_INDEX
        ror
        ror
        ror
        and #%11000000
        sta scratch_byte

        ; apply the combined channel and instrument volume
        lda channel_tremolo_volume + PULSE_2_INDEX
        asl
        asl
        asl
        asl
        ora channel_instrument_volume + PULSE_2_INDEX
        tax
        lda volume_table, x
        ora #%00110000 ; disable length counter and envelope
        ora scratch_byte
        sta $4004

        ; disable the sweep unit
        lda #$08
        sta $4005

        lda channel_detuned_frequency_low + PULSE_2_INDEX
        sta $4006

        ; If we triggered this frame, write unconditionally
        lda channel_status + PULSE_2_INDEX
        and #CHANNEL_TRIGGERED
        bne write_pulse2

        ; otherwise, to avoid resetting the sequence counter, only
        ; write if the high byte has changed since the last time
        lda channel_detuned_frequency_high + PULSE_2_INDEX
        cmp shadow_pulse2_freq_hi
        beq tick_triangle

write_pulse2:
        lda channel_detuned_frequency_high + PULSE_2_INDEX
        sta shadow_pulse2_freq_hi
        ora #%11111000
        sta $4007
        jmp tick_triangle
pulse2_muted:
        ; if the channel is muted, little else matters, but ensure
        ; we set the volume to 0
        lda #%00110000
        sta $4004

tick_triangle:
        lda #CHANNEL_SUPPRESSED
        bit channel_status + TRIANGLE_INDEX
        bne tick_noise
        bmi triangle_muted

        ; triangle additionally should mute here if either channel volume,
        ; or instrument volume is zero
        ; (but don't clobber a)
        ldx channel_volume + TRIANGLE_INDEX
        beq triangle_muted
        ldx channel_instrument_volume + TRIANGLE_INDEX
        beq triangle_muted

        lda #$FF
        sta $4008 ; timers to max

        lda channel_detuned_frequency_low + TRIANGLE_INDEX
        sta $400A
        lda channel_detuned_frequency_high + TRIANGLE_INDEX
        sta $400B
        jmp tick_noise
triangle_muted:
        ; since triangle has no volume, we'll instead choose to mute it by
        ; setting the length counter to 0 and forcing an immediate reload.
        ; This will delay the mute by up to 1/4 of a frame, but this is the
        ; best we can do without conflicting with the DMC channel
        lda #$80
        sta $4008

tick_noise:
        lda #CHANNEL_SUPPRESSED
        bit channel_status + NOISE_INDEX
        bne tick_dpcm
        bmi noise_muted

        ; apply the combined channel and instrument volume
        lda channel_tremolo_volume + NOISE_INDEX
        asl
        asl
        asl
        asl
        ora channel_instrument_volume + NOISE_INDEX
        tax
        lda volume_table, x

        ora #%00110000 ; disable length counter and envelope
        sta $400C

        ; the low 4 bits of relative_frequency become the
        ; noise period
        lda channel_relative_frequency_low + NOISE_INDEX
        ; of *course* it's inverted
        sta scratch_byte
        lda #$10
        sec
        sbc scratch_byte
        and #%00001111
        sta scratch_byte

        ; the low bit of channel duty becomes mode bit 1
        lda channel_instrument_duty + NOISE_INDEX
        ror
        ror
        and #%10000000 ; safety mask
        ora scratch_byte

        sta $400E

        ; finally, ensure the note is actually playing with a length
        ; counter that is not zero
        lda #%11111000
        sta $400F
        jmp tick_dpcm
noise_muted:
        ; if the channel is muted, little else matters, but ensure
        ; we set the volume to 0
        lda #%00110000
        sta $400C

tick_dpcm:
        jsr play_dpcm_samples

.if ::BHOP_ZSAW_ENABLED
        jsr play_zsaw
.endif

.if ::BHOP_MMC5_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_MMC5
            beq skip_mmc5
            .endif
        jsr play_mmc5
            .if ::BHOP_MULTICHIP
skip_mmc5:
            .endif
.endif

.if ::BHOP_VRC6_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6
            .endif
        jsr play_vrc6
            .if ::BHOP_MULTICHIP
skip_vrc6:
            .endif
.endif

cleanup:
        ; clear the triggered flag from every instrument
        lda channel_status + PULSE_1_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + PULSE_1_INDEX

        lda channel_status + PULSE_2_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + PULSE_2_INDEX

        lda channel_status + TRIANGLE_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + TRIANGLE_INDEX

        lda channel_status + NOISE_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + NOISE_INDEX

        .if ::BHOP_ZSAW_ENABLED
        lda channel_status + ZSAW_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + ZSAW_INDEX
        .endif

        .if ::BHOP_MMC5_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_MMC5
            beq skip_mmc5_trigger_reset
            .endif
        lda channel_status + MMC5_PULSE_1_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + MMC5_PULSE_1_INDEX

        lda channel_status + MMC5_PULSE_2_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + MMC5_PULSE_2_INDEX
            .if ::BHOP_MULTICHIP
skip_mmc5_trigger_reset:
            .endif
        .endif

        .if ::BHOP_VRC6_ENABLED
            .if ::BHOP_MULTICHIP
            lda expansion_flags
            and #EXPANSION_VRC6
            beq skip_vrc6_trigger_reset
            .endif
        lda channel_status + VRC6_PULSE_1_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + VRC6_PULSE_1_INDEX

        lda channel_status + VRC6_PULSE_2_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + VRC6_PULSE_2_INDEX

        lda channel_status + VRC6_SAWTOOTH_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + VRC6_SAWTOOTH_INDEX
            .if ::BHOP_MULTICHIP
skip_vrc6_trigger_reset:
            .endif
        .endif

        lda channel_status + DPCM_INDEX
        and #($FF - CHANNEL_TRIGGERED)
        sta channel_status + DPCM_INDEX

        rts
.endproc

.proc play_dpcm_samples
        lda channel_status + DPCM_INDEX
        and #CHANNEL_SUPPRESSED
        jne done

        ; Xxx handling; see CDPCMChan::RefreshChannel() in Dn-FT
        ; decrement effect_retrigger_counter while effect_retrigger_counter != zero
        lda effect_retrigger_period
        beq next
        dec effect_retrigger_counter

        ; if retrigger counter is decremented to 0 at this point
        ; then time to trigger the sample again
        lda effect_retrigger_counter
        bne next
        lda effect_retrigger_period
        sta effect_retrigger_counter
        
        ; trigger_sample without resetting effect_retrigger_counter via queue_sample
        jsr trigger_sample
next:

        ; handle note cut and note release
        ; see CDPCMChan::RefreshChannel() in Dn-FT 
        lda channel_status + DPCM_INDEX
        and #(CHANNEL_MUTED | CHANNEL_RELEASED)
        jne dpcm_muted

        ; check if channel is enabled in the first place
        lda dpcm_status
        and #DPCM_ENABLED
        jeq done

        ; make arrangements to write to the specific registers
        lda channel_status + DPCM_INDEX
        and #CHANNEL_TRIGGERED
        jeq check_for_inactive

        ; We're about to trigger a DPCM sample,
        ; so silence virtual Z channels.
        ; DPCM will always have higher priority
        .if ::BHOP_ZSAW_ENABLED
        jsr zsaw_disable
        .elseif ::BHOP_ZPCM_ENABLED
        jsr zpcm_disable
        .endif

        ; using the current note, read the sample table
        prepare_ptr_with_fixed_offset music_header_ptr, FtModuleHeader::sample_list
        lda channel_base_note + DPCM_INDEX

        sta scratch_byte
        dec scratch_byte ; notes start at 1, list is indexed at 0
        ; multiply by 3
        lda #0
        clc
        adc scratch_byte
        adc scratch_byte
        adc scratch_byte
        tay
        ; in order, the sample_list should contain:
        ; - LL..RRRR - Loop, playback Rate
        ; - EDDDDDDD - delta Enabled, Delta counter
        ; - nnnnnnnn - iNdex into sample table
        lda (bhop_ptr), y
        iny
        sta scratch_byte
        lda effect_dpcm_pitch ; check for Wxx
        bmi skip_pitch ; != -1? then Wxx takes precedence
        lda scratch_byte
        and #$F0
        ora effect_dpcm_pitch
        sta scratch_byte
skip_pitch:
        lda scratch_byte
        and #%01111111 ; do NOT enable IRQs
        sta $4010      ; write rate and loop enable
        lda (bhop_ptr), y
        iny
        sta scratch_byte
        lda effect_dac_buffer ; check for Zxx
        bpl skip_dac ; != -1? then it was already written
        lda scratch_byte
        bmi skip_dac
        sta $4011
skip_dac:
        lda #$FF
        sta effect_dac_buffer

        lda (bhop_ptr), y
        ; this is the index into the samples table, here it is pre-multiplied
        ; so we can use it directly
        ; save the y value since it is scratched by the prepare_ptr
        pha
        prepare_ptr_with_fixed_offset music_header_ptr, FtModuleHeader::samples
        pla
        tay
        ; the sample table should contain, in order:
        ; - location byte
        ; - size byte
        ; - bank to switch in

        lda (bhop_ptr), y
        ; cheaper to just do this unconditionally
        clc
        adc effect_dpcm_offset
        sta $4012
        iny

        lda (bhop_ptr), y
        sta $4013

.if ::BHOP_DPCM_BANKING
        iny
        lda (bhop_ptr), y
        jsr BHOP_DPCM_SWITCH_ROUTINE
.endif

        ; finally, briefly disable the sample channel to set bytes_remaining in the memory
        ; reader to 0, then start it again to initiate playback
        lda #$0F
        sta $4015
        lda #$1F
        sta $4015

done:
        rts

dpcm_muted:
        ; Only take action if virtual Z channels are disabled...
        .if ::BHOP_ZSAW_ENABLED .or ::BHOP_ZPCM_ENABLED
        lda dpcm_status
            .if ::BHOP_ZSAW_ENABLED
            and #DPCM_ZSAW_ENABLED
            .elseif ::BHOP_ZPCM_ENABLED
            and #DPCM_ZPCM_ENABLED
            .endif
        bne done
        .endif
        ; simply disable the channel and exit (whatever is in the sample playback buffer will
        ; finish, up to 8 bits, there is no way to disable this)
        lda #%00001111
        sta $4015

        lda channel_status + DPCM_INDEX
        and #CHANNEL_MUTED
        bne dpcm_cut
        lda channel_status + DPCM_INDEX
        and #($FF - CHANNEL_RELEASED) ; release release note if note released
        sta channel_status + DPCM_INDEX
        jmp dpcm_release
dpcm_cut:
        lda #0 ; regain full volume for TN
        sta $4011
dpcm_release:
        lda dpcm_status
        and #($FF - (DPCM_ENABLED))
        sta dpcm_status

check_for_inactive:
        ; Only take action if virtual Z channels are disabled...
        .if ::BHOP_ZSAW_ENABLED .or ::BHOP_ZPCM_ENABLED

        ; See if that DPCM playback has finished:
        lda $4015
        and #%00010000
        bne done

        ; If it has, enable virtual Z channels
        ; to initiate playback on the next tick
            .if ::BHOP_ZSAW_ENABLED
            jsr zsaw_enable
            .elseif ::BHOP_ZPCM_ENABLED
            jsr zpcm_enable
            .endif
        .endif

        rts
.endproc

.if ::BHOP_ZPCM_ENABLED
; request to disable ZPCM
.proc zpcm_disable
        ; check if ZPCM is already disabled first
        lda dpcm_status
        and #DPCM_ZPCM_ENABLED
        beq done

        .if ::BHOP_ZPCM_CONFLICT_AVOIDANCE
        jsr BHOP_ZPCM_DISABLE_ROUTINE
        .endif
        
        ; set status flag
        lda dpcm_status
        and #($FF - (DPCM_ZPCM_ENABLED))
        sta dpcm_status
done:
        rts
.endproc

; request to enable ZPCM
.proc zpcm_enable
        ; check if ZPCM is already enabled first
        lda dpcm_status
        and #DPCM_ZPCM_ENABLED
        bne done

        .if ::BHOP_ZPCM_CONFLICT_AVOIDANCE
        jsr BHOP_ZPCM_ENABLE_ROUTINE
        .endif
        
        ; set status flag
        lda dpcm_status
        ora #DPCM_ZPCM_ENABLED
        sta dpcm_status
done:
        rts
.endproc
.endif

.if ::BHOP_ZSAW_ENABLED
; request to disable Z-Saw
.proc zsaw_disable
        ; check if Z-Saw is already disabled first
        lda dpcm_status
        and #DPCM_ZSAW_ENABLED
        beq done
        jsr zsaw_silence
        
        ; set status flag
        lda dpcm_status
        and #($FF - (DPCM_ZSAW_ENABLED))
        sta dpcm_status
done:
        rts
.endproc

; request to enable Z-Saw
.proc zsaw_enable
        ; check if ZPCM is already enabled first
        lda dpcm_status
        and #DPCM_ZSAW_ENABLED
        bne done
        ; do nothing, will play on the next tick
        
        ; set status flag
        lda dpcm_status
        ora #DPCM_ZSAW_ENABLED
        sta dpcm_status
done:
        rts
.endproc
.endif

; resets the retrigger logic upon a new DPCM sample note
.proc trigger_sample
        .if ::BHOP_ZPCM_ENABLED
        .if .not ::BHOP_ZPCM_CONFLICT_AVOIDANCE
        ; since we don't have any means to disable ZPCM,
        ; avoid playing samples altogether when ZPCM is enabled
        lda dpcm_status
        and #DPCM_ZPCM_ENABLED
        beq next
        rts
next:
        .endif
        .endif

        lda dpcm_status
        ora #DPCM_ENABLED
        sta dpcm_status
        lda channel_status + DPCM_INDEX
        ora #CHANNEL_TRIGGERED
        sta channel_status + DPCM_INDEX
        rts
.endproc

; If effect_retrigger_period != 0, this initializes retriggering. Otherwise reset effect_retrigger_counter.
.proc queue_sample
        lda effect_retrigger_period
        beq reset_counter
        sta effect_retrigger_counter
        inc effect_retrigger_counter
        rts
reset_counter:
        lda #0
        sta effect_retrigger_counter
        rts
.endproc

.proc bhop_play
.if ::BHOP_PATTERN_BANKING
        lda module_bank
        sta current_music_bank
        jsr BHOP_PATTERN_SWITCH_ROUTINE
.endif

        jsr tick_frame_counter
        jsr tick_envelopes_and_effects
        jsr tick_registers
        ; :D
        LDA PAGE_C000
        JSR PRGROM_Change_C000
        rts
.endproc

; channel index in A
;;; ORANGE - this didn't mute! We have to actually mute the sound and then suppress the channel
.proc bhop_mute_channel
        tax
        lda #(CHANNEL_SUPPRESSED)
        ora channel_status, x
        sta channel_status, x
        ; if this is a pulse channel, make sure our next update
        ; after we un-mute writes a new frequency value
check_pulse_1:
        cpx #0
        bne check_pulse_2
        lda #$FF
        sta shadow_pulse1_freq_hi
check_pulse_2:
        cpx #1
        bne done
        lda #$FF
        sta shadow_pulse2_freq_hi
done:
        rts
.endproc

.proc init_2a03
        ; if the channel is muted, little else matters, but ensure
        ; we set the volume to 0
        lda #%00110000
        sta $4000
        sta $4004
        sta $400C

        ; since triangle has no volume, we'll instead choose to mute it by
        ; setting the length counter to 0 and forcing an immediate reload.
        ; This will delay the mute by up to 1/4 of a frame, but this is the
        ; best we can do without conflicting with the DMC channel
        lda #$80
        sta $4008

        ; disable unusual IRQ sources
        lda #%01000000
        sta $4017 ; APU frame counter
        lda #0
        sta $4010 ; DMC DMA
        sta $4011 ; regain full volume for TN

        ; disable DPCM channel
        lda #%00001111
        sta $4015
        rts
.endproc

; channel index in A
.proc bhop_unmute_channel
        tax
        lda #($FF - CHANNEL_SUPPRESSED)
        and channel_status, x
        sta channel_status, x
        rts
.endproc

.include "bhop/util.asm"
.include "bhop/2a03_noise.asm"
.if ::BHOP_ZSAW_ENABLED
.include "bhop/2a03_zsaw.asm"
.endif
.if ::BHOP_MMC5_ENABLED
.include "bhop/mmc5.asm"
.endif
.if ::BHOP_VRC6_ENABLED
.include "bhop/vrc6.asm"
.endif


volume_table:
        .byte $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0, $0
        .byte $0, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1
        .byte $0, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $1, $2
        .byte $0, $1, $1, $1, $1, $1, $1, $1, $1, $1, $2, $2, $2, $2, $2, $3
        .byte $0, $1, $1, $1, $1, $1, $1, $1, $2, $2, $2, $2, $3, $3, $3, $4
        .byte $0, $1, $1, $1, $1, $1, $2, $2, $2, $3, $3, $3, $4, $4, $4, $5
        .byte $0, $1, $1, $1, $1, $2, $2, $2, $3, $3, $4, $4, $4, $5, $5, $6
        .byte $0, $1, $1, $1, $1, $2, $2, $3, $3, $4, $4, $5, $5, $6, $6, $7
        .byte $0, $1, $1, $1, $2, $2, $3, $3, $4, $4, $5, $5, $6, $6, $7, $8
        .byte $0, $1, $1, $1, $2, $3, $3, $4, $4, $5, $6, $6, $7, $7, $8, $9
        .byte $0, $1, $1, $2, $2, $3, $4, $4, $5, $6, $6, $7, $8, $8, $9, $A
        .byte $0, $1, $1, $2, $2, $3, $4, $5, $5, $6, $7, $8, $8, $9, $A, $B
        .byte $0, $1, $1, $2, $3, $4, $4, $5, $6, $7, $8, $8, $9, $A, $B, $C
        .byte $0, $1, $1, $2, $3, $4, $5, $6, $6, $7, $8, $9, $A, $B, $C, $D
        .byte $0, $1, $1, $2, $3, $4, $5, $6, $7, $8, $9, $A, $B, $C, $D, $E
        .byte $0, $1, $2, $3, $4, $5, $6, $7, $8, $9, $A, $B, $C, $D, $E, $F


.if ::BHOP_PITCH_DETUNE_CLAMP_ENABLED
channel_min_frequency_low:
        ; PULSE_1_INDEX
        .byte <FREQUENCY_MIN_2A03
        ; PULSE_2_INDEX
        .byte <FREQUENCY_MIN_2A03
        ; TRIANGLE_INDEX
        .byte <FREQUENCY_MIN_2A03
        ; NOISE_INDEX
        .byte 0
.if ::BHOP_ZSAW_ENABLED
        ; ZSAW_INDEX
        .byte 0     ; Z-Saw doesn't support pitch bends
.endif
.if ::BHOP_MMC5_ENABLED
        ; MMC5_PULSE_1_INDEX
        .byte <FREQUENCY_MIN_2A03
        ; MMC5_PULSE_2_INDEX
        .byte <FREQUENCY_MIN_2A03
.endif
.if ::BHOP_VRC6_ENABLED
        ; VRC6_PULSE_1_INDEX
        .byte <FREQUENCY_MIN_VRC6
        ; VRC6_PULSE_2_INDEX
        .byte <FREQUENCY_MIN_VRC6
        ; VRC6_SAWTOOTH_INDEX
        .byte <FREQUENCY_MIN_VRC6
.endif
        ; DPCM_INDEX
        .byte 0

channel_min_frequency_high:
        ; PULSE_1_INDEX
        .byte >FREQUENCY_MIN_2A03
        ; PULSE_2_INDEX
        .byte >FREQUENCY_MIN_2A03
        ; TRIANGLE_INDEX
        .byte >FREQUENCY_MIN_2A03
        ; NOISE_INDEX
        .byte 0
.if ::BHOP_ZSAW_ENABLED
        ; ZSAW_INDEX
        .byte 0     ; Z-Saw doesn't support pitch bends
.endif
.if ::BHOP_MMC5_ENABLED
        ; MMC5_PULSE_1_INDEX
        .byte >FREQUENCY_MIN_2A03
        ; MMC5_PULSE_2_INDEX
        .byte >FREQUENCY_MIN_2A03
.endif
.if ::BHOP_VRC6_ENABLED
        ; VRC6_PULSE_1_INDEX
        .byte >FREQUENCY_MIN_VRC6
        ; VRC6_PULSE_2_INDEX
        .byte >FREQUENCY_MIN_VRC6
        ; VRC6_SAWTOOTH_INDEX
        .byte >FREQUENCY_MIN_VRC6
.endif
        ; DPCM_INDEX
        .byte 0

channel_max_frequency_low:
        ; PULSE_1_INDEX
        .byte <FREQUENCY_MAX_2A03
        ; PULSE_2_INDEX
        .byte <FREQUENCY_MAX_2A03
        ; TRIANGLE_INDEX
        .byte <FREQUENCY_MAX_2A03
        ; NOISE_INDEX
        .byte $FF
.if ::BHOP_ZSAW_ENABLED
        ; ZSAW_INDEX
        .byte $FF   ; Z-Saw doesn't support pitch bends
.endif
.if ::BHOP_MMC5_ENABLED
        ; MMC5_PULSE_1_INDEX
        .byte <FREQUENCY_MAX_2A03
        ; MMC5_PULSE_2_INDEX
        .byte <FREQUENCY_MAX_2A03
.endif
.if ::BHOP_VRC6_ENABLED
        ; VRC6_PULSE_1_INDEX
        .byte <FREQUENCY_MAX_VRC6
        ; VRC6_PULSE_2_INDEX
        .byte <FREQUENCY_MAX_VRC6
        ; VRC6_SAWTOOTH_INDEX
        .byte <FREQUENCY_MAX_VRC6
.endif
        ; DPCM_INDEX
        .byte $FF

channel_max_frequency_high:
        ; PULSE_1_INDEX
        .byte >FREQUENCY_MAX_2A03
        ; PULSE_2_INDEX
        .byte >FREQUENCY_MAX_2A03
        ; TRIANGLE_INDEX
        .byte >FREQUENCY_MAX_2A03
        ; NOISE_INDEX
        .byte $7F
.if ::BHOP_ZSAW_ENABLED
        ; ZSAW_INDEX
        .byte $7F   ; Z-Saw doesn't support pitch bends
.endif
.if ::BHOP_MMC5_ENABLED
        ; MMC5_PULSE_1_INDEX
        .byte >FREQUENCY_MAX_2A03
        ; MMC5_PULSE_2_INDEX
        .byte >FREQUENCY_MAX_2A03
.endif
.if ::BHOP_VRC6_ENABLED
        ; VRC6_PULSE_1_INDEX
        .byte >FREQUENCY_MAX_VRC6
        ; VRC6_PULSE_2_INDEX
        .byte >FREQUENCY_MAX_VRC6
        ; VRC6_SAWTOOTH_INDEX
        .byte >FREQUENCY_MAX_VRC6
.endif
        ; DPCM_INDEX
        .byte $7F
.endif

.export Sound_Engine_Process
Sound_Engine_Process:
    LDA #$ff     ;
    STA FRAMECTR_CTL ; Resets the frame counter clock (sync sound hardware), disables IRQ generation

    ; --- process music ---
    ; MUS1 are
    ; MUS1_PLAYERDEATH    = $01   ; Player death
    ; MUS1_GAMEOVER       = $02   ; Game over
    ; MUS1_BOSSVICTORY    = $04   ; Victory normal
    ; MUS1_WORLDVICTORY   = $08   ; Victory super (King reverted, Bowser defeated, etc.)
    ; MUS1_BOWSERFALL     = $10   ; Bowser dramatic falling
    ; MUS1_COURSECLEAR    = $20   ; Course Clear
    ; MUS1_TIMEWARNING    = $40   ; Time Warning (attempts to speed up song playing)
    ; MUS1_STOPMUSIC      = $80   ; Stops playing any music
    LDA Sound_QMusic1
    BMI _stop_music   ; $80 is MUS1_STOPMUSIC
    BNE _mute   ; TODO: handle each of these?
    ; MUS2 are
    ; MUS2A_WORLD1        = $01   ; World 1
    ; MUS2A_WORLD2        = $02   ; World 2
    ; MUS2A_WORLD3        = $03   ; World 3
    ; MUS2A_WORLD4        = $04   ; World 4
    ; MUS2A_WORLD5        = $05   ; World 5
    ; MUS2A_WORLD6        = $06   ; World 6
    ; MUS2A_WORLD7        = $07   ; World 7
    ; MUS2A_WORLD8        = $08   ; World 8
    ; MUS2A_SKY           = $09   ; Coin Heaven / Sky World / Warp Zone (World 9)
    ; MUS2A_INVINCIBILITY = $0A   ; Invincibility
    ; MUS2A_WARPWHISTLE   = $0B   ; Warp whistle
    ; MUS2A_MUSICBOX      = $0C   ; Music box
    ; MUS2A_THRONEROOM    = $0D   ; King's room
    ; MUS2A_BONUSGAME     = $0E   ; Bonus game
    ; MUS2A_ENDING        = $0F   ; Ending music
    ; MUS2B_OVERWORLD     = $10   ; Overworld 1
    ; MUS2B_UNDERGROUND   = $20   ; Underground
    ; MUS2B_UNDERWATER    = $30   ; Water
    ; MUS2B_FORTRESS      = $40   ; Fortress
    ; MUS2B_BOSS          = $50   ; Boss
    ; MUS2B_AIRSHIP       = $60   ; Airship
    ; MUS2B_BATTLE        = $70   ; Hammer Bros. battle
    ; MUS2B_TOADHOUSE     = $80   ; Toad House
    ; MUS2B_ATHLETIC      = $90   ; Overworld 2
    ; MUS2B_PSWITCH       = $A0   ; P-Switch
    ; MUS2B_BOWSER        = $B0   ; Bowser
    ; MUS2B_WORLD8LETTER  = $C0   ; Bowser's World 8 Letter
    ; MUS2B_MASK          = $F0   ; Not intended for use in code, readability/traceability only
    ; GamePlay_BGM:
    ; .byte MUS2B_OVERWORLD   ; 0  ($10)
    ; .byte MUS2B_UNDERGROUND ; 1  ($20)
    ; .byte MUS2B_UNDERWATER  ; 2  ($30)
    ; .byte MUS2B_FORTRESS    ; 3  ($40)
    ; .byte MUS2B_BOSS        ; 4  ($50)
    ; .byte MUS2B_AIRSHIP     ; 5  ($60)
    ; .byte MUS2B_BATTLE      ; 6  ($70)
    ; .byte MUS2B_TOADHOUSE   ; 7  ($80)
    ; .byte MUS2B_ATHLETIC    ; 8  ($90)
    ; .byte MUS2A_THRONEROOM  ; 9  ($0D)
    ; .byte MUS2A_SKY         ; 10 ($09)
    LDA Sound_QMusic2
    BEQ _process_sounds ; no music queued
    CMP #MUS2A_SKY      ; music >= MUS2A_SKY must use level table rather than world table
    BCS _level_music
    SEC
    SBC #1  ; A = index of world song
    LDX #0  ; X = 0 (world songs)
_music_init:
    JSR bhop_player_init_music
    LDA Sound_QMusic2
    STA SndCur_Music2
    BNE _process_sounds ; (always)
_level_music:
    LSR
    LSR
    LSR
    LSR    ; A = index of level song
    LDX #1 ; X = 1 (level songs)
    BNE _music_init ; (always)
_stop_music:
    sta track_ptr+1
_mute:
    jsr bhop_mute_all
_process_sounds:
    LDA Sound_QPause
    BNE SndPause     ; If a "pause/resume" was requested, jump to SndPause
    LDA SndCur_Pause
    BNE PRG028_A04F     ; If playing the pause sound, jump to PRG028_A04F
    LDA Sound_IsPaused
    BNE PRG028_A08F     ; If sound is currently paused, jump to PRG028_A08F (allows processing of pause sound)

    JMP Sound_Process   ; Otherwise, jump to normal sound processing routine!

SndPause:   ; $A017
    STA SndCur_Pause     ; Store it into the "hold" variable
    STA Sound_IsPaused   ; Mark sound as paused
    CMP #$02     ; Is the request actually to RESUME sound?
    BNE PRG028_A033  ; If not, go to PRG028_A033

    ; Want to RESUME sound, not pause!
    LDA #$00
    STA Sound_IsPaused   ; Clear IsPaused
    STA SndCur_Pause     ; Clear the pause sound hold

    jsr bhop_unmute_all
    
    BNE Sound_Process    ; (Technically always) jump to Sound_Process

PRG028_A033:
    ; Want to PAUSE sound
    ;LDA #$00
    ;STA PAPU_EN ; Disable all sound channels
    ;jsr bhop_mute_all
    jsr bhop_mute_sq1
    jsr bhop_mute_sq2
    LDA #$00

    ; Clear other sound counters
    STA SndCur_Player   ; Kill player sound
    STA SndCur_Level1   ; Kill level 1 sound
    STA SndCur_Level2   ; Kill level 2 sound
    LDA #$0f
    STA PAPU_EN ; Enable all sound channels
    LDA #$2a
    STA SFX_Counter1 ; SFX_Counter1 = $2A

PRG028_A04B:
    LDA #$68     ; Play note 104 (high bing)
    BNE PRG028_A060  ; (Technically always) jump to PRG028_A060

PRG028_A04F:
    LDA SFX_Counter1
    CMP #$24
    BEQ PRG028_A05E  ; If SFX_Counter1 is at $24, jump to PRG028_A05E (play a low bing)
    CMP #$1e
    BEQ PRG028_A04B  ; If SFX_Counter1 is at $1E, jump to PRG028_A04B (play another high bing)
    CMP #$18
    BNE PRG028_A067  ; If SFX_Counter1 is at $18, jump to PRG028_A067 (otherwise, just decrement)

PRG028_A05E:
    LDA #96     ; Play note 96 (low bing)

PRG028_A060:
    LDX #$84     ; Goes to PAPU_CTL1
    LDY #$7f     ; Goes to PAPU_RAMP1
    JSR Sound_Sq1_NoteOn

PRG028_A067:
    DEC SFX_Counter1 ; SFX_Counter1--
    BNE PRG028_A08F  ; If not zero yet, go to PRG028_A08F

    ; Pause sound over!
    ;LDA #$00     ;
    ;STA PAPU_EN  ; Disable all sound channels
    LDA #$00     ;
    STA SndCur_Pause     ; Stop the pause sound hold
    BEQ PRG028_A08F  ; (technically always) go to PRG028_A08F

Sound_Process:
    ; Queue + Play all sounds in...
    JSR Sound_PlayLevel2     ; Level 2
    JSR Sound_PlayPlayer     ; Player
    JSR Sound_PlayLevel1     ; Level 1
    JSR Sound_PlayMapSounds  ; Map sounds
    ;;;JSR Sound_PlayMusic  ; Music

    ; Clear any music queues
    LDA #$00
    STA Sound_QMusic2
    STA Sound_QMusic1

PRG028_A08F:

    ; Clear all sound queues
    LDA #$00
    STA Sound_QPlayer
    STA Sound_QLevel1
    STA Sound_QLevel2
    STA Sound_QMap
    STA Sound_QPause
    RTS      ; Return

Sound_PlayMapSounds:
    LDA Sound_QMap
    BNE MapSound_Queued  ; If a map sound has been queued, jump to MapSound_Queued
    LDA SndCur_Map
    BNE MapSound_Playing     ; If a map sound is already playing, jump to MapSound_Playing

    ; Nothing to do!
    RTS      ; Return

MapSound_Queued:
    jsr bhop_mute_sq1
    LDA Sound_QMap      ; reload queue
    CMP #SND_MAPENTERLEVEL
    BNE PRG028_A0BD  ; If not playing Map Entering Level sound, go to PRG028_A0BD

    ; Entering level sound only:
    ;STX PAPU_EN  ; Disable all sound channels
    ;LDX #$0f     ;
    ;STX PAPU_EN  ; Enable all sound channels
    JSR bhop_mute_all
    LDA Sound_QMap

PRG028_A0BD:
    STA SndCur_Map ; Lock in this sound as playing!

    ; Sound_Unused7FF = 0 (but never used again...)
    LDY #$00
    STY Sound_Unused7FF

    ; The map sounds are issued by bit ($01, $02, $04, $08, etc.)
    ; this loop converts it to a Y value of 1-8
    ; Basically you earn a prioritization system; lowest sound plays first!
PRG028_A0C5:
    INY      ; Y++
    LSR A        ; Sound >> 1 ... -> Carry
    BCC PRG028_A0C5  ; Waiting for that bit...!

    LDA Sound_Map_LUT-1,Y   ; Unfortunately the index is one off, so we have to access the LUT one prior
    TAY         ; Y = first byte for this sound from LUT

    ; Y is now an offset gleaned from the first 8 bytes of this table...
    LDA Sound_Map_LUT,Y ; A = Offset to sound
    STA Sound_Map_Off  ; Store offset to Sound_Map_Off

    LDA Sound_Map_LUT+1,Y   ; Offset for the second track of the sound
    STA Sound_Map_Off2  ; Store offset to Sound_Map_Off2

    LDA #$01     ;
    STA Sound_Map_Len    ; Sound_Map_Len = 1, so it updates immediately
    STA Sound_Map_Len2   ; Sound_Map_Len2 = 1, so it updates immediately

MapSound_Playing:
    DEC Sound_Map_Len    ; Sound_Map_Len--
    BNE PRG028_A136  ; If Sound_Map_Len > 0, jump to PRG028_A136

    ; Sound_Map_Len = 0 ...
    LDY Sound_Map_Off  ; Y = Sound_Map_Off
    INC Sound_Map_Off  ; Sound_Map_Off++
    LDA SndMap_Data,Y   ; Get next byte of sound data

    BEQ MapSound_Stop   ; If it's $00, sound over!  Jump to MapSound_Stop
    BPL MapSound_PlayFreqL  ; $00 - $7f injects a new byte into PAPU_FT1 (low byte frequency)
    BNE MapSound_SetLen ; $80 - $ff, MapSound_SetLen

MapSound_Stop:
    LDA #$08     ;
    STA PAPU_EN  ; Only noise channel left enabled
    LDA #$0f     ;
    STA PAPU_EN  ; All channels enabled
    jsr bhop_unmute_sq1
    LDA #$00     ;
    STA SndCur_Map ; Release hold, no longer playing a sound
    RTS      ; Return

MapSound_SetLen:
    JSR AND7F       ; Just keep the lower 7 bits
    STA Sound_Map_LHold ; Use this as the new length value for any following bytes
    LDY Sound_Map_Off  ; Y = offset into sound data
    INC Sound_Map_Off  ; Sound_Map_Off++
    LDA SndMap_Data,Y   ; Get the next (presumably not rest!) byte


MapSound_PlayFreqL:
    STA PAPU_FT1     ; Byte goes directly into frequency register
    LDA SndCur_Map ; Get the hold value
    BPL PRG028_A120  ; If $80 not set, jump to PRG028_A120

    LDA #$0e     ;
    STA PAPU_CT1     ; Fairly high frequency, short length
    LDX #%10011111   ; Square 1's CTL settings: Max volume, envelope decay disabled, 50% duty cycle
    BNE PRG028_A127  ; (technically always) jump to PRG028_A127

PRG028_A120:
    LDA #$08     ;
    STA PAPU_CT1     ; Short length
    LDX #%10010111   ; Square 1's CTL settings: Half volume, envelope decay disabled, 50% duty cycle

PRG028_A127:
    LDY #$7f     ; Ramp settings: Everything except actually enabling the ramp!
    JSR Sound1_XCTL_YRAMP

    LDA Sound_Map_LHold  ; Get the current length hold value
    STA Sound_Map_Len    ; Reset the length counter with this value!
    LDA #$00         ;
    STA Sound_Map_EntrV     ; Start at index 0 for volume ramping (sound $04, level enter, ONLY!)

PRG028_A136:
    LDA SndCur_Map ; Get current map sound we're playing
    CMP #$04     ;
    BNE PRG028_A147  ; If it's NOT $04 (entering level) jump to PRG028_A147

    ; $04 (entering level) specific...
    ; The volume is ramped down as the sound plays!
    INC Sound_Map_EntrV     ; Sound_Map_EntrV++
    LDY Sound_Map_EntrV     ; Y = Sound_Map_EntrV
    LDA SndMap_Entr_VolData-1,Y  ; because they incremented the pointer FIRST, I have to subtract 1 from the LUT address!
    STA PAPU_CTL1    ; Set the new volume!

PRG028_A147:
    ; For any sound...

    LDY Sound_Map_Off2  ; Y = Sound_Map_Off2
    BEQ PRG028_A19B     ; If Sound_Map_Off2 = 0, jump to PRG028_A19B (do nothing; an offset of zero disables the track)

    DEC Sound_Map_Len2  ; Sound_Map_Len2--
    BNE PRG028_A18F     ; If not zero, jump to PRG028_A18F

    LDY Sound_Map_Off2  ; Y = Sound_Map_Off2 (again)
    INC Sound_Map_Off2  ; Sound_Map_Off2++

    LDA SndMap_Data,Y   ; Get this byte of sound data
    BPL MapSound_Play2FreqL ; If it is $00-$7f, jump to BPL MapSound_Play2FreqL

    ; Otherwise this is a length setting
    JSR AND7F       ; & $7F
    STA Sound_Map_L2Hld ; Use this as the new length for following bytes
    LDY Sound_Map_Off2  ; Y = Sound_Map_Off2
    INC Sound_Map_Off2  ; Sound_Map_Off2++
    LDA SndMap_Data,Y   ; Get the next (presumably note!) byte

MapSound_Play2FreqL:
    CMP #$7e     ;
    BNE PRG028_A176  ; Is the next byte $7e? If not, jump to PRG028_A176
    LDA #%00010000   ;
    STA PAPU_CTL2    ; Disables envelope decay, but that's it
    BNE PRG028_A185  ; (technically always) jump to PRG028_A185

PRG028_A176:
    ; Every other byte...
    STA PAPU_FT2

    LDX #$08     ;
    STX PAPU_CT2     ; Short length
    LDX #%01010101   ; Square 2's CTL settings: 33% volume, envelope decay disabled, 25% duty cycle
    LDY #$7f     ; Ramp settings: Everything except actually enabling the ramp!
    JSR Sound2_XCTL_YRAMP

PRG028_A185:
    LDA Sound_Map_L2Hld  ; Get the current length hold value
    STA Sound_Map_Len2   ; Reset the length counter with this value!

    ; Sound_Map_EntV2 = 0
    LDA #$00
    STA Sound_Map_EntV2

PRG028_A18F:
    INC Sound_Map_EntV2     ; Sound_Map_EntV2++

    LDY Sound_Map_EntV2    ; Y = Sound_Map_EntV2

    LDA SndMap_Entr_VolData-1,Y
    ORA #$50     ; Envelope decay disable + 25% duty cycle
    STA PAPU_CTL2    ; Set the register

PRG028_A19B:
    RTS      ; Return

SndMap_Entr_VolData:
    ; This ramps down the volume during the "level enter" sound
    .byte $97, $96, $96, $95, $95, $95, $94, $94, $94, $93, $93, $92, $92, $91, $91, $91


AND7F:  ; This seems like a ridiculous subroutine!
    AND #$7f
    RTS      ; Return

Sound_Map_LUT:
    ; These are offsets from here to the respective SFX data headers
    .byte SndMapH_Entrance - Sound_Map_LUT ; 1 - SND_MAPENTERWORLD    ($01)
    .byte SndMapH_Move     - Sound_Map_LUT ; 2 - SND_MAPPATHMOVE      ($02)
    .byte SndMapH_Enter    - Sound_Map_LUT ; 3 - SND_MAPENTERLEVEL    ($04)
    .byte SndMapH_Flip     - Sound_Map_LUT ; 4 - SND_MAPINVENTORYFLIP ($08)
    .byte SndMapH_Bonus    - Sound_Map_LUT ; 5 - SND_MAPBONUSAPPEAR   ($10)
    .byte SndMapH_Unused   - Sound_Map_LUT ; 6 - $20 unused
    .byte SndMapH_Unused   - Sound_Map_LUT ; 7 - $40 unused
    .byte SndMapH_Deny     - Sound_Map_LUT ; 8 - SND_MAPDENY          ($80)


    ;   Offset1, Offset2
    ; Offset1 specifies a first track played on Square 1 at 50% duty cycle
    ; Offset2 specifies a second track played on Square 2 at 25% duty cycle, only used by the level entry sound...
SndMapH_Entrance:   .byte SndMap_Data_WEnt - SndMap_Data,    $00 ; SND_MAPENTERWORLD    ($01): World begin starry entrance sound
SndMapH_Move:       .byte SndMap_Data_Move - SndMap_Data,    $00 ; SND_MAPPATHMOVE      ($02): Path move
SndMapH_Enter:      .byte SndMap_Data_Entr - SndMap_Data,    SndMap_Data_Entr2 - SndMap_Data ; SND_MAPENTERLEVEL ($04): Enter level
SndMapH_Flip:       .byte SndMap_Data_Flip - SndMap_Data,    $00 ; SND_MAPINVENTORYFLIP ($08): Flip inventory
SndMapH_Bonus:      .byte SndMap_Data_Bonus - SndMap_Data,   $00 ; SND_MAPBONUSAPPEAR   ($10): Bonus appears
SndMapH_Deny:       .byte SndMap_Data_Deny - SndMap_Data,    $00 ; SND_MAPDENY          ($80): Denied
SndMapH_Unused:     .byte SndMap_Data_Unused - SndMap_Data,  $00 ; $20/$40: ?? unused ?


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Format of Map sound data:
; $00:      Ends sound
; $01-$7F:  Sets PAPU_FT1 to this value (lower = higher pitch)
; $80-$FF:  Removing the high bit, this sets the length of following values
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SndMap_Data:
SndMap_Data_WEnt:
    .byte $83, $35, $32, $2F, $2C, $2A, $28, $25, $23, $21, $1F, $1D, $1C, $1A, $18, $16
SndMap_Data_Unused:
    .byte $00   ; NOTE: This is SndMap_Data_WEnt's terminator!

    ; NOTE: The SndMap_Data_Entr $04 sound is expected to be synced with volume values
    ; specified in the table SndMap_Entr_VolData!
SndMap_Data_Entr:
    .byte $84, $12, $15, $19, $1F, $23, $2A, $32, $3F, $47, $54, $64, $8A, $7F, $00

    ; "Second track" of entry sound, played on Square 2, only map sound to do this...
SndMap_Data_Entr2:
    .byte $82, $7E, $84, $12, $15, $19, $1F, $23, $2A, $32, $3F, $47, $54, $64, $8A, $7F, $00

SndMap_Data_Flip:
    .byte $85, $6A, $5F, $87, $47, $00

SndMap_Data_Move:
    .byte $85, $2A, $8A, $23, $00

SndMap_Data_Bonus:
    .byte $85, $54, $47, $3F, $35, $8A, $2A, $00

SndMap_Data_Deny:
    .byte $88, $14, $14, $8A, $14, $00

; End of "Map" sounds
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Bytes sent to PAPU_CTL1 for the swim sound
SwimCTL1_LUT:
    .byte $9F, $9B, $98, $96, $95, $94, $92, $90, $90, $9A, $97, $95, $93, $92


PRG028_A21D:
    ; Pipe sound comes here
    STY SndCur_Player   ; Mark what Player sound we're playing
    LDA #$08
    STA SFX_Counter1 ; SFX_Counter1 = 8
    BNE PRG028_A22F  ; (technically always) jump to PRG028_A22F

PRG028_A227:
    LSR Sound_QPlayer   ; Sound_QPlayer >>= 1
    BCS PRG028_A22F     ; If we're currently playing SND_PLAYERPOWER and it's also queued, keep ticking the SFX_Counter1
    JMP PlayerSnd_Stop      ; Otherwise, hop to PlayerSnd_Stop

PRG028_A22F:
    LDA #0
    jsr bhop_mute_channel
    DEC SFX_Counter1 ; SFX_Counter1--
    LDA SFX_Counter1 ; A =  SFX_Counter1
    BEQ PRG028_A23F  ; If SFX_Counter1 = 0, jump to PRG028_A23F
    CMP #$04     ;
    BNE PRG028_A24D  ; If SFX_Counter1 <> 4, jump to PRG028_A24D (do nothing)
    LDA #110     ; Note 110
    BNE PRG028_A246  ; (technically always) jump to PRG028_A246

PRG028_A23F:
    ; SFX_Counter1 = 8
    LDA #$08
    STA SFX_Counter1

    LDA #$72

PRG028_A246:
    LDX #%10110100   ; PAPU_CTL1 - volume 8, envelope decay disabled, looping enable, 50% duty
    LDY #$7f     ; PAPU_RAMP - Everything but the ramp enable!
    JSR Sound_Sq1_NoteOn

PRG028_A24D:
    RTS      ; Return

PlayerSnd_Frog:
    STY SndCur_Player   ; Mark what Player sound we're playing
    LDA #66      ; Slightly higher note, otherwise same as PlayerSnd_Jump
    BNE PRG028_A25A  ; Jump (technically always) to PRG028_A25A

PlayerSnd_Jump:
    STY SndCur_Player   ; Mark what Player sound we're playing
    LDA #52      ; Note 52

PRG028_A25A:
    LDX #%10000010   ; PAPU_CTL1  - 50% duty, envelope decay rate 2
    LDY #%10100111   ; PAPU_RAMP1 - Max shift amount, rate update 2, enable sweep
    JSR Sound_Sq1_NoteOn     ; Play sound!

    LDA #$28
    STA SFX_Counter1 ; Load SFX_Counter1 = $28; when this expires, sound ends!

PlayerSnd_FrogCont:
    LDA SFX_Counter1 ; A = SFX_Counter1
    CMP #$25     ;
    BNE PRG028_A273  ; If SFX_Counter1 <> $25, go to PRG028_A273

    ; When SFX_Counter1 reaches $25...
    LDX #%01011111   ; PAPU_CTL1  - max decay rate (and disabled), 25% duty
    LDY #%11110110   ; PAPU_RAMP1 - slower right shift, max sweep rate, and enabled
    BNE PRG028_A27B  ; (technically always) jump to PRG028_A27B

PRG028_A273:
    ; SFX_Counter1 <> $25...
    CMP #$20     ;
    BNE PRG028_A2A6  ; If SFX_Counter1 <> $20, go to PRG028_A2A6

    ; When SFX_Counter1 reaches $20...
    LDX #%01001000   ; PAPU_CTL1  - volume 0, decay disabled, 25% duty
    LDY #%10111100   ; PAPU_RAMP1 - shift amount 4, decrease wavelength, sweep update 3, sweep enable

PRG028_A27B:
    JSR Sound1_XCTL_YRAMP
    BNE PRG028_A2A6  ; (technically always) jump to PRG028_A2A6

PlayerSnd_Fire:
    STY SndCur_Player   ; Mark what Player sound we're playing
    LDA #5      ; SFX_Counter1 will be 5
    LDY #%10011001   ; PPU_RAMP1 - right shift minimal, decrease wavelength, sweep rate 1, enable sweep
    BNE PRG028_A290  ; Jump (technically always) to PRG028_A290

PlayerSnd_Bump:
    STY SndCur_Player   ; Mark what Player sound we're playing
    LDA #10      ; SFX_Counter1 will be 5
    LDY #%10010011   ; PPU_RAMP1 - right shift 3, increase wavelength, sweep update 1, enable sweep

PRG028_A290:
    LDX #%10011110   ; PAPU_CTL1 - volume 14, decay disabled, 50% duty
    STA SFX_Counter1

    LDA #38      ; Note 38
    JSR Sound_Sq1_NoteOn     ; Play sound!

PlayerSnd_FirBmpCont:
    LDA SFX_Counter1
    CMP #$06
    BNE PRG028_A2A6  ; If SFX_Counter1 <> 6, go to PRG028_A2A6

    ; SFX_Counter1 = 6...
    LDA #%10111011   ;
    STA PAPU_RAMP1   ; right shift 3, decrease wavelength, sweep rate 3, enable sweep

PRG028_A2A6:
    JMP PRG028_A325  ; A <> 0, jump to PRG028_A325

PRG028_A2A8:
    ; SFX_Counter1 = 0 is the only point you get down here...
    ; or from Sound_QPlayer = $40 (SND_PLAYERPOWER)
    JMP PRG028_A227  ; Jump to  PRG028_A227

Sound_PlayPlayer:
    LDY Sound_QPlayer ; Get sound queue for Player sounds
    BEQ PRG028_A2D0  ; If 0, nothing's queued; go to PRG028_A2D0

    LDA #0
    jsr bhop_mute_channel
    LDY Sound_QPlayer ; Get sound queue for Player sounds

    BMI PlayerSnd_Frog  ; If sound $80 frog jump, go to PlayerSnd_Frog

    ; Since the input is a bit value ($01, $02, $04, ...), this will
    ; decode it by continuously shifting to the right until we hit
    ; a bit; this also incidentally provides a simple priority system.

    LSR Sound_QPlayer
    BCS PlayerSnd_Jump  ; If sound $01 (SND_PLAYERJUMP), go to PlayerSnd_Jump
    LSR Sound_QPlayer
    BCS PlayerSnd_Bump  ; If sound $02 (SND_PLAYERBUMP), go to PlayerSnd_Bump
    LSR Sound_QPlayer
    BCS PlayerSnd_Swim  ; If sound $04 (SND_PLAYERSWIM), go to PlayerSnd_Swim
    LSR Sound_QPlayer
    BCS PlayerSnd_Kick  ; If sound $08 (SND_PLAYERKICK), go to PlayerSnd_Kick
    LSR Sound_QPlayer
    BCS PlayerSnd_Pipe  ; If sound $10 (SND_PLAYERPIPE), go to PlayerSnd_Pipe
    LSR Sound_QPlayer
    BCS PlayerSnd_Fire  ; If sound $20 (SND_PLAYERFIRE), go to PlayerSnd_Fire

PRG028_A2D0:
    LDA SndCur_Player
    BEQ PRG028_A2E9  ; If no sound playing, jump to PRG028_A2E9

    BMI PlayerSnd_FrogCont   ; If sound $80 (SND_PLAYERFROG), go to PlayerSnd_FrogCont
    LSR A        ;
    BCS PlayerSnd_JumpCont   ; If sound $01 (SND_PLAYERJUMP), go to PlayerSnd_JumpCont
    LSR A        ;
    BCS PlayerSnd_FirBmpCont ; If sound $02 (SND_PLAYERBUMP), go to PlayerSnd_FirBmpCont
    LSR A        ;
    BCS PlayerSnd_SwimCont   ; If sound $04 (SND_PLAYERSWIM), go to PlayerSnd_SwimCont
    LSR A        ;
    BCS PlayerSnd_KickCont   ; If sound $08 (SND_PLAYERKICK), go to PlayerSnd_KickCont
    LSR A        ;
    BCS PlayerSnd_PipeCont   ; If sound $10 (SND_PLAYERPIPE), go to PlayerSnd_PipeCont
    LSR A        ;
    BCS PlayerSnd_FirBmpCont ; If sound $20 (SND_PLAYERFIRE), go to PlayerSnd_FirBmpCont

PRG028_A2E9:
    LDA SndCur_Player
    CMP #SND_PLAYERPOWER
    BEQ PRG028_A2A8     ; If SndCur_Player = SND_PLAYERPOWER, go to PRG028_A2A8

    LSR Sound_QPlayer   ;
    BCS PRG028_A2FC     ; If Sound_QPlayer = SND_PLAYERPOWER, go to PRG028_A2FC
    RTS      ; Return

PlayerSnd_Pipe:
    JMP PlayerSnd_Pipe2

PlayerSnd_PipeCont:
    JMP PlayerSnd_PipeCont2

PRG028_A2FC:
    JMP PRG028_A21D  ; Jump to PRG028_A21D

PlayerSnd_JumpCont: ; jump update comes here
    JMP PlayerSnd_FrogCont

PlayerSnd_Swim:
    STY SndCur_Player   ; Mark what Player sound we're playing
    LDA #$0e
    STA SFX_Counter1 ; SFX_Counter1 = $0e
    LDY #$9c     ; PAPU_RAMP1
    LDX #$9e     ; PAPU_CTL1
    LDA #66      ; Note 66
    JSR Sound_Sq1_NoteOn

PlayerSnd_SwimCont:
    LDY SFX_Counter1
    LDA SwimCTL1_LUT-1,Y    ; SFX_Counter1 is used as an index into SwimCTL1_LUT; we subtract 1 because SFX_Counter1 must be at least 1
    STA PAPU_CTL1       ; Store next swim CTL1 command
    CPY #$06     ;
    BNE PRG028_A325  ; If SFX_Counter1 <> 6, jump to PRG028_A325
    LDA #$9e     ;
    STA PAPU_FT1     ; Update PAPU_FT1

PRG028_A325:
    BNE PlayerSnd_CounterUpd     ; (technically always) jump to PlayerSnd_CounterUpd

PlayerSnd_Kick:
    STY SndCur_Player   ; Mark what Player sound we're playing
    LDA #$0e     ;
    LDY #$cb     ; PAPU_RAMP1
    LDX #$9f     ; PAPU_CTL1
    STA SFX_Counter1 ; SFX_Counter1 = $0E
    LDA #68      ; Note 68
    JSR Sound_Sq1_NoteOn     ; Play sound!
    BNE PlayerSnd_CounterUpd

PlayerSnd_KickCont:
    LDY SFX_Counter1
    CPY #$08     ;
    BNE PRG028_A34A  ; If SFX_Counter1 <> 8, go to PRG028_A34A
    LDA #$a0     ;
    STA PAPU_FT1     ; Update register
    LDA #$9f     ;
    BNE PRG028_A34C  ; (technically always) jump to PRG028_A34C

PRG028_A34A:
    LDA #$90

PRG028_A34C:
    STA PAPU_CTL1

PlayerSnd_CounterUpd:
    DEC SFX_Counter1 ; SFX_Counter1--
    BNE PRG028_A363  ; If SFX_Counter1 <> 0, go to PRG028_A363 (do nothing)

    ; Counter has dropped to zero!
PlayerSnd_Stop:
    LDX #$00        ;
    STX SndCur_Player   ; Clear Player sound hold
    jsr bhop_unmute_sq1
    ;LDX #$1e        ;
    ;STX PAPU_EN     ; Disable square wave 1
    ;LDX #$0f        ;
    ;STX PAPU_EN     ; Enable every channel

PRG028_A363:
    RTS      ; Return

PlayerSnd_Pipe2:
    STY SndCur_Player   ; Mark what Player sound we're playing
    LDA #$2f
    STA SFX_Counter1    ; SFX_Counter1 = $2F

PlayerSnd_PipeCont2:
    LDA SFX_Counter1
    LSR A        ;
    BCS PRG028_A382  ; If SFX_Counter1 & 1, jump to PRG028_A382
    LSR A        ;
    BCS PRG028_A382  ; If SFX_Counter1 & 2, jump to PRG028_A382
    AND #$02     ;
    BEQ PRG028_A382  ; If !(SFX_Counter1 & 8), jump to PRG028_A382
    LDY #$91     ; PAPU_RAMP1
    LDX #$9a     ; PAPU_CTL1
    LDA #104     ; Note 104
    JSR Sound_Sq1_NoteOn

PRG028_A382:
    JMP PlayerSnd_CounterUpd

    ; the "1-up" sound
SndLev1_1upData:
    .byte $23, $2F, $35, $2A, $47, $54

    ; the "power up" sound
SndLev1_PUpData:
    .byte $6A, $74, $6A, $64, $5C, $52, $5C, $52
    .byte $4C, $44, $66, $70, $66, $60, $58, $4E, $58, $4E, $48, $40, $56, $60, $56, $50
    .byte $48, $3E, $48, $3E, $38, $30, $30

SndLev1_PUpRiseData:
    .byte $7E, $3E, $40, $32, $7E, $40, $42, $34, $7E
    .byte $42, $44, $36, $7E, $44, $46, $38, $7E, $46, $48, $3A, $7E, $48, $4A, $3C, $7E
    .byte $4A, $4C, $3E, $7E, $4C, $4E

SndLev1_Coin2:
    STY SndCur_Level1    ; Mark what "level 1" sound we're playing
    LDA #$35     ; SFX_Counter2 value
    LDX #$8d     ; PAPU_CTL2
    BNE PRG028_A3D9  ; (technically always) jump to PRG028_A3D9

SndLev1_Text2:
    STY SndCur_Level1    ; Mark what "level 1" sound we're playing
    LDA #$06     ; SFX_Counter2 value
    LDX #$98     ; PAPU_CTL2

PRG028_A3D9:
    STA SFX_Counter2
    LDY #$7f     ; PAPU_RAMP2
    LDA #94      ; Note 94
    JSR Sound_Sq2_NoteOn

SndLev1_Coin_Cont2:
    LDA SFX_Counter2
    CMP #$30
    BNE PRG028_A3EF  ; If SFX_Counter2 <> $30, jump to PRG028_A3EF

    LDA #$54
    STA PAPU_FT2

PRG028_A3EF:
    BNE SndLev1_PUp_Cont2    ; $A3EF

SndLev1_Boom:
    STY SndCur_Level1    ; Mark what "level 1" sound we're playing
    LDA #$20
    STA SFX_Counter2
    LDY #$94
    LDA #$1c
    BNE PRG028_A40C  ; (technically always) jump to PRG028_A40C

SndLev1_Boom_Cont2:
    LDA SFX_Counter2
    CMP #$18
    BNE SndLev1_PUp_Cont2
    LDY #$93
    LDA #$34
    LDX #$9f
PRG028_A40C:
    JMP PRG028_A425

SndLev1_PUp:
    STY SndCur_Level1    ; Mark what "level 1" sound we're playing
    LDA #$36
    STA SFX_Counter2     ; SFX_Counter2 = $36

SndLev1_PUp_Cont:
    LDA SFX_Counter2
    LSR A
    BCS SndLev1_PUp_Cont2    ; If SFX_Counter2 & 1, jump to SndLev1_PUp_Cont2
    TAY      ; Y = A
    LDA SndLev1_PUpData-1,Y ; As in other parts of sound code, -1 because SFX_Counter2 must be > 0
    LDX #$5d     ; PAPU_CTL2
    LDY #$7f     ; PAPU_RAMP2

PRG028_A425:
    JSR Sound_Sq2_NoteOn

SndLev1_PUp_Cont2:
    DEC SFX_Counter2
    BNE PRG028_A43C  ; If SFX_Counter2 <> 0, jump to PRG028_A43C (RTS)

PRG028_A42D:

    ; SndCur_Level1 = 0
    LDX #$00
    STX SndCur_Level1

    ; Disable and re-enable square 2
    ;LDX #$0d
    ;STX PAPU_EN
    ;LDX #$0f
    ;STX PAPU_EN
    JSR bhop_mute_sq2
    JSR bhop_unmute_sq2

PRG028_A43C:
    RTS      ; Return

SndLev1_PUpRise:
    JMP SndLev1_PUpRise2

SndLev1_Coin:
    JMP SndLev1_Coin2

SndLev1_VineRise:
    JMP SndLev1_VineRise2

SndLev1_SuitLost:
    JMP SndLev1_SuitLost2

Sound_PlayLevel1:
    LDA SndCur_Level1
    AND #$40     ;
    BNE SndLev1_1upCont  ; If currently playing level 1 sound is $40 1-up, jump to SndLev1_1up (overrides any new sounds!)

    LDY Sound_QLevel1
    BEQ PRG028_A47A  ; If no Level 1 sound is queued, jump to PRG028_A47A

    BMI SndLev1_SuitLost     ; If sound $80 (SND_LEVELPOOF) sound, jump to SndLev1_SuitLost

    JSR bhop_mute_sq2

    ; Since the input is a bit value ($01, $02, $04, ...), this will
    ; decode it by continuously shifting to the right until we hit
    ; a bit; this also incidentally provides a simple priority system.

    LSR Sound_QLevel1
    BCS SndLev1_Coin     ; If sound $01 (SND_LEVELCOIN), jump to SndLev1_Coin
    LSR Sound_QLevel1
    BCS SndLev1_PUpRise  ; If sound $02 (SND_LEVELRISE), jump to SndLev1_PUpRise
    LSR Sound_QLevel1
    BCS SndLev1_VineRise     ; If sound $04 (SND_LEVELVINE), jump to SndLev1_VineRise
    LSR Sound_QLevel1
    BCS SndLev1_Boom     ; If sound $08 (SND_LEVELBABOOM), jump to SndLev1_Boom
    LSR Sound_QLevel1
    BCS SndLev1_Text     ; If sound $10 (SND_LEVELBLIP), jump to SndLev1_Text
    LSR Sound_QLevel1
    BCS SndLev1_PUp  ; If sound $20 (SND_LEVELPOWER), jump to SndLev1_PUp
    LSR Sound_QLevel1
    BCS SndLev1_1up  ; If sound $40 (SND_LEVEL1UP), jump to SndLev1_1up

PRG028_A47A:
    LDA SndCur_Level1
    BEQ PRG028_A496  ; If no sound is playing, jump to PRG028_A496 (Do nothing)

    BMI SndLev1_SuitLost_Cont    ; If sound (SND_LEVELPOOF) "lost suit" sound, jump to SndLev1_SuitLost_Cont
    LSR A
    BCS SndLev1_Coin_Cont    ; If sound $01 (SND_LEVELCOIN), jump to SndLev1_Coin_Cont
    LSR A
    BCS SndLev1_PUpRise_Cont     ; If sound $02 (SND_LEVELRISE), jump to SndLev1_PUpRise_Cont
    LSR A
    BCS SndLev1_PUpRise_Cont     ; If sound $04 (SND_LEVELVINE), jump to SndLev1_PUpRise_Cont
    LSR A
    BCS SndLev1_Boom_Cont    ; If sound $08 (SND_LEVELBABOOM), jump to SndLev1_Boom_Cont
    LSR A
    BCS SndLev1_Text_Cont    ; If sound $10 (SND_LEVELBLIP), jump to SndLev1_Text_Cont
    LSR A
    BCS SndLev1_PUp_Cont     ; If sound $20 (SND_LEVELPOWER), jump to SndLev1_PUp_Cont
    LSR A
    BCS SndLev1_1upCont  ; If sound $40 (SND_LEVEL1UP), jump to SndLev1_1upCont

PRG028_A496:
    RTS      ; Return

SndLev1_SuitLost_Cont:
    JMP SndLev1_SuitLost_Cont2

SndLev1_Text:
    JMP SndLev1_Text2

SndLev1_Coin_Cont:
SndLev1_Text_Cont:
    JMP SndLev1_Coin_Cont2

SndLev1_Boom_Cont:
    JMP SndLev1_Boom_Cont2

SndLev1_PUp_1up:
    JMP SndLev1_PUp_Cont2

SndLev1_1up:
    STY SndCur_Level1    ; Store what level 1 sound we're playing
    LDA #$30
    STA SFX_Counter2     ; SFX_Counter2 = $30

SndLev1_1upCont:
    LDA SFX_Counter2
    LDX #$03

PRG028_A4B3:
    LSR A
    BCS SndLev1_PUp_1up  ; If SFX_Counter2 & 1, jump to SndLev1_PUp_1up
    DEX      ; X--
    BNE PRG028_A4B3  ; If X > 0, loop

    TAY         ; Y = A
    LDA SndLev1_1upData-1,Y ; As in other parts of sound code, -1 because SFX_Counter2 must be > 0
    STA PAPU_FT2        ; Store this into PAPU_FT2

    LDX #$82        ; PAPU_CTL2
    LDY #$7f        ; PAPU_RAMP2
    JSR Sound2_XCTL_YRAMP

    ; PAPU_CT2 = 8
    LDA #$08
    STA PAPU_CT2

    JMP SndLev1_PUp_Cont2    ; Jump to SndLev1_PUp_Cont2

SndLev1_PUpRise2:
    STY SndCur_Level1    ; Mark what "level 1" sound we're playing

    LDA #$10
    BNE PRG028_A4DB  ; Jump (technically always) to PRG028_A4DB

SndLev1_VineRise2:
    STY SndCur_Level1    ; Mark what "level 1" sound we're playing
    LDA #$20

PRG028_A4DB:
    STA SFX_Counter2     ; Set SFX_Counter2

    LDA #$7f
    STA PAPU_RAMP2   ;  [NES] Audio -> Square 2

    ; SFX_Counter3 = 0
    LDA #$00
    STA SFX_Counter3

SndLev1_PUpRise_Cont:
    INC SFX_Counter3 ; SFX_Counter3++

    LDA SFX_Counter3
    LSR A
    TAY      ; Y = SFX_Counter3 >> 1
    CPY SFX_Counter2
    BEQ PRG028_A501  ; If SFX_Counter3 / 2 = SFX_Counter2, jump to PRG028_A501 (PRG028_A42D)

    LDA #$9d
    STA PAPU_CTL2    ;  [NES] Audio -> Square 2

    LDA SndLev1_PUpRiseData-1,Y  ; As in other parts of sound code, -1 because SFX_Counter2 must be > 0
    JSR Sound_Sq2_NoteOn_NoPAPURAMP

    RTS      ; Return

PRG028_A501:
    JMP PRG028_A42D  ; Jump to PRG028_A42D

PRG028_A504:
    JMP PRG028_A47A  ; Jump to PRG028_A47A

SndLev1_SuitLost2:
    JSR bhop_mute_sq2
    LDY Sound_QLevel1
    CPY #SND_LEVELPOOF
    BNE PRG028_A512  ; If this is not the "poof" sound, jump to PRG028_A512

    ; "Poof" sound effect
    LDA #SndLev1_DataPoof - SndLev1_Data
    BNE PRG028_A529  ; Jump (technically always) to PRG028_A529

PRG028_A512:
    CPY #SND_LEVELUNK
    BNE PRG028_A51A  ; If not unknown / lost sound, jump to PRG028_A51A

    ; Unknown / lost sound
    LDA #SndLev1_DataUnk - SndLev1_Data
    BEQ PRG028_A529  ; Jump (technically always) to PRG028_A529

PRG028_A51A:
    CPY #SND_LEVELSHOE
    BNE PRG028_A522  ; If not these sounds, jump to PRG028_A522

    ; Lost shoe sound
    LDA #SndLev1_DataLostShoe - SndLev1_Data
    BNE PRG028_A529  ; Jump (technically always) to PRG028_A529

PRG028_A522:
    LDA SndCur_Level1
    BNE PRG028_A504  ; If any level 1 sounds are playing, jump to PRG028_A504

    ; Tail wag
    LDA #SndLev1_DataLongWag - SndLev1_Data

PRG028_A529:
    STA SFX_Counter2     ; Set SFX_Counter2 appropriately

    ; Filter out sound selection
    TYA
    AND #SND_LEVELPOOF | SND_LEVELTAILWAG | SND_LEVELSHOE
    STY SndCur_Level1

SndLev1_SuitLost_Cont2:
    INC SFX_Counter2     ; SFX_Counter2++

    LDY SFX_Counter2     ; Y = SFX_Counter2

    LDA SndLev1_Data,Y   ; Get data
    BEQ PRG028_A553  ; If data = 0, jump to PRG028_A553
    BPL PRG028_A544  ; If data > 0, jump to PRG028_A544

    ; data < 0...

    ; Store value -> SFX_Counter3
    STA SFX_Counter3
    BNE SndLev1_SuitLost_Cont2   ; Jump (technically always) to SndLev1_SuitLost_Cont2

PRG028_A544:
    LDX #$7f
    STX PAPU_RAMP2   ;  [NES] Audio -> Square 2

    LDX SFX_Counter3
    STX PAPU_CTL2    ;  [NES] Audio -> Square 2

    JSR Sound_Sq2_NoteOn_NoPAPURAMP

    RTS      ; Return

PRG028_A553:
    ; SFX_Counter2 = 0
    LDA #$00
    STA SFX_Counter2

    JMP PRG028_A42D  ; Jump to PRG028_A42D


SndLev1_Data:
SndLev1_DataUnk:
    ;.byte $9F, $30, $34, $36, $38, $9F, $3A, $3C, $3E, $40, $9A, $3A, $3C, $3E, $40, $9C ; $A55B - $A56A
    ;.byte $3A, $3C, $3E, $40, $96, $3A, $3C, $3E, $40, $98, $3A, $3C, $3E, $40, $00
    .byte $9A, $44, $D9, $42, $D7, $40, $D6, $3E
    .byte $9A, $46, $D9, $44, $D7, $42, $D6, $40
    .byte $9A, $48, $D9, $46, $D7, $44, $D6, $42, $00

SndLev1_DataPoof:
    .byte $9F
    .byte $2E, $2A, $26, $22, $9D, $2E, $2A, $7E, $7E, $9F, $30, $2E, $2A, $28, $9D, $30 ; $A57B - $A58A
    .byte $2E, $7E, $7E, $9F, $38, $34, $32, $30, $9D, $38, $34, $32, $30, $9A, $38, $34 ; $A58B - $A59A
    .byte $32, $30, $9C, $38, $34, $32, $30, $97, $38, $34, $32, $30, $98, $38, $34, $32 ; $A59B - $A5AA
    .byte $30, $94, $38, $34, $32, $30, $00

SndLev1_DataLostShoe:
    .byte $9F, $42, $40, $7E, $7E, $9F, $46, $48, $7E ; $A5AB - $A5BA
    .byte $7E, $9A, $4A, $4E, $50, $52, $96, $4E, $52, $54, $56, $00

SndLev1_DataLongWag:
    .byte $90, $7E, $7E, $97 ; $A5BB - $A5CA
    .byte $4C, $4E, $90, $7E, $7E, $95, $52, $54, $56, $58, $94, $52, $54, $56, $58, $93 ; $A5CB - $A5DA
    .byte $52, $54, $56, $58, $00

SndLev2_MarchData:
    .byte $55, $81, $AA, $02, $74, $B7, $A5, $04, $92, $A9, $08 ; $A5DB - $A5EA
    .byte $69, $58, $4A

SndLev2_BoomerangData:
    .byte $11, $61, $21, $51, $81, $21, $61, $A2, $23, $64, $A5, $76

SndLev2_SkidNFreq:
    .byte $01, $0E, $0E, $0D, $0B, $06, $0C, $0F, $0A, $09, $03, $0D, $08, $0D, $06

SndLev2_SkidTFreq:
    .byte $0C, $47, $49, $42, $4A, $43, $4B

SndLev2_Skid:
    STY SndCur_Level2    ; Mark what "level 2" sound we're playing

    ; SFX_Counter4 = 6
    LDA #$06
    STA SFX_Counter4

SndLev2_SkidCont:
    LDA SFX_Counter4
    TAY      ; Y = SFX_Counter4

    LDA SndLev2_SkidTFreq,Y
    STA PAPU_TFREQ1  ; [NES] Audio -> Triangle

    LDA #$18
    STA PAPU_TCR1    ; [NES] Audio -> Triangle
    STA PAPU_TFREQ2  ; [NES] Audio -> Triangle
    BNE PRG028_A64C  ; Jump (technically always) to PRG028_A64C

SndLev2_Crumble:
    STY SndCur_Level2    ; Mark what "level 2" sound we're playing

    ; SFX_Counter4 = $20
    LDA #$20
    STA SFX_Counter4

SndLev2_CrumbleCont:
    LDA SFX_Counter4
    LSR A
    BCC PRG028_A64C  ; Every other tick, jump to PRG028_A64C

    TAY      ; SFX_Counter4 / 2 -> 'Y'
    LDX SndLev2_SkidNFreq,Y  ; Get noise frequency
    LDA SndLev2_SkidNCtl,Y   ; Get noise CTL value

PRG028_A641:

    ; Set both
    STA PAPU_NCTL1
    STX PAPU_NFREQ1

    LDA #$18
    STA PAPU_NFREQ2  ; [NES] Audio -> Noise Frequency reg #2

PRG028_A64C:
    DEC SFX_Counter4 ; SFX_Counter4--
    BNE PRG028_A660  ; If SFX_Counter4 <> 0, jump to PRG028_A660 (RTS)

    LDA #$f0
    STA PAPU_NCTL1   ; [NES] Audio -> Noise control reg
    LDA #$00
    STA PAPU_TCR1    ; [NES] Audio -> Triangle

    ; SndCur_Level2 = 0
    LDA #$00
    STA SndCur_Level2
    JSR bhop_unmute_noisetri

PRG028_A660:
    RTS      ; Return

Sound_PlayLevel2:
    LDA SndCur_Level2
    CMP #SND_LEVELAIRSHIP
    BNE PRG028_A66B  ; If this is not the airship sound, jump to PRG028_A66B

    JMP SndLev2_AirshipCont  ; Jump to SndLev2_AirshipCont

PRG028_A66B:

    ; This is here because sounds $20 and $40 are undefined;
    ; if they were to be defined, this could sit down below...
    LDA SndCur_Level2
    BMI SndLev2_SkidCont     ; If sound $80 (SND_LEVELSKID) is currently playing, jump to SndLev2_SkidCont (overrides queue)

    LDY Sound_QLevel2
    BEQ PRG028_A690  ; If no level 2 sound is queued, jump to PRG028_A690

    JSR bhop_mute_noisetri
    LDY Sound_QLevel2

    BMI SndLev2_Skid     ; If sound $80 (SND_LEVELSKID), jump to SndLev2_Skid

    ; Since the input is a bit value ($01, $02, $04, ...), this will
    ; decode it by continuously shifting to the right until we hit
    ; a bit; this also incidentally provides a simple priority system.

    LSR Sound_QLevel2
    BCS SndLev2_Crumble  ; If sound $01 (SND_LEVELCRUMBLE), jump to SndLev2_Crumble
    LSR Sound_QLevel2
    BCS SndLev2_Flame    ; If sound $02 (SND_LEVELFLAME), jump to SndLev2_Flame
    LSR Sound_QLevel2
    BCS SndLev2_Boomerang    ; If sound $04 (SND_BOOMERANG), jump to SndLev2_Boomerang
    LSR Sound_QLevel2
    BCS SndLev2_Airship  ; If sound $08 (SND_LEVELAIRSHIP), jump to SndLev2_Airship
    LSR Sound_QLevel2
    BCS SndLev2_March    ; If sound $10 (SND_LEVELMARCH), jump to SndLev2_March

    ; NOTE: Level 2 set sounds $20 and $40 are undefined!


PRG028_A690:

    ; No sound is queued...

    LDA SndCur_Level2
    BEQ PRG028_A6A4  ; If no sound is playing, jump to PRG028_A6A4 (RTS)
    LSR A
    BCS SndLev2_CrumbleCont  ; If sound $01 (SND_LEVELCRUMBLE), jump to SndLev2_CrumbleCont
    LSR A
    BCS SndLev2_FlameCont    ; If sound $02 (SND_LEVELFLAME), jump to SndLev2_FlameCont
    LSR A
    BCS SndLev2_BoomerangCont    ; If sound $04 (SND_BOOMERANG), jump to SndLev2_BoomerangCont
    LSR A
    BCS SndLev2_AirshipCont  ; If sound $08 (SND_LEVELAIRSHIP), jump to SndLev2_AirshipCont
    LSR A
    BCS SndLev2_MarchCont    ; If sound $10 (SND_LEVELMARCH), jump to SndLev2_MarchCont

PRG028_A6A4:
    RTS      ; Return

SndLev2_Flame:
    STY SndCur_Level2    ; Mark what "level 2" sound we're playing

    ; SFX_Counter4 = $40
    LDA #$40
    STA SFX_Counter4

SndLev2_FlameCont:
    LDA SFX_Counter4
    LSR A
    TAY      ; Y = SFX_Counter4 / 2

    LDX #$0f     ; X = $F
    LDA PRG028_A709-1,Y

PRG028_A6B7:
    JMP PRG028_A641  ; If data <> 0, jump to PRG028_A641

SndLev2_March:
    STY SndCur_Level2    ; Mark what "level 2" sound we're playing

    ; SFX_Counter4 = $E
    LDA #$0e
    STA SFX_Counter4

SndLev2_MarchCont:
    LDA SFX_Counter4
    TAY      ; Y = SFX_Counter4

    ; Lower 4 bits OR'd with $10 -> 'X'
    LDA SndLev2_MarchData,Y
    AND #$0f
    ORA #$10
    TAX

    ; Upper 4 bits shifted down, OR'd with $10
    LDA SndLev2_MarchData,Y
    LSR A
    LSR A
    LSR A
    LSR A
    ORA #$10

PRG028_A6D6:
    BNE PRG028_A6B7  ; Jump (technically always) to PRG028_A6B7

SndLev2_Boomerang:
    STY SndCur_Level2    ; Mark what "level 2" sound we're playing

    ; SFX_Counter4 = $C
    LDA #$0c
    STA SFX_Counter4

SndLev2_BoomerangCont:
    LDA SFX_Counter4
    TAY      ; Y = SFX_Counter4

    ; Lower 4 bits OR'd with $10 -> 'X'
    LDA SndLev2_BoomerangData,Y
    AND #$0f
    ORA #$10
    TAX

    ; Upper 4 bits shifted down, OR'd with $10
    LDA SndLev2_BoomerangData,Y
    LSR A
    LSR A
    LSR A
    LSR A
    ORA #$10

PRG028_A6F5:
    BNE PRG028_A6D6  ; Jump (technically always) to PRG028_A6D6

SndLev2_Airship:
    STY SndCur_Level2    ; Mark what "level 2" sound we're playing

    ; SFX_Counter4 = $40
    LDA #$40
    STA SFX_Counter4

SndLev2_AirshipCont:
    LDA SFX_Counter4
    LSR A
    LSR A
    TAX      ; X = SFX_Counter4 >> 2

    ORA #$10     ; Value OR'd with $10
    BNE PRG028_A6F5  ; Jump (technically always) to PRG028_A6F5


PRG028_A709:
    .byte $15, $16, $16, $17, $17, $18, $19, $19, $1A, $1A, $1C, $1D, $1D, $1E, $1E, $1F ; $A709 - $A718
    .byte $1F, $1F, $1F, $1E, $1D, $1C, $1E, $1F, $1F, $1E, $1D, $1C, $1A, $18, $16, $14 ; $A719 - $A728

SndLev2_SkidNCtl:
    .byte $15, $16, $16, $17, $17, $18, $19, $19, $1A, $1A, $1C, $1D, $1D, $1E, $1E, $1F ; SndLev2_SkidNCtl - $A738
    .byte $A5, $8B, $C9, $03, $F0, $10, $C0


.proc bhop_mute_all
    lda #%00110000
    sta $4000 ; pulse1_muted
    sta $4004 ; pulse2_muted
    sta $400C ; noise_muted
    lda #$80
    sta $4008 ; triangle_muted
    ; dpcm
    lda #%00001111
    sta $4015

    ldx #4
_loop:
    txa
    jsr bhop_mute_channel ; trashes x with a, so it preserves x
    dex
    bpl _loop

    rts
.endproc

.proc bhop_mute_sq1
    lda #%00110000
    sta $4000 ; pulse1_muted
    lda #0
    jsr bhop_mute_channel
    rts
.endproc

.proc bhop_unmute_sq1
    lda #0
    jsr bhop_unmute_channel
    rts
.endproc

.proc bhop_mute_sq2
    lda #%00110000
    sta $4004 ; pulse1_muted
    lda #1
    jsr bhop_mute_channel
    rts
.endproc

.proc bhop_unmute_sq2
    lda #1
    jsr bhop_unmute_channel
    rts
.endproc

.proc bhop_mute_noisetri
    lda #%00110000
    sta $400C ; noise_muted
    lda #$80
    sta $4008 ; triangle_muted
    lda #2
    jsr bhop_mute_channel
    lda #3
    jsr bhop_mute_channel
    rts
.endproc

.proc bhop_unmute_noisetri
    lda #2
    jsr bhop_unmute_channel
    lda #3
    jsr bhop_unmute_channel
    rts
.endproc

.proc bhop_unmute_all
    ldx #4
_loop:
    txa
    jsr bhop_unmute_channel ; trashes x with a, so it preserves x
    dex
    bpl _loop
    rts
.endproc

.proc bhop_apply_music_bank
    PHA
    LDA #MMC3_8K_TO_PRG_C000    ; Changing PRG ROM at C000
    STA MMC3_COMMAND        ; Set MMC3 command
    PLA
    STA MMC3_PAGE           ; Set MMC3 page
    RTS
.endproc
.export bhop_apply_music_bank

; ----- Music Stuff -----

.struct MusicTrack
        ModulePtr .word
        BankNumber .byte
.endstruct

.macro music_track module_ptr, bank_number
.scope
.addr module_ptr
.byte bank_number
.endscope
.endmacro

song_e1m1:      music_track MODULE_DOOM,   <.bank(MODULE_DOOM)
song_world1:    music_track MODULE_W1,     <.bank(MODULE_W1)
song_virus:     music_track MODULE_VIRUS,  <.bank(MODULE_VIRUS)

bhop_world_songs:
bhop_level_songs:
        .addr song_virus

        .addr song_e1m1 ; World 1
        .addr song_world1 ; World 2
        .addr song_virus
        .addr song_virus
        .addr song_virus
        .addr song_virus
        .addr song_virus
        .addr song_virus
        .addr song_virus
        .addr song_virus
        .addr song_virus
        .addr song_virus

bhop_song_tbl_hi:
    .byte >bhop_world_songs, >bhop_level_songs
bhop_song_tbl_lo:
    .byte <bhop_world_songs, <bhop_level_songs

; X is index of song table
; 0 - world songs
; 1 - level songs
; A is index of song
.proc bhop_player_init_music
    pha
    lda bhop_song_tbl_lo, X
    sta track_ptr+0
    lda bhop_song_tbl_hi, X
    sta track_ptr+1
    pla
    asl
    tay

    lda (track_ptr), y
    pha
    iny
    lda (track_ptr), y
    sta track_ptr+1
    pla
    sta track_ptr
    ; Set the correct bank for this song
    ldy #<MusicTrack::BankNumber
    lda (track_ptr), y
    jsr bhop_set_module_bank
    ; Initialize bhop with track 0 of the module specified by the song
    ldy #<MusicTrack::ModulePtr
    lda (track_ptr), y
    tax ; lo ptr for the module address
    iny
    lda (track_ptr), y
    tay ; hi ptr for the module address
    lda #TRACK_0
    jsr bhop_init
    lda #0
    sta track_ptr
    sta track_ptr+1
    rts
.endproc

.endscope
