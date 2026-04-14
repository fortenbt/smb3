; Dn-FamiTracker exported music data: Brinstar_NES.ftm
;
.scope

; Module header
	.word ft_song_list
	.word ft_instrument_list
	.word ft_sample_list
	.word ft_samples
	.word ft_groove_list
	.byte 0 ; flags
	.word 14400 ; NTSC speed
	.word 14400 ; PAL speed

; Instrument pointer list
ft_instrument_list:
	.word ft_inst_0
	.word ft_inst_1
	.word ft_inst_2

; Instruments
ft_inst_0:
	.byte 0
	.byte $01
	.word ft_seq_2a03_5

ft_inst_1:
	.byte 0
	.byte $11
	.word ft_seq_2a03_25
	.word ft_seq_2a03_14

ft_inst_2:
	.byte 0
	.byte $11
	.word ft_seq_2a03_30
	.word ft_seq_2a03_14

; Sequences
ft_seq_2a03_5:
	.byte $0F, $FF, $00, $00, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01, $00
ft_seq_2a03_14:
	.byte $01, $FF, $00, $00, $00
ft_seq_2a03_25:
	.byte $21, $FF, $00, $00, $04, $04, $04, $04, $05, $05, $05, $05, $06, $06, $06, $06, $07, $07, $07, $07
	.byte $08, $08, $08, $08, $07, $07, $07, $07, $06, $06, $06, $06, $05, $05, $05, $05, $04
ft_seq_2a03_30:
	.byte $1D, $FF, $00, $00, $0D, $0D, $0D, $0D, $09, $09, $09, $09, $07, $07, $07, $07, $06, $06, $06, $06
	.byte $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $04

; DPCM instrument list (pitch, sample index)
ft_sample_list:

; DPCM samples list (location, size, bank)
ft_samples:

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
	.byte 15	; frame count
	.byte 24	; pattern length
	.byte 8	; speed
	.byte 150	; tempo
	.byte 0	; groove position
	.byte <.bank(ft_s0_frames)	; initial bank


;
; Pattern and frame data for all songs below
;

