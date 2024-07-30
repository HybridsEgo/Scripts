; ===================================================================================================================================================
; ===================================================================================================================================================
; ===================================================================================================================================================
(script continuous vs_ss_banshee_ambush
	(object_create_anew ss_pelican_01)
	(object_create_anew ss_pelican_02)

	(sleep 1)

	(scenery_animation_start_relative_loop ss_pelican_01 objects\vehicles\pelican\cinematics\vignettes\010vd_pelican_crash\010vd_pelican_crash "pelican1_loop" ss_pelican_anchor)
	(scenery_animation_start_relative_loop ss_pelican_02 objects\vehicles\pelican\cinematics\vignettes\010vd_pelican_crash\010vd_pelican_crash "pelican2_loop" ss_pelican_anchor)

	(sleep (* 109 1))

		(object_create_anew ss_banshee_01)
		(object_create_anew ss_banshee_02)
		(object_create_anew ss_banshee_03)
		(object_create_anew ss_banshee_04)
		
;		(wake vs_ss_banshee_effects)
		
		(sleep 1)
		
		(scenery_animation_start_relative ss_pelican_01 objects\vehicles\pelican\cinematics\vignettes\010vd_pelican_crash\010vd_pelican_crash "pelican1_1" ss_pelican_anchor)
		(scenery_animation_start_relative ss_pelican_02 objects\vehicles\pelican\cinematics\vignettes\010vd_pelican_crash\010vd_pelican_crash "pelican2_1" ss_pelican_anchor)
	
		(scenery_animation_start_relative ss_banshee_01 objects\vehicles\banshee\cinematics\vignettes\010vd_pelican_crash\010vd_pelican_crash "banshee1_1" ss_pelican_anchor)
		(scenery_animation_start_relative ss_banshee_02 objects\vehicles\banshee\cinematics\vignettes\010vd_pelican_crash\010vd_pelican_crash "banshee2_1" ss_pelican_anchor)
		(scenery_animation_start_relative ss_banshee_03 objects\vehicles\banshee\cinematics\vignettes\010vd_pelican_crash\010vd_pelican_crash "banshee3_1" ss_pelican_anchor)
		(scenery_animation_start_relative ss_banshee_04 objects\vehicles\banshee\cinematics\vignettes\010vd_pelican_crash\010vd_pelican_crash "banshee4_1" ss_pelican_anchor)
		

	(sleep (scenery_get_animation_time ss_pelican_01))
	(object_destroy ss_pelican_01)


	(sleep (scenery_get_animation_time ss_pelican_02))
	(object_destroy ss_pelican_02)
	
	(object_destroy ss_banshee_01)
	(object_destroy ss_banshee_02)
	(object_destroy ss_banshee_03)
	(object_destroy ss_banshee_04)
)

;*
(script dormant vs_ss_banshee_effects
	; pelican01 hit 
	(sleep 102)
	(if debug (print "pelican01 hit"))
	(wake vs_ss_pelican01_hit)
			
	; pelican01 explode 
	(sleep (- 145 102))
	(if debug (print "pelican01 explode"))
	(wake vs_ss_pelican01_explode)

	; pelican02 1st hit 
	(sleep (- 205 150))
	(if debug (print "pelican02 1st hit"))
	(wake vs_ss_pelican02_1st_hit)
		
	; pelican02 2nd hit 
	(sleep (- 210 206))
	(if debug (print "pelican02 2nd hit"))
	(wake vs_ss_pelican01_2nd_hit)
)

(script dormant vs_ss_pelican01_hit
	(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "tailfront")
	
	(begin_random
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "right_front_wingtip")
			(sleep (random_range 0 5))
		)
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "right_front_down_thruster")
			(sleep (random_range 0 5))
		)
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "right_back_wingtip")
			(sleep (random_range 0 5))
		)
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "right_rear_back_thruster")
			(sleep (random_range 0 5))
		)
	)
)

(script dormant vs_ss_pelican01_explode
	(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "tailfront")
	(effect_new_at_ai_point "levels\solo\010_jungle\fx\vehicle_explosion\vehicle_explosion.effect" ps_ss_pelican/pel01_explosion)
		
	(begin_random
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "right_front_wingtip")
			(sleep (random_range 0 5))
		)
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "right_front_down_thruster")
			(sleep (random_range 0 5))
		)
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "right_back_wingtip")
			(sleep (random_range 0 5))
		)
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_01 "right_rear_back_thruster")
			(sleep (random_range 0 5))
		)
	)
)

(script dormant vs_ss_pelican02_1st_hit
	(begin_random
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_02 "right_front_wingtip")
			(sleep (random_range 0 5))
		)
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_02 "right_front_down_thruster")
			(sleep (random_range 0 5))
		)
	)
)

(script dormant vs_ss_pelican01_2nd_hit
	(begin_random
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_02 "right_front_wingtip")
			(sleep (random_range 0 5))
		)
		(begin
			(effect_new_on_object_marker "fx\scenery_fx\explosions\human_explosion_large\human_explosion_large.effect" ss_pelican_02 "right_front_down_thruster")
			(sleep (random_range 0 5))
		)
	)
)


*;

; ===================================================================================================================================================
; ===================================================================================================================================================
; ===================================================================================================================================================
