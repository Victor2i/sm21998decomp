; data for graphics

gfx_tiles_51:
	.incbin "gfx/tiles_51.gfx"
gfx_tiles_52:
	.incbin "gfx/tiles_52.gfx"
gfx_tiles_53:
	.incbin "gfx/tiles_53.gfx"
gfx_mvt53:
	.incbin "gfx/mvt53.gfx"
gfx_tiles_54:
	.incbin "gfx/tiles_54.gfx"
gfx_mvt54:
	.incbin "gfx/mvt54.gfx"
gfx_tiles_61:
	.incbin "gfx/tiles_61.gfx"
gfx_mvt61:
	.incbin "gfx/mvt61.gfx"
gfx_tiles_62:
	.incbin "gfx/tiles_62.gfx"
gfx_mvt62:
	.incbin "gfx/mvt62.gfx"
gfx_tiles_63:
	.incbin "gfx/tiles_63.gfx"
gfx_mvt63:
	.incbin "gfx/mvt63.gfx"
gfx_tiles_64:
	.incbin "gfx/tiles_64.gfx"
gfx_mvt64:
	.incbin "gfx/mvt64.gfx"
gfx_tiles_71:
	.incbin "gfx/tiles_71.gfx"
gfx_mvt71:
	.incbin "gfx/mvt71.gfx"
gfx_tiles_72:
	.incbin "gfx/tiles_72.gfx"
gfx_tiles_73:
	.incbin "gfx/tiles_73.gfx"
gfx_tiles_74:
	.incbin "gfx/tiles_74.gfx"
gfx_tiles_81:
	.incbin "gfx/tiles_81.gfx"
gfx_mvt81:
	.incbin "gfx/mvt81.gfx"
gfx_tiles_82:
	.incbin "gfx/tiles_82.gfx"
gfx_mvt82:
	.incbin "gfx/mvt82.gfx"
gfx_tiles_83:
	.incbin "gfx/tiles_83.gfx"
gfx_mvt83:
	.incbin "gfx/mvt83.gfx"
gfx_tiles_841:
	.incbin "gfx/tiles_841.gfx"
gfx_mvt841:
	.incbin "gfx/mvt841.gfx"
gfx_tiles_842:
	.incbin "gfx/tiles_842.gfx"
gfx_mvt842:
	.incbin "gfx/mvt842.gfx"
gfx_tiles_843:
	.incbin "gfx/tiles_843.gfx"
gfx_tiles_844:
	.incbin "gfx/tiles_844.gfx"
gfx_tiles_845:
	.incbin "gfx/tiles_845.gfx"

gfx_moving_tiles:
	.long gfx_mvt11  ; 1-1
	.long gfx_mvt12  ; 1-2
	.long gfx_mvt12  ; 1-1 bonus
	.long gfx_mvt12  ; 1-3
	.long gfx_mvt14  ; 1-4
	.long gfx_mvt11  ; 1-2 bonus
	.long gfx_mvt21  ; 2-1
	.long gfx_mvt12  ; 2-2
	.long gfx_mvt12  ; 2-3
	.long gfx_mvt24  ; 2-4
	.long gfx_mvt31  ; 3-1
	.long gfx_mvt12  ; 3-2
	.long gfx_mvt33  ; 3-3
	.long gfx_mvt34  ; 3-4
	.long gfx_mvt41  ; 4-1
	.long gfx_mvt42  ; 4-2
	.long gfx_mvt43  ; 4-3
	.long gfx_mvt12  ; 4-4
	.long gfx_mvt12  ; 5-1
	.long gfx_mvt12  ; 5-2
	.long gfx_mvt53  ; 5-3
	.long gfx_mvt54  ; 5-4
	.long gfx_mvt61  ; 6-1
	.long gfx_mvt62  ; 6-2
	.long gfx_mvt63  ; 6-3
	.long gfx_mvt64  ; 6-4
	.long gfx_mvt71  ; 7-1
	.long gfx_mvt71  ; 7-2
	.long gfx_mvt71  ; 7-3
	.long gfx_mvt71  ; 7-4
	.long gfx_mvt81  ; 8-1
	.long gfx_mvt82  ; 8-2
	.long gfx_mvt83  ; 8-3
	.long gfx_mvt841 ; 8-4 (1)
	.long gfx_mvt842 ; 8-4 (2)
	.long gfx_mvt11  ; 8-4 (3)
	.long gfx_mvt12  ; 8-4 (4)
	.long gfx_mvt12  ; 8-4 (5)
	.long gfx_mvt12  ; unused
	.long gfx_mvt12  ; unused

gfx_ending:
	.incbin "gfx/ending.gfx"

gfx_gameover:
	.incbin "gfx/gameover.gfx"

gfx_transition:
	.incbin "gfx/transition.gfx"

gfx_mario_fire:
	.incbin "gfx/mario_fire.gfx"
gfx_luigi_tall:
	.incbin "gfx/luigi_tall.gfx"
gfx_mario_tall:
	.incbin "gfx/mario_tall.gfx"
gfx_luigi:
	.incbin "gfx/luigi.gfx"
gfx_mario:
	.incbin "gfx/mario.gfx"

