; init program

	.balign 0x2000,0
	
_init:
	move.b -0x10FF(A1), D0 ; A10001: REG_VERSION
	andi.b #0xF, D0        ; keep lower nybble
	beq.b I_skip_tmss      ; if zero, TMSS is absent
	move.l #0x53454741, 0x2F00(A1) ; write "SEGA" to A14000 to unlock VDP
I_skip_tmss:
	move.w (A4), D0 ; get the VDP status register?
	moveq #0, D0    ; then immediately clear D0. whatever.
	movea.l D0, A6  ; set A6 to the top of RAM
	move.l A6, USP  ; as well as the stack pointer
	
	; initialize VDP regs
	moveq #0x17, D1  ; the VDP has 24 registers
1:	move.b (A5)+, D5 ; set the lower byte of the word value stored in D5, the value for the register
	move.w D5, (A4)  ; set the register value
	add.w D7, D5     ; increment the H digit of 0x8HLL stored in D5, which is the next register
	dbf D1, 1b
	
	; clear video ram and work ram
	move.l (A5)+, (A4) ; set address mode to VRAM fill
	move.w D0, (A3)    ; start VRAM fill with zeroes
2:	move.l D0, -(A6)   ; in the meantime, clear work ram too
	dbf D6, 2b
	
	; clear color ram
	move.l (A5)+, (A4) ; disable rendering and set auto-increment to 2
	move.l (A5)+, (A4) ; set address mode to CRAM write
	moveq #0x1F, D3    ; VDP CRAM size (0x20 dwords)
3:	move.l D0, (A3)    ; clear it
	dbf D3, 3b
	
	; clear vsram
	move.l (A5)+, (A4) ; set address mode to VSRAM write
	moveq #0x13, D4    ; VDP VSRAM size (0x14 dwords)
4:	move.l D0, (A3)    ; clear it
	dbf D4, 4b
	
	; initialize PSG (A3+0x11 = 0xC00011)
	moveq #3, D5           ; 4 bytes to copy
5:	move.b (A5)+, 0x11(A3) ; copy them
	dbf D5, 5b
	
	move.w D0, (A2)
	movem.l (A6), D0-A6
	move #0x2700, SR
	tst.w vdp_ctrl_port
	move.l #0x40020010, vdp_ctrl_port
	move.w #0, vdp_data_port
	move.l #0x40000010, vdp_ctrl_port
	move.w #0, vdp_data_port
	moveq #0x40, D0
	move.b D0, reg_control1
	move.b D0, reg_control2
	move.b D0, reg_control3
	movea.l 0xFFFFF0, A7
	move.b #0, 0xFF110C
	lea 0xFF0E00, A0
	move.w #0x2000, D7
	jsr (_lab_F3148).l
	jsr (_lab_F30A4).l
	lea (_lab_F4370).l, A0
	lea (0xFF0E00).l, A1
	move.w #8, D7
	jsr (_lab_F3140).l
	jsr (_lab_F315C).l
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A4
	move.w (A3), D0
	move.w (A4), D0
	andi.b #0xF, D0
	move.b D0, 0xFF110B
	move.b #1, 0xFF110C
	cmpi.b #0, 0xFF110B
	beq.w _lab_F21CE
	cmpi.b #1, 0xFF110B
	beq.w _lab_F21FE
	cmpi.b #2, 0xFF110B
	beq.w _lab_F222E
	cmpi.b #3, 0xFF110B
	beq.w _lab_F225E
	cmpi.b #4, 0xFF110B
	beq.w _lab_F228E
	cmpi.b #5, 0xFF110B
	beq.w _lab_F22BE
	cmpi.b #6, 0xFF110B
	beq.w _lab_F22EE
	cmpi.b #7, 0xFF110B
	beq.w _lab_F231E
	cmpi.b #8, 0xFF110B
	beq.w _lab_F234E
	cmpi.b #9, 0xFF110B
	beq.w _lab_F237E
	cmpi.b #10, 0xFF110B
	beq.w _lab_F24CE
	cmpi.b #10, 0xFF110B
	beq.w _lab_F23AE
	cmpi.b #11, 0xFF110B
	beq.w _lab_F23DE
	cmpi.b #12, 0xFF110B
	beq.w _lab_F240E
	cmpi.b #13, 0xFF110B
	beq.w _lab_F243E
	cmpi.b #14, 0xFF110B
	beq.w _lab_F246E
	cmpi.b #15, 0xFF110B
	beq.w _lab_F249E
_lab_F21CE:
	move.l #0x0, 0xFF1160
	move.l #0x12, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x1, 0xFF1174
	bra.w _lab_F24D6
_lab_F21FE:
	move.l #0x0, 0xFF1160
	move.l #0xA, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x1, 0xFF1174
	bra.w _lab_F24D6
_lab_F222E:
	move.l #0x14, 0xFF1160
	move.l #0xA, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x21, 0xFF1174
	bra.w _lab_F24D6
_lab_F225E:
	move.l #0x28, 0xFF1160
	move.l #0x2, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x41, 0xFF1174
	bra.w _lab_F24D6
_lab_F228E:
	move.l #0x3C, 0xFF1160
	move.l #0x4, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x61, 0xFF1174
	bra.w _lab_F24D6
_lab_F22BE:
	move.l #0x3C, 0xFF1160
	move.l #0x10, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x61, 0xFF1174
	bra.w _lab_F24D6
_lab_F22EE:
	move.l #0x244, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x581, 0xFF1174
	bra.w _lab_F24D6
_lab_F231E:
	move.l #0x30C, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x781, 0xFF1174
	bra.w _lab_F24D6
_lab_F234E:
	move.l #0x3D4, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x981, 0xFF1174
	bra.w _lab_F24D6
_lab_F237E:
	move.l #0x49C, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x1181, 0xFF1174
	bra.w _lab_F24D6
_lab_F23AE:
	move.l #0xDFC, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0, 0xFF1172
	move.w #0x3581, 0xFF1174
	bra.w _lab_F24D6
_lab_F23DE:
	move.l #0x2BF0C, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0x17, 0xFF1172
	move.w #0x9981, 0xFF1174
	bra.w _lab_F24D6
_lab_F240E:
	move.l #0x30D2C, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0x19, 0xFF1172
	move.w #0x9981, 0xFF1174
	bra.w _lab_F24D6
_lab_F243E:
	move.l #0x8646EC, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0x879, 0xFF1172
	move.w #0x9981, 0xFF1174
	bra.w _lab_F24D6
_lab_F246E:
	move.l #0x5F5E0EC, 0xFF1160
	move.l #0x13, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0x9999, 0xFF1172
	move.w #0x9981, 0xFF1174
	bra.w _lab_F24D6
_lab_F249E:
	move.l #0x112A86C, 0xFF1160
	move.l #0x14, 0xFF1180
	move.w #0, 0xFF1170
	move.w #0x1799, 0xFF1172
	move.w #0x9981, 0xFF1174
	bra.w _lab_F24D6
_lab_F24CE:
	jmp (_game_start).w ; game start
	bra.w _lab_F24D6
