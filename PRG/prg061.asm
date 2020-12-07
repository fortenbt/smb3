Twilight_Hedr2: MusSeg 61, Twilight_R2, Twilight_2, $27, Twilight_Tri2, Twilight_Nse2, $0000
Twilight_Hedr3: MusSeg 61, Twilight_R3, Twilight_3, $1E, Twilight_Tri3, Twilight_Nse3, $0000
Twilight_Hedr4: MusSeg 61, Twilight_R4, Twilight_4, $29, Twilight_Tri4, Twilight_Nse4, $0000
Twilight_Hedr5: MusSeg 61, Twilight_R5, Twilight_5, $1E, Twilight_Tri5, Twilight_Nse5, $0000
Twilight_Hedr6: MusSeg 61, Twilight_R6, Twilight_6, $25, Twilight_Tri6, Twilight_Nse6, $0000

Twilight_R1:
	.byte $20, $06, $07, $0D, $40, $04, $03, $13, $38, $4D, $0B, $09, $08, $0A, $CB
Twilight_R2:
	.byte $20, $07, $06, $0D, $04, $4C, $05, $38, $4D, $40, $0C, $09, $0A, $03, $08, $02
Twilight_R3:
	.byte $20, $06, $07, $0D, $40, $04, $13, $39, $0A, $0F, $03, $10, $09, $11
Twilight_R4:
	.byte $20, $06, $07, $0D, $04, $05, $4B, $38, $0A, $0F, $03, $02, $0B, $09
Twilight_R5:
	.byte $20, $07, $06, $0D, $0C, $40, $05, $04, $03, $14, $38, $0A, $10, $0B, $0E, $09
Twilight_R6:
	.byte $20, $07, $06, $0C, $05, $04, $4D, $0D, $3A, $0B, $0F, $03, $0A, $09, $10, $0E

Twilight_1:
	.byte $C7, $7E, $C0, $48, $C1, $7E, $C2, $3E, $C1, $48, $4C, $C2, $7E, $C1, $3E, $C2
	.byte $48, $C1, $4C, $7E, $C2, $3E, $C1, $4C, $C3, $50, $7E, $C8, $50, $00
	.byte $C0, $48, $C1, $7E, $3E, $C2, $48, $C1, $4C, $C2, $7E, $C1, $3E, $48, $C2, $4C
	.byte $C1, $7E, $C2, $3E, $C1, $4C, $C3, $50, $7E, $C4, $50, $C5, $4C, $50, $C6, $4C
Twilight_2:
	.byte $C1, $7E, $C4, $4C, $50, $C6, $4C, $C0, $48, $C2, $7E, $44, $C1, $4E, $C2, $48
	.byte $C1, $7E, $C2, $44, $4E, $C1, $48, $C2, $7E, $C1, $3E, $C2, $7E, $C3, $44, $C4
	.byte $42, $44, $C6, $42, $C7, $3E, $00
	.byte $C0, $48, $C1, $7E, $C2, $44, $C1, $4E, $C2, $48, $7E, $C1, $44, $C2, $4E, $C1
	.byte $48, $C2, $7E, $3E, $C1, $7E, $C3, $44, $C4, $42, $44, $42, $C5, $3E
Twilight_3:
	.byte $C6, $7E, $C0, $4E, $C1, $7E, $C2, $44, $C1, $4E, $C2, $52, $C1, $7E, $44, $C2
	.byte $4E, $C1, $52, $C2, $7E, $C1, $44, $52, $C3, $56, $7E, $C7, $56, $00
	.byte $C0, $4E, $C1, $7E, $C2, $44, $C1, $4E, $52, $C2, $7E, $C1, $44, $C2, $4E, $C1
	.byte $52, $7E, $C2, $44, $C1, $52, $C3, $56, $7E, $C4, $56, $C5, $52, $56, $52
