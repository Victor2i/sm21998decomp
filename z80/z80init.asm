	.org 0

_start:
	xor A, A ; reset A reg
	ld bc, 0x1FD9
	ld de, 0x0027
	ld hl, 0x0026
	ld sp, hl
	ld (hl), a
	ldir
	pop ix
	pop iy
	ld i, a
	ld r, a
	pop de
	pop hl
	pop af
	ex af, af'
	exx
	pop bc
	pop de
	pop hl
	pop af
	ld sp, hl
	di
	im 1
	ld (hl), 0xE9
	jp hl