_lab_F24D6:
	jsr (_lab_F2584).l
	move.b #0, 0xFF110C
	move.w #0x8174, vdp_ctrl_port
	move #0x2700, SR
	move.w #0x100, z80_req
	move.w #0x100, z80_reset
	jmp _lab_F21CE

; unused code (allegedly)
_lab_F2506:
	move.b #0, 0xFF1108
	move.l #0, 0xFF1120
	move.l #0, 0xFF1130
	move.w #1, 0xFF1134
	move.l #0, 0xFF1140
	move.w #1, 0xFF1144
	jsr (_lab_F3A70).l
_lab_F2542:
	jsr (_lab_F2584).l
	jsr (_lab_F36C4).l
	jsr (_lab_F3702).l
	cmpi.b #0xAA, 0xFF1109
	beq.w _lab_F2572
	cmpi.b #0xAA, 0xFF1104
	beq.w _lab_F257E
	jmp _lab_F2542
_lab_F2572:
	jsr _lab_F3A70
	jmp _lab_F2542
_lab_F257E:
	jmp _lab_F276A
_lab_F2584:
	move.b #2, 0xFF110C
	move.w #0xB, 0xFF1114
	move.w #0x17, 0xFF1116
	move.w #0xB, 0xFF1110
	move.w #0x17, 0xFF1112
	lea (_lab_F434A), A0
	jsr (_lab_F306E).l
	move.w #0xB, 0xFF1114
	move.w #0x18, 0xFF1116
	move.w #0xB, 0xFF1110
	move.w #0x18, 0xFF1112
	lea (_lab_F435D), A0
	jsr (_lab_F306E).l
	move.b #0, 0xFF110C
	rts

_lab_F25EE:
	cmpi.b #0, 0xFF110B
	bne.w _lab_F2606
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F2606:
	cmpi.b #1, 0xFF110B
	bne.w _lab_F261E
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F261E:
	cmpi.b #2, 0xFF110B
	bne.w _lab_F2636
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F2636:
	cmpi.b #3, 0xFF110B
	bne.w _lab_F264E
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F264E:
	cmpi.b #4, 0xFF110B
	bne.w _lab_F2666
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F2666:
	cmpi.b #5, 0xFF110B
	bne.w _lab_F267E
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F267E:
	cmpi.b #6, 0xFF110B
	bne.w _lab_F2696
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F2696:
	cmpi.b #7, 0xFF110B
	bne.w _lab_F26AE
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F26AE:
	cmpi.b #8, 0xFF110B
	bne.w _lab_F26C6
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F26C6:
	cmpi.b #9, 0xFF110B
	bne.w _lab_F26DE
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F26DE:
	cmpi.b #10, 0xFF110B
	bne.w _lab_F26F6
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F26F6:
	cmpi.b #11, 0xFF110B
	bne.w _lab_F270E
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F270E:
	cmpi.b #12, 0xFF110B
	bne.w _lab_F2726
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F2726:
	cmpi.b #13, 0xFF110B
	bne.w _lab_F273E
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F273E:
	cmpi.b #14, 0xFF110B
	bne.w _lab_F2756
	lea (_lab_F3C60).l, A0
	jmp _lab_F2768
_lab_F2756:
	cmpi.b #15, 0xFF110B
	bne.w _lab_F2768
	lea (_lab_F3C60).l, A0
_lab_F2768:
	rts
	
_lab_F276A:
	jsr (_lab_F25EE).l
	move.l 0xFF1120, D0
	andi.l #0x1FF, D0
	adda.l D0, A0
	moveq #0, D0
	move.b 0xFF0E01, D0
	subi.b #0xB0, D0
	lsr.b #3, D0
	adda.l D0, A0
	moveq #0, D0
	move.b (A0), D0
	move.l #0, reg_controllers
	move.l #0, reg_exp_port
	lea (0xFF0000).l, A0
	move.w #0x7FFF, D7
_lab_F27B0:
	move.w #0, (A0)+
	dbf D7, _lab_F27B0
	lea (_lab_F2A82).l, A0
	lea (0xFF2000).l, A1
	move.w #0x100, D7
	jsr (_lab_F3140).l
	cmpi.b #0x7, D0
	beq.w _lab_F27E6
	bhi.w _lab_F27E6
	jsr (_lab_F2ABC).l
	jmp (0xFF2000).l
_lab_F27E6:
	cmpi.b #0x8, D0
	beq.w _lab_F2804
	bhi.w _lab_F2804
	move #0, CCR
	subq.b #7, D0
	jsr (_lab_F2ADA).l
	jmp (0xFF2000).l
_lab_F2804:
	cmpi.b #0xC, D0
	beq.w _lab_F2822
	bhi.w _lab_F2822
	move #0, CCR
	subq.b #8, D0
	jsr (_lab_F2AEC).l
	jmp (0xFF2000).l
_lab_F2822:
	cmpi.b #0x13, D0
	beq.w _lab_F2842
	bhi.w _lab_F2842
	move #0, CCR
	subi.b #0xC, D0
	jsr (_lab_F2B06).l
	jmp (0xFF2000).l
_lab_F2842:
	cmpi.b #0x14, D0
	beq.w _lab_F2862
	bhi.w _lab_F2862
	move #0, CCR
	subi.b #0x13, D0
	jsr (_lab_F2B26).l
	jmp (0xFF2000).l
_lab_F2862:
	cmpi.b #0x15, D0
	beq.w _lab_F2882
	bhi.w _lab_F2882
	move #0, CCR
	subi.b #0x14, D0
	jsr (_lab_F2B38).l
	jmp (0xFF2000).l
_lab_F2882:
	cmpi.b #0x16, D0
	beq.w _lab_F28A2
	bhi.w _lab_F28A2
	move #0, CCR
	subi.b #0x15, D0
	jsr (_lab_F2B4A).l
	jmp (0xFF2000).l
_lab_F28A2:
	cmpi.b #0x17, D0
	beq.w _lab_F28C2
	bhi.w _lab_F28C2
	move #0, CCR
	subi.b #0x16, D0
	jsr (_lab_F2B5C).l
	jmp (0xFF2000).l
_lab_F28C2:
	cmpi.b #0x18, D0
	beq.w _lab_F28E2
	bhi.w _lab_F28E2
	move #0, CCR
	subi.b #0x17, D0
	jsr (_lab_F2B6E).l
	jmp (0xFF2000).l
_lab_F28E2:
	cmpi.b #0x19, D0
	beq.w _lab_F2902
	bhi.w _lab_F2902
	move #0, CCR
	subi.b #0x18, D0
	jsr (_lab_F2B80).l
	jmp (0xFF2000).l
_lab_F2902:
	cmpi.b #0x1A, D0
	beq.w _lab_F2922
	bhi.w _lab_F2922
	move #0, CCR
	subi.b #0x19, D0
	jsr (_lab_F2B92).l
	jmp (0xFF2000).l
_lab_F2922:
	cmpi.b #0x1B, D0
	beq.w _lab_F2942
	bhi.w _lab_F2942
	move #0, CCR
	subi.b #0x1A, D0
	jsr (_lab_F2BA4).l
	jmp (0xFF2000).l
_lab_F2942:
	cmpi.b #0x1C, D0
	beq.w _lab_F2962
	bhi.w _lab_F2962
	move #0, CCR
	subi.b #0x1B, D0
	jsr (_lab_F2BB6).l
	jmp (0xFF2000).l
