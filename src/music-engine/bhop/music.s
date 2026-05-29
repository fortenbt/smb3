.autoimport +

.importzp track_ptr

.segment "PRG_BHOP"

; ----- Music Stuff -----
.struct MusicTrack
    ModulePtr .word
    BankNumber .byte
.endstruct

.define TRACK_0 0

.macro music_track module_ptr
  .scope
    .addr module_ptr
    .byte <.bank(module_ptr)
  .endscope
.endmacro

.struct SongTblHdr
    Magic .byte 4
    NumSongs .byte
.endstruct

.macro NUM_SONGS start
  .scope
    end = .ident(.sprintf("%s_end", .string(start)))
    .byte <((end - (start + .sizeof(SongTblHdr))) / .sizeof(MusicTrack))
  .endscope
.endmacro

.macro SONG_TABLE_HEADER
    .byte "BHOP"
    NUM_SONGS bhop_song_table
.endmacro

bhop_song_table:
    SONG_TABLE_HEADER
    song_death:        music_track DEATH
    song_world1:       music_track W1
    song_revenge:      music_track REVENGE
    song_guile:        music_track GUILE
    song_course_clear: music_track COURSE_CLEAR
    song_w1_1:         music_track W1_1
    song_w1_2:         music_track W1_2
    song_brinstar:     music_track BRINSTAR
    song_summit:       music_track SUMMIT
    song_bobomb:       music_track BOBOMB
    song_eastern:      music_track EASTERN
    song_virus:        music_track VIRUS
    song_shop:         music_track SHOP
bhop_song_table_end:

    ; MUS2
    ; These have 1 subtracted from them to index a music table
    ; 1-8 are used for world music
    ; MUS2A_WORLD1        = $01   ; World 1
    ; MUS2A_WORLD2        = $02   ; World 2
    ; MUS2A_WORLD3        = $03   ; World 3
    ; MUS2A_WORLD4        = $04   ; World 4
    ; MUS2A_WORLD5        = $05   ; World 5
    ; MUS2A_WORLD6        = $06   ; World 6
    ; MUS2A_WORLD7        = $07   ; World 7
    ; MUS2A_WORLD8        = $08   ; World 8
    ; 
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

    ; MUS1 are
    ; MUS1_PLAYERDEATH    = $01   ; Player death
    ; MUS1_GAMEOVER       = $02   ; Game over
    ; MUS1_BOSSVICTORY    = $04   ; Victory normal
    ; MUS1_WORLDVICTORY   = $08   ; Victory super (King reverted, Bowser defeated, etc.)
    ; MUS1_BOWSERFALL     = $10   ; Bowser dramatic falling
    ; MUS1_COURSECLEAR    = $20   ; Course Clear
    ; MUS1_TIMEWARNING    = $40   ; Time Warning (attempts to speed up song playing)
    ; MUS1_STOPMUSIC      = $80   ; Stops playing any music
bhop_mus1_songs:
        .addr song_death        ; MUS1_PLAYERDEATH
        .addr song_death        ; MUS1_GAMEOVER
        .addr song_death        ; MUS1_BOSSVICTORY
        .addr song_death        ; MUS1_WORLDVICTORY
        .addr song_death        ; MUS1_BOWSERFALL
        .addr song_course_clear ; MUS1_COURSECLEAR
        .addr song_course_clear ; MUS1_TIMEWARNING
bhop_special_songs:
                                ; MUS2A_SKY           = $09   ; Coin Heaven / Sky World / Warp Zone (World 9)
                                ; MUS2A_INVINCIBILITY = $0A   ; Invincibility
                                ; MUS2A_WARPWHISTLE   = $0B   ; Warp whistle
                                ; MUS2A_MUSICBOX      = $0C   ; Music box
                                ; MUS2A_THRONEROOM    = $0D   ; King's room
                                ; MUS2A_BONUSGAME     = $0E   ; Bonus game
                                ; MUS2A_ENDING        = $0F   ; Ending music