gfx_sprite_pointers:
	.long gfx_sprites_casual ; 1-1
	.long gfx_sprites_casual ; 1-2
	.long gfx_sprites_casual ; 1-1 bonus
	.long gfx_sprites_casual ; 1-3
	.long gfx_sprites_castle ; 1-4
	.long gfx_sprites_casual ; 1-2 bonus
	.long gfx_sprites_casual ; 2-1
	.long gfx_sprites_casual ; 2-2
	.long gfx_sprites_casual ; 2-3
	.long gfx_sprites_castle ; 2-4
	.long gfx_sprites_casual ; 3-1
	.long gfx_sprites_casual ; 3-2
	.long gfx_sprites_casual ; 3-3
	.long gfx_sprites_castle ; 3-4
	.long gfx_sprites_casual ; 4-1
	.long gfx_sprites_casual ; 4-2
	.long gfx_sprites_casual ; 4-3
	.long gfx_sprites_castle ; 4-4
	.long gfx_sprites_casual ; 5-1
	.long gfx_sprites_casual ; 5-2
	.long gfx_sprites_casual ; 5-3
	.long gfx_sprites_castle ; 5-4
	.long gfx_sprites_casual ; 6-1
	.long gfx_sprites_casual ; 6-2
	
	; BUG: 6-3 AND 6-4 ARE POINTING TO THE WRONG ADDRESSES...
	
	.long gfx_sprites_castle ; 6-3
	.long gfx_sprites_casual ; 6-4
	
	; HERE IS THE FIX:
	; .long gfx_sprites_casual ; 6-3
	; .long gfx_sprites_castle ; 6-4
	
	.long gfx_sprites_casual ; 7-1
	.long gfx_sprites_casual ; 7-2
	.long gfx_sprites_casual ; 7-3
	.long gfx_sprites_castle ; 7-4
	.long gfx_sprites_casual ; 8-1
	.long gfx_sprites_casual ; 8-2
	.long gfx_sprites_casual ; 8-3
	.long gfx_sprites_casual ; 8-4 (1)
	.long gfx_sprites_casual ; 8-4 (2)
	.long gfx_sprites_casual ; 8-4 (3)
	.long gfx_sprites_casual ; 8-4 (4)
	.long gfx_sprites_castle ; 8-4 (5)

gfx_sprites_castle:
	.incbin "gfx/sprites_castle.gfx"

gfx_sprites_casual:
	.incbin "gfx/sprites_casual.gfx"

gfx_sprites_any:
	.incbin "gfx/sprites_any.gfx"

gfx_bg_pointers:
	.long gfx_tiles_11
	.long gfx_tiles_12
	.long gfx_tiles_11_bonus
	.long gfx_tiles_13
	.long gfx_tiles_14
	.long gfx_tiles_12_bonus
	.long gfx_tiles_21
	.long gfx_tiles_22
	.long gfx_tiles_23
	.long gfx_tiles_24
	.long gfx_tiles_31
	.long gfx_tiles_32
	.long gfx_tiles_33
	.long gfx_tiles_34
	.long gfx_tiles_41
	.long gfx_tiles_42
	.long gfx_tiles_43
	.long gfx_tiles_44
	.long gfx_tiles_51
	.long gfx_tiles_52
	.long gfx_tiles_53
	.long gfx_tiles_54
	.long gfx_tiles_61
	.long gfx_tiles_62
	.long gfx_tiles_63
	.long gfx_tiles_64
	.long gfx_tiles_71
	.long gfx_tiles_72
	.long gfx_tiles_73
	.long gfx_tiles_74
	.long gfx_tiles_81
	.long gfx_tiles_82
	.long gfx_tiles_83
	.long gfx_tiles_841
	.long gfx_tiles_842
	.long gfx_tiles_843
	.long gfx_tiles_844
	.long gfx_tiles_845

gfx_tiles_11:
	.incbin "gfx/tiles_11.gfx"
gfx_title:
	.incbin "gfx/title.gfx"
gfx_mvt11:
	.incbin "gfx/mvt11.gfx"
gfx_tiles_12:
	.incbin "gfx/tiles_12.gfx"
gfx_mvt12:
	.incbin "gfx/mvt12.gfx"
gfx_tiles_11_bonus:
	.incbin "gfx/tiles_11_bonus.gfx"
gfx_tiles_13:
	.incbin "gfx/tiles_13.gfx"
gfx_tiles_14:
	.incbin "gfx/tiles_14.gfx"
gfx_mvt14:
	.incbin "gfx/mvt14.gfx"
gfx_tiles_12_bonus:
	.incbin "gfx/tiles_12_bonus.gfx"
gfx_tiles_21:
	.incbin "gfx/tiles_21.gfx"
gfx_mvt21:
	.incbin "gfx/mvt21.gfx"
gfx_springprincess:
	.incbin "gfx/spring_princess.gfx"
gfx_tiles_22:
	.incbin "gfx/tiles_22.gfx"
gfx_tiles_23:
	.incbin "gfx/tiles_23.gfx"
gfx_tiles_24:
	.incbin "gfx/tiles_24.gfx"
gfx_mvt24:
	.incbin "gfx/mvt24.gfx"
gfx_tiles_31:
	.incbin "gfx/tiles_31.gfx"
gfx_mvt31:
	.incbin "gfx/mvt31.gfx"
gfx_tiles_32:
	.incbin "gfx/tiles_32.gfx"
gfx_tiles_33:
	.incbin "gfx/tiles_33.gfx"
gfx_mvt33:
	.incbin "gfx/mvt33.gfx"
gfx_tiles_34:
	.incbin "gfx/tiles_34.gfx"
gfx_mvt34:
	.incbin "gfx/mvt34.gfx"
gfx_tiles_41:
	.incbin "gfx/tiles_41.gfx"
gfx_mvt41:
	.incbin "gfx/mvt41.gfx"
gfx_tiles_42:
	.incbin "gfx/tiles_42.gfx"
gfx_mvt42:
	.incbin "gfx/mvt42.gfx"
gfx_tiles_43:
	.incbin "gfx/tiles_43.gfx"
gfx_mvt43:
	.incbin "gfx/mvt43.gfx"
gfx_tiles_44:
	.incbin "gfx/tiles_44.gfx"
