.set	ym_A0,			0x4000
.set	ym_D0,			0x4001
.set	ym_A1,			0x4002
.set	ym_D1,			0x4003

.set	bank_reg,		0x6000

	.org 0

_start:
	di
	im 1
	ld sp, 0x2000
	jp _lab30

	.balign 0x20,0x7F

	.org 0x30

_lab30:
	ld iy, 0x20
_lab34:
	bit 6, (iy+1)
	jp z, _lab4B
	bit 7, (iy+0)
	jp nz, _lab4B
	push bc
	ld b, 2
_lab45:
	djnz _lab45
	pop bc
	jp _lab118

_lab4B:
	ld a, (0x20)
	or a, (iy+1)
	jp z, _lab4B
	ld a, (0x20)
	or a, a
	jp z, _lab118
	ld (iy+0), 0
	ld i, a
	ld a, 0x80
	jp p, _lab68
	or a, 0x40
_lab68:
	ld (iy+1), a
	ld a, i
	and a, 0x7F
	dec a
	ld h, 0
	ld l, a
	add hl, hl
	add hl, hl
	add hl, hl
	ex de, hl
	ld ix, sample_list
	add ix, de
	
	; M68k bank setup
	ld a, (ix+4)
	ld hl, bank_reg
	ld (hl), a      ; set address bit 15
	ld a, (ix+5)
	ld b, 8
_lab89:
	ld (hl), a      ; set address bits 16 to 23
	rrca
	djnz _lab89
	ld hl, _lab9F
	
	ld a, (0x22)
	add a, a
	add a, l
	ld l, a
	ld a, 0
	adc a, h
	ld h, a
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	jp hl

_lab9F:
	.word _labFA
	.word _labE5
	.word _labD0
	.word _labBB
	.word _labA9

_labA9:
	ld hl, 0x2FCB      ; 'sra a' instrution
	ld (_lab122+0), hl
	ld (_lab122+2), hl
	ld (_lab122+4), hl
	ld (_lab122+6), hl
	jp _lab10C

_labBB:
	ld hl, 0x2FCB      ; 'sra a' instrution
	ld (_lab122+0), hl
	ld (_lab122+2), hl
	ld (_lab122+4), hl
	ld hl, 0           ; 'nop' instrution
	ld (_lab122+6), hl
	jp _lab10C

_labD0:
	ld hl, 0x2FCB      ; 'sra a' instrution
	ld (_lab122+0), hl
	ld (_lab122+2), hl
	ld hl, 0           ; 'nop' instrution
	ld (_lab122+4), hl
	ld (_lab122+6), hl
	jp _lab10C

_labE5:
	ld hl, 0x2FCB      ; 'sra a' instrution
	ld (_lab122+0), hl
	ld hl, 0           ; 'nop' instrution
	ld (_lab122+2), hl
	ld (_lab122+4), hl
	ld (_lab122+6), hl
	jp _lab10C

_labFA:
	ld hl, 0           ; 'nop' instrution
	ld (_lab122+0), hl
	ld (_lab122+2), hl
	ld (_lab122+4), hl
	ld (_lab122+6), hl
	jp _lab10C

_lab10C:
	ld e, (ix+0)
	ld d, (ix+1)
	ld c, (ix+2)
	ld b, (ix+3)
_lab118:
	ld a, (ix+6)
_lab11B:
	dec a
	jp nz, _lab11B
	ld a, (de)
	sub a, 0x80

_lab122:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
	add a, 0x80   ; fix sample (unsigned to signed)
	ld (ym_D0), a ; output to DAC
	inc de
	dec bc
	ld a, b
	or a, c
	jp nz, _lab34
	ld a, (iy+0)
	or a, a
	jp z, _lab14A
	jp m, _lab150
	ld a, (ix+7)
	or a, a
	jp m, _lab14A
	jp _lab150
_lab14A:
	ld a, (ix+7)
	ld (iy+0), a
_lab150:
	ld (iy+1), 0
	jp _lab34