_lab_F2962:
	cmpi.b #0x1D, D0
	beq.w _lab_F2982
	bhi.w _lab_F2982
	move #0, CCR
	subi.b #0x1C, D0
	jsr (_lab_F2BC8).l
	jmp (0xFF2000).l
_lab_F2982:
	cmpi.b #0x1E, D0
	beq.w _lab_F29A2
	bhi.w _lab_F29A2
	move #0, CCR
	subi.b #0x1D, D0
	jsr (_lab_F2BDA).l
	jmp (0xFF2000).l
_lab_F29A2:
	cmpi.b #0x1F, D0
	beq.w _lab_F29C2
	bhi.w _lab_F29C2
	move #0, CCR
	subi.b #0x1E, D0
	jsr (_lab_F2BEC).l
	jmp (0xFF201A).l
_lab_F29C2:
	cmpi.b #0x20, D0
	beq.w _lab_F29E2
	bhi.w _lab_F29E2
	move #0, CCR
	subi.b #0x1F, D0
	jsr (_lab_F2C02).l
	jmp (0xFF2028).l
_lab_F29E2:
	cmpi.b #0x21, D0
	beq.w _lab_F2A02
	bhi.w _lab_F2A02
	move #0, CCR
	subi.b #0x20, D0
	jsr (_lab_F2C1E).l
	jmp (0xFF2028).l
_lab_F2A02:
	cmpi.b #0x22, D0
	beq.w _lab_F2A22
	bhi.w _lab_F2A22
	move #0, CCR
	subi.b #0x21, D0
	jsr (_lab_F2C3A).l
	jmp (0xFF2028).l
_lab_F2A22:
	cmpi.b #0x23, D0
	beq.w _lab_F2A42
	bhi.w _lab_F2A42
	move #0, CCR
	subi.b #0x22, D0
	jsr (_lab_F2C56).l
	jmp (0xFF2028).l
_lab_F2A42:
	cmpi.b #0x24, D0
	beq.w _lab_F2A62
	bhi.w _lab_F2A62
	move #0, CCR
	subi.b #0x23, D0
	jsr (_lab_F2C72).l
	jmp (0xFF2028).l
_lab_F2A62:
	cmpi.b #0x25, D0
	beq.w _lab_F2A82
	bhi.w _lab_F2A82
	move #0, CCR
	subi.b #0x24, D0
	jsr (_lab_F2C8E).l
	jmp (0xFF2028).l
_lab_F2A82:
	move.w D0, (A3)
	move.w D0, (A3)
	movea.l 0x0.w, A7
	jmp (A4)
_lab_F2A8C:
	move.w D0, (A3)
	move.w D0, (A3)
	movea.l 0x0.w, A7
	suba.l #0x10, A7
	jmp (A4)
_lab_F2A9C:
	move.w D0, (A3)
	move.w D0, (A3)
	move.w D0, (A4)
	move.w D0, (A4)
	movea.l 0x4.w, A4
	movea.l 0x0.w, A7
	jmp (A4)
_lab_F2AAE:
	move.w D0, (A3)
	move.w D0, (A3)
	move.w D0, (A4)
	move.w D0, (A4)
	movea.l 0x0.w, A7
	jmp (A5)
_lab_F2ABC:
	move.b D0, 0xFFFFFE
	move.b D0, 0xFFFFFF
	move.l #0x301800A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2ADA:
	move.l #0x301000A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2AEC:
	addq.b #1, D0
	move.w D0, 0xFF16EC
	move.l #0x301400A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2B06:
	move.b #0, 0xFFFFFF
	move.b D0, 0xFFFFFE
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2B26:
	move.l #0x300400A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2B38:
	move.l #0x300800A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2B4A:
	move.l #0x300A00A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2B5C:
	move.l #0x300C00A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2B6E:
	move.l #0x300E00A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2B80:
	move.l #0x308E00A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2B92:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2BA4:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2BB6:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2BC8:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2BDA:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	moveq #0, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2BEC:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	move.l #0x1E00040, D0
	swap D0
	movea.l D0, A4
	rts

_lab_F2C02:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	move.l #0x1E00040, D0
	swap D0
	movea.l D0, A4
	moveq #0, D0
	swap D0
	movea.l D0, A5
	rts

_lab_F2C1E:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	move.l #0x380040, D0
	swap D0
	movea.l D0, A4
	moveq #0, D0
	swap D0
	movea.l D0, A5
	rts

_lab_F2C3A:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	move.l #0x3E0040, D0
	swap D0
	movea.l D0, A4
	moveq #0, D0
	swap D0
	movea.l D0, A5
	rts

_lab_F2C56:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	move.l #0x1E00040, D0
	swap D0
	movea.l D0, A4
	moveq #0, D0
	swap D0
	movea.l D0, A5
	rts

_lab_F2C72:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	move.l #0x380040, D0
	swap D0
	movea.l D0, A4
	moveq #0, D0
	swap D0
	movea.l D0, A5
	rts

_lab_F2C8E:
	move.l #0x300000A1, D0
	swap D0
	movea.l D0, A3
	move.l #0x3E0040, D0
	swap D0
	movea.l D0, A4
	moveq #0, D0
	swap D0
	movea.l D0, A5
	rts

_lab_F2CAA:
	move.w #0x13, D7
	move.w #0x6, 0xFF1118
_lab_F2CB6:
	move.w D7, 0xFFFD9C
	move.w #5, 0xFF1114
	move.w 0xFF1118, 0xFF1116
	move.w #5, 0xFF1110
	move.w 0xFF1118, 0xFF1112
	lea (_lab_F420E).l, A0
	jsr (_lab_F306E).l
	move #0, CCR
	addq.w #1, 0xFF1118
	move.w 0xFFFD9C, D7
	dbf D7, _lab_F2CB6
	rts

_lab_F2D02:
	move.w #5, D7
_lab_F2D06:
	moveq #0, D0
	move.b (A3)+, D0
	move.b D0, 0xFF110A
	cmpi.b #0, D0
	beq.w _lab_F2D46
	andi.b #0xF0, D0
	cmpi.b #0, D0
	bne.w _lab_F2D38
	jsr (_lab_F2F76).l
	bra.w _lab_F2D3E
_lab_F2D2E:
	moveq #0, D0
	move.b (A3)+, D0
	move.b D0, 0xFF110A
_lab_F2D38:
	jsr (_lab_F2F56).l
_lab_F2D3E:
	dbf D7, _lab_F2D2E
	bra.w _lab_F2D4A
_lab_F2D46:
	dbf D7, _lab_F2D06
_lab_F2D4A:
	jsr (_lab_F2D5C).l
	move.b #1, D0
	jsr (_lab_F2F1E).l
	rts

_lab_F2D5C:
	moveq #0, D2
	move.b #0, D0
	move.b #1, D1
	move.b 0xFF1145, D2
	move #4, CCR
	abcd D1, D2
	move.b D2, 0xFF1145
	move.b 0xFF1144, D2
	abcd D0, D2
	move.b D2, 0xFF1144
	move.b 0xFF1143, D2
	abcd D0, D2
	move.b D2, 0xFF1143
	move.b 0xFF1142, D2
	abcd D0, D2
	move.b D2, 0xFF1142
	move.b 0xFF1141, D2
	abcd D0, D2
	move.b D2, 0xFF1141
	move.b 0xFF1140, D2
	abcd D0, D2
	move.b D2, 0xFF1140
	rts

