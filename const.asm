; System defines
.set	init_sp,			0xFFFE00

; I/O

.set	reg_version,		0xA10001
.set	reg_data1,			0xA10003
.set	reg_data2,			0xA10005

.set	reg_control1,		0xA10009
.set	reg_control2,		0xA1000B
.set	reg_control3,		0xA1000D

.set	reg_controllers,	0xA10008
.set	reg_exp_port,		0xA1000C

.set	reg_tmss,			0xA14000

; Z80 regs
.set	z80_bus,			0xA00000
.set	z80_req,			0xA11100
.set	z80_reset,			0xA11200

; YM regs
.set	ym_A0,				0xA04000
.set	ym_D0,				0xA04001
.set	ym_A1,				0xA04002
.set	ym_D1,				0xA04003

; VDP regs
.set	vdp_data_port,		0xC00000
.set	vdp_ctrl_port,		0xC00004
.set	vdp_counter,		0xC00008

.set	psg_input,			0xC00011