; THE LIST
; FORMAT: offset (word), length (word), bank (word), speed (byte), next sample (byte)
sample_list:
	; silence
	.word 0x10, 0x1
	.word 0x1F00
	.byte 1, 0
	
	;
	; BGM SAMPLES
	;
	
	; kick
	.word 0x8000, 0x520 ; OFFSET: 0 , LENGTH: 1312
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 1, 0

	; kick + closed hi-hat
	.word 0x8520, 0x4B7 ; OFFSET: 1312 , LENGTH: 1207
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 1, 0

	; kick + opened hi-hat
	.word 0x89D7, 0xD40 ; OFFSET: 2519 , LENGTH: 3392
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 1, 0

	; snare
	.word 0x9717, 0x1157 ; OFFSET: 5911 , LENGTH: 4439
	.word 0x1F00         ; BANK: 0x1F0000
	.byte 1, 0

	; snare + closed hi-hat
	.word 0xA86D, 0x1157 ; OFFSET: 10349 , LENGTH: 4439
	.word 0x1F00         ; BANK: 0x1F0000
	.byte 1, 0

	; snare + opened hi-hat
	.word 0xB9C5, 0x1157 ; OFFSET: 14789 , LENGTH: 4439
	.word 0x1F00         ; BANK: 0x1F0000
	.byte 1, 0

	; closed hi-hat
	.word 0xCB1C, 0x4B7 ; OFFSET: 19228 , LENGTH: 1207
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 1, 0

	; opened hi-hat
	.word 0xCFD3, 0xD40 ; OFFSET: 20435 , LENGTH: 3392
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 1, 0

	; bong
	.word 0xDD13, 0x653 ; OFFSET: 23827 , LENGTH: 1619
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 1, 0

	; bong
	.word 0xDD13, 0x653 ; OFFSET: 23827 , LENGTH: 1619
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 3, 0

	; sample 12
	.word 0xE366, 0xB23 ; OFFSET: 25446 , LENGTH: 2851
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 1, 0

	; sample 13
	.word 0xE366, 0xB23 ; OFFSET: 25446 , LENGTH: 2851
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 8, 0

	; sample 14
	.word 0xE366, 0xB23 ; OFFSET: 25446 , LENGTH: 2851
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 15, 0

	; sample 15
	.word 0xE366, 0xB23 ; OFFSET: 25446 , LENGTH: 2851
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 24, 0

	; sample 16
	.word 0xE366, 0xB23 ; OFFSET: 25446 , LENGTH: 2851
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 31, 0

	; sample 17
	.word 0xE366, 0xB23 ; OFFSET: 25446 , LENGTH: 2851
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 40, 0

	; sample 18
	.word 0xEE89, 0xE8C ; OFFSET: 28297 , LENGTH: 3724
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 1, 0

	; sample 19
	.word 0xEE89, 0xE8C ; OFFSET: 28297 , LENGTH: 3724
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 8, 0

	; sample 20
	.word 0xEE89, 0xE8C ; OFFSET: 28297 , LENGTH: 3724
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 15, 0

	; sample 21
	.word 0xEE89, 0xE8C ; OFFSET: 28297 , LENGTH: 3724
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 24, 0

	; sample 22
	.word 0xEE89, 0xE8C ; OFFSET: 28297 , LENGTH: 3724
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 31, 0

	; sample 23
	.word 0xEE89, 0xE8C ; OFFSET: 28297 , LENGTH: 3724
	.word 0x1F00        ; BANK: 0x1F0000
	.byte 40, 0

	; sample 24
	.word 0x8000, 0x42B ; OFFSET: 0 , LENGTH: 1067
	.word 0x1E01        ; BANK: 0x1E8000
	.byte 4, 0

	; sample 25
	.word 0x8000, 0x42B ; OFFSET: 0 , LENGTH: 1067
	.word 0x1E01        ; BANK: 0x1E8000
	.byte 8, 0

	; kick + cymbal
	.word 0x842B, 0x2D66 ; OFFSET: 1067 , LENGTH: 11622
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 1, 0

	; sample 27
	.word 0xB191, 0x2EF ; OFFSET: 12689 , LENGTH: 751
	.word 0x1E01        ; BANK: 0x1E8000
	.byte 3, 0

	; sample 28
	.word 0xB480, 0x2DF ; OFFSET: 13440 , LENGTH: 735
	.word 0x1E01        ; BANK: 0x1E8000
	.byte 1, 0

	; sample 29
	.word 0xB75E, 0x2FA ; OFFSET: 14174 , LENGTH: 762
	.word 0x1E01        ; BANK: 0x1E8000
	.byte 4, 0

	; sample 30
	.word 0xB75E, 0x2FA ; OFFSET: 14174 , LENGTH: 762
	.word 0x1E01        ; BANK: 0x1E8000
	.byte 8, 0

	; sample 31
	.word 0xBA59, 0x853 ; OFFSET: 14937 , LENGTH: 2131
	.word 0x1E01        ; BANK: 0x1E8000
	.byte 4, 0

	; sample 32
	.word 0xBA59, 0x853 ; OFFSET: 14937 , LENGTH: 2131
	.word 0x1E01        ; BANK: 0x1E8000
	.byte 8, 0

	; timpani A#4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 2, 0

	; timpani A-4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 3, 0

	; timpani G#4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 4, 0

	; timpani G-4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 5, 0

	; timpani F#4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 7, 0

	; timpani F-4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 8, 0

	; timpani E-4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 10, 0

	; timpani D#4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 11, 0

	; timpani D-4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 13, 0

	; timpani C#4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 15, 0

	; timpani C-4
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 16, 0

	; timpani B-3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 18, 0

	; timpani A#3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 20, 0

	; timpani A-3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 22, 0

	; timpani G#3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 25, 0

	; timpani G-3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 27, 0

	; timpani F#3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 29, 0

	; timpani F-3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 32, 0

	; timpani E-3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 36, 0

	; timpani D#3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 38, 0

	; timpani D-3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 41, 0

	; timpani C#3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 45, 0

	; timpani C-3
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 48, 0

	; timpani B-2
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 52, 0

	; timpani A#2
	.word 0xC2AC, 0x14BD ; OFFSET: 17068 , LENGTH: 5309
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 55, 0

	; orchestral hit B-5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 2, 0

	; orchestral hit A#5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 3, 0

	; orchestral hit A-5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 4, 0

	; orchestral hit G#5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 5, 0

	; orchestral hit G-5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 7, 0

	; orchestral hit F#5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 8, 0

	; orchestral hit F-5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 10, 0

	; orchestral hit E-5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 11, 0

	; orchestral hit D#5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 12, 0

	; orchestral hit D-5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 15, 0

	; orchestral hit C#5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 16, 0

	; orchestral hit C-5
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 18, 0

	; orchestral hit B-4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 20, 0

	; orchestral hit A#4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 22, 0

	; orchestral hit A-4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 25, 0

	; orchestral hit G#4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 27, 0

	; orchestral hit G-4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 29, 0

	; orchestral hit F#4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 32, 0

	; orchestral hit F-4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 36, 0

	; orchestral hit E-4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 38, 0

	; orchestral hit D#4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 41, 0

	; orchestral hit D-4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 45, 0

	; orchestral hit C#4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 48, 0

	; orchestral hit C-4
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 52, 0

	; orchestral hit B-3
	.word 0xD769, 0x1BB1 ; OFFSET: 22377 , LENGTH: 7089
	.word 0x1E01         ; BANK: 0x1E8000
	.byte 54, 0
	
	; BUG!
	; the next two samples are corrupt,
	; to fix them, change the bank value from 0xE01 to 0x1E01
	; ironically, they have the correct value in high seas havoc.

	; sample 83
	.word 0xF31A, 0x9BC ; OFFSET: 29466 , LENGTH: 2492
	.word 0xE01         ; BANK: 0xE8000 (invalid)
	;.word 0x1E01        ; BANK: 0x1E8000 (fix)
	.byte 1, 0

	; sample 84
	.word 0xFCD6, 0x1 ; OFFSET: 31958 , LENGTH: 1
	.word 0xE01       ; BANK: 0xE8000 (invalid)
	;.word 0x1E01      ; BANK: 0x1E8000 (fix)
	.byte 1, 0

	;
	; SFX SAMPLES
	;

	; menu select
	.word 0x8000, 0x208 ; OFFSET: 0 , LENGTH: 520
	.word 0x1D00        ; BANK: 0x1D0000
	.byte 28, 0

	; menu confirm
	.word 0x8228, 0x3F2 ; OFFSET: 552 , LENGTH: 1010
	.word 0x1D00        ; BANK: 0x1D0000
	.byte 28, 0

	; spin
	.word 0x863A, 0x1106 ; OFFSET: 1594 , LENGTH: 4358
	.word 0x1D00         ; BANK: 0x1D0000
	.byte 28, 0

	; jump
	.word 0x9760, 0x586 ; OFFSET: 5984 , LENGTH: 1414
	.word 0x1D00        ; BANK: 0x1D0000
	.byte 28, 0

	; stomp
	.word 0x9D06, 0x45A ; OFFSET: 7430 , LENGTH: 1114
	.word 0x1D00        ; BANK: 0x1D0000
	.byte 28, 0

	; coin collect
	.word 0xA180, 0x3C2 ; OFFSET: 8576 , LENGTH: 962
	.word 0x1D00        ; BANK: 0x1D0000
	.byte 28, 0

	; door open
	.word 0xA562, 0xF92 ; OFFSET: 9570 , LENGTH: 3986
	.word 0x1D00        ; BANK: 0x1D0000
	.byte 28, 0

	; pause
	.word 0xB514, 0x1264 ; OFFSET: 13588 , LENGTH: 4708
	.word 0x1D00         ; BANK: 0x1D0000
	.byte 28, 0

	; power-up block hit
	.word 0xC798, 0x183A ; OFFSET: 18328 , LENGTH: 6202
	.word 0x1D00         ; BANK: 0x1D0000
	.byte 28, 0

	; power-up collect
	.word 0x8000, 0x237E ; OFFSET: 0 , LENGTH: 9086
	.word 0x1D01         ; BANK: 0x1D8000
	.byte 28, 0

	; 2 stomps
	.word 0xA39E, 0xFEA ; OFFSET: 9118 , LENGTH: 4074
	.word 0x1D01        ; BANK: 0x1D8000
	.byte 28, 0

	; sample 96
	.word 0xB3A8, 0x17E8 ; OFFSET: 13224 , LENGTH: 6120
	.word 0x1D01         ; BANK: 0x1D8000
	.byte 28, 0

	; pipe entrance
	.word 0xCBB0, 0x1B84 ; OFFSET: 19376 , LENGTH: 7044
	.word 0x1D01         ; BANK: 0x1D8000
	.byte 28, 0

	; coin block hit
	.word 0xE754, 0x3D0 ; OFFSET: 26452 , LENGTH: 976
	.word 0x1D01        ; BANK: 0x1D8000
	.byte 28, 0

	; yoshi tongue
	.word 0xEB44, 0xC32 ; OFFSET: 27460 , LENGTH: 3122
	.word 0x1D01        ; BANK: 0x1D8000
	.byte 28, 0

	; flag descending
	.word 0x8000, 0x1C9A ; OFFSET: 0 , LENGTH: 7322
	.word 0x1E00         ; BANK: 0x1E0000
	.byte 28, 0

	; sample 101
	.word 0x9CBA, 0x2EA0 ; OFFSET: 7354 , LENGTH: 11936
	.word 0x1E00         ; BANK: 0x1E0000
	.byte 28, 0

	; level clear
	.word 0xCB7A, 0x358 ; OFFSET: 19322 , LENGTH: 856
	.word 0x1E00        ; BANK: 0x1E0000
	.byte 28, 0

	; brick hit
	.word 0xCEF2, 0x1A6 ; OFFSET: 20210 , LENGTH: 422
	.word 0x1E00        ; BANK: 0x1E0000
	.byte 28, 0

	; brick smash
	.word 0xD0B8, 0xE62 ; OFFSET: 20664 , LENGTH: 3682
	.word 0x1E00        ; BANK: 0x1E0000
	.byte 28, 0
	
	; from now on, the remaining samples are
	; most likely remains from high seas havoc.
	; expect corrupt audio from these.

	; sample 105
	.word 0x84BC, 0x1A61 ; OFFSET: 1212 , LENGTH: 6753
	.word 0x701          ; BANK: 0x78000 (invalid)
	.byte 32, 0

	; sample 106
	.word 0x84BC, 0x1A61 ; OFFSET: 1212 , LENGTH: 6753
	.word 0x701          ; BANK: 0x78000 (invalid)
	.byte 48, 0

	; sample 107
	.word 0x9F1D, 0xA29 ; OFFSET: 7965 , LENGTH: 2601
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 27, 0

	; sample 108
	.word 0x9F1D, 0xA29 ; OFFSET: 7965 , LENGTH: 2601
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 43, 0

	; sample 109
	.word 0x9F1D, 0xA29 ; OFFSET: 7965 , LENGTH: 2601
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 59, 0

	; sample 110
	.word 0x9F1D, 0xA29 ; OFFSET: 7965 , LENGTH: 2601
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 75, 0

	; sample 111
	.word 0x98D3, 0x2663 ; OFFSET: 6355 , LENGTH: 9827
	.word 0x500          ; BANK: 0x50000 (invalid)
	.byte 43, 0

	; sample 112
	.word 0xC000, 0x94D ; OFFSET: 16384 , LENGTH: 2381
	.word 0x401         ; BANK: 0x48000 (invalid)
	.byte 43, 0

	; sample 113
	.word 0xC94D, 0xE12 ; OFFSET: 18765 , LENGTH: 3602
	.word 0x401         ; BANK: 0x48000 (invalid)
	.byte 43, 0

	; sample 114
	.word 0xD75F, 0x657 ; OFFSET: 22367 , LENGTH: 1623
	.word 0x401         ; BANK: 0x48000 (invalid)
	.byte 43, 0

	; sample 115
	.word 0xA946, 0xC80 ; OFFSET: 10566 , LENGTH: 3200
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 33, 0

	; sample 116
	.word 0xA946, 0xC80 ; OFFSET: 10566 , LENGTH: 3200
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 49, 0

	; sample 117
	.word 0xA946, 0xC80 ; OFFSET: 10566 , LENGTH: 3200
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 65, 0

	; sample 118
	.word 0xD02E, 0x4B3 ; OFFSET: 20526 , LENGTH: 1203
	.word 0x401         ; BANK: 0x48000 (invalid)
	.byte 43, 0

	; sample 119
	.word 0x8000, 0x102E ; OFFSET: 0 , LENGTH: 4142
	.word 0x300          ; BANK: 0x30000 (invalid)
	.byte 43, 0

	; sample 120
	.word 0xF86D, 0x1F7 ; OFFSET: 30829 , LENGTH: 503
	.word 0x401         ; BANK: 0x48000 (invalid)
	.byte 43, 0

	; sample 121
	.word 0xFA64, 0x377 ; OFFSET: 31332 , LENGTH: 887
	.word 0x401         ; BANK: 0x48000 (invalid)
	.byte 43, 0

	; sample 122
	.word 0x8000, 0xB41 ; OFFSET: 0 , LENGTH: 2881
	.word 0x501         ; BANK: 0x58000 (invalid)
	.byte 43, 0

	; sample 123
	.word 0x8B41, 0x1223 ; OFFSET: 2881 , LENGTH: 4643
	.word 0x501          ; BANK: 0x58000 (invalid)
	.byte 43, 0

	; sample 124
	.word 0x9D64, 0x3F9 ; OFFSET: 7524 , LENGTH: 1017
	.word 0x501         ; BANK: 0x58000 (invalid)
	.byte 43, 0

	; sample 125
	.word 0xA15D, 0x1421 ; OFFSET: 8541 , LENGTH: 5153
	.word 0x501          ; BANK: 0x58000 (invalid)
	.byte 43, 0

	; sample 126
	.word 0xF745, 0x56A ; OFFSET: 30533 , LENGTH: 1386
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 79, 0

	; sample 127
	.word 0xF745, 0x56A ; OFFSET: 30533 , LENGTH: 1386
	.word 0x701         ; BANK: 0x78000 (invalid)
	.byte 88, 0

