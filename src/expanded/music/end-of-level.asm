; Dn-FamiTracker exported music data: end-of-level.ftm
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

; DPCM samples list (location, size, bank)
ft_samples:
	.byte <((ft_sample_2 - $C000) >> 6), 16, <.bank(ft_sample_2)

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
	.byte $82, $00, $E0, $92, $93, $00, $FA, $2E, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00
	.byte $F3, $00, $83, $F2, $00, $01, $F1, $00, $02, $82, $00, $92, $93, $00, $FA, $30, $93, $01, $F9, $00
	.byte $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3, $00, $83, $F2, $00, $01, $F1, $00, $02, $82, $00, $91
	.byte $81, $93, $00, $FA, $31, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3, $00, $83
	.byte $F2, $00, $01, $F1, $00, $02, $82, $00, $92, $93, $00, $FA, $33, $93, $01, $F9, $00, $F8, $00, $F7
	.byte $00, $83, $F6, $00, $01, $F5, $00, $01, $F4, $00, $01, $F3, $00, $02, $F2, $00, $02, $F1, $00, $05
	.byte $F0, $00, $01, $91, $81, $F3, $35, $01, $F4, $00, $00, $F5, $00, $01, $F6, $00, $02, $F7, $00, $03
	.byte $92, $F3, $36, $01, $F4, $00, $00, $F5, $00, $01, $F6, $00, $02, $F7, $00, $03, $91, $81, $F3, $38
	.byte $01, $F4, $00, $00, $F5, $00, $01, $F6, $00, $02, $F7, $00, $03, $82, $00, $91, $81, $93, $00, $FA
	.byte $35, $93, $01, $F9, $00, $F8, $00, $F7, $00, $83, $F6, $00, $01, $F5, $00, $01, $F4, $00, $01, $F3
	.byte $00, $02, $F2, $00, $02, $F1, $00, $05, $F0, $00, $19, $82, $00, $92, $93, $00, $FA, $29, $93, $01
	.byte $F9, $00, $F8, $00, $F7, $00, $83, $F6, $00, $01, $F5, $00, $01, $F4, $00, $01, $F3, $00, $02, $F2
	.byte $00, $02, $F1, $00, $05, $F0, $00, $58

ft_s0p0c1:
	.byte $82, $00, $E0, $91, $81, $93, $00, $FA, $31, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4
	.byte $00, $F3, $00, $83, $F2, $00, $01, $F1, $00, $02, $82, $00, $92, $93, $00, $FA, $33, $93, $01, $F9
	.byte $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3, $00, $83, $F2, $00, $01, $F1, $00, $02, $82, $00
	.byte $91, $81, $93, $00, $FA, $35, $93, $01, $F9, $00, $F7, $00, $F6, $00, $F5, $00, $F4, $00, $F3, $00
	.byte $83, $F2, $00, $01, $F1, $00, $02, $82, $00, $92, $93, $00, $FA, $36, $93, $01, $F9, $00, $F8, $00
	.byte $F7, $00, $83, $F6, $00, $01, $F5, $00, $01, $F4, $00, $01, $F3, $00, $02, $F2, $00, $02, $F1, $00
	.byte $05, $F0, $00, $01, $91, $81, $F3, $38, $01, $F4, $00, $00, $F5, $00, $01, $F6, $00, $02, $F7, $00
	.byte $03, $92, $F3, $3A, $01, $F4, $00, $00, $F5, $00, $01, $F6, $00, $02, $F7, $00, $03, $92, $F3, $3C
	.byte $01, $F4, $00, $00, $F5, $00, $01, $F6, $00, $02, $F7, $00, $03, $82, $00, $91, $81, $93, $00, $FA
	.byte $3D, $93, $01, $F9, $00, $F8, $00, $F7, $00, $83, $F6, $00, $01, $F5, $00, $01, $F4, $00, $01, $F3
	.byte $00, $02, $F2, $00, $02, $F1, $00, $05, $F0, $00, $19, $82, $00, $91, $81, $93, $00, $FA, $31, $93
	.byte $01, $F9, $00, $F8, $00, $F7, $00, $83, $F6, $00, $01, $F5, $00, $01, $F4, $00, $01, $F3, $00, $02
	.byte $F2, $00, $02, $F1, $00, $05, $F0, $00, $58

ft_s0p0c2:
	.byte $E0, $92, $2A, $07, $7F, $1B, $27, $13, $7F, $03, $27, $07, $7F, $03, $2C, $07, $7F, $03, $2C, $07
	.byte $7F, $03, $25, $13, $7F, $1B, $25, $2F, $7F, $3E

ft_s0p0c3:
	.byte $E0, $93, $00, $FE, $1D, $00, $F0, $00, $0A, $FE, $00, $00, $F0, $00, $0A, $FE, $00, $00, $F0, $00
	.byte $0A, $FE, $00, $00, $F0, $00, $0A, $F0, $20, $0B, $FE, $1D, $00, $F0, $00, $0A, $FE, $00, $00, $F0
	.byte $00, $0A, $FE, $00, $00, $F0, $00, $0A, $FF, $1E, $04, $F0, $00, $12, $F0, $20, $86

ft_s0p0c4:
	.byte $82, $0B, $01, $01, $01, $01, $7E, $01, $01, $01, $83, $01, $5F, $7E, $3E

ft_s0p1c0:
	.byte $00, $FE

.endscope