ft_s0_frames:
	.word ft_s0f0
	.word ft_s0f0
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
ft_s0f0:
	.word ft_s0p0c0, ft_s0p0c1, ft_s0p0c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p0c0), <.bank(ft_s0p0c1), <.bank(ft_s0p0c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
;ft_s0f1:
	;.word ft_s0p0c0, ft_s0p0c1, ft_s0p0c2, ft_s0p0c3, ft_s0p0c4
	;.byte <.bank(ft_s0p0c0), <.bank(ft_s0p0c1), <.bank(ft_s0p0c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f2:
	.word ft_s0p1c0, ft_s0p1c1, ft_s0p1c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c1), <.bank(ft_s0p1c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f3:
	.word ft_s0p1c0, ft_s0p1c1, ft_s0p1c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c1), <.bank(ft_s0p1c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f4:
	.word ft_s0p1c0, ft_s0p1c1, ft_s0p1c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p1c0), <.bank(ft_s0p1c1), <.bank(ft_s0p1c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f5:
	.word ft_s0p2c0, ft_s0p2c1, ft_s0p2c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p2c0), <.bank(ft_s0p2c1), <.bank(ft_s0p2c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f6:
	.word ft_s0p3c0, ft_s0p3c1, ft_s0p3c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p3c0), <.bank(ft_s0p3c1), <.bank(ft_s0p3c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f7:
	.word ft_s0p3c0, ft_s0p3c1, ft_s0p3c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p3c0), <.bank(ft_s0p3c1), <.bank(ft_s0p3c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f8:
	.word ft_s0p3c0, ft_s0p3c1, ft_s0p3c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p3c0), <.bank(ft_s0p3c1), <.bank(ft_s0p3c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f9:
	.word ft_s0p4c0, ft_s0p4c1, ft_s0p3c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p4c0), <.bank(ft_s0p4c1), <.bank(ft_s0p3c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f10:
	.word ft_s0p5c0, ft_s0p5c1, ft_s0p4c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p5c0), <.bank(ft_s0p5c1), <.bank(ft_s0p4c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f11:
	.word ft_s0p6c0, ft_s0p6c1, ft_s0p4c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p6c0), <.bank(ft_s0p6c1), <.bank(ft_s0p4c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f12:
	.word ft_s0p7c0, ft_s0p7c1, ft_s0p5c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p7c0), <.bank(ft_s0p7c1), <.bank(ft_s0p5c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f13:
	.word ft_s0p8c0, ft_s0p8c1, ft_s0p6c2, ft_s0p0c3, ft_s0p0c4
	.byte <.bank(ft_s0p8c0), <.bank(ft_s0p8c1), <.bank(ft_s0p6c2), <.bank(ft_s0p0c3), <.bank(ft_s0p0c4)
ft_s0f14:
	.word ft_s0p9c0, ft_s0p9c1, ft_s0p7c2, ft_s0p0c3, ft_s0p1c4
	.byte <.bank(ft_s0p9c0), <.bank(ft_s0p9c1), <.bank(ft_s0p7c2), <.bank(ft_s0p0c3), <.bank(ft_s0p1c4)
ft_s0p0c0:
	.byte $E1, $24, $0B, $25, $0B

ft_s0p0c1:
	.byte $E2, $91, $7F, $14, $02, $14, $00, $92, $0F, $00, $91, $7F, $14, $00, $14, $02, $14, $00, $92, $0F
	.byte $00, $91, $7F, $14, $00, $92, $17, $02, $17, $00, $91, $7F, $12, $00, $92, $17, $00, $17, $02, $17
	.byte $00, $91, $7F, $12, $00, $92, $17, $00

ft_s0p0c2:
	.byte $00, $17

ft_s0p0c3:
	.byte $E0, $1F, $02, $1F, $02, $1F, $02, $1F, $00, $1F, $00, $1F, $00, $1F, $02, $1F, $02, $1F, $02, $1F
	.byte $00, $1F, $00, $1F, $00

ft_s0p0c4:
	.byte $84, $08, $00, $17

ft_s0p1c0:
	.byte $82, $05, $E1, $24, $27, $25, $83, $2A, $05

ft_s0p1c1:
	.byte $E2, $2C, $0B, $91, $81, $2F, $07, $94, $20, $82, $00, $92, $2E, $94, $18, $91, $81, $2F, $94, $10
	.byte $92, $2E, $94, $08, $83, $2A, $00

ft_s0p1c2:
	.byte $E1, $20, $00, $9B, $1C, $00, $01, $82, $00, $9B, $1C, $20, $9B, $1C, $2C, $9B, $1C, $27, $20, $83
	.byte $9B, $1C, $00, $01, $82, $00, $9B, $1C, $20, $9B, $1C, $27, $9B, $1C, $20, $23, $83, $9B, $1C, $00
	.byte $01, $82, $00, $9B, $1C, $23, $9B, $1C, $2A, $9B, $1C, $23, $23, $83, $9B, $1C, $00, $01, $9B, $1C
	.byte $23, $00, $9B, $1C, $2A, $00, $9B, $1C, $23, $00

ft_s0p1c4:
	.byte $00, $16, $84, $09, $00, $00

ft_s0p2c0:
	.byte $E1, $24, $0B, $25, $05, $27, $05

ft_s0p2c1:
	.byte $E2, $2C, $0B, $2C, $0B

ft_s0p2c2:
	.byte $E1, $20, $00, $9B, $1C, $00, $01, $82, $00, $9B, $1C, $27, $9B, $1C, $20, $9B, $1C, $20, $20, $83
	.byte $9B, $1C, $00, $01, $82, $00, $9B, $1C, $27, $9B, $1C, $20, $9B, $1C, $20, $20, $83, $9B, $1C, $00
	.byte $01, $82, $00, $9B, $1C, $27, $9B, $1C, $20, $9B, $1C, $20, $20, $83, $9B, $1C, $00, $01, $9B, $1C
	.byte $27, $00, $9B, $1C, $20, $00, $9B, $1C, $20, $00

ft_s0p3c0:
	.byte $E1, $29, $08, $25, $00, $20, $00, $25, $00, $2A, $05, $27, $05

ft_s0p3c1:
	.byte $E2, $91, $81, $31, $08, $92, $2C, $02, $91, $81, $2F, $07, $94, $20, $82, $00, $92, $2E, $94, $18
	.byte $91, $81, $2F, $94, $10, $92, $2E, $94, $08, $83, $2A, $00

ft_s0p3c2:
	.byte $82, $00, $E1, $9B, $1C, $19, $9B, $1C, $20, $9B, $1C, $19, $19, $83, $9B, $1C, $00, $01, $82, $00
	.byte $9B, $1C, $19, $9B, $1C, $20, $9B, $1C, $19, $19, $83, $9B, $1C, $00, $01, $82, $00, $9B, $1C, $19
	.byte $9B, $1C, $20, $9B, $1C, $19, $19, $83, $9B, $1C, $00, $01, $82, $00, $9B, $1C, $19, $9B, $1C, $20
	.byte $9B, $1C, $19, $19, $83, $9B, $1C, $00, $01

ft_s0p4c0:
	.byte $E1, $29, $0B, $29, $0B

ft_s0p4c1:
	.byte $E2, $2C, $0B, $20, $0B

ft_s0p4c2:
	.byte $E1, $1C, $00, $9B, $1C, $00, $01, $82, $00, $9B, $1C, $1C, $9B, $1C, $19, $9B, $1C, $1C, $1C, $83
	.byte $9B, $1C, $00, $01, $82, $00, $9B, $1C, $1C, $9B, $1C, $19, $9B, $1C, $1C, $1B, $83, $9B, $1C, $00
	.byte $01, $82, $00, $9B, $1C, $1B, $9B, $1C, $17, $9B, $1C, $1B, $1B, $83, $9B, $1C, $00, $01, $9B, $1C
	.byte $1B, $00, $9B, $1C, $17, $00, $9B, $1C, $1B, $00

ft_s0p5c0:
	.byte $E1, $2A, $02, $25, $02, $22, $02, $25, $00, $23, $00, $25, $00, $27, $02, $2A, $02, $25, $05

ft_s0p5c1:
	.byte $E2, $2E, $08, $2E, $00, $2C, $00, $2E, $00, $91, $81, $2F, $05, $92, $2A, $02, $25, $00, $2A, $00
	.byte $2C, $00

ft_s0p5c2:
	.byte $E1, $20, $00, $9B, $1C, $00, $01, $16, $00, $9B, $1C, $00, $01, $18, $00, $9B, $1C, $00, $01, $19
	.byte $00, $9B, $1C, $00, $01, $1B, $00, $9B, $1C, $00, $01, $1D, $00, $9B, $1C, $00, $01, $1F, $00, $9B
	.byte $1C, $00, $01, $20, $00, $9B, $1C, $00, $01

ft_s0p6c0:
	.byte $E1, $28, $02, $22, $02, $1E, $02, $91, $7F, $19, $00, $92, $23, $00, $91, $7F, $19, $00, $92, $1B
	.byte $02, $1E, $02, $23, $02, $91, $7F, $19, $00, $92, $1E, $00, $22, $00

ft_s0p6c1:
	.byte $E2, $2E, $08, $2E, $00, $2C, $00, $2E, $00, $91, $81, $2F, $05, $92, $2A, $02, $2A, $00, $91, $81
	.byte $2F, $00, $31, $00

ft_s0p6c2:
	.byte $E1, $21, $00, $9B, $1C, $00, $01, $82, $00, $9B, $1C, $21, $9B, $1C, $1C, $9B, $1C, $19, $15, $83
	.byte $9B, $1C, $00, $01, $82, $00, $9B, $1C, $25, $9B, $1C, $23, $9B, $1C, $21, $1C, $83, $9B, $1C, $00
	.byte $01, $1B, $00, $9B, $1C, $00, $01, $19, $00, $9B, $1C, $00, $01, $17, $00, $9B, $1C, $00, $01

ft_s0p7c0:
	.byte $82, $05, $E1, $24, $22, $20, $83, $27, $05

ft_s0p7c1:
	.byte $E2, $92, $33, $0B, $91, $81, $31, $05, $92, $30, $05

ft_s0p7c2:
	.byte $E1, $22, $00, $9B, $1C, $00, $01, $22, $00, $9B, $1C, $00, $01, $22, $00, $9B, $1C, $00, $01, $22
	.byte $00, $9B, $1C, $00, $01, $82, $00, $9B, $1C, $22, $9B, $1C, $22, $9B, $1C, $22, $9B, $1C, $22, $9B
	.byte $1C, $22, $9B, $1C, $22, $9B, $1C, $22, $9B, $1C, $22, $9B, $1C, $22, $9B, $1C, $22, $9B, $1C, $22
	.byte $83, $9B, $1C, $22, $00

ft_s0p8c0:
	.byte $E1, $28, $02, $2A, $02, $21, $02, $20, $00, $1E, $00, $91, $7F, $1C, $00, $92, $1E, $02, $23, $02
	.byte $20, $02, $1E, $00, $91, $81, $2F, $00, $92, $27, $00

ft_s0p8c1:
	.byte $E2, $91, $81, $31, $08, $34, $00, $92, $33, $00, $91, $81, $31, $00, $92, $33, $05, $91, $81, $2F
	.byte $02, $2F, $00, $92, $33, $00, $36, $00

ft_s0p9c0:
	.byte $E1, $27, $0B, $24, $05, $20, $05

ft_s0p9c1:
	.byte $E2, $37, $0B, $37, $0B

.endscope
