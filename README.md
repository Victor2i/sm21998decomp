# sm21998decomp
Decompilation of Super Mario 2 1998 for the Sega Mega Drive / Sega Genesis

## Prerequisites
You need the verified good dump, `Super Mario 2 1998 (Unl) [!].gen`

You will also need to create a directory named "GFX" in the root of the repo.

By default, the graphics files are absent in the GFX folder.

Luckily, you can extract them from the original ROM yourself, using the python script "extract_gfx" included in the repo.

Run `python extract_gfx.py "Super Mario 2 1998 (Unl) [!].gen"` inside the root directory, and it will extract all of the graphics files into `GFX/`.

## Compiling
This decompilation was made to work with [Volker Assembler "vasm"](http://sun.hasenbraten.de/vasm/index.php), which is the compiler I'm most comfortable with.
You can always use a different compiler as long as it is compatible, but I recommend using vasm as it is very simple yet efficient.

The version you need is "vasmm68k_std".

To compile the ROM, just run this single command in the root of the repo:

* `vasmm68k_std -Fbin main.asm -no-opt -o out.md`

This will build a new file, `out.md`, which you can run in any emulator you want.

## Sound Driver Z80 code
By default, the code fed to the Z80 by the sound driver is present in the `z80/` directory, it is decompiled, and already compiled as a binary file in the same folder.
If you wish to modify it for testing, you will also need "vasmz80_std".

To compile it, run these two following commands:

* `vasmz80_std -Fbin z80init.asm -o z80init.bin`
* `vasmz80_std -Fbin z80main.asm -o z80main.bin`

## Manual of Style
Upper-case symbols are variable names.
Lower-case symbols are function names.

## Decompilation progress
As of now, the game is fully decompiled, and the decompilation is byte accurate to the original ROM, minus a few "garbage" regions (see "Garbage regions of the original ROM")

The current goal is the reverse engineer the code, comment the code that hasn't been documented yet, and replace pointers to memory locations by friendly variable names, as well as code labels.

Once that is done, the next goal will be to reverse engineer the Sonic Jam 6 version of this game, using this decompilation as a base, and eventually merge the two.

## Garbage regions of the original ROM
For unknown reasons, there are four regions in the `Super Mario 2 1998 (Unl) [!].gen` ROM (as well as other dumps known) that contain copies of other regions of the ROM:

* 0x1C2000 to 0x1C3FFF is a copy of 0x1C0000 to 0x1C1FFF
* 0x1C5000 to 0x1C5FFF is a copy of 0x150000 to 0x150FFF
* 0x1C6040 to 0x1CFFFF is a copy of 0x156040 to 0x15FFFF
* 0x1F7D30 to 0x1FDFFF is a copy of 0x167D30 to 0x16DFFF

We don't care about recreating these, they have no real purpose and were never meant to be used by the game.
