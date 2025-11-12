; Exception vectors
	.org 0
	
.if COMP_BOOT_DIRECTLY
	; the rom can function without the "init program", and boot directly to the game.
	
	.long 0                 ; initial stack pointer
	.long _game_start       ; reset vector
.else
	; by default, the rom boots to the "init program"
	
	.long __default_int     ; initial stack pointer (unused)
	.long __reset           ; reset vector
.endif
	
	.long __default_int     ; bus error
	.long __default_int     ; address error
	.long __default_int     ; illegal instruction
	.long __default_int     ; zero divide
	.long __default_int     ; CHK instruction
	.long __default_int     ; TRAPV instruction
	.long __default_int     ; Privilege violation
	.long __default_int     ; Trace
	.long __default_int     ; Line 1010 Emulator
	.long __default_int     ; Line 1111 Emulator
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	
	.long __error_except
	.long __error_except
	.long __error_except
	.long __error_except     ; Horizontal interrupt
	.long __error_except
	
	.long __vblank           ; Vertical interrupt
	
	.long __error_except
	
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int
	.long __default_int

; Header
	.balign 0x100,0xFF
	
	.byte "SEGA are Registered  Trademarks Of Sega Enterprises Ltd."
	
; Interrupts
	.balign 0x200,0xFF
	
__default_int:
	jmp (__default_int).L
	rte

	.balign 0x210,0xFF
	
__error_except:
	;nothing lol


	.balign 0x220,0xFF

__vblank:
	movem.l D0-A6, -(A7)
	jsr (_lab_EBC04).l
	movem.l (A7)+, D0-A6
	rte