Twilight_4:
	.byte $C1, $7E, $C4, $52, $C5, $56, $C4, $52, $C0, $4E, $C1, $7E, $C2, $4A, $C1, $54
	.byte $4E, $C2, $7E, $C1, $4A, $C2, $54, $C1, $4E, $7E, $C2, $44, $C1, $7E, $C3, $4A
	.byte $C4, $48, $C5, $4A, $C4, $48, $C7, $44, $00
	.byte $C0, $4E, $C1, $7E, $4A, $C2, $54, $C1, $4E, $C2, $7E, $C1, $4A, $54, $C2, $4E
	.byte $C1, $7E, $C2, $44, $C1, $7E, $C3, $4A, $C4, $48, $4A, $C5, $48, $C6, $44
Twilight_5:
	.byte $C9, $7E, $C0, $4E, $C2, $7E, $44, $C1, $4E, $C2, $52, $C1, $7E, $C2, $44, $4E
	.byte $C1, $52, $C2, $7E, $C1, $44, $C2, $52, $C3, $56, $7E, $CA, $56, $00
	.byte $C0, $4E, $C1, $7E, $C2, $44, $C1, $4E, $C2, $52, $7E, $C1, $44, $C2, $4E, $C1
	.byte $52, $C2, $7E, $44, $C1, $52, $C3, $56, $C4, $7E, $C5, $56, $C6, $52, $C7, $56
	.byte $C8, $52
Twilight_6:
	.byte $C1, $7E, $C5, $52, $56, $52, $C0, $4E, $C1, $7E, $C2, $44, $C1, $52, $C2, $4E
	.byte $7E, $C1, $44, $C2, $52, $C1, $4E, $C2, $7E, $44, $C1, $7E, $C7, $4E, $C5, $4C
	.byte $4E, $4C, $C8, $48, $00
	.byte $C0, $4E, $C1, $7E, $C2, $44, $52, $C1, $4E, $C2, $7E, $C1, $44, $C2, $52, $4E
	.byte $C1, $7E, $C2, $44, $C1, $7E, $C3, $4E, $C4, $4C, $C5, $4E, $4C, $C6, $48

Twilight_Tri6:
	.byte $A1, $28, $A2, $7E, $28, $A1, $7E, $A2, $28, $A1, $7E, $A2, $28, $7E, $A1, $28
	.byte $A2, $7E, $A1, $28, $A2, $7E, $28, $A1, $7E, $A2, $28, $A1, $7E, $A2, $2C, $7E
	.byte $A1, $2C, $A2, $7E, $A1, $2C, $A2, $7E, $2C, $A1, $7E, $A2, $2C, $A1, $7E, $A2
	.byte $2C, $7E, $A1, $2E, $A2, $7E, $A1, $2E, $A2, $7E
Twilight_Nse6:
	.byte $A9, $03, $AA, $01, $AB, $06, $AC, $01, $AB, $03, $AD, $01, $AC, $03, $AE, $01
	.byte $AB, $06, $AC, $01, $AB, $03, $AC, $01, $A9, $03, $AF, $01, $AB, $06, $AC, $01
	.byte $AB, $03, $AC, $01, $A9, $03, $AF, $01, $AB, $06, $A5, $01, $AB, $06, $01, $06
	.byte $A5, $01, $AB, $06, $01, $00

Twilight_Tri5:
	.byte $A1, $36, $A2, $7E, $A1, $36, $A2, $7E, $36, $A1, $7E, $A2, $36, $A1, $7E, $A2
	.byte $36, $7E, $A1, $36, $A2, $7E, $A1, $36, $A2, $7E, $36, $A1, $7E, $A2, $30, $A1
	.byte $7E, $A2, $30, $7E, $A1, $30, $A2, $7E, $A1, $30, $A2, $7E, $30, $A1, $7E, $A2
	.byte $30, $A1, $7E, $A2, $30, $7E, $A1, $30, $A6, $7E