bhop_level_songs:
        .addr song_summit       ; MUS2B_OVERWORLD
        .addr song_guile        ; MUS2B_UNDERGROUND
        .addr song_brinstar     ; MUS2B_UNDERWATER
        .addr song_guile        ; MUS2B_FORTRESS
        .addr song_guile        ; MUS2B_BOSS
        .addr song_w1_2         ; MUS2B_AIRSHIP
        .addr song_w1_2         ; MUS2B_BATTLE
        .addr song_bobomb       ; MUS2B_TOADHOUSE
        .addr song_brinstar     ; MUS2B_ATHLETIC
        .addr song_w1_2         ; 
        .addr song_w1_2         ; 
        .addr song_w1_2         ; 
        .addr song_w1_2         ; 
bhop_world_songs:
        .addr song_shop         ; MUS2A_WORLD1
        .addr song_virus        ; MUS2A_WORLD2
        .addr song_revenge      ; MUS2A_WORLD3
        .addr song_world1

bhop_song_tbl_hi:
    .byte >bhop_world_songs, >bhop_level_songs, >bhop_mus1_songs, >bhop_special_songs
bhop_song_tbl_lo:
    .byte <bhop_world_songs, <bhop_level_songs, <bhop_mus1_songs, <bhop_special_songs

; X is index of song table
; 0 - mus2a $01-$08, "world bgm" songs (e.g. each map bgm)
; 1 - mus2b $10-$C0, "level bgm" songs (e.g. athletic, overworld, fortress, peach letter, toadhouse, etc)
; 2 - mus1 $01-$40, "during level" songs (e.g. death, gameover, victory, etc)
; 3 - mus2a $09-$0f, "special" songs (e.g. coin heaven, invincibility, music box, king's room, ending, etc)
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
.export bhop_player_init_music

.segment "MUS_01"

.segment "MUS_02" ; 2 - 5
    W1:
        .include "music/world1.asm"
    .export W1

.segment "MUS_05" ; solely in 5
    COURSE_CLEAR:
        .include "music/end-of-level.asm"
    .export COURSE_CLEAR

.segment "MUS_05" ; solely in 5
    DEATH:
        .include "music/death.asm"
    .export DEATH

.segment "MUS_05" ; 5 - 6
    W1_1:
        .include "music/w1-1.asm"
    .export W1_1

.segment "MUS_06" ; 6 - 9
    W1_2:
        .include "music/w1-2.asm"
    .export W1_2

.segment "MUS_0A" ; solely in A
    REVENGE:
        .include "music/revenge.asm"
    .export REVENGE

.segment "MUS_0A" ; solely in A
    BRINSTAR:
        .include "music/brinstar.asm"
    .export BRINSTAR

.segment "MUS_0A" ; A - B
    GUILE:
        .include "music/guile.asm"
    .export GUILE

.segment "MUS_0B"
    SUMMIT:
        .include "music/summit.asm"
    .export SUMMIT

.segment "MUS_0E"
    VIRUS:
        .include "music/virus-busting.asm"
    .export VIRUS

.segment "MUS_0E"
    BOBOMB:
        .include "music/bobomb.asm"
    .export BOBOMB

.segment "MUS_10"
    EASTERN:
        .include "music/eastern-night.asm"
    .export EASTERN

.segment "MUS_11"
    SHOP:
        .include "music/wii-shop-2a03.asm"
    .export SHOP

.segment "MUS_12"
.segment "MUS_13"
.segment "MUS_14"
.segment "MUS_15"
.segment "MUS_16"
.segment "MUS_17"
.segment "MUS_18"
.segment "MUS_19"
.segment "MUS_1A"
.segment "MUS_1B"
.segment "MUS_1C"
.segment "MUS_1D"
.segment "MUS_1E"
.segment "MUS_1F"
.segment "MUS_20"