_lab_F2DC0:
	jsr (_lab_F25EE).l
	move.l 0xFF1120, D0
	andi.l #0x1FF, D0
	adda.l D0, A0
	moveq #0, D0
	move.w 0xFF111A, D0
	adda.l D0, A0
	moveq #0, D0
	move.b (A0), D0
	lea (_lab_F3EEE).l, A0
	lsl.l #5, D0
	adda.l D0, A0
	moveq #0, D0
	jsr (_lab_F306E).l
	move.b #0, D0
	jsr (_lab_F2F1E).l
	rts

_lab_F2E00:
	lea (_lab_F4236).l, A0
	move.l 0xFF1120, D0
	andi.l #0xFF, D0
	moveq #0, D1
	move.w 0xFF111A, D1
	lsl.l #2, D1
	add.l D1, D0
	adda.l D0, A0
	moveq #0, D0
	move.b 0xFF1122, D0
	andi.b #7, D0
	cmpi.b #0, D0
	beq.w _lab_F2E80
	cmpi.b #1, D0
	beq.w _lab_F2EBE
	cmpi.b #2, D0
	beq.w _lab_F2EA8
	cmpi.b #3, D0
	beq.w _lab_F2E6C
	cmpi.b #4, D0
	beq.w _lab_F2E94
	cmpi.b #5, D0
	beq.w _lab_F2ED6
	cmpi.b #6, D0
	beq.w _lab_F2EEC
	cmpi.b #7, D0
	beq.w _lab_F2F02
_lab_F2E6C:
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	bra.w _lab_F2F16
_lab_F2E80:
	move.w #2, D7
_lab_F2E84:
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	dbf D7, _lab_F2E84
	bra.w _lab_F2F16
_lab_F2E94:
	move.w #3, D7
_lab_F2E98:
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	dbf D7, _lab_F2E98
	bra.w _lab_F2F16
_lab_F2EA8:
	move.b (A0)+, D0
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	bra.w _lab_F2F16
_lab_F2EBE:
	move.b (A0)+, D0
	move.b (A0)+, D0
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	bra.w _lab_F2F16
_lab_F2ED6:
	move.w #3, D7
	move.b (A0)+, D0
_lab_F2EDC:
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	dbf D7, _lab_F2EDC
	bra.w _lab_F2F16
_lab_F2EEC:
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	move.b (A0)+, D0
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	bra.w _lab_F2F16
_lab_F2F02:
	move.b (A0)+, D0
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
	move.b (A0)+, D0
	move.b (A0)+, D0
	jsr (_lab_F2F18).l
_lab_F2F16:
	rts

_lab_F2F18:
	jsr (_lab_F2F92).l
_lab_F2F1E:
	move.w 0xFF1114, D6
	move.w 0xFF1116, D5
	lsl.w #7, D5
	lsl.w #1, D6
	add.w D5, D6
	swap D6
	clr.w D6
	ori.l #0x60000003, D6
	move.l D6, vdp_ctrl_port
	move.w D0, vdp_data_port
	move.w 0xFF1114, D6
	addq.w #1, D6
	move.w D6, 0xFF1114
	rts

_lab_F2F56:
	moveq #0, D0
	move.b 0xFF110A, D0
	andi.b #0xF0, D0
	lsr.b #4, D0
	andi.l #0xF, D0
	move #0, CCR
	addq.b #2, D0
	jsr (_lab_F2F1E).l
_lab_F2F76:
	moveq #0, D0
	move.b 0xFF110A, D0
	andi.l #0xF, D0
	move #0, CCR
	addq.b #2, D0
	jsr (_lab_F2F1E).l
	rts
	
_lab_F2F92:
	cmpi.b #0, 0xFF110C
	bne.w _lab_F3042
	cmpi.w #0x20, D0
	bne.w _lab_F2FAE
	move.w #0, D0
	bra.w _lab_F3042
_lab_F2FAE:
	cmpi.w #0x2E, D0
	bne.w _lab_F2FBE
	move.w #1, D0
	bra.w _lab_F3042
_lab_F2FBE:
	cmpi.w #0x30, D0
	blt.w _lab_F2FD6
	cmpi.w #0x39, D0
	bgt.w _lab_F2FD6
	subi.w #0x2E, D0
	bra.w _lab_F3042
_lab_F2FD6:
	cmpi.w #0x41, D0
	blt.w _lab_F2FEE
	cmpi.w #0x5A, D0
	bgt.w _lab_F2FEE
	subi.w #0x35, D0
	bra.w _lab_F3042
_lab_F2FEE:
	cmpi.w #0x2A, D0
	bne.w _lab_F2FFE
	move.w #0x26, D0
	bra.w _lab_F3042
_lab_F2FFE:
	cmpi.w #0x28, D0
	bne.w _lab_F300E
	move.w #0x28, D0
	bra.w _lab_F3042
_lab_F300E:
	cmpi.w #0x29, D0
	bne.w _lab_F301E
	move.w #0x29, D0
	bra.w _lab_F3042
_lab_F301E:
	cmpi.w #0x2D, D0
	bne.w _lab_F302E
	move.w #0x2A, D0
	bra.w _lab_F3042
_lab_F302E:
	cmpi.w #0x27, D0
	bne.w _lab_F303E
	move.w #0x2B, D0
	bra.w _lab_F3042
_lab_F303E:
	move.w #0, D0
_lab_F3042:
	cmpi.b #1, 0xFF110C
	bne.w _lab_F3058
	addi.w #0x40, D0
	jmp (_lab_F3068).l
_lab_F3058:
	cmpi.b #2, 0xFF110C
	bne.w _lab_F3068
	addi.w #0x80, D0
_lab_F3068:
	andi.w #0xFF, D0
	rts

_lab_F306E:
	move.b (A0)+, D0
	cmpi.b #0xFF, D0
	beq.w _lab_F3088
	cmpi.b #0xFE, D0
	beq.w _lab_F30A2
	jsr (_lab_F2F18).l
	bra.b _lab_F306E
_lab_F3088:
	move.w 0xFF1110, 0xFF1114
	addq.w #1, 0xFF1112
	move.w 0xFF1112, 0xFF1116
_lab_F30A2:
	rts

_lab_F30A4:
	lea (__init_GFX).l, A0
	lea (0xFF2000).l, A1
	clr.l D1
	moveq #0x3F, D5
	moveq #1, D3
	moveq #0x10, D4
	jsr (_lab_F3110).l
	lea (__init_digits_GFX).l, A0
	clr.l D1
	moveq #0x3F, D5
	moveq #2, D3
	moveq #0x20, D4
	jsr (_lab_F3110).l
	lea (__init_err_GFX).l, A0
	clr.l D1
	moveq #0x7F, D5
	moveq #3, D3
	moveq #0x30, D4
	jsr (_lab_F3110).l
	move.l #0x81749310, vdp_ctrl_port
	move.l #0x94189500, vdp_ctrl_port
	move.l #0x9690977F, vdp_ctrl_port
	move.l #0x40000080, vdp_ctrl_port
	rts

