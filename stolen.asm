; the code they stole and it's OBVIOUS

	.org 0x1C4000

; unused code
_lab_1C4000:
	movem.l D0-A6, -(A7)
	move.l 0x8000, D0
	move.l #0x6700001A, D0
	movea.l #0x8000, A0 ; in the middle of level enemy data
	move.l (A0), 0xFF0000
	cmp.l (A0), D0
	beq.w _lab_1C402C
	move.l (A7)+, D0
	movea.l (A7)+, A5
	jsr (0xD97C).l ; this will crash by executing an invalid opcode LOL!!!
_lab_1C402C:
	move.w #0, 0x608100  ; this address could have been mapped to special hardware??
	movem.l (A7)+, D0-A6
	rts

	.balign 0x1C4200,0xFF

; more unused code!! :D
_lab_1C4200:
	movem.l D0-A6, -(A7)
	move.l 0x96000, D0
	move.l #0x15C5322, D0
	movea.l #0x96000, A0 ; in the middle of level tile data
	move.l (A0), 0xFF1000
	cmp.l (A0), D0
	beq.w _lab_1C422C
	move.l (A7)+, D0
	movea.l (A7)+, A5
	jsr (0xD97C).l ; this will crash by executing an invalid opcode LOL!!!
_lab_1C422C:
	move.w #0, 0x608100  ; this address could have been mapped to special hardware??
	movem.l (A7)+, D0-A6
	rts

	.org 0x1C6000

; more unused code!! :D
_lab_1C6000:
	movem.l D0-A6, -(A7)
	move.l 0x10000, D0
	move.l #0x435E435E, D0
	movea.l #0x10000, A0 ; in the middle of palette data
	move.l (A0), 0xFF2000
	cmp.l (A0), D0
	beq.w _lab_1C602C
	move.l (A7)+, D0
	movea.l (A7)+, A5
	jsr (0xD97C).l ; this will crash by executing an invalid opcode LOL!!!
_lab_1C602C:
	move.w #0, 0x608100  ; this address could have been mapped to special hardware??
	movem.l (A7)+, D0-A6
	rts

	.org 0x1FE000

_lab_1FE000:
	movem.l D0-A6, -(A7)
	move.l A5, 0xFF0900
	move.l D0, 0xFF0A00
	movea.l #reg_data1, A5
	move.b #0x40, (A5)
	lea (vdp_data_port).l, A0
	lea (vdp_ctrl_port).l, A1
	moveq #5, D5
	moveq #2, D6
	move.l #0x47200003, D0
	jsr (_lab_1FE0C8).l
	moveq #4, D5
	moveq #2, D6
	move.l #0x420A0003, D0
	jsr (_lab_1FE0C8).l
	lea (0x2E06).w, A4 ; since this points to code, the subroutine
	moveq #4, D5       ; will effectively copy code to vram.
	moveq #2, D6
	move.l #0x42100003, D0
	jsr (_lab_1FE0E0).l
	move.b (A5), 0xE00000
	andi.b #0x3F, 0xE00000
	move.b #0, (A5)
	move.b (A5), D0
	asl.b #2, D0
	andi.b #0xC0, D0
	move.l #0x435E435E, 0xFF2000
	bra.b _lab_1FE0C2

; unused data
_lab_1FE080:
	.word 0xA000

; unused code
_lab_1FE082:
	or.b D0, 0xE00000
	move.l 0xFF0B00, D0
	move.w #0x300, 0x4088F0 ; since this code is stolen, some instructions point to
	move.l 0x40000, D0      ; completely unrelated places, like this one, which points to gfx data on cart.
	move.l #0x435E435E, D0
	movea.l #0x40000, A0
	cmp.l (A0), D0
	beq.w _lab_1FE0BA
	jsr (controller_set_TH).l
	move.l (A7)+, D0
	movea.l (A7)+, A5
	rts

_lab_1FE0BA:
	move.w #0, 0x40A100 ; this points to memory that does not exist by default
_lab_1FE0C2:
	movem.l (A7)+, D0-A6
	rts

_lab_1FE0C8:
	move.l D5, D7
	move.l D0, (A1)
_lab_1FE0CC:
	move.w #0, (A0)
	dbf D7, _lab_1FE0CC
_lab_1FE0D4:
	addi.l #0x800000, D0
	dbf D6, _lab_1FE0D4
	rts

_lab_1FE0E0:
	move.l D5, D7
	move.l D0, (A1)
