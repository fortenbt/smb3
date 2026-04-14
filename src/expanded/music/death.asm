; Dn-FamiTracker exported music data: death.ftm
;
.autoimport +

.scope

; Module header
	.word ft_song_list
	.word ft_instrument_list
	.word ft_sample_list
	.word ft_samples
	.word ft_groove_list
	.byte 0 ; flags
	.word 3600 ; NTSC speed
	.word 3000 ; PAL speed

; Instrument pointer list
ft_instrument_list:
	.word ft_inst_0

; Instruments
ft_inst_0:
	.byte 0
	.byte $00

; Sequences

; DPCM instrument list (pitch, sample index)
ft_sample_list:
	.byte 15, 255, 0
	.byte 15, 255, 3
	.byte 14, 255, 3

; DPCM samples list (location, size, bank)
ft_samples:
	.byte <((ft_sample_2 - $C000) >> 6), 16, <.bank(ft_sample_2)
	.byte <((ft_sample_4 - $C000) >> 6), 56, <.bank(ft_sample_4)

; Groove list
ft_groove_list:
	.byte $00
; Grooves (size, terms)

; Song pointer list
ft_song_list:
	.word ft_song_0

; Song info
ft_song_0:
	.word ft_s0_frames
	.byte 29	; frame count
	.byte 255	; pattern length
	.byte 1	; speed
	.byte 150	; tempo
	.byte 0	; groove position
	.byte <.bank(ft_s0_frames)	; initial bank


;
; Pattern and frame data for all songs below
;

ft_s0_frames:
	.word ft_s0f0
	.word ft_s0f1
	.word ft_s0f2
	.word ft_s0f3
	.word ft_s0f4
	.word ft_s0f5
	.word ft_s0f6
	.word ft_s0f7
	.word ft_s0f8
	.word ft_s0f9
	.word ft_s0f10
	.word ft_s0f11
	.word ft_s0f12
	.word ft_s0f13
	.word ft_s0f14
	.word ft_s0f15
	.word ft_s0f16
	.word ft_s0f17
	.word ft_s0f18
	.word ft_s0f19
	.word ft_s0f20
	.word ft_s0f21
	.word ft_s0f22
	.word ft_s0f23
	.word ft_s0f24
	.word ft_s0f25
	.word ft_s0f26
	.word ft_s0f27
	.word ft_s0f28
ft_s0f0:
	.word ft_s0p0c0, ft_s0p0c1, ft_s0p0c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p0c0), <.bank(ft_s0p0c1), <.bank(ft_s0p0c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f1:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f2:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f3:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f4:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f5:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f6:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f7:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f8:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f9:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f10:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f11:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f12:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f13:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f14:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f15:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f16:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f17:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f18:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f19:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f20:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f21:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f22:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f23:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f24:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f25:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f26:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f27:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0f28:
	.word ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0, ft_s0p1c0
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0), <.bank(ft_s0p1c0)
ft_s0p0c0:
	.byte $82, $00, $E0, $91, $81, $93, $00, $FA, $2F, $93, $01, $F9, $2D, $F7, $2B, $F6, $29, $92, $93, $00
	.byte $FA, $30, $93, $01, $F9, $2E, $F7, $2C, $F6, $2A, $91, $81, $93, $00, $FA, $31, $93, $01, $F9, $2F
	.byte $F7, $2D, $F6, $2C, $83, $93, $02, $F0, $00, $0B, $93, $01, $00, $17, $82, $00, $92, $93, $00, $95
	.byte $94, $FA, $30, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3, $00, $F2, $00, $83
	.byte $F0, $00, $07, $82, $00, $92, $93, $00, $95, $94, $FA, $30, $93, $01, $F9, $00, $F7, $00, $F6, $00
	.byte $F5, $00, $F4, $00, $F3, $00, $F2, $00, $83, $F0, $00, $0F, $82, $00, $92, $93, $00, $95, $94, $FA
	.byte $2A, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3, $00, $F2, $00, $83, $F0, $00
	.byte $07, $82, $00, $92, $93, $00, $95, $94, $FA, $2A, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00
	.byte $F4, $00, $F3, $00, $F2, $00, $83, $F0, $00, $07, $82, $00, $92, $93, $00, $95, $94, $FA, $29, $93
	.byte $01, $F9, $00, $F8, $00, $F7, $00, $83, $F6, $00, $01, $F5, $00, $01, $F4, $00, $01, $F3, $00, $02
	.byte $F2, $00, $02, $F1, $00, $05, $F0, $00, $70