_lab_F3110:
	moveq #7, D7
_lab_F3112:
	move.b (A0)+, D1
	moveq #3, D6
_lab_F3116:
	clr.l D2
	lsl.b #1, D1
	bcs.b _lab_F3122
	move.b #0, D2
	bra.b _lab_F3124
_lab_F3122:
	move.b D4, D2
_lab_F3124:
	lsl.b #1, D1
	bcs.b _lab_F312E
	ori.b #0, D2
	bra.b _lab_F3130
_lab_F312E:
	or.b D3, D2
_lab_F3130:
	move.b D2, (A1)+
	dbf D6, _lab_F3116
	dbf D7, _lab_F3112
	dbf D5, _lab_F3110
	rts

_lab_F3140:
	move.w (A0)+, (A1)+
	dbf D7, _lab_F3140
	rts
	
_lab_F3148:
	move.w #0, (A0)+
	dbf D7, _lab_F3148
	rts

_lab_F3152:
	move.w #0xFFFF, (A0)+
	dbf D7, _lab_F3152
	rts

_lab_F315C:
	lea (0xFF1020).l, A1
	moveq #0x40, D7
	lea (_default_palette).l, A0
_lab_F316A:
	move.w (A0)+, (A1)+
	dbf D7, _lab_F316A
	move.w #1, 0xFF101E
	jsr (_lab_F3C24).l
	rts

_default_palette:
	.word 0x0000,0x0EEE,0x0EEE,0x0EEE,0x0000,0x0000,0x0000,0x0000
	.word 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.word 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.word 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.word 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.word 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.word 0x0000,0x0C0C,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000
	.word 0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000

__init_GFX:
	.incbin "init/initgfx.bin"
__init_digits_GFX:
	.incbin "init/initdigits.bin"
__init_err_GFX:
	.incbin "init/initerrgfx.bin"

__reset:
	move #0x2700, SR
	lea init_sp, A7    ; set stack pointer
	lea (__initregs).l, A5
	movem.w (A5)+, D5/D6/D7
	movem.l (A5)+, A0/A1/A2/A3/A4
	jmp (_init).l

__initregs:
	.word 0x8000        ; D5 (VDP reg base)
	.word 0x3FFF        ; D6 (ram size, 0x4000 dwords)
	.word 0x0100        ; D7 (increment high byte of D5)
	.long z80_bus       ; A0
	.long z80_req       ; A1
	.long z80_reset     ; A2
	.long vdp_data_port ; A3
	.long vdp_ctrl_port ; A4
	
	; VDP regs
	.byte 0x04 ; mode reg 1
	.byte 0x14 ; mode reg 2
	.byte 0x30 ; layer A (VRAM 0xC000)
	.byte 0x3C ; window (VRAM 0xF000)
	.byte 0x07 ; layer B (VRAM 0xE000)
	.byte 0x6C ; sprites (VRAM 0xD800)
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0xFF ; HINT counter
	.byte 0x00 ; mode reg 3
	.byte 0x81 ; mode reg 4 (40 cell mode)
	.byte 0x37 ; horizontal scrolling offset
	.byte 0x00
	.byte 0x01 ; auto-increment by 1
	.byte 0x01 ; plane size
	.byte 0x00 ; window horizontal position
	.byte 0x0A ; window vertical position
	.byte 0xFF
	.byte 0xFF
	.byte 0x00
	.byte 0x00
	.byte 0x80
	
	.long 0x40000080 ; VRAM fill mode
	.word 0x8104     ; disable VDP rendering
	.word 0x8F02     ; VDP auto-increment by 2
	.long 0xC0000000 ; CRAM address mode
	.long 0x40000010 ; VSRAM address mode
	
	.byte 0x9F,0xBF,0xDF,0xFF ; PSG registers

_lab_F36C4:
	lea (0xFF1100).l, A0
	lea (reg_data1).l, A1
	bsr.b _lab_F36D4
	addq.w #2, A1
_lab_F36D4:
	move.b #0, (A1)
	nop
	nop
	move.b (A1), D0
	lsl.b #2, D0
	andi.b #0xC0, D0
	move.b #0x40, (A1)
	nop
	nop
	move.b (A1), D1
	andi.b #0x3F, D1
	or.b D1, D0
	not.b D0
	move.b (A0), D1
	eor.b D0, D1
	move.b D0, (A0)+
	and.b D0, D1
	move.b d1, (A0)+
	rts

_lab_F3702:
	move.b #0, 0xFF1104
	move.b #0, 0xFF1105
	move.b #0, 0xFF1107
	move.b #0, 0xFF1109
	move.b 0xFF1101, D7
	btst.l #7, D7
	bne.w _lab_F37BE
	move.b 0xFF1101, D7
	btst.l #5, D7
	beq.w _lab_F375E
	move.w #0xB0, 0xFF0E00
	jsr (_lab_F3BDA).l
	move.b #0xAA, 0xFF1107
	jsr (_lab_F389C).l
	bra.w _lab_F37BC
_lab_F375E:
	move.b 0xFF1101, D7
	btst.l #6, D7
	beq.w _lab_F3770
	bra.w _lab_F37BC
_lab_F3770:
	move.b 0xFF1100, D7
	btst.l #0, D7
	beq.w _lab_F3798
	move.w #0xFFFF, D7
_lab_F3782:
	dbf D7, _lab_F3782
	move.w #0xFFFF, D7
_lab_F378A:
	dbf D7, _lab_F378A
	jsr _lab_F37C8
	bra.w _lab_F37BC
_lab_F3798:
	move.b 0xFF1100, D7
	btst.l #1, D7
	beq.w _lab_F37BC
	move.w #0xFFFF, D7
_lab_F37AA:
	dbf D7, _lab_F37AA
	move.w #0xFFFF, D7
_lab_F37B2:
	dbf D7, _lab_F37B2
	jsr (_lab_F3800).l
_lab_F37BC:
	rts
_lab_F37BE:
	move.b #0xAA, 0xFF1104
	rts

_lab_F37C8:
	subq.w #8, 0xFF0E00
	cmpi.w #0xB0, 0xFF0E00
	bge.w _lab_F37F8
	move.w #0x148, 0xFF0E00
	jsr (_lab_F3BDA).l
	jsr (_lab_F3942).l
	rts

_lab_F37F0:
	move.w #0xB0, 0xFF0E00
_lab_F37F8:
	jsr (_lab_F3BDA).l
	rts

_lab_F3800:
	addq.w #8, 0xFF0E00
	cmpi.w #0x148, 0xFF0E00
	ble.w _lab_F3830
	move.b #0xAA, 0xFF1109
	move.w #0xB0, 0xFF0E00
	jsr (_lab_F3BDA).l
	jsr (_lab_F389C).l
	rts

_lab_F3830:
	move.l 0xFF1160, D0
	move.l 0xFF1120, D1
	cmp.l D0, D1
	beq.w _lab_F384A
	jsr (_lab_F3BDA).l
	rts

