; constants for compiling
.set COMP_BOOT_DIRECTLY,	0		; 0 by default. Set this to 1 if you don't want to see " 輔助記憶體讀取失敗 "

; assembly files
	.include "const.asm"
	.include "interrupts.asm"
	.include "mario.asm"
	.include "palettes.asm"
	.include "bgs.asm"
	.include "gfx.asm"
	.include "levels.asm"
	.include "screens.asm"
	.include "sonic.asm"
	.include "demo.asm"
	.include "sound.asm"
.ifeq COMP_BOOT_DIRECTLY
	.include "init/init.asm"
.endif
	.include "tilemaps.asm"
	
	.include "PCM_bank1.asm"
	.include "PCM_bank2.asm"
	.include "PCM_bank3.asm"
	.include "PCM_bank4.asm"
	.include "PCM_bank5.asm"
	
	.include "stolen.asm" ; lmao

; Make the binary 2 megabytes
	.balign 0x200000,0