ft_s0p0c1:
	.byte $92, $93, $02, $F0, $7F, $17, $93, $01, $00, $17, $82, $00, $E0, $91, $81, $93, $00, $FA, $35, $93
	.byte $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3, $00, $F2, $00, $83, $F0, $00, $07, $82
	.byte $00, $91, $81, $93, $00, $FA, $35, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3
	.byte $00, $F2, $00, $83, $F0, $00, $0F, $82, $00, $92, $93, $00, $FA, $33, $93, $01, $F9, $00, $F7, $00
	.byte $F6, $00, $F5, $00, $F4, $00, $F3, $00, $F2, $00, $83, $F0, $00, $07, $82, $00, $92, $93, $00, $FA
	.byte $33, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3, $00, $F2, $00, $83, $F0, $00
	.byte $07, $82, $00, $91, $81, $93, $00, $FA, $31, $93, $01, $F9, $00, $F8, $00, $F7, $00, $83, $F6, $00
	.byte $01, $F5, $00, $01, $F4, $00, $01, $F3, $00, $02, $F2, $00, $02, $F1, $00, $05, $F0, $00, $70

ft_s0p0c2:
	.byte $92, $7F, $17, $E0, $2C, $05, $7F, $09, $2C, $05, $7F, $29, $2C, $05, $7F, $09, $2C, $05, $7F, $09
	.byte $25, $47, $7F, $3E

ft_s0p0c3:
	.byte $E0, $93, $00, $F0, $20, $FE

ft_s0p0c4:
	.byte $7E, $2F, $01, $07, $7E, $07, $01, $07, $7E, $0F, $01, $07, $7E, $07, $01, $07, $7E, $2F, $02, $07
	.byte $03, $17, $7E, $3E

ft_s0p1c0:
	.byte $00, $FE


; DPCM samples (located at DPCM segment)
.segment "aPRGFIXED_E000"

	.align 64