Twilight_Nse5:
	.byte $AB, $03, $AC, $01, $A8, $06, $AB, $01, $A8, $03, $AB, $01, $AD, $03, $AE, $01
	.byte $A8, $06, $AB, $01, $A8, $03, $AB, $01, $AD, $03, $AE, $01, $A7, $06, $AF, $01
	.byte $A8, $03, $AB, $01, $A4, $03, $AE, $01, $A8, $06, $AF, $01, $A8, $03, $AF, $01
	.byte $00

Twilight_Tri4:
	.byte $A1, $36, $7E, $A2, $36, $A1, $7E, $A2, $36, $A1, $7E, $36, $A2, $7E, $A1, $36
	.byte $A2, $7E, $A1, $36, $7E, $A2, $36, $A1, $7E, $A2, $36, $A1, $7E, $36, $A2, $7E
	.byte $A1, $36, $A2, $7E, $A1, $36, $7E, $A2, $36, $A1, $7E, $A2, $36, $A1, $7E, $36
	.byte $A2, $7E, $A1, $36, $A2, $7E, $A1, $36, $A5, $7E
Twilight_Nse4:
	.byte $A8, $03, $A9, $01, $AA, $06, $A8, $01, $AA, $03, $A8, $01, $03, $A9, $01, $AA
	.byte $06, $A8, $01, $AB, $03, $AC, $01, $03, $A9, $01, $AA, $06, $AD, $01, $AB, $03
	.byte $AC, $01, $03, $A9, $01, $A4, $06, $AD, $01, $AB, $03, $AD, $01, $00

Twilight_Tri3:
	.byte $A1, $36, $A2, $7E, $A1, $36, $7E, $A2, $36, $A1, $7E, $A2, $36, $A1, $7E, $36
	.byte $A2, $7E, $A1, $36, $A2, $7E, $A1, $36, $7E, $A2, $36, $A1, $7E, $A2, $36, $A1
	.byte $7E, $36, $A2, $7E, $A1, $36, $A2, $7E, $A1, $36, $7E, $A2, $36, $A1, $7E, $A2
	.byte $36, $A1, $7E, $36, $A2, $7E, $A1, $36, $7E
Twilight_Nse3:
	.byte $A8, $03, $A9, $01, $AA, $06, $A8, $01, $AA, $03, $A8, $01, $03, $AB, $01, $AA
	.byte $06, $AC, $01, $AA, $03, $A8, $01, $03, $AB, $01, $A5, $06, $AC, $01, $AA, $03
	.byte $AC, $01, $03, $AD, $01, $AA, $06, $A8, $01, $AA, $03, $AC, $01, $00

Twilight_Tri2:
	.byte $A3, $30, $A1, $7E, $A2, $30, $A8, $7E, $A3, $30, $A2, $7E, $30, $A9, $7E, $AA
	.byte $26
Twilight_Nse2:
	.byte $A4, $06, $AB, $01, $AC, $02, $AD, $01, $A4, $06, $AB, $01, $AC, $02, $AD, $01
	.byte $A4, $06, $AE, $01, $AC, $02, $AD, $01, $A4, $06, $AB, $01, $AC, $02, $AD, $01
	.byte $A4, $06, $AB, $01, $AC, $02, $AF, $01, $AD, $06, $AC, $01, $02, $AD, $01, $A4
	.byte $06, $AB, $01, $AC, $02, $AD, $01, $A4, $06, $AE, $01, $AC, $02, $AF, $01, $00

Twilight_Tri1:
	.byte $A3, $30, $A1, $7E, $30, $A9, $7E, $A3, $30, $A1, $7E, $A2, $30, $A4, $7E, $AA
	.byte $26
Twilight_Nse1:
	.byte $A6, $06, $AB, $01, $02, $A5, $01, $06, $AB, $01, $02, $A5, $01, $06, $AB, $01
	.byte $02, $A6, $01, $A5, $06, $AB, $01, $02, $A5, $01, $06, $AB, $01, $02, $A5, $01
	.byte $06, $AC, $01, $AB, $02, $A5, $01, $06, $A6, $01, $06, $01, $AB, $02, $A5, $01
	.byte $A6, $06, $AD, $01, $AA, $02, $00