_lab_F384A:
	move.l 0xFF1180, D0
	rol.w #3, D0
	move #0, CCR
	addi.w #0xA8, D0
	move.w 0xFF0E00, D1
	cmp.w D0, D1
	ble.w _lab_F3884
	move.b #0xAA, 0xFF1109
	move.w #0xB0, 0xFF0E00
	jsr (_lab_F3BDA).l
	jsr (_lab_F389C).l
	rts

_lab_F3884:
	jsr (_lab_F3BDA).l
	rts

_lab_F388C:
	move.w #0x148, 0xFF0E00
	jsr (_lab_F3BDA).l
	rts

_lab_F389C:
	move #0, CCR
	addi.l #0x14, 0xFF1120
	move.b #0, 0xFF1108
	move.l 0xFF1160, D0
	move.l 0xFF1120, D1
	cmp.l D0, D1
	beq.w _lab_F38CC
	bhi.w _lab_F38F0
	bra.w _lab_F3932
_lab_F38CC:
	move.b #0xAA, 0xFF1109
	move.b #0xAA, 0xFF1108
	move.l 0xFF1160, 0xFF1120
	jsr (_lab_F3A0E).l
	bra.w _lab_F3940
_lab_F38F0:
	move.b #0xAA, 0xFF1109
	move.b #0, 0xFF1108
	move.l #0, 0xFF1120
	move.l #0, 0xFF1130
	move.w #1, 0xFF1134
	move.l #0, 0xFF1140
	move.w #1, 0xFF1144
	bra.w _lab_F3940
_lab_F3932:
	move.b #0xAA, 0xFF1109
	jsr (_lab_F3A0E).l
_lab_F3940:
	rts

_lab_F3942:
	move.b #0, 0xFF1108
	moveq #0, D0
	move.l 0xFF1120, D1
	cmp.l D0, D1
	beq.w _lab_F3984
	bhi.w _lab_F3964
	bra.w _lab_F3984
_lab_F3960:
	bra.w _lab_F3A0C
_lab_F3964:
	move.b #0xAA, 0xFF1109
	move #0, CCR
	subi.l #0x14, 0xFF1120
	jsr (_lab_F3B3C).l
	bra.w _lab_F3A0C
_lab_F3984:
	move.l 0xFF1180, D0
	rol.w #3, D0
	move #0, CCR
	addi.w #0xA8, D0
	move.w D0, 0xFF0E00
	jsr (_lab_F3BDA).l
	move.b #0xAA, 0xFF1109
	move.b #0xAA, 0xFF1108
	move.w 0xFF1160, 0xFF1120
	move.w 0xFF1162, 0xFF1122
	move.w 0xFF1170, D0
	move.w D0, 0xFF1130
	move.w 0xFF1172, D0
	move.w D0, 0xFF1132
	move.w 0xFF1174, D0
	move.w D0, 0xFF1134
	move.w 0xFF1170, D0
	move.w D0, 0xFF1140
	move.w 0xFF1172, D0
	move.w D0, 0xFF1142
	move.w 0xFF1174, D0
	move.w D0, 0xFF1144
_lab_F3A0C:
	rts

_lab_F3A0E:
	move.b #0, D0
	move.b #0x20, D1
	move #4, CCR
	move.b 0xFF1135, D2
	abcd D1, D2
	move.b D2, 0xFF1135
	move.b 0xFF1134, D2
	abcd D0, D2
	move.b D2, 0xFF1134
	move.b 0xFF1133, D2
	abcd D0, D2
	move.b D2, 0xFF1133
	move.b 0xFF1132, D2
	abcd D0, D2
	move.b D2, 0xFF1132
	move.b 0xFF1131, D2
	abcd D0, D2
	move.b D2, 0xFF1131
	move.b 0xFF1130, D2
	abcd D0, D2
	move.b D2, 0xFF1130
	rts

_lab_F3A70:
	jsr (_lab_F3BDA).l
	move.l 0xFF1160, D0
	move.l 0xFF1120, D1
	cmp.l D0, D1
	blt.w _lab_F3A9A
	move.b #0xAA, 0xFF1108
	move.l 0xFF1160, 0xFF1120
_lab_F3A9A:
	jsr (_lab_F2CAA).l
	jsr (_lab_F3B26).l
	move.w #0x13, D7
	move.w #6, 0xFF1118
	move.w #0, 0xFF111A
_lab_F3ABA:
	move.w D7, 0xFFFD9C
	move.w #5, 0xFF1114
	move.w 0xFF1118, 0xFF1116
	move.w #5, 0xFF1110
	move.w 0xFF1118, 0xFF1112
	cmpi.b #0, 0xFF1108
	beq.w _lab_F3B04
	moveq #0, D0
	move.w 0xFF111A, D0
	move.l 0xFF1180, D1
	cmp.l D0, D1
	beq.w _lab_F3B24
_lab_F3B04:
	jsr (_lab_F2DC0).l
	move #0, CCR
	addq.w #1, 0xFF1118
	addq.w #1, 0xFF111A
	move.w 0xFFFD9C, D7
	dbf D7, _lab_F3ABA
_lab_F3B24:
	rts

_lab_F3B26:
	lea (0xFF1130).l, A0
	lea (0xFF1140).l, A1
	moveq #5, D7
_lab_F3B34:
	move.b (A0)+, (A1)+
	dbf D7, _lab_F3B34
	rts

_lab_F3B3C:
	lea (0xFF1130).l, A0
	lea (0xFF1150).l, A1
	move.w #5, D6
_lab_F3B4C:
	move.w D6, 0xFFFD98
	moveq #0, D0
	move.b (A0), D0
	andi.b #0xF0, D0
	ror.b #4, D0
	move.b D0, (A1)+
	move.b (A0)+, D0
	andi.b #0xF, D0
	move.b D0, (A1)+
	move.w 0xFFFD98, D6
	dbf D6, _lab_F3B4C
_lab_F3B70:
	move.b 0xFF115A, D0
	cmpi.b #0, D0
	bne.w _lab_F3BA0
	lea (0xFF115A).l, A0
	move.b #8, (A0)
_lab_F3B88:
	move.b -(A0), D0
	cmpi.b #0, D0
	bne.w _lab_F3B98
	move.b #9, (A0)
	bra.b _lab_F3B88
_lab_F3B98:
	subq.b #1, D0
	move.b D0, (A0)
	bra.w _lab_F3BA8
_lab_F3BA0:
	subq.b #2, D0
	move.b D0, 0xFF115A
_lab_F3BA8:
	lea (0xFF1150).l, A0
	lea (0xFF1130).l, A1
	move.w #5, D6
_lab_F3BB8:
	move.w D6, 0xFFFD98
	moveq #0, D0
	move.b (A0)+, D0
	andi.b #0xF, D0
	rol.b #4, D0
	move.b (A0)+, D1
	add.b D0, D1
	move.b D1, (A1)+
	move.w 0xFFFD98, D6
	dbf D6, _lab_F3BB8
	rts

_lab_F3BDA:
	lea (0xFF0E00).l, A0
	move (A0), 8(A0)
	add.l #8, A0
	move.w #0x8F02, vdp_ctrl_port
	move.l #0x93509400, vdp_ctrl_port
	move.l #0x96879500, vdp_ctrl_port
	move.w #0x977F, vdp_ctrl_port
	move.l #0x58000083, vdp_ctrl_port
	move.w #0, 0xFF1000
	rts