_lab_1FE0E4:
	move.w (A4)+, D1
	ori.w #0x8000, D1
	move.w D1, (A0)
	dbf D7, _lab_1FE0E4
	addi.l #0x800000, D0
	dbf D6, _lab_1FE0E0
	rts

	.balign 0x1FF000,0xFF

_lab_1FF000:
	movem.l D0-A6, -(A7)
	bra.b _lab_1FF014

_lab_1FF006:
	btst.l D0, D0
	ori.w #0x8000, D0
	move.w #0x4581, 0x649000 ; wild
_lab_1FF014:
	move.w #1, 0xE00004
	move.w #1, 0xE0002C
	move.b #0x00, 0xFFF800
	move.b #0xA8, 0xFFF801
	move.b #0x04, 0xFFF802
	move.b #0x00, 0xFFF803
	move.b #0x80, 0xFFF804
	move.b #0x01, 0xFFF805
	move.b #0x00, 0xFFF806
	move.b #0xB8, 0xFFF807
	move.w #0x00EF, 0xE00016
	move.w #0x000F, 0xE00018
	move.w #0xFFFF, 0xC00010
	move.l 0xFF0100, D0
	move.l #0x6700001A, 0xFF0000
	bra.b _lab_1FF0BA

; more unused code!! :D
_lab_1FF08E:
	move.l D0, D0
	move.l 0x8000, D0
	move.l #0x6700001A, D0
	movea.l #0x8000, A0  ; 0x8000 is the enemy data for the game's levels
	cmp.l (A0), D0
	beq.w _lab_1FF0B2
	move.l (A7)+, D0
	movea.l (A7)+, A5
	jsr (0xD97C).l ; this points in the middle of some code
_lab_1FF0B2:
	move.w #0, 0x408100
_lab_1FF0BA:
	move.w #0x8FF, 0xE0002A
	move.w #0x80, 0xE0000E
	move.w #0x80, 0xE00010
	move.w #0x80, 0xE00012
	move.w #0x80, 0xE00014
	move.w #0, 0xE00006
	move.w #0, 0xE00008
	move.w #0, 0xE0000A
	move.w #0, 0xE0000C
	move.w #0xFFFF, 0xC00010
	move.w #0, 0xE0001A
	move.w #0, 0xE00020
	move.w #0, 0xE00022
	jsr (s_reset_all).l
	movem.l (A7)+, D0-A6
	rts

	.balign 0x1FF400,0xFF

_lab_1FF400:
	movem.l D0-A6, -(A7)
	bra.b _lab_1FF414

_lab_1FF406:
	andi.b #0x40, D0
	subx.b D0, D7
	move.w #0x4581, 0x649000 ; wild
_lab_1FF414:
	move.w #1, 0xE00004
	move.w #1, 0xE0002C
	move.b #0x80, 0xFFF800
	move.b #0xB8, 0xFFF801
	move.b #0x44, 0xFFF802
	move.b #0x60, 0xFFF803
	move.b #0x90, 0xFFF804
	move.b #0x31, 0xFFF805
	move.b #0x20, 0xFFF806
	move.b #0xB6, 0xFFF807
	move.w #0x20EF, 0xE00016
	move.w #0x040F, 0xE00018
	move.w #0xF6FF, 0xC00010
	move.l 0xFF0200, D0
	move.l #0x15C5322, 0xFF1000
	bra.b _lab_1FF4C2

; more unused code!! :D
_lab_1FF48E:
	move.l D0, D1
	move.w #0x200, 0x40A000
	move.l 0xCA000, D0
	move.l #0x15C5322, D0
	movea.l #0xCA000, A0  ; 0xCA000 is some level data
	cmp.l (A0), D0
	beq.w _lab_1FF4BA
	move.l (A7)+, D0
	movea.l (A7)+, A5
	jsr (0xD97C).l ; this points in the middle of some code
_lab_1FF4BA:
	move.w #0, 0x408100
_lab_1FF4C2:
	move.w #0x18FF, 0xE0002A
	move.w #0x380, 0xE0000E
	move.w #0x480, 0xE00010
	move.w #0x580, 0xE00012
	move.w #0x680, 0xE00014
	move.w #0x700, 0xE00006
	move.w #0x800, 0xE00008
	move.w #0x900, 0xE0000A
	move.w #0xA00, 0xE0000C
	move.w #0xFBFF, 0xC00010
	move.w #0x10, 0xE0001A
	move.w #0x30, 0xE00020
	move.w #0x50, 0xE00022
	movem.l (A7)+, D0-A6
	jsr (_lab_EBCD8).l
	rts