; ripped01.dmc
ft_sample_4:
	.byte $55, $55, $55, $55, $55, $55, $D5, $AA, $D5, $37, $02, $00, $F4, $A3, $FF, $FF, $7F, $00, $2A, $00
	.byte $00, $80, $FF, $FF, $FF, $7F, $05, $00, $00, $E0, $FF, $1F, $C0, $FF, $17, $00, $F0, $FF, $C0, $89
	.byte $FF, $00, $00, $E0, $FF, $FF, $FF, $03, $00, $00, $00, $FA, $FF, $3F, $00, $EC, $FF, $7F, $00, $FF
	.byte $7F, $00, $E0, $08, $00, $F8, $F7, $FF, $07, $0E, $90, $00, $80, $FE, $FF, $7F, $00, $C0, $FE, $7F
	.byte $7F, $01, $FE, $2F, $00, $8C, $00, $80, $FF, $FF, $4F, $00, $C0, $7F, $00, $F8, $0F, $FC, $07, $F0
	.byte $7F, $FF, $A6, $BF, $40, $5B, $00, $C0, $0A, $01, $FB, $8B, $FE, $04, $00, $FC, $FF, $00, $FC, $04
	.byte $FE, $91, $FB, $FF, $1F, $E0, $FF, $03, $00, $00, $60, $7F, $2B, $48, $C0, $FF, $02, $D0, $FE, $1F
	.byte $00, $FE, $09, $FA, $A5, $FF, $FF, $21, $A2, $FF, $01, $00, $04, $B0, $EF, $17, $81, $1D, $C0, $FE
	.byte $0F, $54, $0B, $AA, $FA, $3F, $00, $FF, $FE, $FF, $00, $F4, $57, $02, $00, $89, $A4, $3E, $50, $FF
	.byte $0F, $80, $FF, $0B, $01, $EA, $C4, $FD, $27, $DA, $B6, $FB, $2F, $E0, $85, $56, $02, $C0, $0B, $A8
	.byte $90, $BA, $FF, $2F, $80, $FD, $07, $C0, $56, $D2, $FE, $83, $FF, $89, $4F, $A5, $D6, $0A, $24, $01
	.byte $FC, $03, $F0, $02, $F8, $FF, $6B, $52, $BB, $09, $80, $BE, $BD, $84, $F6, $7F, $DF, $09, $00, $FB
	.byte $4B, $00, $D0, $8A, $4A, $55, $49, $FD, $AA, $FA, $AD, $5A, $05, $08, $7B, $B7, $A2, $52, $FF, $FF
	.byte $03, $00, $6D, $2B, $40, $52, $13, $D1, $B6, $EA, $AB, $42, $ED, $7F, $12, $92, $5A, $51, $9F, $A8
	.byte $4B, $DB, $B7, $AF, $40, $4B, $00, $D0, $2E, $91, $AA, $AA, $FD, $1F, $01, $F6, $BF, $08, $AD, $64
	.byte $2B, $95, $FA, $26, $B5, $A5, $7E, $A9, $2A, $01, $10, $D8, $2B, $B1, $EA, $BE, $7D, $25, $49, $6D
	.byte $15, $A9, $6B, $95, $C8, $EA, $DD, $49, $52, $5B, $2B, $49, $13, $41, $88, $D4, $F7, $91, $FA, $BE
	.byte $6D, $25, $28, $95, $D4, $5E, $55, $85, $B6, $BD, $64, $4B, $52, $AD, $88, $6A, $25, $08, $6A, $FB
	.byte $AA, $55, $6F, $FB, $91, $54, $09, $A8, $AD, $DA, $AD, $24, $BB, $5D, $05, $A9, $49, $92, $BA, $92
	.byte $24, $59, $6D, $57, $DB, $56, $D3, $2E, $AD, $2A, $08, $B0, $7B, $5B, $49, $DB, $57, $49, $22, $A9
	.byte $92, $64, $2B, $B5, $95, $A4, $B7, $6B, $B5, $6A, $25, $B5, $55, $22, $A4, $B2, $ED, $4A, $7D, $17
	.byte $A9, $89, $D4, $04, $50, $DB, $DB, $15, $EA, $B6, $6A, $9B, $D4, $96, $A4, $5A, $49, $55, $49, $6C
	.byte $AF, $76, $95, $54, $55, $55, $02, $A8, $56, $DB, $5E, $69, $5F, $A5, $52, $6D, $25, $89, $6A, $5B
	.byte $AA, $24, $B5, $55, $DB, $25, $69, $95, $54, $95, $20, $B5, $6A, $DB, $F6, $6D, $92, $5A, $95, $2A
	.byte $41, $EA, $2B, $B5, $52, $5A, $AB, $52, $6D, $AB, $92, $50, $B5, $52, $25, $A9, $ED, $6B, $B7, $91
	.byte $AD, $24, $95, $24, $A5, $56, $6B, $B5, $B6, $25, $A4, $B6, $55, $49, $A2, $D5, $4A, $55, $95, $D6
	.byte $6D, $6D, $AB, $AA, $44, $29, $95, $54, $A5, $6A, $DF, $A6, $4A, $A5, $AA, $92, $54, $55, $B5, $2A
	.byte $B5, $B5, $AA, $54, $7D, $AB, $2A, $11, $D5, $54, $92, $AA, $DA, $B6, $D5, $56, $52, $25, $29, $95
	.byte $AA, $56, $A9, $7B, $55, $55, $2A, $DB, $AA, $AA, $A4, $52, $2A, $55, $55, $AD, $AA, $76, $5B, $49
	.byte $15, $52, $55, $A9, $D4, $B6, $B5, $D5, $5A, $A9, $54, $49, $B5, $9A, $4A, $89, $DA, $4E, $49, $6B
	.byte $B5, $AD, $2A, $29, $A9, $92, $CA, $6A, $AB, $B6, $55, $DB, $54, $4A, $85, $AA, $55, $AA, $AA, $6A
	.byte $55, $55, $95, $D5, $AA, $AA, $55, $09, $95, $AA, $B6, $95, $DA, $B6, $B5, $92, $4A, $49, $95, $A4
	.byte $B6, $AA, $5A, $B5, $6A, $55, $52, $AA, $DA, $56, $92, $54, $B5, $AA, $AA, $B5, $AD, $56, $A9, $2A
	.byte $25, $49, $AA, $5A, $B5, $5A, $B5, $6A, $AD, $24, $A9, $AA, $B4, $6A, $55, $A5, $6A, $55, $AB, $55
	.byte $D5, $CA, $AA, $24, $49, $AA, $DA, $54, $AD, $6B, $55, $95, $AA, $56, $82, $5A, $D5, $56, $53, $D5
	.byte $6A, $55, $A9, $AA, $6A, $55, $49, $A5, $4A, $A9, $55, $B5, $6D, $55, $55, $55, $95, $A4, $92, $6A
	.byte $AB, $55, $6B, $55, $55, $55, $A9, $4A, $A5, $D6, $4A, $A5, $4A, $55, $6D, $AB, $AA, $55, $55, $95
	.byte $92, $54, $B5, $52, $AB, $6D, $AB, $54, $6A, $2B, $25, $4A, $55, $AB, $55, $95, $5A, $55, $5A, $B5
	.byte $6A, $55, $A5, $52, $95, $4A, $55, $AD, $B6, $B5, $AA, $54, $55, $95, $24, $55, $55, $AB, $6A, $6B
	.byte $A9, $52, $AB, $AA, $52, $AD, $AA, $52, $A5, $D4, $AA, $D5, $5A, $B5, $AA, $54, $52, $AA, $AA, $52
	.byte $55, $B5, $6D, $95, $AA, $A9, $AA, $4A, $AA, $5A, $55, $55, $55, $55, $A9, $55, $5B, $B5, $94, $2A
	.byte $95, $AA, $54, $55, $AD, $D6, $56, $55, $55, $95, $52, $A9, $6A, $AA, $5A, $AD, $5A, $29, $55, $AB
	.byte $AA, $AA, $AA, $2A, $95, $54, $B5, $AA, $5A, $AB, $55, $AB, $24, $55, $55, $55, $AA, $6A, $D5, $AA
	.byte $55, $55, $AA, $AA, $54, $55, $AB, $54, $AA, $55, $A9, $AA, $D5, $5A, $55, $55, $A9, $52, $95, $AA
	.byte $AA, $55, $B5, $6A, $55, $55, $4A, $55, $55, $95, $55, $55, $55, $2B, $55, $55, $DA

.endscope