_lab_F3C22:
	rte     ; unused rte instruction

_lab_F3C24:
	tst.w 0xFF101E
	beq.w _lab_F3C5E
	move.l #0x81749340, vdp_ctrl_port
	move.l #0x94009510, vdp_ctrl_port
	move.l #0x9688977F, vdp_ctrl_port
	move.l #0xC0000080, vdp_ctrl_port ; do DMA
	move.w #0, 0xFF101E
_lab_F3C5E:
	rts

_lab_F3C60:
	.byte 0x00,0x07,0x08,0x0C,0x13,0x14,0x15,0x16
	.byte 0x17,0x18,0x06,0x12,0x0B,0x02,0x11,0x03
	.byte 0x09,0x0D,0x0F,0x10,0x01,0x0A,0x04,0x0E
	.byte 0x05,0x18,0x02,0x0A,0x14,0x09,0x02,0x12
	.byte 0x06,0x17,0x14,0x0B,0x0E,0x07,0x11,0x04
	.byte 0x0F,0x03,0x14,0x01,0x15,0x11,0x0A,0x02
	.byte 0x08,0x0B,0x0C,0x16,0x10,0x0A,0x17,0x09
	.byte 0x12,0x0B,0x05,0x0D,0x14,0x06,0x11,0x0E
	.byte 0x12,0x05,0x09,0x08,0x0C,0x07,0x05,0x15
	.byte 0x0C,0x02,0x10,0x09,0x0C,0x0D,0x15,0x12
	.byte 0x06,0x13,0x04,0x0D,0x0B,0x00,0x15,0x0B
	.byte 0x01,0x12,0x0D,0x04,0x17,0x13,0x17,0x13
	.byte 0x0C,0x11,0x06,0x13,0x07,0x15,0x08,0x05
	.byte 0x00,0x04,0x0D,0x0A,0x08,0x06,0x01,0x06
	.byte 0x0C,0x01,0x07,0x0E,0x05,0x0C,0x17,0x03
	.byte 0x13,0x04,0x02,0x00,0x16,0x09,0x0C,0x02
	.byte 0x07,0x18,0x01,0x0C,0x10,0x03,0x0C,0x0E
	.byte 0x02,0x08,0x14,0x12,0x0B,0x03,0x10,0x17
	.byte 0x0C,0x02,0x0D,0x09,0x17,0x07,0x0E,0x11
	.byte 0x0F,0x02,0x17,0x13,0x0C,0x11,0x06,0x13
	.byte 0x07,0x15,0x08,0x03,0x04,0x0F,0x11,0x10
	.byte 0x0E,0x0D,0x14,0x09,0x04,0x12,0x0F,0x0C
	.byte 0x17,0x17,0x13,0x06,0x0D,0x0A,0x0E,0x04
	.byte 0x09,0x05,0x13,0x04,0x16,0x15,0x0F,0x0F
	.byte 0x10,0x07,0x16,0x02,0x0B,0x0A,0x16,0x18
	.byte 0x07,0x06,0x0B,0x05,0x15,0x16,0x03,0x06
	.byte 0x13,0x0B,0x12,0x18,0x14,0x12,0x11,0x0A
	.byte 0x0B,0x10,0x13,0x10,0x02,0x03,0x09,0x16
	.byte 0x0F,0x0B,0x02,0x16,0x17,0x01,0x08,0x0D
	.byte 0x0E,0x0F,0x06,0x08,0x16,0x0A,0x0B,0x0C
	.byte 0x06,0x02,0x10,0x08,0x16,0x12,0x13,0x04
	.byte 0x00,0x17,0x0C,0x08,0x0A,0x13,0x0D,0x14
	.byte 0x02,0x16,0x14,0x16,0x09,0x03,0x05,0x04
	.byte 0x13,0x08,0x16,0x15,0x0E,0x10,0x13,0x03
	.byte 0x02,0x04,0x05,0x14,0x09,0x12,0x06,0x12
	.byte 0x07,0x04,0x06,0x10,0x0C,0x15,0x0A,0x17
	.byte 0x09,0x08,0x13,0x18,0x07,0x02,0x15,0x0B
	.byte 0x16,0x01,0x13,0x09,0x05,0x06,0x10,0x15
	.byte 0x0E,0x18,0x00,0x08,0x14,0x11,0x06,0x15
	.byte 0x08,0x15,0x0F,0x02,0x09,0x08,0x00,0x07
	.byte 0x03,0x10,0x14,0x07,0x0A,0x0C,0x11,0x03
	.byte 0x0F,0x0B,0x0D,0x09,0x02,0x01,0x12,0x01
	.byte 0x12,0x07,0x11,0x13,0x09,0x08,0x0F,0x0C
	.byte 0x03,0x13,0x02,0x15,0x0A,0x16,0x08,0x01
	.byte 0x12,0x0A,0x08,0x00,0x03,0x0A,0x09,0x13
	.byte 0x16,0x0F,0x0A,0x10,0x07,0x03,0x0A,0x06
	.byte 0x05,0x01,0x11,0x04,0x17,0x0F,0x08,0x17
	.byte 0x10,0x0E,0x15,0x09,0x15,0x0D,0x0A,0x00
	.byte 0x05,0x06,0x16,0x15,0x08,0x03,0x04,0x14
	.byte 0x07,0x14,0x0C,0x0E,0x03,0x02,0x00,0x10
	.byte 0x01,0x15,0x08,0x0D,0x06,0x03,0x10,0x16
	.byte 0x08,0x15,0x01,0x06,0x0C,0x06,0x0D,0x15
	.byte 0x0C,0x03,0x0F,0x14,0x0B,0x0A,0x13,0x04
	.byte 0x0F,0x09,0x0B,0x0E,0x06,0x18,0x0B,0x03
	.byte 0x05,0x0D,0x15,0x0E,0x06,0x13,0x08,0x0A
	.byte 0x11,0x12,0x05,0x18,0x07,0x11,0x02,0x08
	.byte 0x06,0x0F,0x0B,0x10,0x02,0x0C,0x0E,0x05
	.byte 0x08,0x06,0x01,0x13,0x09,0x12,0x13,0x00
	.byte 0x09,0x0F,0x01,0x0E,0x06,0x0B,0x07,0x02
	.byte 0x0C,0x0B,0x09,0x0D,0x02,0x16,0x10,0x09
	.byte 0x06,0x12,0x11,0x16,0x07,0x13,0x0C,0x17
	.byte 0x12,0x0D,0x06,0x07,0x02,0x12,0x0A,0x00
	.byte 0x15,0x14,0x13,0x05,0x12,0x0A,0x16,0x0F
	.byte 0x09,0x11,0x0F,0x0E,0x09,0x04,0x00,0x01
	.byte 0x09,0x0B,0x12,0x00,0x11,0x12,0x0D,0x02
	.byte 0x0D,0x05,0x0B,0x10,0x18,0x11,0x15,0x16
	.byte 0x13,0x04,0x0D,0x04,0x0D,0x08,0x04,0x10
	.byte 0x01,0x14,0x0C,0x01,0x17,0x04,0x02,0x07
	.byte 0x03,0x04,0x05,0x06,0x07,0x08,0x02,0x0A
	.byte 0x09,0x0D,0x14,0x0E,0x11,0x05,0x13,0x16
	.byte 0x18,0x17,0x0C,0x0A,0x01,0x16,0x0A,0x15
	.byte 0x11,0x04,0x12,0x05,0x02,0x17,0x15,0x14
	.byte 0x0B,0x0B,0x13,0x0E,0x15,0x08,0x0B,0x05
	.byte 0x0A,0x0E,0x02,0x09,0x10,0x17,0x0D,0x15
	.byte 0x07,0x04,0x02,0x0F,0x06,0x13,0x0E,0x06
	.byte 0x01,0x08,0x12,0x0A,0x0B,0x03,0x11,0x06
	.byte 0x03,0x01,0x0B,0x12,0x0C,0x05,0x07,0x02
	.byte 0x09,0x10,0x0C,0x13,0x15,0x07,0x0A,0x0E
	.byte 0x16,0x0D,0x0F,0x04,0x05,0x01,0x14,0x0C
	.byte 0x14,0x02,0x09,0x08,0x18,0x03,0x17,0x00
	.byte 0x16,0x0D,0x06,0x11,0x02,0x0E,0x06,0x13
	.byte 0x0F,0x01,0x06,0x08,0x12,0x0A

_lab_F3EEE:
	.byte "BARE KNUCKLEþ                  þ"
	.byte "BARE FORTUNEþ                  þ"
	.byte "BARE TAKKENþ                   þ"
	.byte "FIGHTER OF RAGEþ               þ"
	.byte "CLAY HEROSþ                    þ"
	.byte "FIGHTER MANþ                   þ"
	.byte "ARM WRESTLINGþ                 þ"
	.byte "98 WORLD CUP SOCCERþ           þ"
	.byte "DOUBLE CLUTCHþ                 þ"
	.byte "MANSELLþ                       þ"
	.byte "FERRARIþ                       þ"
	.byte "FASTEST LARþ                   þ"
	.byte "RAMBO 3þ                       þ"
	.byte "FRAG FIGHTERþ                  þ"
	.byte "LAMARCKþ                       þ"
	.byte "DRAGON FIGHTERþ                þ"
	.byte "HEAVY BARRELþ                  þ"
	.byte "ZEN INTERGALACTIC RANBOþ       þ"
	.byte "SUPER CONTRAþ                  þ"
	.byte "SUPER VOLLEY BALLþ             þ"
	.byte "BLOCK OUTþ                     þ"
	.byte "FATAL LABYRINTHþ               þ"
	.byte "ART ALIVEþ                     þ"
	.byte "OMEGA RACEþ                    þ"
	.byte "PING PONGþ                     þ"

_lab_F420E:
	.byte "                                       þ" ; why is it longer?

_lab_F4236:
	.byte 0x12,0x15,0x24,0x27,0xFE ; not quite sure what these could be used for...
	.byte 0x13,0x16,0x25,0x28,0xFE
	.byte 0x14,0x17,0x26,0x29,0xFE
	.byte 0x06,0x09,0x24,0x27,0xFE
	.byte 0x07,0x0A,0x25,0x28,0xFE
	.byte 0x08,0x0B,0x26,0x29,0xFE
	.byte 0x24,0x27,0x18,0x1B,0xFE
	.byte 0x25,0x28,0x19,0x1C,0xFE
	.byte 0x26,0x29,0x1A,0x1D,0xFE
	.byte 0x2A,0x2D,0x24,0x27,0xFE
	.byte 0x2B,0x2E,0x25,0x28,0xFE
	.byte 0x2C,0x2F,0x26,0x29,0xFE
	
	.byte 0x1E,0x21,0x00,0x03,0x00,0x03,0xFE
	.byte 0x1F,0x22,0x01,0x04,0x01,0x04,0xFE
	.byte 0x20,0x23,0x02,0x05,0x02,0x05,0xFE
	.byte 0x30,0x33,0x00,0x03,0x00,0x03,0xFE
	.byte 0x31,0x34,0x01,0x04,0x01,0x04,0xFE
	.byte 0x32,0x35,0x02,0x05,0x02,0x05,0xFE
	
	.byte 0x06,0x09,0x0C,0x0F,0x00,0x03,0x00,0x03,0xFE
	.byte 0x07,0x0A,0x0D,0x10,0x01,0x04,0x01,0x04,0xFE
	.byte 0x08,0x0B,0x0E,0x11,0x02,0x05,0x02,0x05,0xFE
	.byte 0x30,0x33,0x30,0x33,0x30,0x33,0x30,0x33,0xFE
	.byte 0x31,0x34,0x31,0x34,0x31,0x34,0x31,0x34,0xFE
	.byte 0x32,0x35,0x32,0x35,0x32,0x35,0x32,0x35,0xFE
	
	.byte 0x30,0x33,0x30,0x33,0xFE
	.byte 0x31,0x34,0x31,0x34,0xFE
	.byte 0x32,0x35,0x32,0x35,0xFE
	.byte 0x12,0x15,0x00,0x03,0xFE
	.byte 0x13,0x16,0x01,0x04,0xFE
	.byte 0x14,0x17,0x02,0x05,0xFE
	.byte 0x1E,0x21,0x00,0x03,0xFE
	.byte 0x1F,0x22,0x01,0x04,0xFE
	.byte 0x20,0x23,0x02,0x05,0xFE
	.byte 0x18,0x1B,0x0C,0x0F,0xFE
	.byte 0x19,0x1C,0x0D,0x10,0xFE
	.byte 0x1A,0x1D,0x0E,0x11,0xFE
	.byte 0x36,0x39,0x00,0x03,0xFE
	.byte 0x37,0x3A,0x01,0x04,0xFE
	.byte 0x38,0x3B,0x02,0x05,0xFE
	.byte 0x12,0x15,0x30,0x33,0xFE
	.byte 0x13,0x16,0x31,0x34,0xFE
	.byte 0x14,0x17,0x32,0x35,0xFE
	.byte 0x24,0x27,0x24,0x27,0xFE
	.byte 0x25,0x28,0x25,0x28,0xFE
	.byte 0x26,0x29,0x26,0x29,0xFE
	.byte 0x36,0x39,0x30,0x33,0xFE
	.byte 0x37,0x3A,0x31,0x34,0xFE
	.byte 0x38,0x3B,0x32,0x35,0xFE

_lab_F434A: ; even numbers
	.byte 0x00,0x02,0x04,0x06,0x08,0x0A,0x0C,0x0E,0x10
	.byte 0x12,0x14,0x16,0x18,0x1A,0x1C,0x1E,0x20,0x22
	.byte 0xFE

_lab_F435D: ; odd numbers
	.byte 0x01,0x03,0x05,0x07,0x09,0x0B,0x0D,0x0F,0x11
	.byte 0x13,0x15,0x17,0x19,0x1B,0x1D,0x1F,0x21,0x23
	.byte 0xFE

_lab_F4370:
	.word 0x00B0, 0x0001, 0x0000, 0x0098, 0x00B0, 0x0002, 0x6027, 0x00A0
