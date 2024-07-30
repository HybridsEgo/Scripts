; ===============================================================================================================================================
; global hud ================================================================================================================================
; ===============================================================================================================================================
(script static void f_hud_obj_complete
	(objectives_clear)
	(chud_show_screen_objective campaign_hud_objcomplete)
	(sleep 160)
	(chud_show_screen_objective "")
)
; =================================================================================================
; global_pelican.hsc
; how to use:
; 	1. open your scenario in sapien
;	2. in the menu bar, open the "scenarios" menu, then select "add mission script"
;	3. point the dialogue to this file: main\data\globals\global_pelican.hsc
; =================================================================================================
(global boolean b_debug_pelican true)

(script static void	(f_load_pelican
								(vehicle pelican)		; phantom to load 
								(string load_side)		; how to load it 
								(ai load_squad_01)		; squads to load 
								(ai load_squad_02)
				)
	; place ai 
	(ai_place load_squad_01)
	(ai_place load_squad_02)
	;(ai_place load_squad_03)
	;(ai_place load_squad_04)
	(sleep 1)
	
	
	(cond
		; left 
		((= load_side "left")
						(begin
							(if b_debug_pelican (print "load pelican left..."))
							(ai_vehicle_enter_immediate load_squad_01 pelican "pelican_p_l")
							;(ai_vehicle_enter_immediate load_squad_02 pelican "phantom_p_lf")
							;(ai_vehicle_enter_immediate load_squad_03 pelican "phantom_p_ml_f")
							;(ai_vehicle_enter_immediate load_squad_04 pelican "phantom_p_ml_b")
						)
		)
		; right 
		((= load_side "right")
						(begin
							(if b_debug_pelican (print "load pelican right..."))
							(ai_vehicle_enter_immediate load_squad_01 pelican "pelican_p_r")
							;(ai_vehicle_enter_immediate load_squad_02 pelican "phantom_p_rf")
							;(ai_vehicle_enter_immediate load_squad_03 pelican "phantom_p_mr_f")
							;(ai_vehicle_enter_immediate load_squad_04 pelican "phantom_p_mr_b")
							
						)
		)
		; dual 
		((= load_side "dual")
						(begin
							(if b_debug_pelican (print "load pelican dual..."))
							(ai_vehicle_enter_immediate load_squad_01 pelican "pelican_p_l")
							(ai_vehicle_enter_immediate load_squad_02 pelican "pelican_p_r")
							;(ai_vehicle_enter_immediate load_squad_02 phantom "phantom_p_rf")
							;(ai_vehicle_enter_immediate load_squad_03 phantom "phantom_p_lb")
							;(ai_vehicle_enter_immediate load_squad_04 phantom "phantom_p_rb")
						)
		)
	)			
				
)


(script static void (f_unload_pelican_all	(vehicle pelican))
	(unit_open pelican)
	(sleep 60)
	(begin_random
		(begin
			(vehicle_unload pelican "pelican_p_l01")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_l02")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_l03")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_l04")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_l05")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_r01")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_r02")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_r03")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_r04")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload pelican "pelican_p_r05")
			(sleep (random_range 0 10))
		)
	)
)

; new pelican global scripts =======================================================================================================================================

(script static void (f_load_pelican_cargo
										(vehicle pelican)		; the phantom you are loading the cargo in to 
										(string load_type)	; 1 - single load    ---   2 - double load 
										(ai load_squad_01)		; first squad to load
										(ai load_squad_02)		; second squad to load 
				)
	; place ai 
	
	; load into fork 
	(cond
		((= load_type "large")	
						(begin
							(ai_place load_squad_01)
								(sleep 1)
							(vehicle_load_magic pelican "pelican_lc" (ai_vehicle_get_from_squad load_squad_01 0))
						)
		)
		((= load_type "small")	
						(begin
							(ai_place load_squad_01)
							(ai_place load_squad_02)
								(sleep 1)
							;(vehicle_load_magic pelican "pelican_lc_01" (ai_vehicle_get_from_squad load_squad_01 0))
							;(vehicle_load_magic pelican "pelican_lc_02" (ai_vehicle_get_from_squad load_squad_02 0))
						)
		)
	)
)

(script static void (f_unload_pelican_cargo
										(vehicle pelican)
										(string load_type)
				)
	; unload cargo seats 
	(cond
		((= load_type "large")	(vehicle_unload pelican "pelican_lc"))
		((= load_type "small")
								(begin_random
									(begin
										;(vehicle_unload pelican "pelican_lc_01")
										(sleep (random_range 15 30))
									)
									(begin
										;(vehicle_unload pelican "pelican_lc_02")
										(sleep (random_range 15 30))
									)
								)
		)
		;*
		((= load_type "small01")
								(vehicle_unload fork "pelican_lc_01")
		)
		((= load_type "small02")
								(vehicle_unload fork "pelican_lc_02")
		)
		*;
	)
)
; =================================================================================================
; global_phantom.hsc
; how to use:
; 	1. open your scenario in sapien
;	2. in the menu bar, open the "scenarios" menu, then select "add mission script"
;	3. point the dialogue to this file: main\data\globals\global_phantom.hsc
; =================================================================================================
(global boolean b_debug_phantom false)

;*
== load parameters ==
1 - left 
2 - right 
3 - dual 
4 - out the chute 
*;

; call this script to load up the phantom before flying it into position ================================================================
(script static void	(f_load_phantom
								(vehicle phantom)		; phantom to load 
								(string load_side)		; how to load it 
								(ai load_squad_01)		; squads to load 
								(ai load_squad_02)
								(ai load_squad_03)
								(ai load_squad_04)
				)
				
	; place ai 
	(ai_place load_squad_01)
	(ai_place load_squad_02)
	(ai_place load_squad_03)
	(ai_place load_squad_04)
		(sleep 1)
	
	
	(cond
		; left 
		((= load_side "left")
						(begin
							(if b_debug_phantom (print "load phantom left..."))
							(ai_vehicle_enter_immediate load_squad_01 phantom "phantom_p_lb")
							(ai_vehicle_enter_immediate load_squad_02 phantom "phantom_p_lf")
							(ai_vehicle_enter_immediate load_squad_03 phantom "phantom_p_ml_f")
							(ai_vehicle_enter_immediate load_squad_04 phantom "phantom_p_ml_b")
						)
		)
		; right 
		((= load_side "right")
						(begin
							(if b_debug_phantom (print "load phantom right..."))
							(ai_vehicle_enter_immediate load_squad_01 phantom "phantom_p_rb")
							(ai_vehicle_enter_immediate load_squad_02 phantom "phantom_p_rf")
							(ai_vehicle_enter_immediate load_squad_03 phantom "phantom_p_mr_f")
							(ai_vehicle_enter_immediate load_squad_04 phantom "phantom_p_mr_b")
							
						)
		)
		; dual 
		((= load_side "dual")
						(begin
							(if b_debug_phantom (print "load phantom dual..."))
							(ai_vehicle_enter_immediate load_squad_01 phantom "phantom_p_lf")
							(ai_vehicle_enter_immediate load_squad_02 phantom "phantom_p_rf")
							(ai_vehicle_enter_immediate load_squad_03 phantom "phantom_p_lb")
							(ai_vehicle_enter_immediate load_squad_04 phantom "phantom_p_rb")
						)
		)
		
		((= load_side "any")
						(begin
							(if b_debug_phantom (print "load phantom any..."))
							(ai_vehicle_enter_immediate load_squad_01 phantom "phantom_p")
							(ai_vehicle_enter_immediate load_squad_02 phantom "phantom_p")
							(ai_vehicle_enter_immediate load_squad_03 phantom "phantom_p")
							(ai_vehicle_enter_immediate load_squad_04 phantom "phantom_p")
						)
		)
		; chute lives!

		((= load_side "chute")
						(begin
							(if b_debug_phantom (print "load phantom chute..."))
							(ai_vehicle_enter_immediate load_squad_01 phantom "phantom_pc_1")
							(ai_vehicle_enter_immediate load_squad_02 phantom "phantom_pc_2")
							(ai_vehicle_enter_immediate load_squad_03 phantom "phantom_pc_3")
							(ai_vehicle_enter_immediate load_squad_04 phantom "phantom_pc_4")
						)
		)
	)
)

(script static void (f_load_phantom_cargo
										(vehicle phantom)		; the phantom you are loading the cargo in to 
										(string load_number)	; 1 - single load    ---   2 - double load 
										(ai load_squad_01)		; first squad to load 
										(ai load_squad_02)		; second squad to load 
				)
	; place ai 
	
	; load into phantom 
	(cond
		((= load_number "single")	
						(begin
							(ai_place load_squad_01)
								(sleep 1)
							(vehicle_load_magic phantom "phantom_lc" (ai_vehicle_get_from_squad load_squad_01 0))
						)
		)
		((= load_number "double")	
						(begin
							(ai_place load_squad_01)
							(ai_place load_squad_02)
								(sleep 1)
							(vehicle_load_magic phantom "phantom_sc01" (ai_vehicle_get_from_squad load_squad_01 0))
							(vehicle_load_magic phantom "phantom_sc02" (ai_vehicle_get_from_squad load_squad_02 0))
						)
		)
	)
)



; call this script when the phantom is in place to drop off all the ai ====================================================================
(script static void (f_unload_phantom
										(vehicle phantom)
										(string drop_side)
				)
	
	(if b_debug_phantom (print "opening phantom..."))
	(unit_open phantom)
	(sleep 60)
	; determine how to unload the phantom 
	(cond
		((= drop_side "left")	
						(begin
							(f_unload_ph_left phantom)
							(sleep 45)
							(f_unload_ph_mid_left phantom)
							(sleep 75)
						)
		)

		((= drop_side "right")	
						(begin
							(f_unload_ph_right phantom)
							(sleep 45)
							(f_unload_ph_mid_right phantom)
							(sleep 75)
						)
		)

		((= drop_side "dual")
						(begin
							(f_unload_ph_left phantom)
							(f_unload_ph_right phantom)
							(sleep 75)
						)
		)
		((= drop_side "chute")
						(begin
							(f_unload_ph_chute phantom)
							(sleep 75)
						)
		)
	)
	
	(if b_debug_phantom (print "closing phantom..."))
	(unit_close phantom)
	
)

; you never have to call these scripts directly ===========================================================================================
(script static void (f_unload_ph_left
										(vehicle phantom)
				)
	; randomly evacuate the two sides 
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_lf")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_lb")
			(sleep (random_range 0 10))
		)
	)
)
(script static void (f_unload_ph_right
										(vehicle phantom)
				)
	; randomly evacuate the two sides 
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_rf")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_rb")
			(sleep (random_range 0 10))
		)
	)
)
(script static void (f_unload_ph_mid_left
										(vehicle phantom)
				)
	; randomly evacuate the two sides 
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_ml_f")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_ml_b")
			(sleep (random_range 0 10))
		)
	)
)
(script static void (f_unload_ph_mid_right
										(vehicle phantom)
				)
	; randomly evacuate the two sides 
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_mr_f")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_mr_b")
			(sleep (random_range 0 10))
		)
	)
)
(script static void (f_unload_ph_chute
										(vehicle phantom)
				)
	; turn on phantom power 
	(object_set_phantom_power phantom true)
	
	; poop dudes out the chute 

	(if (vehicle_test_seat phantom "phantom_pc_1")	
									(begin
										(vehicle_unload phantom "phantom_pc_1")
										(sleep 120)
									)
	)
	(if (vehicle_test_seat phantom "phantom_pc_2")	
									(begin
										(vehicle_unload phantom "phantom_pc_2")
										(sleep 120)
									)
	)
	(if (vehicle_test_seat phantom "phantom_pc_3")	
									(begin
										(vehicle_unload phantom "phantom_pc_3")
										(sleep 120)
									)
	)
	(if (vehicle_test_seat phantom "phantom_pc_4")	
									(begin
										(vehicle_unload phantom "phantom_pc_4")
										(sleep 120)
									)
	)

	
	; turn off phantom power 
	(object_set_phantom_power phantom false)
									
)

(script static void (f_unload_phantom_cargo
										(vehicle phantom)
										(string load_number)
				)
	; unload cargo seats 
	(cond
		((= load_number "single")	(vehicle_unload phantom "phantom_lc"))
		((= load_number "double")
								(begin_random
									(begin
										(vehicle_unload phantom "phantom_sc01")
										(sleep (random_range 15 30))
									)
									(begin
										(vehicle_unload phantom "phantom_sc02")
										(sleep (random_range 15 30))
									)
								)
		)
	)
)

; ===============================================================================================================================================
; global scripts ================================================================================================================================
; ===============================================================================================================================================
(global boolean b_debug_globals false)

(global short player_00 0)
(global short player_01 1)
(global short player_02 2)
(global short player_03 3)

(global short s_md_play_time 0)

(script static unit player0
	(player_get 0)
)

(script static unit player1
	(player_get 1)
)

(script static unit player2
	(player_get 2)
)

(script static unit player3
	(player_get 3)
)
 
(script static short player_count
  (list_count (players)))

(script static void print_difficulty
	(cond
		((= (game_difficulty_get_real) easy)		(print "easy"))
		((= (game_difficulty_get_real) normal)		(print "normal"))
		((= (game_difficulty_get_real) heroic)		(print "heroic"))
		((= (game_difficulty_get_real) legendary)	(print "legendary"))
	)
)

; globals 
(global string data_mine_mission_segment "")


; difficulty level scripts 
(script static boolean difficulty_legendary
	(= (game_difficulty_get_real) legendary)
)

(script static boolean difficulty_heroic
	(= (game_difficulty_get_real) heroic)
)

(script static boolean difficulty_normal
	(<= (game_difficulty_get_real) normal)
)

(script static void replenish_players
	(if b_debug_globals (print "replenish player health..."))
	(unit_set_current_vitality player0 80 80)
	(unit_set_current_vitality player1 80 80)
	(unit_set_current_vitality player2 80 80)
	(unit_set_current_vitality player3 80 80)
)

; coop player booleans 
(script static boolean coop_players_2
	(>= (game_coop_player_count) 2)
)
(script static boolean coop_players_3
	(>= (game_coop_player_count) 3)
)
(script static boolean coop_players_4
	(>= (game_coop_player_count) 4)
)

;returns true if any player is in a vehicle
(script static boolean any_players_in_vehicle
    (or
	     (unit_in_vehicle (unit player0))
	     (unit_in_vehicle (unit player1))
	     (unit_in_vehicle (unit player2))
	     (unit_in_vehicle (unit player3))
    )
)


;fades the vehicle out and then erases it
(script static void (f_vehicle_scale_destroy  (vehicle vehicle_variable))
	(object_set_scale vehicle_variable .01 (* 30 5))
	(sleep (* 30 5))
	(object_destroy vehicle_variable)
)


;for placing pelicans and falcons etc that are critial and cannot die
(script static void (f_ai_place_vehicle_deathless (ai squad))
	(ai_place squad)
	(ai_cannot_die (object_get_ai (vehicle_driver (ai_vehicle_get_from_squad squad 0))) true)
	(object_cannot_die (ai_vehicle_get_from_squad squad 0) true)
)

(script static void (f_ai_place_vehicle_deathless_no_emp (ai squad))
	(ai_place squad)
	(ai_cannot_die (object_get_ai (vehicle_driver (ai_vehicle_get_from_squad squad 0))) true)
	(object_cannot_die (ai_vehicle_get_from_squad squad 0) true)
	(object_ignores_emp (ai_vehicle_get_from_squad squad 0) true)
)

;to get the number of ai passengers in a vehicle
(script static short (f_vehicle_rider_number (vehicle v))
	(list_count (vehicle_riders v))
)

;to determine if first squad is riding in vehicle of second squad
(script static boolean (f_all_squad_in_vehicle (ai inf_squad) (ai vehicle_squad))
	(and
		(= (ai_living_count inf_squad) 0)
		(= (ai_living_count vehicle_squad) (f_vehicle_rider_number (ai_vehicle_get_from_squad vehicle_squad 0)))
	)
)

;return the driver of a vehicle assuming only one vehicle in squad
(script static ai (f_ai_get_vehicle_driver (ai squad))
	(object_get_ai (vehicle_driver (ai_vehicle_get_from_squad squad 0)))
)


; call magic sight on all players
(script static void (f_ai_magically_see_players (ai squad))
	(ai_magically_see_object squad player0)
	(ai_magically_see_object squad player1)
	(ai_magically_see_object squad player2)
	(ai_magically_see_object squad player3)
)

; ===============================================================================================================================================
; global health script =================================================================================================================================
; ===============================================================================================================================================
(script dormant f_global_health_saves
	(sleep_until (> (player_count) 0))
	(sleep_until
		(begin
			(sleep_until (< (object_get_health player0) 1))
			(sleep (* 30 7))
			(if (< (object_get_health player0) 1)
				(begin
					(sleep_until (= (object_get_health player0) 1))
					(print "global health: health pack aquired")
					(game_save)
				)
				(print "global health: re-gen")
			)
			false
		)
	)
	
)

; ===============================================================================================================================================
; award tourist =================================================================================================================================
; ===============================================================================================================================================
;*
(script dormant player0_award_tourist
	(f_award_tourist player_00)
)
(script dormant player1_award_tourist
	(f_award_tourist player_01)
)
(script dormant player2_award_tourist
	(f_award_tourist player_02)
)
(script dormant player3_award_tourist
	(f_award_tourist player_03)
)
*;
;*
(script static void (f_award_tourist
							(short player_short)
				)
	(sleep_until (pda_is_active_deterministic (player_get player_short)) 45)
		(sleep 30)
	
	; award the achievement for accessing the pda 
	(achievement_grant_to_player (player_get player_short) "_achievement_tourist")
)

; ===============================================================================================================================================
; waypoint scripts ==============================================================================================================================
; ===============================================================================================================================================
(global short s_waypoint_index 0)
(global short s_waypoint_timer (* 30 10))

(script static void (f_sleep_until_activate_waypoint
									(short player_short)
				)
		(sleep 3)
	(unit_action_test_reset (player_get player_short))
		(sleep 3)
	(sleep_until	(and
					(> (object_get_health (player_get player_short)) 0)
					(or
						(unit_action_test_dpad_up (player_get player_short))
						(unit_action_test_dpad_down (player_get player_short))
					)
				)
	1)
	(f_sfx_a_button player_short)
		(sleep 3)
)

(script static void (f_sleep_deactivate_waypoint
									(short player_short)
				)
	; sleep until dpad pressed or player dies 
		(sleep 3)
	(unit_action_test_reset (player_get player_short))
		(sleep 3)
	(sleep_until	(or
					(<= (unit_get_health (player_get player_short)) 0)
					(unit_action_test_dpad_up (player_get player_short))
					(unit_action_test_dpad_down (player_get player_short))
				)
	1 s_waypoint_timer)
	(if	(or
			(unit_action_test_dpad_up (player_get player_short))
			(unit_action_test_dpad_down (player_get player_short))
		)
		(f_sfx_a_button player_short)
	)
	(sleep 3)
)

; ===============================================================================================================================================
(script static void	(f_waypoint_message
									(short			player_short)
									(cutscene_flag		waypoint_01)
									(cutscene_title	display_title)
									(cutscene_title	blank_title)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if	(not (pda_is_active_deterministic (player_get player_short)))
		(begin
			(chud_show_cinematic_title (player_get player_short) display_title)
			(sleep 15)
	
				; sleep until dpad pressed or player dies 
				(f_sleep_deactivate_waypoint player_short)
			
			; turn waypoints off 
			(chud_show_cinematic_title (player_get player_short) blank_title)
		)
		(sleep 5)
	)
)
; ===============================================================================================================================================
(script static void	(f_waypoint_activate_1
									(short			player_short)
									(cutscene_flag		waypoint_01)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if (not (pda_is_active_deterministic (player_get player_short))) (chud_show_navpoint (player_get player_short) waypoint_01 .55 true))
	(sleep 15)
	
		; sleep until dpad pressed or player dies 
		(f_sleep_deactivate_waypoint player_short)
	
	; turn waypoints off 
	(chud_show_navpoint (player_get player_short) waypoint_01 0 false)
)
; ===============================================================================================================================================
(script static void	(f_waypoint_activate_2
									(short			player_short)
									(cutscene_flag		waypoint_01)
									(cutscene_flag		waypoint_02)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if (not (pda_is_active_deterministic (player_get player_short))) 
		(begin
			(chud_show_navpoint (player_get player_short) waypoint_01 .55 true)
			(chud_show_navpoint (player_get player_short) waypoint_02 .55 true)
		)
	)
	(sleep 15)
	
		; sleep until dpad pressed or player dies 
		(f_sleep_deactivate_waypoint player_short)
	
	; turn waypoints off 
	(chud_show_navpoint (player_get player_short) waypoint_01 0 false)
	(chud_show_navpoint (player_get player_short) waypoint_02 0 false)
)
; ===============================================================================================================================================
(script static void	(f_waypoint_activate_3
									(short			player_short)
									(cutscene_flag		waypoint_01)
									(cutscene_flag		waypoint_02)
									(cutscene_flag		waypoint_03)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if (not (pda_is_active_deterministic (player_get player_short))) 
		(begin
			(chud_show_navpoint (player_get player_short) waypoint_01 .55 true)
			(chud_show_navpoint (player_get player_short) waypoint_02 .55 true)
			(chud_show_navpoint (player_get player_short) waypoint_03 .55 true)
		)
	)
	(sleep 15)
	
		; sleep until dpad pressed or player dies 
		(f_sleep_deactivate_waypoint player_short)
	
	; turn waypoints off 
	(chud_show_navpoint (player_get player_short) waypoint_01 0 false)
	(chud_show_navpoint (player_get player_short) waypoint_02 0 false)
	(chud_show_navpoint (player_get player_short) waypoint_03 0 false)
)
; ===============================================================================================================================================
(script static void	(f_waypoint_activate_4
									(short			player_short)
									(cutscene_flag		waypoint_01)
									(cutscene_flag		waypoint_02)
									(cutscene_flag		waypoint_03)
									(cutscene_flag		waypoint_04)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if (not (pda_is_active_deterministic (player_get player_short))) 
		(begin
			(chud_show_navpoint (player_get player_short) waypoint_01 .55 true)
			(chud_show_navpoint (player_get player_short) waypoint_02 .55 true)
			(chud_show_navpoint (player_get player_short) waypoint_03 .55 true)
			(chud_show_navpoint (player_get player_short) waypoint_04 .55 true)
		)
	)
	(sleep 15)
	
		; sleep until dpad pressed or player dies 
		(f_sleep_deactivate_waypoint player_short)
	
	; turn waypoints off 
	(chud_show_navpoint (player_get player_short) waypoint_01 0 false)
	(chud_show_navpoint (player_get player_short) waypoint_02 0 false)
	(chud_show_navpoint (player_get player_short) waypoint_03 0 false)
	(chud_show_navpoint (player_get player_short) waypoint_04 0 false)
)
*;
; ===============================================================================================================================================
; coop resume messaging =========================================================================================================================
; ===============================================================================================================================================
(script static void (f_coop_resume_unlocked
									(cutscene_title	resume_title)
									(short			insertion_point)
				)
	(if (game_is_cooperative)
		(begin
			(sound_impulse_start sfx_hud_in none 1)
			(cinematic_set_chud_objective resume_title)
			(game_insertion_point_unlock insertion_point)
			;(sleep (* 30 7)) commented this out because it was breaking stuff! dmiller march 28/09
			;(sound_impulse_start sfx_hud_out none 1) commented this out temp because it was gonna sound weird!
		)
	)
)

; ===============================================================================================================================================
; new intel messaging ===========================================================================================================================
; ===============================================================================================================================================
;*
(script static void (f_new_intel
							(cutscene_title	new_intel)
							(cutscene_title	intel_chapter)
							(long			objective_number)
							(cutscene_flag		minimap_flag)
				)
	(sound_impulse_start sfx_objective none 1)
	(chud_display_pda_objectives_message "pda_activate_intel" 0)
	
	(cinematic_set_chud_objective new_intel)
	(objectives_show objective_number)
		(sleep 60)
	(sound_impulse_start sfx_hud_in none 1)
	(cinematic_set_chud_objective intel_chapter)
		(sleep (* 30 3))
	(sound_impulse_start sfx_hud_out none 1)
	(chud_display_pda_minimap_message "" minimap_flag)
)
*;
; ===============================================================================================================================================
; cinematic skip scripts ========================================================================================================================
; ===============================================================================================================================================
(script static boolean cinematic_skip_start
	(cinematic_skip_start_internal)		; listen for the button which reverts (skips) 
	(game_save_cinematic_skip)			; save the game state 
	(sleep_until (not (game_saving)) 1)	; sleep until the game is done saving 
	(not (game_reverted))				; return whether or not the game has been reverted 
)


(script static void (cinematic_skip_stop (string_id cinematic_name))
	(cinematic_skip_stop_internal)		; stop listening for the button 
	(if (not (game_reverted)) 
		(begin
			(game_revert) ; if the player did not revert, do it for him 
			(sleep 1) ; sleep so that the game can apply the revert
		)
	)
)

(script static void (cinematic_skip_stop_load_zone (string_id cinematic_name) (zone_set z))
	(cinematic_skip_stop_internal)		; stop listening for the button 
	(if (not (game_reverted)) 
		(begin
			(game_revert) ; if the player did not revert, do it for him 
			(sleep 1) ; sleep so that the game can apply the revert
		)
	)
	;(sleep 31)
	(switch_zone_set z)
	(sleep 2)
)

(script static void (cinematic_skip_stop_terminal (string_id cinematic_name))
 	(cinematic_skip_stop_internal)		; stop listening for the button
	(if (not (game_reverted))
	 	(begin
		 	(game_revert)					; if the player did not revert, do it for him
			(sleep 1) ; we need to sleep to ensure that the game gets reverted
			(if b_debug_globals (print "sleeping forever..."))
			(sleep_forever)						; sleep forever so game_level_advance is not called twice (not sure that this ever gets called)
		)
	)
)

; ===============================================================================================================================================
; cinematic fade black scripts ==================================================================================================================
; ===============================================================================================================================================

; -------------------------------------------------------------------------------------------------
; tipul's new cinematic scripts
; god help you all.
; -------------------------------------------------------------------------------------------------
(global boolean b_debug_cinematic_scripts true)
(global boolean b_cinematic_entered false)
; -------------------------------------------------------------------------------------------------
(script static void test_cinematic_enter_exit
	;(cinematic_enter default_fade_to_black_transitions true)
	(sleep 30)
	;(cinematic_exit default_fade_to_black_transitions true)
)

(script static void (cinematic_enter (string_id cinematic_name) (boolean lower_weapon))
	; setting this boolean up so that designers can call a cinematic_enter from outside of the f_play_cinematic -dmiller 6-11-2010
	(set b_cinematic_entered true)
	(cinematic_enter_pre lower_weapon)
	(sleep (cinematic_tag_fade_out_from_game cinematic_name))
	(cinematic_enter_post)
)


(script static void (designer_cinematic_enter (boolean lower_weapon))
	(cinematic_enter_pre lower_weapon)
	(sleep (cinematic_transition_fade_out_from_game cinematics\transitions\default_intra.cinematic_transition))
	(cinematic_enter_post)
)


(script static void (cinematic_enter_pre (boolean lower_weapon))
	; ai ignores players
	(ai_disregard (players) true)

	; players cannot take damage 
	(object_cannot_take_damage (players))

	; scale player input to zero 
	; cgirons todo: this was (player_control_fade_out_all_input 0) for snaps check if it is a problem
	(player_control_fade_out_all_input 1)
	
	; lower the player's weapon
	(if (= lower_weapon true)
		(begin 
			(if b_debug_cinematic_scripts (print "lowering weapon slowly..."))
			(unit_lower_weapon player0 30)
			(unit_lower_weapon player1 30)
			(unit_lower_weapon player2 30)
			(unit_lower_weapon player3 30)
		)
	)			
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause true)

	; fade out the chud 
	; cgirons todo: this was (chud_cinematic_fade 0 0) for snaps check if it is a problem
	(chud_cinematic_fade 0 0.5)
)

(script static void cinematic_enter_post
	; hide players 
	(if b_debug_cinematic_scripts (print "hiding players..."))
	(object_hide player0 true)
	(object_hide player1 true)
	(object_hide player2 true)
	(object_hide player3 true)

	; disable player input 
	(player_enable_input false)

	; player can now move 
	(player_disable_movement true)
		(sleep 1)	
	
	; go time
	(if b_debug_cinematic_scripts (print "camera control on"))
	(camera_control on)
	(cinematic_start)
)

(script static void (cinematic_exit (string_id cinematic_name) (boolean weapon_starts_lowered))
	(cinematic_exit_pre weapon_starts_lowered)
	(sleep (cinematic_tag_fade_in_to_game cinematic_name))
	(cinematic_exit_post weapon_starts_lowered)
)

(script static void (designer_cinematic_exit (boolean weapon_starts_lowered))
	(cinematic_exit_pre weapon_starts_lowered)
	(sleep (cinematic_transition_fade_in_to_game cinematics\transitions\default_intra.cinematic_transition))
	(cinematic_exit_post weapon_starts_lowered)
)

(script static void (cinematic_exit_into_title (string_id cinematic_name) (boolean weapon_starts_lowered))
	(cinematic_exit_pre weapon_starts_lowered)
	(chud_cinematic_fade 0 0)
	(sleep (cinematic_tag_fade_in_to_game cinematic_name))
	(cinematic_exit_post_title weapon_starts_lowered)
)


(script static void (cinematic_exit_pre (boolean weapon_starts_lowered))
	(cinematic_stop)
	(camera_control off)

	; unhide players 
	(object_hide player0 false)
	(object_hide player1 false)
	(object_hide player2 false)
	(object_hide player3 false)
	
	; raise weapon 
	(if (= weapon_starts_lowered true)
		(begin
			(if b_debug_cinematic_scripts (print "snapping weapon to lowered state..."))
			(unit_lower_weapon player0 1)
			(unit_lower_weapon player1 1)
			(unit_lower_weapon player2 1)
			(unit_lower_weapon player3 1)
			(sleep 1)
		)
		
		(begin
			(unit_raise_weapon player0 1)
			(unit_raise_weapon player1 1)
			(unit_raise_weapon player2 1)
			(unit_raise_weapon player3 1)
			(sleep 1)
		)
	)
	
	; unlock the players gaze 
	(player_control_unlock_gaze player0)
	(player_control_unlock_gaze player1)
	(player_control_unlock_gaze player2)
	(player_control_unlock_gaze player3)
	(sleep 1)
)

(script static void (cinematic_exit_post (boolean weapon_starts_lowered))
	(cinematic_show_letterbox 0)
	
	; raise weapon 
	(if (= weapon_starts_lowered true)
		(begin
			(if b_debug_cinematic_scripts (print "raising player weapons slowly..."))
			(unit_raise_weapon player0 30)
			(unit_raise_weapon player1 30)
			(unit_raise_weapon player2 30)
			(unit_raise_weapon player3 30)
			(sleep 10)
		)
	)
	
	; fade in the chud 
	(chud_cinematic_fade 1 1)
	(sleep 1)
		
	; enable player input 
	(player_enable_input true)

	; scale player input to one 
	(player_control_fade_in_all_input 1)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause false)

	; the ai will disregard all players 
	(ai_disregard (players) false)

	; players can now take damage 
	(object_can_take_damage (players))

	; player can now move 
	(player_disable_movement false)	
)

(script static void (cinematic_exit_post_title (boolean weapon_starts_lowered))
	(cinematic_show_letterbox 0)
	
	; raise weapon 
	(if (= weapon_starts_lowered true)
		(begin
			(if b_debug_cinematic_scripts (print "raising player weapons slowly..."))
			(unit_raise_weapon player0 30)
			(unit_raise_weapon player1 30)
			(unit_raise_weapon player2 30)
			(unit_raise_weapon player3 30)
			(sleep 10)
		)
	)
	
	; fade in the chud 
	;(chud_cinematic_fade 1 1)
	(sleep 1)
		
	; enable player input 
	(player_enable_input true)

	; scale player input to one 
	(player_control_fade_in_all_input 1)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause false)

	; the ai will disregard all players 
	(ai_disregard (players) false)

	; players can now take damage 
	(object_can_take_damage (players))

	; player can now move 
	(player_disable_movement false)	
)

(script static void insertion_snap_to_black
	(fade_out 0 0 0 0)
	
	; ai ignores players
	(ai_disregard (players) true)

	; players cannot take damage 
	(object_cannot_take_damage (players))

	; scale player input to zero 
	; cgirons todo: this was (player_control_fade_out_all_input 0) for snaps check if it is a problem
	(player_control_fade_out_all_input 1)
	
	; lower the player's weapon
	(unit_lower_weapon player0 0)
	(unit_lower_weapon player1 0)
	(unit_lower_weapon player2 0)
	(unit_lower_weapon player3 0)

	; pause the meta-game timer 
	(campaign_metagame_time_pause true)

	; fade out the chud 
	; cgirons todo: this was (chud_cinematic_fade 0 0) for snaps check if it is a problem
	(chud_cinematic_fade 0 0)
	
	; hide players 
	(if b_debug_cinematic_scripts (print "hiding players..."))
	(object_hide player0 true)
	(object_hide player1 true)
	(object_hide player2 true)
	(object_hide player3 true)

	; disable player input 
	(player_enable_input false)

	; player can now move 
	(player_disable_movement true)
		(sleep 1)	
	
	; go time
	(if b_debug_cinematic_scripts (print "camera control on"))
)

(script static void insertion_fade_to_gameplay
	(designer_fade_in "fade_from_black" true))

(script static void (designer_fade_in (string fade_type) (boolean weapon_starts_lowered))
	(cinematic_stop)
	(camera_control off)

	; unhide players 
	(object_hide player0 false)
	(object_hide player1 false)
	(object_hide player2 false)
	(object_hide player3 false)
	
	; raise weapon 
	(if (= weapon_starts_lowered true)
		(begin
			(if b_debug_cinematic_scripts (print "snapping weapon to lowered state..."))
			(unit_lower_weapon player0 1)
			(unit_lower_weapon player1 1)
			(unit_lower_weapon player2 1)
			(unit_lower_weapon player3 1)
			(sleep 1)
		)
	)
	
	; unlock the players gaze 
	(player_control_unlock_gaze player0)
	(player_control_unlock_gaze player1)
	(player_control_unlock_gaze player2)
	(player_control_unlock_gaze player3)
		(sleep 1)

	; fade or snap screen back
	(cond
		((= fade_type "fade_from_black") 	
			(begin 
				(if b_debug_cinematic_scripts (print "fading from black..."))
				(fade_in 0 0 0 30)
				(sleep 20)
			)
		)
		((= fade_type "fade_from_white") 
			(begin
				(if b_debug_cinematic_scripts (print "fading from white..."))
				(fade_in 1 1 1 30)
				(sleep 20)
			)
		)
		((= fade_type "snap_from_black") 
			
			(begin 
				(if b_debug_cinematic_scripts (print "snapping from black..."))
				(fade_in 0 0 0 5)
				(sleep 5)
			)
		)
		((= fade_type "snap_from_white") 
			(begin
				(if b_debug_cinematic_scripts (print "snapping from white..."))
				(fade_in 1 1 1 5)
				(sleep 5)
			)
		)
		((= fade_type "no_fade") 
			(begin
				(fade_in 1 1 1 0)
				(sleep 5)
			)
		)
	)


	(cinematic_show_letterbox 0)
	
	; raise weapon 
	(if (= weapon_starts_lowered true)
		(begin
			(if b_debug_cinematic_scripts (print "raising player weapons slowly..."))
			(unit_raise_weapon player0 30)
			(unit_raise_weapon player1 30)
			(unit_raise_weapon player2 30)
			(unit_raise_weapon player3 30)
			(sleep 10)
		)
	)
	
	; fade in the chud 
	(chud_cinematic_fade 1 1)
	(sleep 1)
		
	; enable player input 
	(player_enable_input true)

	; scale player input to one 
	(player_control_fade_in_all_input 1)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause false)

	; the ai will disregard all players 
	(ai_disregard (players) false)

	; players can now take damage 
	(object_can_take_damage (players))

	; player can now move 
	(player_disable_movement false)
)

; ======================================================================================
(script static void cinematic_snap_to_black
	(sleep 0)
	;(cinematic_enter default_snap_to_black_transitions false)
)

(script static void cinematic_snap_to_white
	(sleep 0)
	;(cinematic_enter "default_snap_to_white_transitions" false)
)
	
; ======================================================================================
(script static void cinematic_snap_from_black
	(sleep 0)
	;(cinematic_exit default_snap_to_black_transitions false)
)

(script static void cinematic_snap_from_white
	(sleep 0)
	;(cinematic_exit default_snap_to_white_transitions false)
)

; ======================================================================================
(script static void cinematic_fade_to_black
	(sleep 0)
	;(cinematic_enter default_fade_to_black_transitions true)
)

(script static void cinematic_fade_to_white
	(sleep 0)
	;(cinematic_enter default_fade_to_white_transitions true)
)

(script static void (cinematic_fade_to_gameplay)
	(designer_fade_in "fade_from_black" true)
)

; ===============================================================================================================================================
; cinematic hud =================================================================================================================================
; ===============================================================================================================================================
(script static void cinematic_hud_on
	(chud_cinematic_fade 1 0)
	;(chud_show_compass false)
	(chud_show_crosshair false)
)

(script static void cinematic_hud_off
	(chud_cinematic_fade 0 0)
	;(chud_show_compass true)
	(chud_show_crosshair true)
)

; ===============================================================================================================================================
; performances ==================================================================================================================================
; ===============================================================================================================================================

; this script is called from a thread spawned by a performance.
; therefore all of the "performance_..." functions known which performance the function calls are intended for
; and thus we don't have to pass in a performance index.
; the default script function simply plays through all of the lines in the script, one after the other.

(script static void performance_default_script
	(sleep_until
		(begin
			(performance_play_line_by_id (+ (performance_get_last_played_line_index) 1))
		(>= (+ (performance_get_last_played_line_index) 1) (performance_get_line_count))) 0)
)


; ===============================================================================================================================================
; pda scripts ===================================================================================================================================
; ===============================================================================================================================================

;*
(global short g_pda_breadcrumb_fade (* 30 45))
(global short g_pda_breadcrumb_timer (* 30 1.5))


(script dormant pda_breadcrumbs
	(pda_set_footprint_dead_zone 5)
	
	(sleep_until
		(begin
			(player_add_footprint player0 g_pda_breadcrumb_fade)
			(player_add_footprint player1 g_pda_breadcrumb_fade)
			(player_add_footprint player2 g_pda_breadcrumb_fade)
			(player_add_footprint player3 g_pda_breadcrumb_fade)
		false)
	g_pda_breadcrumb_timer)
)
*;
		
; ===============================================================================================================================================
; end mission ===================================================================================================================================
; ===============================================================================================================================================
(script static void end_mission
	(game_won))

(script static void (f_start_mission
						(string_id cinematic_name)
					)
	(if (= b_cinematic_entered false) (cinematic_enter cinematic_name true))
	(set b_cinematic_entered false)
	(sleep 1)
	(if (cinematic_skip_start)
		(begin
			(if b_debug_cinematic_scripts (print "f_start_mission: cinematic_skip_start is true... starting cinematic..."))
			(cinematic_show_letterbox_immediate true)
			(cinematic_run_script_by_name cinematic_name)
		)
	)	
	
	(cinematic_skip_stop cinematic_name)
)


; used for mid-mission cinematics
(script static void (f_play_cinematic_advanced
						(string_id cinematic_name)
						(zone_set cinematic_zone_set)
						(zone_set zone_to_load_when_done)
					)
	
	(if b_debug_cinematic_scripts (print "f_play_cinematic: calling cinematic_enter"))
	
	(set b_cinematic_entered false)
	
	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sleep 1)
		
	(if (cinematic_skip_start)
		(begin
			(if b_debug_globals (print "f_play_cinematic: playing cinematic..."))
			(cinematic_show_letterbox_immediate true)
			(cinematic_run_script_by_name cinematic_name)
		)
	)
	(cinematic_skip_stop_load_zone cinematic_name zone_to_load_when_done)	
	;(switch_zone_set zone_to_load_when_done)
		
	(if b_debug_cinematic_scripts (print "f_play_cinematic: done with cinematic. resetting audio levels..."))
)

; used for mid-mission cinematics
(script static void (f_play_cinematic_unskippable
						(string_id cinematic_name)
						(zone_set cinematic_zone_set)
					)
	
	(if b_debug_cinematic_scripts (print "f_play_cinematic: calling cinematic_enter"))

	(if (= b_cinematic_entered false) (cinematic_enter cinematic_name false))
	(set b_cinematic_entered false)	
	(sleep 1)

	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sleep 1)
		
	(sound_suppress_ambience_update_on_revert)
	(sleep 1)

	;(if (cinematic_skip_start)
		(begin
			(if b_debug_globals (print "f_play_cinematic: playing cinematic..."))

				(cinematic_show_letterbox true)
				(sleep 30)
				(cinematic_show_letterbox_immediate true)
			
			(cinematic_run_script_by_name cinematic_name)
		)
	;)
	;(cinematic_skip_stop cinematic_name)		
)
; used for mid-mission cinematics- back with a vengeance
(script static void (f_play_cinematic
						(string_id cinematic_name)
						(zone_set cinematic_zone_set)
					)
	
	(if b_debug_cinematic_scripts (print "f_play_cinematic: calling cinematic_enter"))

	(if (= b_cinematic_entered false) (cinematic_enter cinematic_name false))
	(set b_cinematic_entered false)	
	(sleep 1)

	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sleep 1)
		
	(sound_suppress_ambience_update_on_revert)
	(sleep 1)

	(if (cinematic_skip_start)
		(begin
			(if b_debug_globals (print "f_play_cinematic: playing cinematic..."))

				(cinematic_show_letterbox true)
				(sleep 30)
				(cinematic_show_letterbox_immediate true)
			
			(cinematic_run_script_by_name cinematic_name)
		)
	)
	(cinematic_skip_stop cinematic_name)		
)

(script static void (f_end_mission
						(string_id cinematic_name)
						(zone_set cinematic_zone_set)
					)
		
	(if (= b_cinematic_entered false) (cinematic_enter cinematic_name false))
	(set b_cinematic_entered false)	
	(sleep 1)
	
	(ai_erase_all)
	(garbage_collect_now)
	(switch_zone_set cinematic_zone_set)
	(sleep 1)

	; the magic
	(if (cinematic_skip_start)
		(begin
			(if b_debug_globals (print "play outro cinematic..."))

			(cinematic_show_letterbox true)
			(sleep 30)
			(cinematic_show_letterbox_immediate true)
			
			(cinematic_run_script_by_name cinematic_name)
		)
	)
	(cinematic_skip_stop_internal)
	(fade_out 0 0 0 0)
	(sleep 1)
)

(script static void (f_end_mission_ai
						(string_id cinematic_name)
						(zone_set cinematic_zone_set)
					)
		
	(if (= b_cinematic_entered false) (cinematic_enter cinematic_name false))
	(set b_cinematic_entered false)	
	(sleep 1)
	
	;(ai_erase_all) in case we want to end the cinematic and manually erase ai
	(ai_disregard player0 true)
	(ai_disregard player1 true)
	(ai_disregard player2 true)
	(ai_disregard player3 true)			
	(garbage_collect_now)
	(switch_zone_set cinematic_zone_set)
	(sleep 1)

	; the magic
	(if (cinematic_skip_start)
		(begin
			(if b_debug_globals (print "play outro cinematic..."))

			(cinematic_show_letterbox true)
			(sleep 30)
			(cinematic_show_letterbox_immediate true)
			
			(cinematic_run_script_by_name cinematic_name)
		)
	)
	(cinematic_skip_stop_internal)
	(fade_out 0 0 0 0)
	(sleep 1)
)

; ===== do not delete this ever ===================
(script startup beginning_mission_segment
	(data_mine_set_mission_segment mission_start)
)





; =============================================================================================================================================== 
; message confirmation scripts ================================================================================================================== 
; =============================================================================================================================================== 

(global sound sfx_a_button	"sound\game_sfx\ui\hud_ui\b_button")
(global sound sfx_b_button	"sound\game_sfx\ui\hud_ui\a_button")
(global sound sfx_hud_in	"sound\game_sfx\ui\hud_ui\hud_in")
(global sound sfx_hud_out	"sound\game_sfx\ui\hud_ui\hud_out")
(global sound sfx_objective	"sound\game_sfx\ui\hud_ui\mission_objective")
(global sound sfx_tutorial_complete "sound\game_sfx\ui\pda_transition.sound")


(script static void (f_sfx_a_button
								(short player_short)
				)			
	(sound_impulse_start sfx_a_button (player_get player_short) 1)
)
(script static void (f_sfx_b_button
								(short player_short)
				)			
	(sound_impulse_start sfx_b_button (player_get player_short) 1)
)
(script static void (f_sfx_hud_in
								(short player_short)
				)			
	(sound_impulse_start sfx_hud_in (player_get player_short) 1)
)
(script static void (f_sfx_hud_out
								(short player_short)
				)			
	(sound_impulse_start sfx_hud_out (player_get player_short) 1)
)
(script static void (f_sfx_hud_tutorial_complete
								(player player_to_train)
				)			
	(sound_impulse_start sfx_tutorial_complete player_to_train 1)
)




; timeout 
(script static void (f_display_message
								(short			player_short)
								(cutscene_title	display_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
)

(script static void (f_tutorial_begin
								(player 	player_to_train)
								(string_id display_title))
								
	;(chud_show_cinematic_title (player_get player_short) display_title)
	(f_hud_training_forever player_to_train display_title)
		(sleep 5)
	(unit_action_test_reset player_to_train)
		(sleep 5)
)

(script static void (f_tutorial_end
								(player player_to_train)
								)
	
	(f_sfx_hud_tutorial_complete player_to_train)
	;(chud_show_cinematic_title (player_get player_short) blank_title)
	(f_hud_training_clear player_to_train)
		(sleep 30)
)

; boost
(script static void (f_tutorial_boost
								(player		player_variable)
								(string_id	display_title)
				)
	(f_tutorial_begin player_variable display_title)
	(sleep_until (unit_action_test_grenade_trigger player_variable) 1)
	(f_tutorial_end player_variable)
)

; switch weapons
(script static void (f_tutorial_rotate_weapons
								(player		player_variable)
								(string_id	display_title)
				)
	(f_tutorial_begin player_variable display_title)
	(sleep_until (unit_action_test_rotate_weapons player_variable) 1)
	(f_tutorial_end player_variable)
)

; switch weapons
(script static void (f_tutorial_fire_weapon
								(player		player_variable)
								(string_id	display_title)
				)
	(f_tutorial_begin player_variable display_title)
	(sleep_until (unit_action_test_primary_trigger player_variable) 1)
	(f_tutorial_end player_variable)
)


(script static void (f_tutorial_turn
								(player		player_variable)
								(string_id	display_title)
				)
	(f_tutorial_begin player_variable display_title)
	(sleep 20)
	(sleep_until (unit_action_test_look_relative_all_directions player_variable) 1)
	(f_tutorial_end player_variable)
)

(script static void (f_tutorial_throttle
								(player		player_variable)
								(string_id	display_title)
				)
	(f_tutorial_begin player_variable display_title)
	(sleep 20)
	(sleep_until (unit_action_test_move_relative_all_directions player_variable) 1)
	(f_tutorial_end player_variable)
)

(script static void (f_tutorial_tricks
								(player		player_variable)
								(string_id	display_title)
				)
	(f_tutorial_begin player_variable display_title)
	(sleep_until (unit_action_test_vehicle_trick_secondary player_variable) 1)
	(f_tutorial_end player_variable)
)


;*
; accept button 
(script static void (f_display_message_accept
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_message (player_get player_short))
	(sleep_until (unit_action_test_accept (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; cancel button 
(script static void (f_display_message_cancel
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_cancel_message (player_get player_short))
	(sleep_until (unit_action_test_cancel (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; accept / cancel button 
(script static void (f_display_message_confirm
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_message (player_get player_short))
	(unit_confirm_cancel_message (player_get player_short))
	(sleep_until	(or
					(unit_action_test_accept (player_get player_short))
					(unit_action_test_cancel (player_get player_short))
				)
	1)
	(cond
		((unit_action_test_accept (player_get player_short)) (f_sfx_a_button player_short))
		((unit_action_test_cancel (player_get player_short)) (f_sfx_b_button player_short))
	)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)
; repeat training  
(script static void (f_display_repeat_training
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
								(trigger_volume	volume_01)
								(trigger_volume	volume_02)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_y_button (player_get player_short))
	(unit_confirm_cancel_message (player_get player_short))
	(sleep_until	(or
					(unit_action_test_y (player_get player_short))
					(unit_action_test_cancel (player_get player_short))
					(and
						(not (volume_test_object volume_01 (player_get player_short)))
						(not (volume_test_object volume_02 (player_get player_short)))
					)
				)
	1)

	(if	(or
			(volume_test_object volume_01 (player_get player_short))
			(volume_test_object volume_02 (player_get player_short))
		)
		(begin
			(cond
				((unit_action_test_y	 (player_get player_short)) (f_sfx_a_button player_short))
				((unit_action_test_cancel (player_get player_short)) (f_sfx_b_button player_short))
			)
			(chud_show_cinematic_title (player_get player_short) blank_title)
				(sleep 5)
		)
	)
)
; vision button 
(script static void (f_display_message_vision
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
								(trigger_volume	volume_01)
								(trigger_volume	volume_02)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_vision_trigger (player_get player_short))
					(and
						(not (volume_test_object volume_01 (player_get player_short)))
						(not (volume_test_object volume_02 (player_get player_short)))
					)
				)
	1)
	(if	(or
			(volume_test_object volume_01 (player_get player_short))
			(volume_test_object volume_02 (player_get player_short))
		)
		(begin
			(f_sfx_a_button player_short)
			(chud_show_cinematic_title (player_get player_short) blank_title)
				(sleep 5)
		)
	)
)


; accept button w/ trigger timeout 
(script static void (f_display_message_accept_volume
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
								(trigger_volume	volume_01)
								(trigger_volume	volume_02)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_message (player_get player_short))
	(sleep_until	(or
					(unit_action_test_accept (player_get player_short))
					(and
						(not (volume_test_object volume_01 (player_get player_short)))
						(not (volume_test_object volume_02 (player_get player_short)))
					)
				)
	1)
	(if	(or
			(volume_test_object volume_01 (player_get player_short))
			(volume_test_object volume_02 (player_get player_short))
		)
		(begin
			(f_sfx_a_button player_short)
			(chud_show_cinematic_title (player_get player_short) blank_title)
				(sleep 5)
		)
	)
)


; a button 
(script static void (f_display_message_a
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_accept (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; b button 
(script static void (f_display_message_b
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_cancel (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)
; x button 
(script static void (f_display_message_x
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_x (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; y button 
(script static void (f_display_message_y
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_y (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; back button 
(script static void (f_display_message_back
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_back (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; back button 
(script static void (f_display_message_back_b
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_back (player_get player_short))
					(unit_action_test_cancel (player_get player_short))
				)
	1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; left bumper button 
(script static void (f_display_message_left_bumper
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_left_shoulder (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; right bumper button 
(script static void (f_display_message_right_bumper
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_right_shoulder (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)
; either bumper button 
(script static void (f_display_message_bumpers
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_left_shoulder (player_get player_short))
					(unit_action_test_right_shoulder (player_get player_short))
				)
	1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; rotate grenades button 
(script static void (f_display_message_rotate_gren
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_rotate_grenades (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; action button 
(script static void (f_display_message_action
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_action (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; d-pad up 
(script static void (f_display_message_dpad_up
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_dpad_up (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; d-pad up -or- d-pad down 
(script static void (f_display_message_dpad_up_down
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_dpad_up (player_get player_short))
					(unit_action_test_dpad_down (player_get player_short))
				)
	1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; move stick 
(script static void (f_display_message_move_stick
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_move_relative_all_directions (player_get player_short)) 1)
	(f_sfx_a_button player_short)
		(sleep 150)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; look stick 
(script static void (f_display_message_look_stick
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_look_relative_up (player_get player_short))
					(unit_action_test_look_relative_down (player_get player_short))
					(unit_action_test_look_relative_left (player_get player_short))
					(unit_action_test_look_relative_right (player_get player_short))
				)
	1)
	(f_sfx_a_button player_short)
		(sleep 150)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)
*;

; =================================================================================================
; training
; =================================================================================================
(script static void (f_hud_training (player player_num) (string_id string_hud))
	(chud_show_screen_training player_num string_hud)
	(sleep 120)
	(chud_show_screen_training player_num "")
)

(script static void (f_hud_training_forever (player player_num) (string_id string_hud))
	(chud_show_screen_training player_num string_hud)
)

(script static void (f_hud_training_clear (player player_num))
	(chud_show_screen_training player_num "")
)

(script static void f_hud_training_new_weapon
	(chud_set_static_hs_variable player0 0 1)
	(chud_set_static_hs_variable player1 0 1)
	(chud_set_static_hs_variable player2 0 1)
	(chud_set_static_hs_variable player3 0 1)
	(sleep 200)
	(chud_clear_hs_variable player0 0)
	(chud_clear_hs_variable player1 0)
	(chud_clear_hs_variable player2 0)
	(chud_clear_hs_variable player3 0)
)

(script static void (f_hud_training_new_weapon_player (player p))
	(chud_set_static_hs_variable p 0 1)
	(sleep 200)
	(chud_clear_hs_variable p 0)
)

(script static void (f_hud_training_new_weapon_player_clear (player p))
	(chud_clear_hs_variable p 0)
)

(script static void (f_hud_training_confirm (player player_num) (string_id string_hud) (string button_press))
	;kill script if there is no player
	(if (= (player_is_in_game player_num) false)
		(sleep_forever)
	)
	
	(chud_show_screen_training player_num string_hud)
	(sleep 10)
	
	(player_action_test_reset)
	(sleep_until
		(cond
			((= button_press "primary_trigger") (sleep_until (unit_action_test_primary_trigger player_num)))
			((= button_press "grenade_trigger") (sleep_until (unit_action_test_grenade_trigger  player_num)))
			((= button_press "equipment") (sleep_until (unit_action_test_equipment player_num)))
			((= button_press "melee") (sleep_until (unit_action_test_melee player_num)))
			((= button_press "jump") (sleep_until (unit_action_test_jump player_num)))
			((= button_press "rotate_grenades") (sleep_until (unit_action_test_rotate_grenades player_num)))
			((= button_press "rotate_weapons") (sleep_until (unit_action_test_rotate_weapons player_num)))
			((= button_press "context_primary") (sleep_until (unit_action_test_context_primary player_num)))
			((= button_press "vision_trigger") (sleep_until (or (unit_action_test_vision_trigger player_num) (player_night_vision_on))))
			((= button_press "back") (sleep_until (unit_action_test_back player_num)))
			((= button_press "vehicle_trick") (sleep_until (unit_action_test_vehicle_trick_primary player_num)))
		)
	1 (* 30 10))
	
	(chud_show_screen_training player_num "")
)

;example:
;(f_hud_training_confirm player0 ct_training_melee "melee")




; =================================================================================================
; objectives
; =================================================================================================
(script static void (f_hud_obj_new (string_id string_hud) (string_id string_start))
	(f_hud_start_menu_obj string_start)
	(chud_show_screen_objective string_hud)
	(sleep 160)
	(chud_show_screen_objective "")
)

(script static void (f_hud_obj_repeat (string_id string_hud))
	(chud_show_screen_objective string_hud)
	(sleep 160)
	(chud_show_screen_objective "")
)

(script static void (f_hud_start_menu_obj (string_id reference))
	(objectives_clear)
	(objectives_set_string 0 reference)
	(objectives_show_string reference) 
)


; =================================================================================================
; chapter tittes
; =================================================================================================
(script static void (f_hud_chapter (string_id string_hud))
	(chud_cinematic_fade 0 30)
	(sleep 10)
	(chud_show_screen_chapter_title string_hud)
	(chud_fade_chapter_title_for_player player0 1 30)
	(chud_fade_chapter_title_for_player player1 1 30)
	(chud_fade_chapter_title_for_player player2 1 30)
	(chud_fade_chapter_title_for_player player3 1 30)
	
	(sleep 120)
	(chud_fade_chapter_title_for_player player0 0 30)
	(chud_fade_chapter_title_for_player player1 0 30)
	(chud_fade_chapter_title_for_player player2 0 30)
	(chud_fade_chapter_title_for_player player3 0 30)
	(chud_show_screen_chapter_title "")
	
	(sleep 10)
	(chud_cinematic_fade 1 30)
)



; =================================================================================================
; flash object
; =================================================================================================
(script static void (f_hud_flash_object_fov (object_name hud_object_highlight))
	(sleep_until
		(or
			(objects_can_see_object player0 hud_object_highlight 25)
			(objects_can_see_object player1 hud_object_highlight 25)
			(objects_can_see_object player2 hud_object_highlight 25)
			(objects_can_see_object player3 hud_object_highlight 25)
		)
	1)
	(object_create hud_object_highlight)
	(set chud_debug_highlight_object_color_red 1)
	(set chud_debug_highlight_object_color_green 1)
	(set chud_debug_highlight_object_color_blue 0)
	(f_hud_flash_single hud_object_highlight)
	(f_hud_flash_single hud_object_highlight)
	(f_hud_flash_single hud_object_highlight)
	(object_destroy hud_object_highlight)
)

(script static void (f_hud_flash_object (object_name hud_object_highlight))
	(object_create hud_object_highlight)
	(set chud_debug_highlight_object_color_red 1)
	(set chud_debug_highlight_object_color_green 1)
	(set chud_debug_highlight_object_color_blue 0)
	(f_hud_flash_single hud_object_highlight)
	(f_hud_flash_single hud_object_highlight)
	(f_hud_flash_single hud_object_highlight)
	(object_destroy hud_object_highlight)
)

(script static void (f_hud_flash_single (object_name hud_object_highlight))
	(object_hide hud_object_highlight false)
	(set chud_debug_highlight_object hud_object_highlight)
	;(sound_impulse_start sound\game_sfx\ui\transition_beeps none 1)
	(sleep 4)
	(object_hide hud_object_highlight true)
	(sleep 5)
)

(script static void (f_hud_flash_single_nodestroy (object_name hud_object_highlight))
	(set chud_debug_highlight_object hud_object_highlight)
	;(sound_impulse_start sound\game_sfx\ui\transition_beeps none 1)
	(sleep 4)
	(set chud_debug_highlight_object none)
	(sleep 5)
)



; =================================================================================================
; temp
; =================================================================================================
(global sound sfx_blip "sound\game_sfx\ui\transition_beeps")
(global object_list l_blip_list (players))
(global boolean b_blip_list_locked false)
(global short s_blip_list_index 0)

; =================================================================================================
; low-level blip functions -- do not call directly!
(script static void (f_blip_internal (object obj) (short icon_disappear_time) (short final_delay))
	(chud_track_object obj true)
	(sound_impulse_start sfx_blip none 1)
	(sleep icon_disappear_time)
	(chud_track_object obj false)
	(sleep final_delay)
)

(script static void (f_blip_flag_internal (cutscene_flag f) (short icon_disappear_time) (short final_delay))
	(chud_track_flag f true)
	(sound_impulse_start sfx_blip none 1)
	(sleep icon_disappear_time)
	(chud_track_flag f false)
	(sleep final_delay)
)

; -------------------------------------------------------------------------------------------------
; blips
; -------------------------------------------------------------------------------------------------
;*
0.	neutralize
1.	defend
2.	ordnance
3.	interface
4.	recon
5.	recover
6.	hostile enemy
7.	neutralize alpha
8.	neutralize bravo
9.	neutralize charlie
*;

(global short blip_neutralize 			0)
(global short blip_defend 				1)
(global short blip_ordnance 			2)
(global short blip_interface 			3)
(global short blip_recon 				4)
(global short blip_recover 				5)
(global short blip_structure			6)
(global short blip_neutralize_alpha 	7)
(global short blip_neutralize_bravo 	8)
(global short blip_neutralize_charlie 	9)
(global short blip_ammo 				13)
(global short blip_hostile_vehicle		14)
(global short blip_hostile 				15)
(global short blip_default_a 			17)
(global short blip_default_b 			18)
(global short blip_default_c 			19)
(global short blip_default_d 			20)
(global short blip_default 				21)
(global short blip_destination			21)


; blip a cinematic flag temporarily
(script static void (f_blip_flag (cutscene_flag f) (short type))
	(chud_track_flag_with_priority f type))

; blip a cinenamtic flag forever
(script static void (f_blip_flag_forever (cutscene_flag f))
	(print "f_blip_flag_forever is going away. please use f_blip_flag")
	(f_blip_flag f blip_neutralize))

; unblip a cinematic flag
(script static void (f_unblip_flag (cutscene_flag f))
	(chud_track_flag f false))

; blip an object temporarily
(script static void (f_blip_object (object obj) (short type))
	(chud_track_object_with_priority obj type))
	
	; blip an object temporarily
(script static void (f_blip_object_offset (object obj) (short type) (short offset))
	(chud_track_object_with_priority obj type)
	(chud_track_object_set_vertical_offset obj offset))

; blip an object until you say so
(script static void (f_blip_object_forever (object obj))
	(print "f_blip_object_forever is going away. please use f_blip_object")
	(chud_track_object obj true))

; turn off a blip on an object that was blipped forever
(script static void (f_unblip_object (object obj))
	(chud_track_object obj false))

; put a blip over an object's head until dead	
(script static void (f_blip_object_until_dead (object obj))
	(chud_track_object obj true)
	(sleep_until (<= (object_get_health obj) 0))
	(chud_track_object obj false))

; blip ai actors (single or multiple)
; todo: use local list variables when they come online
(script static void (f_blip_ai (ai group) (short blip_type))
	(sleep_until (= b_blip_list_locked false) 1)
	(set b_blip_list_locked true)
	(set s_blip_list_index 0)
	
	(set l_blip_list (ai_actors group))
	(sleep_until
		(begin
			(if (> (object_get_health (list_get l_blip_list s_blip_list_index)) 0)
				(f_blip_object (list_get l_blip_list s_blip_list_index) blip_type))
			(set s_blip_list_index (+ s_blip_list_index 1))
		(>= s_blip_list_index (list_count l_blip_list))) 1)

	(set b_blip_list_locked false)
)

; blip ai offset (single or multiple)
; todo: use local list variables when they come online
(script static void (f_blip_ai_offset (ai group) (short blip_type) (short offset))
	(sleep_until (= b_blip_list_locked false) 1)
	(set b_blip_list_locked true)
	(set s_blip_list_index 0)
	
	(set l_blip_list (ai_actors group))
	(sleep_until
		(begin
			(if (> (object_get_health (list_get l_blip_list s_blip_list_index)) 0)
				(f_blip_object_offset (list_get l_blip_list s_blip_list_index) blip_type offset))
			(set s_blip_list_index (+ s_blip_list_index 1))
		(>= s_blip_list_index (list_count l_blip_list))) 1)

	(set b_blip_list_locked false)
)

; blip ai actors forever (single or multiple)
; todo: use local list variables when they come online
(script static void (f_blip_ai_forever (ai group))
	(print "f_blip_ai_forever is going away. please use f_blip_ai")
	(f_blip_ai group 0)
)

; put a blip over someone's head until dead	
(script static void (f_blip_ai_until_dead (ai char))
	(print "f_blip_ai_until_dead will be rolled into the new f_blip_ai command. consider using that instead.")
	(f_blip_ai_forever char)
	(sleep_until (<= (object_get_health (ai_get_object char)) 0))
	(f_unblip_ai char))

(script static void (f_unblip_ai (ai group))
	(sleep_until (= b_blip_list_locked false) 1)
	(set b_blip_list_locked true)
	(set s_blip_list_index 0)
	
	(set l_blip_list (ai_actors group))
	(sleep_until
		(begin
			(if (> (object_get_health (list_get l_blip_list s_blip_list_index)) 0)
				(f_unblip_object (list_get l_blip_list s_blip_list_index)))
			(set s_blip_list_index (+ s_blip_list_index 1))
		(>= s_blip_list_index (list_count l_blip_list))) 1)
	
	(set b_blip_list_locked false)
)

(script static void (f_blip_title (object obj) (string_id title))
	(chud_track_object_with_priority obj 6 title)
	(sleep 120)
	(chud_track_object obj false)
)

;(f_blip_weapon w_plasma_launcher_01 2 5)
(script static void (f_blip_weapon (object gun) (short dist) (short dist2))
	(sleep_until 
		(or
			(and (<= (objects_distance_to_object player0 gun) dist) (>= (objects_distance_to_object player0 gun) .1))
			(and (<= (objects_distance_to_object player1 gun) dist) (>= (objects_distance_to_object player1 gun) .1))
			(and (<= (objects_distance_to_object player2 gun) dist) (>= (objects_distance_to_object player2 gun) .1))
			(and (<= (objects_distance_to_object player3 gun) dist) (>= (objects_distance_to_object player3 gun) .1))
		)	
	1)
	(print "blip on")
	(f_blip_object gun blip_ordnance)
	(sleep_until
		(or
			(not (object_get_at_rest gun))
			 (and
			 	(>= (objects_distance_to_object player0 gun) dist2)
			 	(>= (objects_distance_to_object player0 gun) dist2)
			 	(>= (objects_distance_to_object player0 gun) dist2)
			 	(>= (objects_distance_to_object player0 gun) dist2)
			 )
		)
	1)
	(print "blip off")
	(f_unblip_object gun)
)

; =================================================================================================
; spartan waypoint scripts
; =================================================================================================
(script static void (f_hud_spartan_waypoint (ai spartan) (string_id spartan_hud) (short max_dist))
	(sleep_until
		(begin
			(cond
				((< (objects_distance_to_object (ai_get_object spartan) player0) .95)
					(begin
						(chud_track_object spartan false)
						(sleep 60)
					)
				)
				
				((> (objects_distance_to_object (ai_get_object spartan) player0) max_dist)
					(begin
						(chud_track_object spartan false)
						(sleep 60)
					)
				)
				
				((< (objects_distance_to_object (ai_get_object spartan) player0) 3)
					(begin
						(chud_track_object_with_priority spartan 22 spartan_hud)
						(sleep 60)
					)
				)
				
				((objects_can_see_object player0 (ai_get_object spartan) 10)
					(begin
						(chud_track_object_with_priority spartan 22 spartan_hud)
						(sleep 60)
					)
				)
				
				(true
					(begin
						(chud_track_object_with_priority spartan 5 "")
						;(sleep 30)
					)
				)
			)
		0)
	30)
	
)

; =================================================================================================
; callout scripts
; =================================================================================================
(script static void (f_callout_atom (object obj) (short type) (short time) (short postdelay))
	(chud_track_object_with_priority obj type)
	(sound_impulse_start sfx_blip none 1)
	(sleep time)
	(chud_track_object obj false)
	(sleep postdelay)
)

(script static void (f_callout_flag_atom (cutscene_flag f) (short type) (short time) (short postdelay))
	(chud_track_flag_with_priority f type)
	(sound_impulse_start sfx_blip none 1)
	(sleep time)
	(chud_track_flag f false)
	(sleep postdelay)
)

(script static void (f_callout_object (object obj) (short type))
	;(f_callout_atom obj type 10 2)
	;(f_callout_atom obj type 10 2)
	;(f_callout_atom obj type 10 2)
	(f_callout_atom obj type 120 2)
)

(script static void (f_callout_object_fast (object obj) (short type))
	;(f_callout_atom obj type 2 2)
	;(f_callout_atom obj type 2 2)
	(f_callout_atom obj type 20 5)
)

(script static void (f_callout_ai (ai actors) (short type))
	(sleep_until (= b_blip_list_locked false) 1)
	(set b_blip_list_locked true)
	
	(set l_blip_list (ai_actors actors))
	(sleep_until
		(begin
			(if (> (object_get_health (list_get l_blip_list s_blip_list_index)) 0)
				(f_callout_object (list_get l_blip_list s_blip_list_index) type))
			(set s_blip_list_index (+ s_blip_list_index 1))
		(>= s_blip_list_index (list_count l_blip_list))) 1)
	
	(set s_blip_list_index 0)
	(set b_blip_list_locked false)	
)

(script static void (f_callout_ai_fast (ai actors) (short type))
	(sleep_until (= b_blip_list_locked false) 1)
	(set b_blip_list_locked true)
	
	(set l_blip_list (ai_actors actors))
	(sleep_until
		(begin
			(if (> (object_get_health (list_get l_blip_list s_blip_list_index)) 0)
				(f_callout_object_fast (list_get l_blip_list s_blip_list_index) type))
			(set s_blip_list_index (+ s_blip_list_index 1))
		(>= s_blip_list_index (list_count l_blip_list))) 1)
	
	(set s_blip_list_index 0)
	(set b_blip_list_locked false)	
)


(script static void (f_callout_and_hold_flag (cutscene_flag f) (short type))
	;(f_callout_flag_atom f type 2 2)
	;(f_callout_flag_atom f type 2 2)
	(chud_track_flag_with_priority f type)
	(sound_impulse_start sfx_blip none 1)
	(sleep 10)
)
	
; mission dialogue
; =================================================================================================
; play the specified line, then delay afterwards for a specified amount of time.
; added if statement to check if character exists so we don't get into bad situations- dmiller 5/25
(script static void (f_md_ai_play (short delay) (ai character) (ai_line line))
	(set b_is_dialogue_playing true)
	(if (>= (ai_living_count character) 1)
		(begin
			(set s_md_play_time (ai_play_line character line))
			(sleep s_md_play_time)
			(sleep delay)
		)
		(print "this actor does not exist to play f_md_ai_play")
	)
	(set b_is_dialogue_playing false)
)

; play the specified line, then delay afterwards for a specified amount of time.
(script static void (f_md_object_play (short delay) (object obj) (ai_line line))
	(set b_is_dialogue_playing true)
	(set s_md_play_time (ai_play_line_on_object obj line))
	(sleep s_md_play_time)
	(sleep delay)
	(set b_is_dialogue_playing false)
)

; play the specified line, then cutoff afterwards for a specified amount of time.
(script static void (f_md_ai_play_cutoff (short cutoff_time) (ai character) (ai_line line))
	(set b_is_dialogue_playing true)
	(set s_md_play_time (- (ai_play_line character line) cutoff_time))
	(sleep s_md_play_time)
	(set b_is_dialogue_playing false)
)

; play the specified line, then cutoff afterwards for a specified amount of time.
(script static void (f_md_object_play_cutoff (short cutoff_time) (object obj) (ai_line line))
	(set b_is_dialogue_playing true)
	(set s_md_play_time (- (ai_play_line_on_object obj line) cutoff_time))
	(sleep s_md_play_time)
	(set b_is_dialogue_playing false)
)

; for branching scipts in dialog
(script static void f_md_abort
	(sleep s_md_play_time)
	(print "dialog script aborted!")
	(set b_is_dialogue_playing false)
	(ai_dialogue_enable true)
)

(script static void (f_md_abort_no_combat_dialog)
	(f_md_abort)
	(sleep 1)
	(ai_dialogue_enable false)
)


; play the specified line, then delay afterwards for a specified amount of time.
(global boolean b_is_dialogue_playing false)
(script static void (f_md_play (short delay) (sound line))
	; (sleep_until (not b_is_dialogue_playing) 1) 			; dmiller does not want this functionality! 1.04.10
	(set b_is_dialogue_playing true)
	(set s_md_play_time (sound_impulse_language_time line)) ; dmiller added this so he can reference a time in mission scripts
	(sound_impulse_start line none 1)
	(sleep (sound_impulse_language_time line))
	(sleep delay)
	(set s_md_play_time 0) ; dmiller adds this to reset the current line time, indicating the line is finished.		
	(set b_is_dialogue_playing false))

	
(script static boolean f_is_dialogue_playing
	b_is_dialogue_playing)
	
; longswords
; =================================================================================================
; make a longsword device activate. 
; device tag: sound\device_machines\040vc_longsword\start
; flyby sound tag: sound\device_machines\040vc_longsword\start
; =================================================================================================
; example: 	(f_ls_flyby my_longsword_device_machine)
;			(sound_impulse_start sound\device_machines\040vc_longsword\start none 1)
; =================================================================================================
;*
(script static void (f_ls_flyby (device d))
	(device_animate_position d 0 0.0 0.0 0.0 true)
	(device_set_position_immediate d 0)
	(device_set_power d 0)
	(sleep 1)
	(device_set_position_track d device:position 0)
	(device_animate_position d 0.5 7.0 0.1 0.1 true))
*;
; carpetbombs
; =================================================================================================
; spawn a trail of bombs across a point set.
; effect tag: fx\fx_library\explosions\reach_test_explosion_large\reach_test_explosion_large
; count: how many points are in the set?
; delay: time (in ticks) between the detonation of each bomb effect
; =================================================================================================
; example: 	(f_ls_carpetbomb pts_030 fx\my_explosion_fx 6 10)
; =================================================================================================
;*
(global short global_s_current_bomb 0)
(script static void (f_ls_carpetbomb (point_reference p) (effect e) (short count) (short delay))
	(set global_s_current_bomb 0)
	(sleep_until
		(begin
			(if b_debug_globals (print "boom..."))
			(effect_new_at_point_set_point e p global_s_current_bomb)
			(set global_s_current_bomb (+ global_s_current_bomb 1))
			(sleep delay)
		(>= global_s_current_bomb count)) 1)	
)
*;

; =================================================================================================
; helpers
; =================================================================================================
; macro to see if a squad or group has ever spawned
(script static boolean (f_ai_has_spawned (ai actors))
	(> (ai_spawn_count actors) 0))
	
; macro to see if a squad or group has ever spawned and has no living members left
(script static boolean (f_ai_is_defeated (ai actors))
	(and
		(> (ai_spawn_count actors) 0)
		(<= (ai_living_count actors) 0)))
		
; macro to see if a squad or group has ever spawned and has a specified number of living members
(script static boolean (f_ai_is_partially_defeated (ai actors) (short count))
	(and
		(>= (ai_spawn_count actors) count)
		(<= (ai_living_count actors) count)))

; macro to see if a task is empty or not
(script static boolean (f_task_is_empty (ai task))
	(<= (ai_task_count task) 0))

; macro to see if a task has anyone in it
(script static boolean (f_task_has_actors (ai task))
	(> (ai_task_count task) 0))
	
; macro so we can get ahold of our ai
(script static ai (f_object_get_squad (object ai_obj))
	(ai_get_squad (object_get_ai ai_obj)))


; =================================================================================================
; debug rendering of pathfinding stuff
; =================================================================================================

(script static void debug_toggle_cookie_cutters
	(if (= debug_instanced_geometry 0)
		(begin
			(set debug_objects_collision_models 0)
			(set debug_objects_physics_models 0)
			(set debug_objects_bounding_spheres 0)
			(set debug_objects_cookie_cutters 1)
			(set debug_objects 1)

			(set debug_instanced_geometry_collision_geometry 0)
			(set debug_instanced_geometry_cookie_cutters 1)
			(set debug_instanced_geometry 1)
		)
		(begin
			(set debug_objects_cookie_cutters 0)
			(set debug_objects 0)

			(set debug_instanced_geometry_cookie_cutters 0)
			(set debug_instanced_geometry 0)
		)
	)
)

(script static void debug_toggle_pathfinding_collisions
	(if (= collision_debug 0)
		(begin
			(set collision_debug 1)
			(set collision_debug_flag_ignore_invisible_surfaces 0)
		)
		(begin
			(set collision_debug 0)
			(set collision_debug_flag_ignore_invisible_surfaces 1)
		)
	)
)

; =================================================================================================
; thespian scripts
; =================================================================================================

(script static void f_branch_empty01
	(print "branch exit")
)

(script static void f_branch_empty02
	(print "branch exit")
)

(script static void f_branch_empty03
	(print "branch exit")
)
�tgbl���������������tgst�sÝ�sÝtgda�����hO;----------------------------------------------------------------------------------------------------
; *** globals *** 
;----------------------------------------------------------------------------------------------------

; b_debug options
(global boolean b_debug 					true)
(global boolean b_breakpoints			false)
(global boolean b_md_print 				true)
(global boolean debug_objectives 	false)
(global boolean editor 						(editor_mode))
(global boolean cinematics 				true)
(global boolean editor_cinematics false)
(global boolean game_emulate 			false)
(global boolean dialogue 					false)
(global boolean skip_intro				false)

; objective controls
(global short objcon_dirt -1)
(global short objcon_goose -1)
(global short objcon_drop -1)
(global short objcon_block -1)
(global short objcon_carter -1)
(global short objcon_tunnels -1)
(global short objcon_wall -1)
(global short objcon_factory -1)
(global short objcon_crane -1)
(global short objcon_catwalk -1)
(global short objcon_platform -1) 
(global short objcon_zealot -1)
(global short objcon_cannon -1)


; objective readiness
(global boolean b_dirt_ready false)
(global boolean b_goose_ready false)
(global boolean b_drop_ready false)
(global boolean b_block_ready false)
(global boolean b_carter_ready false)
(global boolean b_tunnels_ready false)
(global boolean b_wall_ready false)
(global boolean b_factory_ready false)
(global boolean b_crane_ready false)
(global boolean b_catwalk_ready false)
(global boolean b_platform_ready false)
(global boolean b_zealot_ready false)
(global boolean b_cannon_ready false)

; insertion
(global short g_insertion_index 0)

; insertion indicies
(global short s_insert_idx_dirt 1)
(global short s_insert_idx_goose 2)
(global short s_insert_idx_drop 3)
(global short s_insert_idx_block 4)
(global short s_insert_idx_carter 5)
(global short s_insert_idx_tunnels 6)
(global short s_insert_idx_wall 7)
(global short s_insert_idx_factory 8)
(global short s_insert_idx_crane 9)
(global short s_insert_idx_catwalk 10)
(global short s_insert_idx_platform 11)
(global short s_insert_idx_zealot 12)
(global short s_insert_idx_cannon 13)

; zone sets
(global short s_set_intro_cinematic 0)
(global short s_set_dirt 1)
(global short s_set_block 2)
(global short s_set_cave 3)
(global short s_set_bone 4)
(global short s_set_hall_1 5)
(global short s_set_smelt 6)
(global short s_set_hall_2 7)
(global short s_set_final_0 8)
(global short s_set_final_1 9)
(global short s_set_package_cinematic 10)
(global short s_set_final_2 11)
(global short s_set_outro_cinematic 12)
(global short s_set_all 13)

; fire teams
(global short fireteam_max 4)
(global real fireteam_dist 3.0)

; mission specific
(global boolean g_mission_complete false)

; persistent objects
(global object bp_emile none)
(global ai ai_emile none)
(global object o_emile none)
(global vehicle v_mongoose_player_0 none)
(global vehicle v_mongoose_emile none)
(global vehicle v_pelican_carter none)

; global functions
(script command_script cs_abort  
	(sleep 1) 
)
; utility
(global short s_wave_spawning 0)

; =================================================================================================
; package startup
; =================================================================================================
(script startup package

	(print_difficulty)
	(dprint "::: m70 - the pillar of autumn :::")

	; allegiances
	(ai_allegiance human player)
	(ai_allegiance player human)
	(set respawn_players_into_friendly_vehicle true)

	(f_loadout_set "default")

	(zone_set_trigger_volume_enable begin_zone_set:set_smelt false)
	(zone_set_trigger_volume_enable begin_zone_set:set_hall_2 false)
	(zone_set_trigger_volume_enable begin_zone_set:set_final_0 false)
	(zone_set_trigger_volume_enable begin_zone_set:set_final_1 false)
	(zone_set_trigger_volume_enable zone_set:set_final_1 false)

	(set breakpoints_enabled false)

	;(wake f_fireteam_setup)
	(wake f_weather_control)
	(wake f_checkpoint_generic)
	(wake f_coop_forward)
	(wake f_player_on_foot)
	(wake f_objects_manage)
	(wake f_flock_control)
	(wake special_elite)

	; starting the game
	; ============================================================================================
	(if	
		(or
			(and (not editor) (> (player_count) 0))
			game_emulate
		)
			(begin			
				; if true, start the game
				(start)
			)
			; else just fade in, we're in edit mode
			(begin
				(dprint ":::  editor mode  :::")
			)
	)

	; encounters
	; ============================================================================================

		; dirtroad
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_dirt_start)
				(>= g_insertion_index s_insert_idx_dirt))
			1)
		
		(if (<= g_insertion_index s_insert_idx_dirt) (wake f_dirt_objective_control))
		

		; mongoose
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_goose_start)
				(>= g_insertion_index s_insert_idx_goose))
			1)
		
		(if (<= g_insertion_index s_insert_idx_goose) (wake f_goose_objective_control))

		; scarabdrop
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_drop_start)
				(>= g_insertion_index s_insert_idx_drop))
			1)

		(if (<= g_insertion_index s_insert_idx_drop) (wake f_drop_objective_control))
		
		; blockade
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_block_start)
				(>= g_insertion_index s_insert_idx_block))
			1)
		
		(if (<= g_insertion_index s_insert_idx_block) (wake f_block_objective_control))
		

		; cave - carter
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_carter_start)
				(>= g_insertion_index s_insert_idx_carter))
			1)
		
		(if (<= g_insertion_index s_insert_idx_carter) (wake f_carter_objective_control))


		; cave - tunnels
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_tunnels_start)
				(>= g_insertion_index s_insert_idx_tunnels))
			1)
		
		(if (<= g_insertion_index s_insert_idx_tunnels) (wake f_tunnels_objective_control))
		
		
		; boneyard - wall
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_wall_start)
				(>= g_insertion_index s_insert_idx_wall))
			1)
		
		(if (<= g_insertion_index s_insert_idx_wall) (wake f_wall_objective_control))


		; boneyard - factory
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_factory_start)
				(>= g_insertion_index s_insert_idx_factory))
			1)
		
		(if (<= g_insertion_index s_insert_idx_factory) (wake f_factory_objective_control))		


		; smelter - crane
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_crane_start)
				(>= g_insertion_index s_insert_idx_crane))
			1)
		
		(if (<= g_insertion_index s_insert_idx_crane) (wake f_crane_objective_control))


		; smelter - catwalk
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_catwalk_start)
				(>= g_insertion_index s_insert_idx_catwalk))
			1)
		
		(if (<= g_insertion_index s_insert_idx_catwalk) (wake f_catwalk_objective_control))


		; big gun - platform
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_platform_start)
				(>= g_insertion_index s_insert_idx_platform))
			1)
		
		(if (<= g_insertion_index s_insert_idx_platform) (wake f_platform_objective_control))


		; big gun - zealot
		; =======================================================================================
		(sleep_until	
			(or
				(= b_zealot_ready true)
				(>= g_insertion_index s_insert_idx_zealot))
			1)
		
		(if (<= g_insertion_index s_insert_idx_zealot) (wake f_zealot_objective_control))


		; big gun - cannon
		; =======================================================================================
		(sleep_until	
			(or
				(and
					(= b_cannon_ready true)
					(volume_test_players tv_cannon_start)
				)
				(>= g_insertion_index s_insert_idx_cannon))
			1)
		
		(if (<= g_insertion_index s_insert_idx_cannon) (wake f_cannon_objective_control))

)


(script static void (f_loadout_set (string area))

	(if (= area "default")(begin

		(if (game_is_cooperative)(begin
			(unit_add_equipment player0 default_coop true false)
			(unit_add_equipment player1 default_coop true false)
			(unit_add_equipment player2 default_coop true false)
			(unit_add_equipment player3 default_coop true false)
			(player_set_profile default_coop_respawn player0)
			(player_set_profile default_coop_respawn player1)
			(player_set_profile default_coop_respawn player2)
			(player_set_profile default_coop_respawn player3)
		)(begin
			(player_set_profile default_single_respawn player0)
		))
	))

	(if (= area "boneyard")(begin
		(if (game_is_cooperative)(begin
			(player_set_profile boneyard_coop_respawn player0)
			(player_set_profile boneyard_coop_respawn player1)
			(player_set_profile boneyard_coop_respawn player2)
			(player_set_profile boneyard_coop_respawn player3)
		)(begin
			(player_set_profile boneyard_single_respawn player0)
		))
	))

	(if (= area "smelter")(begin
		(if (game_is_cooperative)(begin
			(player_set_profile smelter_coop_respawn player0)
			(player_set_profile smelter_coop_respawn player1)
			(player_set_profile smelter_coop_respawn player2)
			(player_set_profile smelter_coop_respawn player3)
		)(begin
			(player_set_profile smelter_single_respawn player0)
		))
	))

	(if (= area "platform")(begin
		(if (game_is_cooperative)(begin
			(player_set_profile platform_coop_respawn player0)
			(player_set_profile platform_coop_respawn player1)
			(player_set_profile platform_coop_respawn player2)
			(player_set_profile platform_coop_respawn player3)
		)(begin
			(player_set_profile platform_single_respawn player0)
		))
	))


)


(global object o_package cr_package)
(script static void f_package_attach

	(objects_attach (player0) "package" cr_package "")

)

(script static void f_package_destroy

	(objects_detach (player0) cr_package)
	(object_destroy cr_package)

)

(script dormant f_coop_forward

	(wake f_coop_forward_triggers)
	(sleep_until (volume_test_players "begin_zone_set:set_block:*") 5)
	(sleep_until
		(begin
			(if (game_is_cooperative)
				(cond
					((volume_test_objects tv_block_coop_teleport player0)
						(object_teleport_to_ai_point player0 ps_drop_coop_teleport/p0))
					((volume_test_objects tv_block_coop_teleport player1)
						(object_teleport_to_ai_point player1 ps_drop_coop_teleport/p1))
					((volume_test_objects tv_block_coop_teleport player2)
						(object_teleport_to_ai_point player2 ps_drop_coop_teleport/p2))
					((volume_test_objects tv_block_coop_teleport player3)
						(object_teleport_to_ai_point player3 ps_drop_coop_teleport/p3))
				)
			)
		(volume_test_players begin_zone_set:set_cave)
		)
	1)

)

(global boolean b_cin_delivery_rain false)
(script dormant f_weather_control

	(sleep_until (or (> objcon_wall 0)(> objcon_platform 0) b_dirt_ready b_ins_wall b_ins_platform))
	(if (and (not b_ins_wall)(not b_ins_platform)) (begin (dprint "init rain")(set s_rain_force 2)))
	(wake f_rain)

	; cave - inward arch
	(sleep_until (or (> objcon_wall 0)(> objcon_platform 0)(>= objcon_carter 10) b_ins_wall b_ins_platform ))
	(if (and (not b_ins_wall)(not b_ins_platform)) (begin (dprint "cave rain")(set s_rain_force 1)))

	(sleep_until (or (> objcon_platform 0)(>= objcon_crane 10) b_ins_platform ))
	(if (not b_ins_platform) (begin (dprint "crane rain") (set s_rain_force 5)))

	(sleep_until (>= objcon_platform 10))
	(set s_rain_force 8)

	(sleep_until b_cin_delivery_rain 1)
	(set s_rain_force 9)

	(sleep_until (> objcon_zealot 0))
	(set s_rain_force 5)
	(sound_class_set_gain weapon_ready_third_person .75 90)

	(sleep_until (> objcon_cannon 0))
	(set s_rain_force 2)
	(sound_class_set_gain weapon_ready_third_person 0 90)

)


(script dormant f_coop_forward_triggers

	(sleep_until
		(begin
			(if (game_is_cooperative)
				(begin
					(zone_set_trigger_volume_enable begin_zone_set:set_dirt:* false)
					(zone_set_trigger_volume_enable zone_set:set_dirt false)
				)(begin
					(zone_set_trigger_volume_enable begin_zone_set:set_dirt:* true)
					(zone_set_trigger_volume_enable zone_set:set_dirt true)
				)
			)
		(volume_test_players begin_zone_set:set_cave)
		)
	1)

)


(script dormant f_fireteam_setup

	(sleep_until (> (player_count) 0))

	; fireteams
	(ai_player_add_fireteam_squad player0 sq_player_0)
	(ai_player_add_fireteam_squad player1 sq_player_1)
	(ai_player_add_fireteam_squad player2 sq_player_2)
	(ai_player_add_fireteam_squad player3 sq_player_3)
	(ai_player_set_fireteam_max player0 5)
	(ai_player_set_fireteam_max player1 5)
	(ai_player_set_fireteam_max player2 5)
	(ai_player_set_fireteam_max player3 5)
	(ai_player_set_fireteam_max_squad_absorb_distance player0 3.0)
	(ai_player_set_fireteam_max_squad_absorb_distance player1 3.0)
	(ai_player_set_fireteam_max_squad_absorb_distance player2 3.0)
	(ai_player_set_fireteam_max_squad_absorb_distance player3 3.0)

)



(script static void (f_emile_respawn (ai emile) (string_id obj))

	(ai_erase ai_emile)
	(ai_erase sq_emile)
	(object_destroy o_emile)
	(sleep 10)
	(f_emile_spawn emile obj)

)

(script static void (f_emile_respawn_vehicle (ai emile) (ai emile_vehicle) (string_id obj))

	(ai_erase ai_emile)
	(ai_erase sq_emile)
	(object_destroy o_emile)
	(sleep 10)
	(f_emile_spawn_vehicle emile emile_vehicle obj)

)

(script static void (f_emile_spawn (ai emile) (string_id obj))

	(ai_place emile)
	(tick)
	(set ai_emile emile)
	(set o_emile (ai_get_object emile))
	(ai_cannot_die emile true)
	(ai_force_active ai_emile true)
	(ai_set_objective (ai_get_squad emile) obj)
	(f_emile_blip)

)

(script static void (f_emile_spawn_vehicle (ai emile) (ai emile_vehicle) (string_id obj))

	(print "vehicle respawn")

	(ai_place emile)
	(ai_place emile_vehicle)
	(tick)
	(set ai_emile emile)
	(set o_emile (ai_get_object ai_emile))
	(ai_cannot_die ai_emile true)
	(ai_force_active ai_emile true)
	(tick)
	(ai_vehicle_enter_immediate ai_emile (ai_vehicle_get_from_starting_location emile_vehicle) "mongoose_d")
	(ai_set_objective (ai_get_squad ai_emile) obj)
	(ai_set_objective (ai_get_squad emile_vehicle) obj)
	(f_emile_blip)
	
)

(global object o_vehicle_emile none)
(script static void (f_emile_area_forward (trigger_volume tv_area) (point_reference pt) (ai respawn_emile) (ai respawn_vehicle) (string_id obj) (boolean b_vehicle) )

	(branch
		b_nanny_reset
		(f_abort)
	)		

	(if (unit_in_vehicle ai_emile) (set o_vehicle_emile (object_get_parent ai_emile)) (set o_vehicle_emile none) )

	; bring forward failsafe
	(sleep_until
		(or
			b_vehicle
			(and
				(volume_test_object tv_area o_emile)
				(volume_test_players tv_area)
			)
		)
	5 (* 30 s_emile_forward_timer))
	(if
		(or
			(not b_vehicle)
			(and
				(volume_test_players tv_area)
				(not (volume_test_object tv_area o_emile))
			)
		)
		(begin
			(dbreak "emile forward")
			(ai_set_objective sq_emile obj)
			(tick)
			(ai_bring_forward o_emile r_emile_forward_range)
		)
	)
	
	; teleport failsafe
	(sleep_until
		(or
			b_vehicle
			(and
				(volume_test_object tv_area o_emile)
				(volume_test_players tv_area)
			)
		)
	5 (* 30 s_emile_teleport_timer))
	(if
		(or
			(not b_vehicle)
			(and
				(volume_test_players tv_area)
				(not (volume_test_object tv_area o_emile))
			)
		)
		(begin
			(dbreak "emile teleport")
			(ai_set_objective sq_emile obj)
		)
	)

	; respawn failsafe
	(sleep_until
		(and
			(volume_test_object tv_area o_emile)
			(volume_test_players tv_area)
		)
	5 (* 30 s_emile_spawn_timer))
	(if
		(and
			(volume_test_players tv_area)
			(not (volume_test_object tv_area o_emile))
		)
		(begin
			(dbreak "emile respawn")
			(if b_vehicle (f_emile_respawn_vehicle respawn_emile respawn_vehicle obj) (f_emile_respawn respawn_emile obj))
		)
	)

)

(global short s_emile_forward_timer 15)
(global real r_emile_forward_range 50)
(global short s_emile_teleport_timer 5)
(global short s_emile_spawn_timer 5)
(global boolean b_nanny_reset false)
(script dormant f_emile_nanny

	(dprint "emile nanny")
	(if (<= g_insertion_index s_insert_idx_dirt) (wake f_emile_nanny_dirt_shack) )
	(if (<= g_insertion_index s_insert_idx_goose) (wake f_emile_nanny_dirt_bend) )
	(if (<= g_insertion_index s_insert_idx_drop) (wake f_emile_nanny_drop_scarab) )
	(if (<= g_insertion_index s_insert_idx_block) (wake f_emile_nanny_block_cliff) )
	(if (<= g_insertion_index s_insert_idx_block) (wake f_emile_nanny_block_jump) )
	(if (<= g_insertion_index s_insert_idx_block) (wake f_emile_nanny_block_gulch) )
	(if (<= g_insertion_index s_insert_idx_carter) (wake f_emile_nanny_carter) )
	(if (<= g_insertion_index s_insert_idx_tunnels) (wake f_emile_nanny_tunnels) )
	(if (<= g_insertion_index s_insert_idx_wall) (wake f_emile_nanny_wall) )
	(if (<= g_insertion_index s_insert_idx_factory) (wake f_emile_nanny_factory) )
	(if (<= g_insertion_index s_insert_idx_factory) (wake f_emile_nanny_hall_1) )
	(if (<= g_insertion_index s_insert_idx_crane) (wake f_emile_nanny_crane) )
	(if (<= g_insertion_index s_insert_idx_catwalk) (wake f_emile_nanny_catwalk) )
	(if (<= g_insertion_index s_insert_idx_platform) (wake f_emile_nanny_hall_2) )
	;(if (<= g_insertion_index s_insert_idx_platform) (wake f_emile_nanny_platform) )

)

(script dormant f_emile_nanny_dirt_shack

	(sleep_until (volume_test_players tv_area_dirt_shack) 5)
	(f_emile_area_forward tv_area_dirt_shack ps_emile_teleport/dirt_shack sq_emile/sp_dirt_shack none obj_vehicle_hum false)

)

(script dormant f_emile_nanny_dirt_bend

	(sleep_until (volume_test_players tv_area_dirt_bend) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_dirt_bend ps_emile_teleport/dirt_bend sq_emile/sp_dirt_bend sq_mongoose_emile/sp_dirt_bend obj_vehicle_hum true)

)

(script dormant f_emile_nanny_drop_scarab

	(sleep_until (volume_test_players tv_area_drop_scarab) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_drop_scarab ps_emile_teleport/drop_scarab sq_emile/sp_drop_scarab sq_mongoose_emile/sp_drop_scarab obj_vehicle_hum true)

)

(script dormant f_emile_nanny_block_cliff

	(sleep_until (volume_test_players tv_area_block_cliff) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_block_cliff ps_emile_teleport/block_cliff sq_emile/sp_block_cliff sq_mongoose_emile/sp_block_cliff obj_vehicle_hum true)

)


(script dormant f_emile_nanny_block_jump

	(sleep_until (volume_test_players tv_area_block_jump) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_block_jump ps_emile_teleport/block_jump sq_emile/sp_block_jump sq_mongoose_emile/sp_block_jump obj_vehicle_hum true)

)

(script dormant f_emile_nanny_block_gulch

	(sleep_until (volume_test_players tv_area_block_gulch) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_block_gulch ps_emile_teleport/block_gulch sq_emile/sp_block_gulch none obj_block_hum false)

)


(script dormant f_emile_nanny_carter

	(sleep_until (volume_test_players tv_area_carter) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_carter ps_emile_teleport/carter sq_emile/sp_carter none obj_carter_hum false)

)


(script dormant f_emile_nanny_tunnels

	(sleep_until (volume_test_players tv_area_tunnels) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_tunnels ps_emile_teleport/tunnels sq_emile/sp_tunnels none obj_tunnels_hum false)

)


(script dormant f_emile_nanny_wall

	(sleep_until (volume_test_players tv_area_wall) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_wall ps_emile_teleport/wall_yard sq_emile/sp_wall_yard none obj_wall_hum false)

)

(script dormant f_emile_nanny_factory

	(sleep_until (volume_test_players tv_area_factory) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_factory ps_emile_teleport/factory sq_emile/sp_factory none obj_factory_hum false)

)


(script dormant f_emile_nanny_hall_1

	(sleep_until (volume_test_players tv_area_hall_1) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_hall_1 ps_emile_teleport/hall_1 sq_emile/sp_hall_1 none obj_factory_hum false)

)


(script dormant f_emile_nanny_crane

	(sleep_until (volume_test_players tv_area_crane) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_crane ps_emile_teleport/crane sq_emile/sp_crane none obj_crane_hum false)

)

(script dormant f_emile_nanny_catwalk

	(sleep_until (volume_test_players tv_area_catwalk) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_catwalk ps_emile_teleport/catwalk sq_emile/sp_catwalk none obj_catwalk_hum false)

)

(script dormant f_emile_nanny_hall_2

	(sleep_until (volume_test_players tv_area_hall_2) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_hall_2 ps_emile_teleport/hall_2 sq_emile/sp_hall_2 none obj_platform_hum false)

)

(script dormant f_emile_nanny_platform

	(sleep_until (volume_test_players tv_area_platform) 5)
	(set b_nanny_reset true) (tick) (set b_nanny_reset false)
	(f_emile_area_forward tv_area_platform ps_emile_teleport/platform sq_emile/sp_platform none obj_platform_hum false)

)


(script static void f_emile_blip_kill

	(sleep_forever f_emile_blip_1)
	(sleep_forever f_emile_blip_2)
	(sleep_forever f_emile_blip_3)
	(sleep_forever f_emile_blip_4)
	(sleep_forever f_emile_blip_5)
	(sleep_forever f_emile_blip_6)
	(sleep_forever f_emile_blip_7)
	(sleep_forever f_emile_blip_8)
	(sleep_forever f_emile_blip_9)
	(sleep_forever f_emile_blip_10)
	(sleep_forever f_emile_blip_11)
	(sleep_forever f_emile_blip_12)
	(sleep_forever f_emile_blip_13)
	(sleep_forever f_emile_blip_14)
	(sleep_forever f_emile_blip_15)
	(sleep_forever f_emile_blip_16)
	(sleep_forever f_emile_blip_17)
	(sleep_forever f_emile_blip_18)

)

(global short s_emile_blip 1)
(script static void f_emile_blip

	(cond
		((= s_emile_blip 1)
			(wake f_emile_blip_1)
			(set s_emile_blip 2)
		)
		((= s_emile_blip 2)
			(sleep_forever f_emile_blip_1)
			(wake f_emile_blip_2)
			(set s_emile_blip 3)
		)
		((= s_emile_blip 3)
			(sleep_forever f_emile_blip_2)
			(wake f_emile_blip_3)
			(set s_emile_blip 4)
		)
		((= s_emile_blip 4)
			(sleep_forever f_emile_blip_3)
			(wake f_emile_blip_4)
			(set s_emile_blip 5)
		)
		((= s_emile_blip 5)
			(sleep_forever f_emile_blip_4)
			(wake f_emile_blip_5)
			(set s_emile_blip 6)
		)
		((= s_emile_blip 6)
			(sleep_forever f_emile_blip_5)
			(wake f_emile_blip_6)
			(set s_emile_blip 7)
		)
		((= s_emile_blip 7)
			(sleep_forever f_emile_blip_6)
			(wake f_emile_blip_7)
			(set s_emile_blip 8)
		)
		((= s_emile_blip 8)
			(sleep_forever f_emile_blip_7)
			(wake f_emile_blip_8)
			(set s_emile_blip 9)
		)
		((= s_emile_blip 9)
			(sleep_forever f_emile_blip_8)
			(wake f_emile_blip_9)
			(set s_emile_blip 10)
		)
		((= s_emile_blip 10)
			(sleep_forever f_emile_blip_9)
			(wake f_emile_blip_10)
			(set s_emile_blip 11)
		)
		((= s_emile_blip 11)
			(sleep_forever f_emile_blip_10)
			(wake f_emile_blip_11)
			(set s_emile_blip 12)
		)
		((= s_emile_blip 12)
			(sleep_forever f_emile_blip_11)
			(wake f_emile_blip_12)
			(set s_emile_blip 13)
		)
		((= s_emile_blip 13)
			(sleep_forever f_emile_blip_12)
			(wake f_emile_blip_13)
			(set s_emile_blip 14)
		)
		((= s_emile_blip 14)
			(sleep_forever f_emile_blip_13)
			(wake f_emile_blip_14)
			(set s_emile_blip 15)
		)
		((= s_emile_blip 15)
			(sleep_forever f_emile_blip_14)
			(wake f_emile_blip_15)
			(set s_emile_blip 16)
		)
		((= s_emile_blip 16)
			(sleep_forever f_emile_blip_15)
			(wake f_emile_blip_16)
			(set s_emile_blip 17)
		)
		((= s_emile_blip 17)
			(sleep_forever f_emile_blip_16)
			(wake f_emile_blip_17)
			(set s_emile_blip 18)
		)
		((= s_emile_blip 18)
			(sleep_forever f_emile_blip_17)
			(wake f_emile_blip_18)
			(set s_emile_blip -1)
		)



	)

)

(script dormant f_emile_blip_1

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_2

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_3

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_4

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_5

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_6

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_7

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_8

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_9

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_10

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_11

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)


(script dormant f_emile_blip_12

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_13

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_14

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_15

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_16

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_17

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(script dormant f_emile_blip_18

	(if (not (game_is_cooperative))
		(begin
			(f_hud_spartan_waypoint (object_get_ai o_emile) emile_name 60)
		)
	)

)

(global boolean b_insertion_fade_in false)
(script dormant f_insertion_fade_in

	(sleep_until b_insertion_fade_in)
	(insertion_fade_to_gameplay)

)


(script dormant f_flock_control

	(if (and (not b_ins_platform)(not b_test_finalbattle)(< objcon_platform 10 )) (begin

			(sleep_until
				(or
					(>= objcon_dirt 1)
					(>= objcon_wall 1)
				)
			)

			(flock_create flc_init_phantom_01)
			(flock_create flc_init_banshee_01)
			(flock_create flc_init_wraith_01)
			(flock_create flc_init_ghost_01)
			
	))

)

(global short s_zoneset_last_refreshed -1)
(script dormant f_objects_manage

		(sleep_until (begin

			(cond
				((and (= (current_zone_set_fully_active) s_set_dirt)(not (= s_zoneset_last_refreshed s_set_dirt)))
					(dprint "creating dirt objects")
					(f_objects_dirt_create)
					(set s_zoneset_last_refreshed s_set_dirt)
				)
				((and (= (current_zone_set_fully_active) s_set_block)(not (= s_zoneset_last_refreshed s_set_block)))
					(dprint "creating block objects")
					(f_objects_block_create)
					(set s_zoneset_last_refreshed s_set_block)
				)
				((and (= (current_zone_set_fully_active) s_set_cave)(not (= s_zoneset_last_refreshed s_set_cave)))
					(dprint "creating cave objects")
					(f_objects_cave_create)
					(f_objects_dirt_destroy)
					(set s_zoneset_last_refreshed s_set_cave)
				)
				((and (= (current_zone_set_fully_active) s_set_bone)(not (= s_zoneset_last_refreshed s_set_bone)))
					(dprint "creating bone objects")
					(f_objects_bone_create)
					(f_objects_block_destroy)
					(set s_zoneset_last_refreshed s_set_bone)
				)
				((and (= (current_zone_set_fully_active) s_set_hall_1)(not (= s_zoneset_last_refreshed s_set_hall_1)))
					(dprint "creating hall 1 objects")
					(f_objects_hall_1_create)
					(f_objects_cave_destroy)
					(set s_zoneset_last_refreshed s_set_hall_1)
				)
				((and (= (current_zone_set_fully_active) s_set_smelt)(not (= s_zoneset_last_refreshed s_set_smelt)))
					(dprint "creating smelt objects")
					(f_objects_smelt_create)
					(f_objects_bone_destroy)
					(set s_zoneset_last_refreshed s_set_smelt)
				)
				((and (= (current_zone_set_fully_active) s_set_hall_2)(not (= s_zoneset_last_refreshed s_set_hall_2)))
					(dprint "creating hall 2 objects")
					(f_objects_hall_2_create)
					(f_objects_hall_1_destroy)
					(set s_zoneset_last_refreshed s_set_hall_2)
				)
				((and (= (current_zone_set_fully_active) s_set_final_0)(not (= s_zoneset_last_refreshed s_set_final_0)))
					(dprint "creating final 0 objects")
					(f_objects_final_0_create)
					(f_objects_smelt_destroy)
					(flock_delete flc_init_phantom_01)
					(flock_delete flc_init_banshee_01)
					(flock_delete flc_init_wraith_01)
					(flock_delete flc_init_ghost_01)
					(object_create_anew sc_poa)
					(set s_zoneset_last_refreshed s_set_final_0)
				)
				((and (= (current_zone_set_fully_active) s_set_final_1)(not (= s_zoneset_last_refreshed s_set_final_1)))
					(dprint "creating final 1 objects")
					(f_objects_final_0_create)
					(f_objects_hall_2_destroy)
					(set s_zoneset_last_refreshed s_set_final_1)
				)
				((and (= (current_zone_set_fully_active) s_set_final_2)(not (= s_zoneset_last_refreshed s_set_final_2)))
					(dprint "creating final 2 objects")
					(f_objects_final_2_create)
					(set s_zoneset_last_refreshed s_set_final_2)
				)
			)

	false) 3)

)

; objects dirt
(script static void f_objects_dirt_create

	(object_create_folder eq_dirt)
	(object_create_folder dc_dirt)
	(object_create_folder w_dirt)
	(object_create_folder v_dirt)
	(object_create_folder sc_dirt)
	(object_create_folder cr_dirt)

	(f_dirt_place_vehicles)

	(pose_body sc_dirt_marine_1 pose_on_back_var1)
	(pose_body sc_dirt_marine_2 pose_on_back_var2)

)
(script static void f_objects_dirt_destroy

	(f_dirt_erase_vehicles)

	(object_destroy_folder eq_dirt)
	(object_destroy_folder dc_dirt)
	(object_destroy_folder dm_dirt_scarabs)
	(object_destroy_folder w_dirt)
	(object_destroy_folder v_dirt)
	(object_destroy_folder sc_dirt)
	(object_destroy_folder cr_dirt)

)

; objects block
(script static void f_objects_block_create

	(dprint "creating block objects")

	(object_create_folder dm_block)
	(object_create_folder dc_block)
	(object_create_folder v_block)
	(object_create_folder sc_block)
	(object_create_folder cr_block)

	(pose_body sc_block_marine_1 pose_against_wall_var4)

)

(script static void f_objects_block_destroy

	(object_destroy_folder dm_block)
	(object_destroy_folder dc_block)
	(object_destroy_folder v_block)
	(object_destroy_folder sc_block)
	(object_destroy_folder cr_block)

)

; objects cave
(script static void f_objects_cave_create

	(object_create_folder w_cave)
	(object_create_folder sc_cave)
	(object_create_folder cr_cave)
	(object_create_folder dc_cave)	
	(object_create_folder eq_cave)

	(pose_body sc_cave_marine_1 pose_against_wall_var4)
	(pose_body sc_cave_marine_2 pose_face_down_var2)
	(pose_body sc_cave_marine_3 pose_on_side_var3)

)

(script static void f_objects_cave_destroy

	(object_destroy_folder w_cave)
	(object_destroy_folder sc_cave)
	(object_destroy_folder dc_cave)	
	(object_destroy_folder eq_cave)
	(object_destroy_folder cr_cave)

)

; objects bone
(script static void f_objects_bone_create

	(object_create_folder dt_bone)
	(object_create_folder eq_bone)
	(object_create_folder dc_bone)
	(object_create_folder dm_bone)
	(object_create_folder w_bone)
	(object_create_folder v_bone)
	(object_create_folder sc_bone)
	(object_create_folder cr_bone)

	(if (difficulty_is_legendary) (object_create dt_term_2) (object_destroy dt_term_2) )

	(pose_body sc_bone_marine_1 pose_on_back_var3)
	(pose_body sc_bone_marine_2 pose_on_back_var2)
	(pose_body sc_bone_marine_3 pose_face_down_var2)

)

(script static void f_objects_bone_destroy

	(object_destroy_folder dt_bone)
	(object_destroy_folder eq_bone)
	(object_destroy_folder dc_bone)
	(object_destroy_folder dm_bone)
	(object_destroy_folder w_bone)
	(object_destroy_folder v_bone)
	(object_destroy_folder sc_bone)
	(object_destroy_folder cr_bone)

)

; objects hall_1
(script static void f_objects_hall_1_create

	(object_create_folder dt_hall_1)
	(object_create_folder w_hall_1)
	(object_create_folder cr_hall_1)
	(object_create_folder dm_hall_1)
	(object_create_folder sc_hall_1)

	(if (difficulty_is_normal_or_higher) (object_create dt_term_1) (object_destroy dt_term_1) )

	(pose_body sc_hall1_marine_1 pose_against_wall_var4)
	(pose_body sc_hall1_marine_2 pose_on_side_var2)

)


(script static void f_objects_hall_1_destroy

	(object_create_folder dt_hall_1)
	(object_destroy_folder w_hall_1)
	(object_destroy_folder cr_hall_1)
	(object_destroy_folder dm_hall_1)
	(object_destroy_folder sc_hall_1)

)

; objects smelt
(script static void f_objects_smelt_create

	(object_create_folder dc_smelt)
	(object_create_folder w_smelt)
	(object_create_folder sc_smelt)
	(object_create_folder cr_smelt)
	(object_create_folder eq_smelt)

	(pose_body sc_smelt_marine_1 pose_on_side_var1)
	(pose_body sc_smelt_marine_2 pose_face_down_var2)

)

(script static void f_objects_smelt_destroy

	(object_destroy_folder dc_smelt)
	(object_destroy_folder w_smelt)
	(object_destroy_folder sc_smelt)
	(object_destroy_folder cr_smelt)
	(object_destroy_folder eq_smelt)

)

; objects hall_2
(script static void f_objects_hall_2_create

	(object_create_folder cr_hall_2)
	(object_create_folder sc_hall_2)

)

(script static void f_objects_hall_2_destroy

	(object_destroy_folder cr_hall_2)
	(object_destroy_folder sc_hall_2)

)

; objects final_0
(script static void f_objects_final_0_create

	(object_create_folder dm_final_0)
	(object_create_folder eq_final_0)
	(object_create_folder dc_final_0)
	(object_create_folder sc_final_0)
	(object_create_folder w_final_0)
	(object_create_folder cr_final_0)

	(pose_body sc_final_0_marine_1 pose_on_back_var2)
	(pose_body sc_final_0_marine_2 pose_on_side_var2)

)
(script static void f_objects_final_0_destroy

	(object_destroy_folder dm_final_0)
	(object_destroy_folder eq_final_0)
	(object_destroy_folder dc_final_0)
	(object_destroy_folder sc_final_0)
	(object_destroy_folder w_final_0)
	(object_destroy_folder cr_final_0)

)

; objects final_2
(script static void f_objects_final_2_create

	(object_create_folder dm_final_2)
	(object_create_folder w_final_2)
	(object_create_folder sc_final_2)
	(object_create_folder cr_final_2)
	(object_create_folder eq_final_2)
	(object_create_folder dc_final_2)

	(pose_body sc_final_2_marine_1 pose_against_wall_var1)
	(pose_body sc_final_2_marine_2 pose_against_wall_var2)
	(pose_body sc_final_2_marine_3 pose_face_down_var2)

	(scenery_animation_start sc_final_2_emile objects\characters\spartans_ai\spartans_ai m70:emile_dead)
	(scenery_animation_start sc_final_2_elite_1 objects\characters\elite_ai\elite_ai m70:zealot_dead_b)
	(scenery_animation_start sc_final_2_elite_2 objects\characters\elite_ai\elite_ai m70:zealot_dead_a)

	(if
		(game_is_cooperative)
		(begin
			(object_create sc_cannon_case_1)
			(object_create sc_cannon_case_2)
			(object_create w_cannon_splaser_1)
			(object_create w_cannon_splaser_2)
			(object_create w_cannon_splaser_3)
			(object_create w_cannon_splaser_4)
		)
	)

)

(script static void f_objects_final_2_destroy

	(object_destroy_folder dm_final_2)
	(object_destroy_folder w_final_2)
	(object_destroy_folder sc_final_2)
	(object_destroy_folder cr_final_2)
	(object_destroy_folder eq_final_2)
	(object_destroy_folder dc_final_2)

)

(script static void f_objects_global_destroy

	(object_destroy_folder dm_global)
	(object_destroy_folder sc_global)

)

(global boolean b_game_safe_to_respawn true)
(script continuous f_rule_volumes

	(set b_game_safe_to_respawn true)

	(cond
		((volume_test_players tv_rule_bridge)
			(begin
				(game_save_cancel)
				(set b_game_safe_to_respawn false)
			)
		)
	)
	
	(if b_game_safe_to_respawn
		(game_safe_to_respawn true)
		(game_safe_to_respawn false)
	)

)


(global boolean b_shake false)
(script continuous f_shake_control

	(sleep_until
		(begin
			(sleep_until b_shake)
			(set b_shake false)
			(player_effect_set_max_rotation 0 1 0.25)
			(player_effect_set_max_rumble 1 1)     
			(player_effect_start .70 .1)                                                        
			(sleep 90)
			(player_effect_stop .5)
			false
		)
	1)

)

; =================================================================================================
; =================================================================================================
; start
; =================================================================================================
; =================================================================================================

(script static void start

	; handle intro cinematic


	; figure out what insertion point to use
	(cond
		((= (game_insertion_point_get) 0) (ins_dirt))
		((= (game_insertion_point_get) 1) (ins_block))
		((= (game_insertion_point_get) 2) (ins_wall))
		((= (game_insertion_point_get) 3) (ins_crane))
		((= (game_insertion_point_get) 4) (ins_platform))
		((= (game_insertion_point_get) 5) (f_test_carterdeath))
		((= (game_insertion_point_get) 6) (f_test_finalbattle))
		((= (game_insertion_point_get) 7) (f_test_scarabdrop))
		((= (game_insertion_point_get) 8) (f_test_cruiser))
	)
)

; =================================================================================================
; =================================================================================================
; dirtroad
; =================================================================================================
; =================================================================================================

(script dormant f_dirt_objective_control

	(dprint "::: dirtroad encounter :::")
	(set b_dirt_ready true)

	; standard scripts	
	(wake f_dirt_title_control)
	(wake f_dirt_missionobj_control)
	(wake f_dirt_waypoint_control)
	(wake f_dirt_hilite_control)
	(wake f_dirt_music_control)
	(wake f_dirt_md_control)
	(wake f_dirt_save_control)
	(wake f_dirt_spawn_control)
	(wake f_dirt_cleanup_control)

	; encounter scripts
	(wake f_dirt_emile_control)
	(wake f_dirt_cov_alerted)
	(wake f_dirt_ridge_patrol_listen)

	(sleep_forever f_insertion_fade_in)
	(cinematic_exit 070la_carter true)

	(sleep_until (volume_test_players tv_dirt_10) 1)
	(dprint "objective control : dirtroad.10")
	(set objcon_dirt 10)

	(soft_ceiling_enable camera_blocker_01 false)

	(sleep_until (volume_test_players tv_dirt_20) 1)
	(dprint "objective control : dirtroad.20")
	(set objcon_dirt 20)

	(sleep_until (volume_test_players tv_dirt_30) 1)
	(dprint "objective control : dirtroad.30")
	(set objcon_dirt 30)

	(sleep_until (volume_test_players tv_dirt_40) 1)
	(dprint "objective control : dirtroad.40")
	(set objcon_dirt 40)

	(sleep_until (volume_test_players tv_dirt_50) 1)
	(dprint "objective control : dirtroad.50")
	(set objcon_dirt 50)

	(sleep_until (volume_test_players tv_dirt_55) 1)
	(dprint "objective control : dirtroad.55")
	(set objcon_dirt 55)

	(sleep_until (volume_test_players tv_dirt_60) 1)
	(dprint "objective control : dirtroad.60")
	(set objcon_dirt 60)

	(sleep_until (volume_test_players tv_dirt_70) 1)
	(dprint "objective control : dirtroad.70")
	(set objcon_dirt 70)

)


(script command_script f_cs_dirt_carter

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_boost true)

	(effect_new_on_object_marker_loop objects\vehicles\human\pelican\fx\destruction\pelican_damage.effect (ai_vehicle_get_from_starting_location sq_pelican_carter/dirt)  "fx_m70_wing_r_damage")

	; enter
	;--------------------------------------------
	(cs_fly_by ps_dirt_carter_chase/carter_exit_01a)
	(cs_vehicle_boost true)
	(cs_fly_by ps_dirt_carter_chase/carter_exit_01b)
	(cs_fly_by ps_dirt_carter_chase/carter_exit_01c)
	(cs_fly_by ps_dirt_carter_chase/carter_exit_01d)
	(cs_fly_by ps_dirt_carter_chase/carter_exit_01)
	(cs_fly_by ps_dirt_carter_chase/carter_exit_02)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(cs_fly_by ps_dirt_carter_chase/carter_erase)

	(effect_stop_object_marker objects\vehicles\human\pelican\fx\destruction\pelican_damage.effect (ai_vehicle_get_from_starting_location sq_pelican_carter/dirt) "fx_m70_wing_r_damage")

	(ai_erase ai_current_squad)

)


(script command_script f_cs_dirt_banshee_1

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_looking true)
	(cs_enable_targeting true)

	(cs_vehicle_speed 1.8)

	; enter
	;--------------------------------------------
	(cs_fly_by ps_dirt_carter_chase/banshee_1_exit_01a)
	(cs_fly_by ps_dirt_carter_chase/banshee_1_exit_01b)
	(cs_vehicle_boost true)
	(cs_fly_by ps_dirt_carter_chase/banshee_1_exit_01c)
	(cs_vehicle_boost false)
	(cs_fly_by ps_dirt_carter_chase/banshee_1_exit_01d)
	(cs_vehicle_boost true)
	(cs_fly_by ps_dirt_carter_chase/banshee_1_exit_01)
	(cs_vehicle_boost false)
	(cs_fly_by ps_dirt_carter_chase/banshee_1_exit_02)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(cs_fly_by ps_dirt_carter_chase/banshee_1_erase)
	(ai_erase ai_current_squad)

)



(script command_script f_cs_dirt_banshee_2

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_looking true)
	(cs_enable_targeting true)

	(cs_vehicle_speed 1.8)

	; enter
	;--------------------------------------------

	(cs_fly_by ps_dirt_carter_chase/banshee_2_exit_01a)
	(cs_fly_by ps_dirt_carter_chase/banshee_2_exit_01b)
	(cs_vehicle_boost true)
	(cs_fly_by ps_dirt_carter_chase/banshee_2_exit_01c)
	(cs_vehicle_boost false)
	(cs_fly_by ps_dirt_carter_chase/banshee_2_exit_01d)
	(cs_vehicle_boost true)
	(cs_fly_by ps_dirt_carter_chase/banshee_2_exit_01)
	(cs_vehicle_boost false)
	(cs_fly_by ps_dirt_carter_chase/banshee_2_exit_02)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(cs_fly_by ps_dirt_carter_chase/banshee_2_erase)
	(ai_erase ai_current_squad)

)



(global short s_dirt_elite_patrol_point 0)
(script command_script f_cs_dirt_elite_patrol

	(cs_walk true)
	(cs_abort_on_damage true)

	(sleep_until
		(begin

			(set s_dirt_elite_patrol_point (random_range 0 4))
			(if (= s_dirt_elite_patrol_point 0) (begin (cs_go_to_and_face ps_dirt_elite_patrol/p0 ps_dirt_elite_patrol/p0_face) (sleep (* 30 2) ) ) )
			(if (= s_dirt_elite_patrol_point 1) (begin (cs_go_to_and_face ps_dirt_elite_patrol/p1 ps_dirt_elite_patrol/p1_face) (sleep (* 30 2) ) ) )
			(if (= s_dirt_elite_patrol_point 2) (begin (cs_go_to_and_face ps_dirt_elite_patrol/p2 ps_dirt_elite_patrol/p2_face) (sleep (* 30 2) ) ) )
			(if (= s_dirt_elite_patrol_point 3) (begin (cs_go_to ps_dirt_elite_patrol/p3) (sleep (* 30 2) ) ) )

		(>= (ai_combat_status obj_dirt_cov) 3) )	
	)

)

(script static void f_dirt_place_vehicles

	(ai_place sq_mongoose_new_0a)
	(ai_place sq_mongoose_new_0)
	(ai_place sq_mongoose_new_1)
	(ai_place sq_mongoose_new_2)
	(ai_place sq_mongoose_new_3)

	(ai_squad_enumerate_immigrants sq_mongoose_new_0 true)
	(ai_squad_enumerate_immigrants sq_mongoose_new_1 true)
	(ai_squad_enumerate_immigrants sq_mongoose_new_2 true)
	(ai_squad_enumerate_immigrants sq_mongoose_new_3 true)

)

(script static void f_dirt_erase_vehicles

	(ai_erase sq_mongoose_new_0)
	(ai_erase sq_mongoose_new_1)
	(ai_erase sq_mongoose_new_2)
	(ai_erase sq_mongoose_new_3)

)

(script dormant f_dirt_hilite_control

	(sleep_until (>= objcon_dirt 20) 5)
	
	(sleep 120)

	(sleep_until
		(or
			(objects_can_see_object player0 sc_pillar_hilite_pillar_marker 25)
			(objects_can_see_object player1 sc_pillar_hilite_pillar_marker 25)
			(objects_can_see_object player2 sc_pillar_hilite_pillar_marker 25)
			(objects_can_see_object player3 sc_pillar_hilite_pillar_marker 25)
		)
	1)

	(f_hud_flash_object sc_pillar_hilite_pillar)
	(object_destroy sc_pillar_hilite_pillar)

)

(script dormant f_dirt_title_control

	(sleep_until (>= objcon_dirt 20) 5)
	(tit_dirt)

)

(script dormant f_dirt_missionobj_control

	(sleep_until (>= objcon_dirt 20) 5)
	(sleep 220)
	(mo_dirtroad)

)

(global short s_dirt_waypoint_timer 180)
(script dormant f_dirt_waypoint_control

	; nonlinear
	(wake f_dirt_waypoint_goose)

)

(script dormant f_dirt_waypoint_goose

	(branch
		(or
			(>= objcon_drop 1)
			(player_in_vehicle (ai_vehicle_get_from_spawn_point sq_mongoose_player_0/sp_dirt_shack))
			(player_in_vehicle (ai_vehicle_get_from_spawn_point sq_mongoose_emile/sp_dirt_shack))
		)
		(f_dirt_waypoint_goose_end)
	)

	(sleep_until (>= objcon_dirt 20))
	(sleep (* 30 s_dirt_waypoint_timer))
	
	(if
		(not
			(or 
				(>= objcon_drop 1)
				(player_in_vehicle (ai_vehicle_get_from_spawn_point sq_mongoose_player_0/sp_dirt_shack))
				(player_in_vehicle (ai_vehicle_get_from_spawn_point sq_mongoose_emile/sp_dirt_shack))
			)
		)
		(f_blip_object (ai_vehicle_get_from_spawn_point sq_mongoose_player_0/sp_dirt_shack) blip_ordnance)
	)
	

)

(script static void f_dirt_waypoint_goose_end

	(f_unblip_object (ai_vehicle_get_from_spawn_point sq_mongoose_player_0/sp_dirt_shack))

)

(script dormant f_dirt_md_control

	(f_abort_md)

	; linear
	; ---------------

	(sleep_until b_dirt_ready 1)
	(sleep (* 30 9))
	(md_dirt_drop)

	(sleep_until b_dirt_emile_look 1 (* 30 20))
	(md_dirt_look)

	; delay for overlook
	(sleep_until (>= objcon_dirt 30) 1 (* 30 60))
	(if (not (>= objcon_dirt 30))
		(begin
			(md_dirt_look_delay_0)
		)
	)

	(sleep_until (>= objcon_dirt 30) 1 (* 30 60))
	(if (not (>= objcon_dirt 30))
		(begin
			(md_dirt_look_delay_1)
		)
	)

	(sleep_until (>= objcon_dirt 30) 1)

	; delay for bridge
	(sleep_until (>= objcon_dirt 50) 1 (* 30 120))
	(if (not (>= objcon_dirt 50))
		(begin
			(md_dirt_bridge_delay)
		)
	)


)

(global boolean b_dirt_cov_alerted false)
(script dormant f_dirt_cov_alerted

	(sleep_until (>= (ai_combat_status obj_dirt_cov) 3))
	(dprint "dirt squads alerted")
	(tick)
	(ai_set_task sq_dirt_elite_convoy_1 obj_dirt_cov convoy_elite_1_main)
	(tick)
	(set b_dirt_cov_alerted true)
	(tick)
	(ai_squad_patrol_enable obj_dirt_sp_wreck false)
	(tick)
	(ai_squad_patrol_objective_disallow sq_dirt_elite_convoy_1 true)
	(thespian_performance_kill_by_name "th_dirt_grunt_check_1")
	(thespian_performance_kill_by_name "th_dirt_grunt_check_2")
	(thespian_performance_kill_by_name "th_dirt_grunt_check_3")

)


(global boolean b_ridge_search true)
(script dormant f_dirt_ridge_patrol_listen

	(sleep_until (volume_test_object tv_dirt_ridge_patrol (ai_get_object sq_dirt_elite_convoy_2)) 1)
	(sleep 200)
	(set b_ridge_search false)

)


(script static boolean f_ridge_search

	(= b_ridge_search true)

)


(script dormant f_dirt_save_control

	(wake f_dirt_save_combatend)
	(game_save_immediate)

)

(script dormant f_dirt_save_combatend

	(branch (>= objcon_drop 0) (f_abort))

	(sleep_until (<= (ai_living_count gr_dirt_cov) 0))
	(game_save_no_timeout)

)



(script dormant	f_dirt_music_control

	(wake music_dirt)

)


(script dormant f_dirt_spawn_control


	(ai_place sq_pelican_carter/dirt)
	(ai_place sq_dirt_banshee_1)
	(ai_place sq_dirt_banshee_2)

	(sleep_until (>= objcon_dirt 1))
	(f_squad_group_place gr_dirt_cov_init)

)


; objective control
;============================================

(script static boolean f_dirt_convoy_search

	(<= (ai_combat_status obj_dirt_cov) 3)

)


; emile
;============================================

(global boolean b_dirt_emile_look false)
(global boolean b_dirt_emile_moveon false)
(script dormant f_dirt_emile_control

	(ai_set_deaf sq_emile true)
	(ai_set_blind sq_emile true)
	(sleep_until b_dirt_emile_moveon 5 (* 30 20))
	(ai_set_deaf sq_emile false)
	(ai_set_blind sq_emile false)

)


(script dormant f_dirt_cleanup_control

	(sleep_until (volume_test_players tv_dirt_cleanup) 5)
	(f_dirt_despawn_all)
	(f_dirt_kill_scripts)

)

(script static void f_dirt_despawn_all

	(ai_erase gr_dirt_cov)
	(ai_erase gr_goose_cov)

)

(script static void f_dirt_kill_scripts

	(sleep_forever f_dirt_objective_control)
	(sleep_forever f_dirt_spawn_control)
	(sleep_forever f_dirt_save_combatend)
	(sleep_forever f_dirt_save_control)
	(sleep_forever f_dirt_ridge_patrol_listen)
	(sleep_forever f_dirt_cov_alerted)
	(sleep_forever f_dirt_md_control)
	(sleep_forever f_dirt_waypoint_goose)
	(sleep_forever f_dirt_waypoint_goose_end)
	(sleep_forever f_dirt_missionobj_control)
	(sleep_forever f_dirt_waypoint_control)
	(sleep_forever f_dirt_title_control)
	(sleep_forever f_dirt_hilite_control)
	(sleep_forever f_dirt_emile_control)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	
)


; =================================================================================================
; =================================================================================================
; mongoose
; =================================================================================================
; =================================================================================================


(script dormant f_goose_objective_control
	(dprint "::: mongoose encounter :::")
	
	; wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))
	
	(set b_goose_ready true)

	; standard scripts
	(wake f_goose_save_control)
	(wake f_goose_waypoint_control)
	(wake f_goose_md_control)
	(wake f_goose_cleanup_control)
	(wake f_goose_spawn_control)

	; encounter scripts
	(wake f_goose_emile_control)
	(wake f_mongoose_findnew)
	(wake f_goose_birds)

	(set b_insertion_fade_in true)

	(dprint "objective control : mongoose.1")
	(set objcon_goose 1)

	(sleep_until (volume_test_players tv_goose_10) 1)
	(dprint "objective control : mongoose.10")
	(set objcon_goose 10)

	(sleep_until (volume_test_players tv_goose_15) 1)
	(dprint "objective control : mongoose.15")
	(set objcon_goose 15)

	(sleep_until (volume_test_players tv_goose_17) 1)
	(dprint "objective control : mongoose.17")
	(set objcon_goose 17)

	(sleep_until (volume_test_players tv_goose_20) 1)
	(dprint "objective control : mongoose.20")
	(set objcon_goose 20)

	(sleep_until (volume_test_players tv_goose_25) 1)
	(dprint "objective control : mongoose.25")
	(set objcon_goose 25)
	
	(soft_ceiling_enable camera_blocker_02 false)

	(sleep_until (volume_test_players tv_goose_30) 1)
	(dprint "objective control : mongoose.30")
	(set objcon_goose 30)

)

(script dormant f_goose_spawn_control

	(sleep_until (>= objcon_goose 1) 1)
	(f_squad_group_place gr_goose_cov_banshees)

)


(script dormant f_goose_birds

	(sleep_until (>= objcon_goose 17) 1)
	(dprint "birds")
	(flock_create flc_goose_birds_01)

)


(script dormant f_goose_save_control

	(game_save_no_timeout)

)

(global short s_goose_waypoint_timer 30)
(script dormant f_goose_waypoint_control

	; nonlinear

	; linear
	(sleep_until (>= objcon_goose 10))

	(sleep_until (>= objcon_goose 25) 5 (* 30 s_goose_waypoint_timer))
	(if (not (>= objcon_goose 25))
		(begin
			(f_blip_flag fl_goose_waypoint_1 blip_destination)
			(sleep_until (>= objcon_goose 25) 5)
			(f_unblip_flag fl_goose_waypoint_1)
		)
	)

)

(script dormant f_goose_md_control

	(f_abort_md)

	; conditional
	; ---------------
	; check player not getting on goose
	(wake f_goose_md_goose_delay)

	; linear
	; ---------------
	(sleep_until b_goose_ready 1)
	(md_goose_wheels)

	(sleep_until (>= objcon_goose 10) 1)
	(if (not b_players_any_in_vehicle)
		(begin
			(md_goose_pass)
		)
	)

)

(script dormant f_goose_md_goose_delay

	(branch
		b_players_any_in_vehicle
		(f_abort_md)
	)

	; check player delaying before mongoose
	(sleep (* 30 60))
	(if (not b_players_any_in_vehicle)
		(begin
			(md_goose_wheels_delay_0)
		)
	)

	(sleep (* 30 60))
	(if (not b_players_any_in_vehicle)
		(begin
			(md_goose_wheels_delay_1)
		)
	)

)


(script dormant f_mongoose_findnew

	(branch
		(or
			b_carter_ready
			b_tunnels_ready
			b_wall_ready
			b_factory_ready
			b_crane_ready
			b_catwalk_ready
			b_platform_ready
			b_zealot_ready
			b_cannon_ready
		)
		(f_abort_md)
	)
	
	; loop until branch kills this script
	(sleep_until
		(begin
			; when player enters any tv_goose_new, play a prompt to get on goose
			(sleep_until
				(and
					(or
						(volume_test_players tv_goose_new_0)
						(volume_test_players tv_goose_new_1)
					)
					(not b_players_any_in_vehicle)
				)
			5)
			(md_goose_findnew)
			(sleep 1000)
			(sleep_until
				(not
					(or
						(volume_test_players tv_goose_new_0)
						(volume_test_players tv_goose_new_1)
					)
				)
			)
			false
		)
	5)

)

; emile
;============================================
(script dormant f_goose_emile_control

	(sleep_until
		(or
			(<= (ai_living_count obj_dirt_cov) 2)
			(>= objcon_dirt 60)
		)
	)
	(dprint "mongoose approach")

	(ai_set_objective sq_emile obj_vehicle_hum)

)

(script command_script f_cs_abort

	(sleep 0)

)

(global short s_vehicle_player_pos -1)
(global short s_emile_follow_dist 20)
(global short s_emile_mongoose_progress 0)
(script command_script f_cs_emile_goose_move

	(cs_abort_on_vehicle_exit true)

	(sleep_until

		(begin

				(if (not (vehicle_test_seat_unit (ai_vehicle_get ai_current_actor) "mongoose_d" ai_current_actor)) (cs_run_command_script ai_current_actor f_cs_abort))

				(if (volume_test_players tv_area_dirt_shack) (begin

					(if (volume_test_players tv_vehicle_dirt_1) (set s_vehicle_player_pos 1))
					(if (or (volume_test_players tv_vehicle_dirt_2_1)(volume_test_players tv_vehicle_dirt_2_2)) (set s_vehicle_player_pos 2))
					(if (or (volume_test_players tv_vehicle_dirt_3_1)(volume_test_players tv_vehicle_dirt_3_2)) (set s_vehicle_player_pos 3))
					(if (or (volume_test_players tv_vehicle_dirt_4_1)(volume_test_players tv_vehicle_dirt_4_2)) (set s_vehicle_player_pos 4))
					(if (volume_test_players tv_vehicle_dirt_5) (set s_vehicle_player_pos 5))
					(if (volume_test_players tv_vehicle_dirt_6) (set s_vehicle_player_pos 6))
					(if (volume_test_players tv_vehicle_dirt_7) (set s_vehicle_player_pos 7))
					(if (volume_test_players tv_vehicle_dirt_8) (set s_vehicle_player_pos 8))
					(if (volume_test_players tv_vehicle_dirt_9) (set s_vehicle_player_pos 9))


				))

				(if (volume_test_players tv_area_dirt_bend) (begin

					(if (volume_test_players tv_vehicle_dirt_8) (set s_vehicle_player_pos 8))
					(if (volume_test_players tv_vehicle_dirt_9) (set s_vehicle_player_pos 9))
					(if (volume_test_players tv_vehicle_dirt_10) (set s_vehicle_player_pos 10))
					(if (volume_test_players tv_vehicle_dirt_11) (set s_vehicle_player_pos 11))
					(if (volume_test_players tv_vehicle_dirt_12) (set s_vehicle_player_pos 12))
					(if (volume_test_players tv_vehicle_drop_13) (set s_vehicle_player_pos 13))
					(if (or (volume_test_players tv_vehicle_drop_14_1)(volume_test_players tv_vehicle_drop_14_2)) (set s_vehicle_player_pos 14))
					(if (or (volume_test_players tv_vehicle_drop_15_1)(volume_test_players tv_vehicle_drop_15_2)) (set s_vehicle_player_pos 15))


				))

				(if (volume_test_players tv_area_drop_scarab) (begin

					(if (or (volume_test_players tv_vehicle_drop_14_1)(volume_test_players tv_vehicle_drop_14_2)) (set s_vehicle_player_pos 14))
					(if (or (volume_test_players tv_vehicle_drop_15_1)(volume_test_players tv_vehicle_drop_15_2)) (set s_vehicle_player_pos 15))
					(if (or (volume_test_players tv_vehicle_drop_16_1)(volume_test_players tv_vehicle_drop_16_2)(volume_test_players tv_vehicle_drop_16_3)(volume_test_players tv_vehicle_drop_16_4)) (set s_vehicle_player_pos 16))
					(if (or (volume_test_players tv_vehicle_drop_17_1)(volume_test_players tv_vehicle_drop_17_2)(volume_test_players tv_vehicle_drop_17_3)) (set s_vehicle_player_pos 17))
					(if (volume_test_players tv_vehicle_drop_18) (set s_vehicle_player_pos 18))
					(if (volume_test_players tv_vehicle_drop_19) (set s_vehicle_player_pos 19))
					(if (volume_test_players tv_vehicle_drop_20) (set s_vehicle_player_pos 20))
					(if (volume_test_players tv_vehicle_drop_21) (set s_vehicle_player_pos 21))
					(if (volume_test_players tv_vehicle_drop_22) (set s_vehicle_player_pos 22))
					(if (volume_test_players tv_vehicle_drop_23) (set s_vehicle_player_pos 23))
					(if (volume_test_players tv_vehicle_drop_24) (set s_vehicle_player_pos 24))
					(if (volume_test_players tv_vehicle_drop_25) (set s_vehicle_player_pos 25))
					(if (volume_test_players tv_vehicle_block_26) (set s_vehicle_player_pos 26))
					(if (volume_test_players tv_vehicle_block_27) (set s_vehicle_player_pos 27))

				))

				(if (volume_test_players tv_area_block_cliff) (begin

					(if (volume_test_players tv_vehicle_block_26) (set s_vehicle_player_pos 26))
					(if (volume_test_players tv_vehicle_block_27) (set s_vehicle_player_pos 27))
					(if (volume_test_players tv_vehicle_block_28) (set s_vehicle_player_pos 28))
					(if (volume_test_players tv_vehicle_block_29) (set s_vehicle_player_pos 29))
					(if (volume_test_players tv_vehicle_block_30) (set s_vehicle_player_pos 30))
					(if (volume_test_players tv_vehicle_block_31) (set s_vehicle_player_pos 31))
					(if (volume_test_players tv_vehicle_block_32) (set s_vehicle_player_pos 32))
					(if (or (volume_test_players tv_vehicle_block_33_1)(volume_test_players tv_vehicle_block_33_2)) (set s_vehicle_player_pos 33))
					(if (volume_test_players tv_vehicle_block_34) (set s_vehicle_player_pos 34))

				))

				(if (or (volume_test_players tv_area_block_jump)(volume_test_players tv_area_block_gulch)) (begin

					(if (or (volume_test_players tv_vehicle_block_33_1)(volume_test_players tv_vehicle_block_33_2)) (set s_vehicle_player_pos 33))
					(if (volume_test_players tv_vehicle_block_34) (set s_vehicle_player_pos 34))
					(if (volume_test_players tv_vehicle_block_35) (set s_vehicle_player_pos 35))
					(if (volume_test_players tv_vehicle_block_36) (set s_vehicle_player_pos 36))
					(if (or (volume_test_players tv_vehicle_block_37)(volume_test_players tv_area_block_gulch)) (set s_vehicle_player_pos 37))

				))
				
				; emile

				(if (volume_test_object tv_area_dirt_shack ai_current_actor) (begin

					(if (and (volume_test_object tv_vehicle_dirt_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 0))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 2))))(cs_go_to ps_vehicle_dirt/1 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_2_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 1))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 3))))(cs_go_to ps_vehicle_dirt/2_1 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_2_2 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 1))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 3))))(cs_go_to ps_vehicle_dirt/2_2 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_3_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 2))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 4))))(cs_go_to ps_vehicle_dirt/3_1 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_3_2 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 2))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 4))))(cs_go_to ps_vehicle_dirt/3_2 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_4_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 3))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 5))))(cs_go_to ps_vehicle_dirt/4_1 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_4_2 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 3))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 5))))(cs_go_to ps_vehicle_dirt/4_2 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_5 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 4))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 6))))(cs_go_to ps_vehicle_dirt/5 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_6 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 5))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 7))))(cs_go_to ps_vehicle_dirt/6 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_7 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 6))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 8))))(cs_go_to ps_vehicle_dirt/7 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_8 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 7))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 9))))(cs_go_to ps_vehicle_dirt/8 .25) )

				))

				(if (volume_test_object tv_area_dirt_bend ai_current_actor) (begin

					(if (and (volume_test_object tv_vehicle_dirt_7 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 6))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 8))))(cs_go_to ps_vehicle_dirt/7 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_8 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 7))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 9))))(cs_go_to ps_vehicle_dirt/8 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_9 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 8))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 10))))(cs_go_to ps_vehicle_dirt/9 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_10 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 9))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 11))))(cs_go_to ps_vehicle_dirt/10 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_11 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 10))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 12))))(cs_go_to ps_vehicle_drop/11 .25) )
					(if (and (volume_test_object tv_vehicle_dirt_12 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 11))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 13))))(cs_go_to ps_vehicle_drop/12 .25) )
					(if (and (volume_test_object tv_vehicle_drop_13 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 12))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 14))))(cs_go_to ps_vehicle_drop/13 .25) )
					(if (and (volume_test_object tv_vehicle_drop_14_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 13))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 15))))(cs_go_to ps_vehicle_drop/14_1 .25) )
				
				))

				(if (volume_test_object tv_area_drop_scarab ai_current_actor) (begin
				
					(if (and (volume_test_object tv_vehicle_drop_14_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 13))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 15))))(cs_go_to ps_vehicle_drop/14_1 .25) )
					(if (and (volume_test_object tv_vehicle_drop_14_2 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 13))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 15))))(cs_go_to ps_vehicle_drop/14_2 .25) )
					(if (and (volume_test_object tv_vehicle_drop_15_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 14))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 16))))(cs_go_to ps_vehicle_drop/15_1 .25) )
					(if (and (volume_test_object tv_vehicle_drop_15_2 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 14))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 16))))(cs_go_to ps_vehicle_drop/15_2 .25) )
					(if (and (volume_test_object tv_vehicle_drop_16_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 15))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 17))))(cs_go_to ps_vehicle_drop/16_1 .25) )
					(if (and (volume_test_object tv_vehicle_drop_16_2 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 15))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 17))))(cs_go_to ps_vehicle_drop/16_2 .25) )
					(if (and (volume_test_object tv_vehicle_drop_16_3 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 15))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 17))))(cs_go_to ps_vehicle_drop/16_3 .25) )
					(if (and (volume_test_object tv_vehicle_drop_16_4 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 15))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 17))))(cs_go_to ps_vehicle_drop/16_4 .25) )
					(if (and (volume_test_object tv_vehicle_drop_17_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 16))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 18))))(cs_go_to ps_vehicle_drop/17_1 .25) )
					(if (and (volume_test_object tv_vehicle_drop_17_2 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 16))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 18))))(cs_go_to ps_vehicle_drop/17_2 .25) )
					(if (and (volume_test_object tv_vehicle_drop_17_3 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 16))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 18))))(cs_go_to ps_vehicle_drop/17_3 .25) )
					(if (and (volume_test_object tv_vehicle_drop_18 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 17))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 19))))(cs_go_to ps_vehicle_drop/18 .25) )
					(if (and (volume_test_object tv_vehicle_drop_19 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 18))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 20))))(cs_go_to ps_vehicle_drop/19 .25) )
					(if (and (volume_test_object tv_vehicle_drop_20 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 19))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 21))))(cs_go_to ps_vehicle_drop/20 .25) )
					(if (and (volume_test_object tv_vehicle_drop_21 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 20))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 22))))(cs_go_to ps_vehicle_drop/21 .25) )
					(if (and (volume_test_object tv_vehicle_drop_22 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 21))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 23))))(cs_go_to ps_vehicle_drop/22 .25) )
					(if (and (volume_test_object tv_vehicle_drop_23 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 22))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 24))))(cs_go_to ps_vehicle_drop/23 .25) )
					(if (and (volume_test_object tv_vehicle_drop_24 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 23))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 25))))(cs_go_to ps_vehicle_drop/24 .25) )
					(if (and (volume_test_object tv_vehicle_drop_25 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 24))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 26))))(cs_go_to ps_vehicle_drop/25 .25) )
					(if (and (volume_test_object tv_vehicle_block_26 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 25))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 27))))(cs_go_to ps_vehicle_drop/26 .25) )
					
				))

				(if (volume_test_object tv_area_block_cliff ai_current_actor) (begin

					(if (and (volume_test_object tv_vehicle_drop_25 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 24))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 26))))(cs_go_to ps_vehicle_drop/25 .25) )
					(if (and (volume_test_object tv_vehicle_block_26 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 25))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 27))))(cs_go_to ps_vehicle_drop/26 .25) )
					(if (and (volume_test_object tv_vehicle_block_27 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 26))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 28))))(cs_go_to ps_vehicle_drop/27 .25) )
					(if (and (volume_test_object tv_vehicle_block_28 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 27))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 29))))(cs_go_to ps_vehicle_block/28 .25) )
					(if (and (volume_test_object tv_vehicle_block_29 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 28))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 30))))(cs_go_to ps_vehicle_block/29 .25) )
					(if (and (volume_test_object tv_vehicle_block_30 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 29))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 31))))(cs_go_to ps_vehicle_block/30 .25) )
					(if (and (volume_test_object tv_vehicle_block_31 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 30))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 32))))(cs_go_to ps_vehicle_block/31 .25) )
					(if (and (volume_test_object tv_vehicle_block_32 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 31))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 33))))(cs_go_to ps_vehicle_block/32 .25) )
					(if (and (volume_test_object tv_vehicle_block_33_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 32))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 34))))(cs_go_to ps_vehicle_block/33_1 .25) )

				))

				(if (volume_test_object tv_area_block_jump ai_current_actor) (begin

					(if (and (volume_test_object tv_vehicle_block_32 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 31))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 33))))(cs_go_to ps_vehicle_block/32 .25) )
					(if (and (volume_test_object tv_vehicle_block_33_1 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 32))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 34)))) (cs_go_to ps_vehicle_block/33_1 .25) )
					(if (and (volume_test_object tv_vehicle_block_33_2 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 32))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 34))))(cs_go_to ps_vehicle_block/33_2 .25) )
					(if (and (volume_test_object tv_vehicle_block_34 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 32))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 34))))(cs_go_to ps_vehicle_block/34 .25) )
					(if (and (volume_test_object tv_vehicle_block_35 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 32))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 34))))(begin (set b_emile_boost true)(cs_move_towards_point ps_vehicle_block/35 1) ) )
					(if (and (volume_test_object tv_vehicle_block_36 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 32))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 34))))(cs_go_to ps_vehicle_block/36 .25) )
					(if (and (volume_test_object tv_vehicle_block_37 ai_current_actor) (or (and b_players_any_in_vehicle (>= s_vehicle_player_pos 32))(and (not b_players_any_in_vehicle)(>= s_vehicle_player_pos 34))))(cs_run_command_script ai_current_actor f_cs_abort) )

				))

		false)
	
	1)

)

(global boolean b_emile_boost false)
(script dormant f_emile_boost

	(sleep_until b_emile_boost 1)
	(sleep 25)

	(if (player_in_vehicle (ai_vehicle_get_from_squad sq_emile 0))
		(begin
			(dprint "emile player boost")
			(object_set_velocity (ai_vehicle_get_from_squad sq_emile 0) 16)
			(sleep 10)
			(object_set_velocity (ai_vehicle_get_from_squad sq_emile 0) 16)
		)
		(begin
			(dprint "emile solo boost")
			(object_set_velocity (ai_vehicle_get_from_squad sq_emile 0) 16)
			(sleep 10)
			(object_set_velocity (ai_vehicle_get_from_squad sq_emile 0) 16)
		)
	)

)

(script command_script f_cs_emile_goose_mount

	(cs_enable_looking true)
	(cs_enable_moving true)
	(cs_enable_targeting true)
	(ai_enter_squad_vehicles gr_hum)

)


(script static void f_goose_emile_wait

	(sleep_until (<= (objects_distance_to_object (ai_get_object sq_emile) player0) s_emile_follow_dist) 5 500)

)

(script dormant f_goose_cleanup_control

	(sleep_until (volume_test_players tv_goose_cleanup) 5)
	(f_goose_kill_scripts)
	(f_goose_despawn_all)

)

(script static void f_goose_kill_scripts

	(sleep_forever f_goose_objective_control)
	(sleep_forever f_goose_save_control)
	(sleep_forever f_goose_waypoint_control)
	(sleep_forever f_goose_md_control)
	(sleep_forever f_mongoose_findnew)
	(sleep_forever f_goose_md_goose_delay)
	(sleep_forever f_goose_emile_control)
	(sleep_forever f_goose_birds)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

(script static void f_goose_despawn_all

	(ai_erase gr_goose_cov)

)


; =================================================================================================
; =================================================================================================
; scarabdrop
; =================================================================================================
; =================================================================================================

(script dormant f_drop_objective_control
	(dprint "::: scarab drop encounter :::")
	
	; wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))
	
	(set b_drop_ready true)

	; standard scripts
	(wake f_drop_save_control)
	(wake f_drop_waypoint_control)
	(wake f_drop_spawn_control)
	(wake f_drop_cleanup_control)
	(wake f_drop_music_control)
	(wake f_drop_md_control)
	(wake f_drop_emile_control)

	; encounter scripts
	(wake f_drop_scarabs_start)
	(wake f_drop_pods_control)

	(set b_insertion_fade_in true)
	
	(sleep_until (volume_test_players tv_drop_10) 1)
	(dprint "objective control : scarabdrop.10")
	(set objcon_drop 10)

	(sleep_until (volume_test_players tv_drop_20) 1)
	(dprint "objective control : scarabdrop.20")
	(set objcon_drop 20)

	(sleep_until (volume_test_players tv_drop_30) 1)
	(dprint "objective control : scarabdrop.30")
	(set objcon_drop 30)

	(sleep_until (volume_test_players tv_drop_35) 1)
	(dprint "objective control : scarabdrop.35")
	(set objcon_drop 35)

	(sleep_until (volume_test_players tv_drop_40) 1)
	(dprint "objective control : scarabdrop.40")
	(set objcon_drop 40)

	(sleep_until (volume_test_players tv_drop_45) 1)
	(dprint "objective control : scarabdrop.45")
	(set objcon_drop 45)

	(sleep_until (volume_test_players tv_drop_50) 1)
	(dprint "objective control : scarabdrop.50")
	(set objcon_drop 50)

	(soft_ceiling_enable camera_blocker_03 false)

	(sleep_until (volume_test_players tv_drop_60) 1)
	(dprint "objective control : scarabdrop.60")
	(set objcon_drop 60)

)

(script dormant f_drop_save_control

	(game_save_no_timeout)

)

(global short s_drop_waypoint_timer 90)
(script dormant f_drop_waypoint_control

	; nonlinear

	; linear
	(sleep_until (>= objcon_drop 30))
	(sleep_until (>= objcon_drop 60) 5 (* 30 s_drop_waypoint_timer))
	(if (not (>= objcon_drop 60))
		(begin
			(f_blip_flag fl_drop_waypoint_1 blip_destination)
			(sleep_until (>= objcon_drop 60) 5)
			(f_unblip_flag fl_drop_waypoint_1)
		)
	)

)

(script dormant	f_drop_emile_control

	(sleep 0)

)

(script dormant	f_drop_md_control

	(f_abort_md)

	; linear
	; -----------------
	(sleep_until (>= objcon_drop 30) 1)
	(md_drop_intro)

	(sleep_until (>= objcon_drop 35) 1)
	(md_drop_carter)

	(sleep_until (>= objcon_drop 50) 1 (* 30 90))
	(if (not (>= objcon_drop 50))
		(begin
			(md_drop_delay_0)
		)
	)

	(sleep_until (>= objcon_drop 50) 1 (* 30 90))
	(if (not (>= objcon_drop 50))
		(begin
			(md_drop_delay_1)
		)
	)

)

(script dormant	f_drop_music_control

	(wake music_drop)
	
	(sleep_until (>= objcon_block 5))
	(set s_music_drop 2)

	(sleep_until (volume_test_players tv_area_block_gulch))
	(set s_music_drop 4)

)

(script command_script f_cs_drop_pelican_carter

	(cs_ignore_obstacles true)
	(cs_enable_targeting true)

	; enter
	;--------------------------------------------
	(cs_vehicle_speed 5)

	(effect_new_on_object_marker_loop objects\vehicles\human\pelican\fx\destruction\pelican_damage.effect (ai_vehicle_get_from_starting_location sq_pelican_carter/drop)  "fx_m70_wing_r_damage")

	(cs_fly_to ps_drop_pelican_carter/move_01 .1)
	(cs_fly_to ps_drop_pelican_carter/move_02 .1)
	(cs_fly_to_and_face ps_drop_pelican_carter/move_03 ps_drop_pelican_carter/move_03_face .1)
	(cs_fly_to_and_face ps_drop_pelican_carter/move_04 ps_drop_pelican_carter/move_04_face .1)
	(sleep 120)
	(cs_fly_to_and_face ps_drop_pelican_carter/move_05 ps_drop_pelican_carter/move_05_face .1)
	(cs_fly_to_and_face ps_drop_pelican_carter/move_06 ps_drop_pelican_carter/move_06_face .1)	
	(cs_enable_targeting false)
	(cs_fly_to_and_face ps_drop_pelican_carter/move_07 ps_drop_pelican_carter/move_07_face .1)	
	(cs_fly_to ps_drop_pelican_carter/move_08 .1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(cs_fly_to ps_drop_pelican_carter/erase)

	(effect_stop_object_marker objects\vehicles\human\pelican\fx\destruction\pelican_damage.effect (ai_vehicle_get_from_starting_location sq_pelican_carter/drop) "fx_m70_wing_r_damage")

	(ai_erase ai_current_squad)
	
)

(script dormant f_drop_longsword_control

	(sleep_until (>= objcon_drop 50))
	(f_ls_flyby dm_dirt_longsword_01)
	(sound_impulse_start sound\device_machines\040vc_longsword\start none 1)
	(f_ls_carpetbomb ps_drop_longbomb_1 fx\fx_library\_placeholder\placeholder_explosion 6 10)

)

(script dormant f_drop_spawn_control

	(dprint "::: spawning all scarabdrop squads")
	(sleep_until (volume_test_players tv_drop_drop_1) 1)
	(ai_place sq_pelican_carter/drop)

)


(script dormant f_drop_scarabs_start

	(wake f_drop_scarabs_distance)
	(wake f_drop_scarab_1)
	(wake f_drop_scarab_2)

)


(script dormant f_drop_scarabs_distance

	(sleep_until (volume_test_players tv_drop_drop_1) 1)
	(wake f_drop_scarab_distance_1)
	(wake f_drop_scarab_1_far)
	(sleep 60)
	(wake f_drop_scarab_2_far)
	(sleep 60)
	(sleep_forever f_drop_scarab_distance_1)
	(wake f_drop_scarab_distance_2)
	(wake f_drop_scarab_3_far)

)

(global boolean b_drop_1_scarab_dropped false)
(global short s_drop_scarab_1_loops 0)
(global short s_drop_scarab_1_loop_idx 0)
(global short s_drop_scarab_1_drop_time 0)
(global short s_drop_scarab_1_idlewalk_time 0)
(global short s_drop_scarab_1_walk_time 0)
(global short s_drop_scarab_1_climb_time 0)
(script dormant f_drop_scarab_1

	(if (not b_test_scarabdrop)
		(begin
			(sleep_until (volume_test_players tv_drop_drop_1) 1)
		)
	)

	(sleep_until
		(begin

			(set s_drop_scarab_1_loops 1)
			(set s_drop_scarab_1_loop_idx 0)
			(set s_drop_scarab_1_drop_time 7)
			(set s_drop_scarab_1_idlewalk_time 7)
			(set s_drop_scarab_1_walk_time 7)
			(set s_drop_scarab_1_climb_time 57)
		
			(object_create_anew dm_drop_scarab_1)
			
			(set b_drop_1_scarab_dropped true)

			(ai_place sq_drop_scarab_1_turret)
			;(ai_vehicle_enter_immediate sq_drop_scarab_1_turret/driver_01 (object_get_turret dm_drop_scarab_1 0) "")
			(ai_vehicle_enter_immediate sq_drop_scarab_1_turret/driver_02 (object_get_turret dm_drop_scarab_1 1) "")
			(ai_vehicle_enter_immediate sq_drop_scarab_1_turret/driver_03 (object_get_turret dm_drop_scarab_1 2) "")
			(ai_vehicle_enter_immediate sq_drop_scarab_1_turret/driver_04 (object_get_turret dm_drop_scarab_1 3) "")

			(device_set_position_track dm_drop_scarab_1 "device:scarab_drop" 0)
		  (device_animate_position dm_drop_scarab_1 1 s_drop_scarab_1_drop_time 0.034 0.034 false)
			(sleep (- (* s_drop_scarab_1_drop_time 30) 2) )
		
			(device_set_position_track dm_drop_scarab_1 "device:idle_2_move_front" 0)
		  (device_animate_position dm_drop_scarab_1 1 s_drop_scarab_1_idlewalk_time 0.034 0.034 false)
			(sleep (- (* s_drop_scarab_1_idlewalk_time 30) 2) )
		
			(sleep_until
				(begin
					(device_set_position_track dm_drop_scarab_1 "device:move_front" 0)	
		  		(device_animate_position dm_drop_scarab_1 1 s_drop_scarab_1_walk_time 0.034 0.034 false)
					(set s_drop_scarab_1_loop_idx (+ s_drop_scarab_1_loop_idx 1))
					(sleep (- (* s_drop_scarab_1_walk_time 30) 2) )
					(>= s_drop_scarab_1_loop_idx s_drop_scarab_1_loops)
				)
			1)
		
			(device_set_position_track dm_drop_scarab_1 "device:m70_scarab_climb" 0)
		  (device_animate_position dm_drop_scarab_1 1 s_drop_scarab_1_climb_time 0.034 0.034 false)
			(sleep (- (* s_drop_scarab_1_climb_time 30) 2) )

			(not b_test_scarabdrop)

		)
	1)

)

(global boolean b_drop_scarab_2_near false)
(global short s_drop_scarab_2_drop_time 0)
(global short s_drop_scarab_2_idle_time 0)
(global short s_drop_scarab_2_idlewalk_time 0)
(global short s_drop_scarab_2_wkloops 0)
(global short s_drop_scarab_2_wkloop_idx 0)
(global short s_drop_scarab_2_walk_time 0)
(global short s_drop_scarab_2_climb_time 0)
(script dormant f_drop_scarab_2

	(if (not b_test_scarabdrop)
		(begin
			(sleep_until (volume_test_players tv_drop_drop_2) 1)
		)
	)

	(sleep_until
		(begin

			(set s_drop_scarab_2_drop_time 8)
			(set s_drop_scarab_2_idle_time 1)
			(set s_drop_scarab_2_idlewalk_time 7)
			(set s_drop_scarab_2_wkloops 4)
			(set s_drop_scarab_2_wkloop_idx 0)
			(set s_drop_scarab_2_walk_time 7)
			(set s_drop_scarab_2_climb_time 57)

			(object_create_anew dm_drop_scarab_2)
		
			(ai_place sq_drop_scarab_2_turret)
			;(ai_vehicle_enter_immediate sq_drop_scarab_2_turret/driver_01 (object_get_turret dm_drop_scarab_2 0) "")
			(ai_vehicle_enter_immediate sq_drop_scarab_2_turret/driver_02 (object_get_turret dm_drop_scarab_2 1) "")
			(ai_vehicle_enter_immediate sq_drop_scarab_2_turret/driver_03 (object_get_turret dm_drop_scarab_2 2) "")
			(ai_vehicle_enter_immediate sq_drop_scarab_2_turret/driver_04 (object_get_turret dm_drop_scarab_2 3) "")

			(device_set_position_track dm_drop_scarab_2 "device:scarab_drop" 0)
		  (device_animate_position dm_drop_scarab_2 1 s_drop_scarab_2_drop_time 0.034 0.034 false)
			(sleep (- (* s_drop_scarab_2_drop_time 30) 2) )
		
			(device_set_position_track dm_drop_scarab_2 "device:idle_2_move_front" 0)
		  (device_animate_position dm_drop_scarab_2 1 s_drop_scarab_2_idlewalk_time 0.034 0.034 false)
			(sleep (- (* s_drop_scarab_2_idlewalk_time 30) 2) )
		
			(sleep_until
				(begin
					(device_set_position_track dm_drop_scarab_2 "device:move_front_up" 0)	
		  		(device_animate_position dm_drop_scarab_2 1 s_drop_scarab_2_walk_time 0.034 0.034 false)
					(set s_drop_scarab_2_wkloop_idx (+ s_drop_scarab_2_wkloop_idx 1))
					(sleep (- (* s_drop_scarab_2_walk_time 30) 2) )
					(>= s_drop_scarab_2_wkloop_idx s_drop_scarab_2_wkloops)
				)
			1)
		
			(device_set_position_track dm_drop_scarab_2 "device:m70_scarab_climb" 0)
		 	(print "init anim start")	
		  (device_animate_position dm_drop_scarab_2 1 s_drop_scarab_2_climb_time 0.034 0.034 false)
			(sleep (- (* s_drop_scarab_2_climb_time 30) 2) )
			
			(not b_test_scarabdrop)

		)
	1)

)

(script dormant f_drop_scarab_distance_1
	(sleep_until
		(begin
			(dprint "scarab_distance_1 go!")
			(effect_new_random "levels/solo/m70/fx/scarab_drop.effect" ps_drop_distance_1 5 5)
			(sleep (random_range 10 15))
			false
		)
	5)
)

(script dormant f_drop_scarab_distance_2
	(dprint "scarab_distance_2 go!")
	(effect_new_random "levels/solo/m70/fx/scarab_drop.effect" ps_drop_distance_2)
	(sleep (random_range 10 15))
	(effect_new_random "levels/solo/m70/fx/scarab_drop.effect" ps_drop_distance_2)
	(sleep (random_range 10 15))
)


(global short s_drop_scarab_1_far_drop_time 6)
(script dormant f_drop_scarab_1_far

	(object_create dm_drop_scarab_1_far)
	(device_set_power dm_drop_scarab_1_far 1)

	(device_set_position_track dm_drop_scarab_1_far "device:scarab_drop" 0)
  (device_animate_position dm_drop_scarab_1_far 1 s_drop_scarab_1_far_drop_time 0.034 0.034 false)
	(sleep (- (* s_drop_scarab_1_far_drop_time 30) 2) )

  (sleep_until
    (begin
	    (device_set_position_track dm_drop_scarab_1_far stationary_march 0)
	    (device_animate_position dm_drop_scarab_1_far 1.0 (random_range 7 10) 1.0 1.0 true)
	    (sleep_until (>= (device_get_position dm_drop_scarab_1_far) 1) 1)
	    (sleep (random_range 0 20))
    0)
  )

)

(global short s_drop_scarab_2_far_drop_time 6)
(script dormant f_drop_scarab_2_far

	(object_create dm_drop_scarab_2_far)
	(device_set_power dm_drop_scarab_2_far 1)

	(device_set_position_track dm_drop_scarab_2_far "device:scarab_drop" 0)
  (device_animate_position dm_drop_scarab_2_far 1 s_drop_scarab_2_far_drop_time 0.034 0.034 false)
	(sleep (- (* s_drop_scarab_2_far_drop_time 30) 2) )

  (sleep_until
    (begin
	    (device_set_position_track dm_drop_scarab_2_far stationary_march 0)
	    (device_animate_position dm_drop_scarab_2_far 1.0 (random_range 7 10) 1.0 1.0 true)
	    (sleep_until (>= (device_get_position dm_drop_scarab_2_far) 1) 1)
	    (sleep (random_range 0 20))
    0)
  )

)

(global short s_drop_scarab_3_far_drop_time 6)
(script dormant f_drop_scarab_3_far

	(object_create dm_drop_scarab_3_far)
	(device_set_power dm_drop_scarab_3_far 1)

	(device_set_position_track dm_drop_scarab_3_far "device:scarab_drop" 0)
  (device_animate_position dm_drop_scarab_3_far 1 s_drop_scarab_3_far_drop_time 0.034 0.034 false)
	(sleep (- (* s_drop_scarab_3_far_drop_time 30) 2) )

  (sleep_until
    (begin
	    (device_set_position_track dm_drop_scarab_3_far stationary_march 0)
	    (device_animate_position dm_drop_scarab_3_far 1.0 (random_range 7 10) 1.0 1.0 true)
	    (sleep_until (>= (device_get_position dm_drop_scarab_3_far) 1) 1)
	    (sleep (random_range 0 20))
    0)
  )
)

; pods
(script dormant f_drop_pods_control

	(sleep_until (volume_test_players tv_drop_pod_1) 1)
	(wake f_drop_pod_1a)
	(wake f_drop_pod_1b)
	(sleep_until (volume_test_players tv_drop_pod_2) 1)
	(wake f_drop_pod_2)
	(sleep_until (volume_test_players tv_drop_pod_3) 1)
	(wake f_drop_pod_3)
	(sleep_until (volume_test_players tv_drop_pod_4) 1)
	(wake f_drop_pod_4)
	(sleep_until (volume_test_players tv_drop_pod_5) 1)
	(wake f_drop_pod_5)
	(sleep_until (volume_test_players tv_drop_pod_6) 1)
	(wake f_drop_pod_6)

)


(script static void f_drop_pods_test
	(wake f_drop_pod_1a)
	(wake f_drop_pod_1b)
	(wake f_drop_pod_2)
	(wake f_drop_pod_3)
	(wake f_drop_pod_4)
	(wake f_drop_pod_5)
	(wake f_drop_pod_6)
)

(script dormant f_drop_pod_1a

	(f_drop_pod dm_drop_pod_1a sq_drop_pod_1a/driver sq_drop_pod_1a)

)

(script dormant f_drop_pod_1b

	(sleep (* 30 1))
	(f_drop_pod dm_drop_pod_1b sq_drop_pod_1b/driver sq_drop_pod_1b)

)

(script dormant f_drop_pod_2

	(f_drop_pod dm_drop_pod_2 sq_drop_pod_2/driver sq_drop_pod_2)

)

(script dormant f_drop_pod_3

	(f_drop_pod dm_drop_pod_3 sq_drop_pod_3/driver sq_drop_pod_3)

)

(script dormant f_drop_pod_4

	(f_drop_pod dm_drop_pod_4 sq_drop_pod_4/driver sq_drop_pod_4)

)

(script dormant f_drop_pod_5

	(f_drop_pod dm_drop_pod_5 sq_drop_pod_5/driver sq_drop_pod_5)

)

(script dormant f_drop_pod_6

	(f_drop_pod dm_drop_pod_6 sq_drop_pod_6/driver sq_drop_pod_6)

)

(script static void (f_drop_pod (device_name pod_marker) (ai pod_pilot) (ai pod_squad))
	(print "pod drop started...")
	(object_create_anew pod_marker)
	(ai_place pod_squad)
	(sleep 1)
	(objects_attach pod_marker "" (ai_vehicle_get_from_spawn_point pod_pilot) "")

	(device_set_position_track pod_marker "position" 0)
	(device_animate_position pod_marker 1.0 2 .034 .034 false)
	(device_set_position pod_marker 1)
	(sleep_until (>= (device_get_position pod_marker) 0.85) 1)
	(unit_open (ai_vehicle_get_from_spawn_point pod_pilot))
	(sleep_until (>= (device_get_position pod_marker) 0.98) 1)
	(dprint "impact fx")
	(effect_new_on_object_marker fx\fx_library\pod_impacts\default\pod_impact_default_large.effect pod_marker "fx_impact")
	(sleep 45)
	(vehicle_unload (ai_vehicle_get_from_spawn_point pod_pilot) "")
	(sleep_until (>= (device_get_position pod_marker) 1) 1)
	(sleep 1)
	(objects_detach pod_marker (ai_vehicle_get_from_spawn_point pod_pilot))
	(object_destroy pod_marker)
	
)


(script dormant f_drop_cleanup_control

	(sleep_until (volume_test_players tv_block_17) 5)
	(f_drop_despawn_all)
	(f_drop_kill_scripts)
	(object_destroy dm_drop_scarab_1)
	(object_destroy dm_drop_scarab_2)

)

(script static void f_drop_despawn_all

	(ai_erase gr_drop_cov)

)

(script static void f_drop_kill_scripts

	(sleep_forever f_drop_objective_control)
	(sleep_forever f_drop_save_control)
	(sleep_forever f_drop_waypoint_control)
	(sleep_forever f_drop_emile_control)
	(sleep_forever f_drop_md_control)
	(sleep_forever f_drop_longsword_control)
	(sleep_forever f_drop_spawn_control)
	(sleep_forever f_drop_scarabs_start)
	(sleep_forever f_drop_scarabs_distance)
	(sleep_forever f_drop_scarab_1)
	(sleep_forever f_drop_scarab_2)
	(sleep_forever f_drop_scarab_1_far)
	(sleep_forever f_drop_scarab_2_far)
	(sleep_forever f_drop_scarab_3_far)
	(sleep_forever f_drop_scarab_distance_1)
	(sleep_forever f_drop_scarab_distance_2)
	(sleep_forever f_drop_pods_control)
	(sleep_forever f_drop_pod_1a)
	(sleep_forever f_drop_pod_1b)
	(sleep_forever f_drop_pod_2)
	(sleep_forever f_drop_pod_3)
	(sleep_forever f_drop_pod_4)
	(sleep_forever f_drop_pod_5)
	(sleep_forever f_drop_pod_6)

	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

; =================================================================================================
; =================================================================================================
; blockade
; =================================================================================================
; =================================================================================================

(script dormant f_block_objective_control
	(dprint "::: blockade encounter :::")
	
	; wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))

	(set b_block_ready true)

	; standard scripts
	(wake f_block_title_control)
	(wake f_block_missionobj_control)
	(wake f_block_waypoint_control)
	(wake f_block_spawn_control)
	(wake f_block_cleanup_control)
	(wake f_block_md_control)
	(wake f_block_music_control)
	(wake f_block_save_control)
	(wake f_block_emile_control)

	; encounter scripts
	(wake f_block_wraith_control)
	(wake f_block_phantom_gulch)
	(wake f_emile_boost)
	(if (game_is_cooperative) (wake f_block_coop_jump_forward) )

	(set b_insertion_fade_in true)

	(sleep_until (volume_test_players tv_block_05) 1)
	(dprint "objective control : blockade.05")
	(set objcon_block 5)

	(sleep_until (volume_test_players tv_block_10) 1)
	(dprint "objective control : blockade.10")
	(set objcon_block 10)

	(soft_ceiling_enable camera_blocker_04 false)

	(sleep_until (volume_test_players tv_block_17) 1)
	(dprint "objective control : blockade.17")
	(set objcon_block 17)

	(sleep_until (volume_test_players tv_block_20) 1)
	(dprint "objective control : blockade.20")
	(set objcon_block 20)

	(sleep_until (volume_test_players tv_block_30) 1)
	(dprint "objective control : blockade.30")
	(set objcon_block 30)

	(sleep_until (volume_test_players tv_block_40) 1)
	(dprint "objective control : blockade.40")
	(set objcon_block 40)

	(sleep_until (volume_test_players tv_block_50) 1)
	(dprint "objective control : blockade.50")
	(set objcon_block 50)

	(sleep_until (volume_test_players tv_block_60) 1)
	(dprint "objective control : blockade.60")
	(set objcon_block 60)

	(soft_ceiling_enable camera_blocker_09 false)

	(sleep_until (volume_test_players tv_block_70) 1)
	(dprint "objective control : blockade.70")
	(set objcon_block 70)

)

(script dormant f_block_coop_jump_forward

	(sleep_until (volume_test_players "begin_zone_set:set_cave") 5)
	(sleep_until
		(begin

				(cond
					((volume_test_object tv_block_coop_jump_teleport player0)
						(if (unit_in_vehicle (player0))
							(begin
								(object_teleport_to_ai_point (object_get_parent player0) ps_block_coop_teleport/p0)
							)(begin
								(object_teleport_to_ai_point player0 ps_block_coop_teleport/p0)
						))
					)
					((volume_test_object tv_block_coop_jump_teleport player1)
						(if (unit_in_vehicle (player1))
							(begin
								(object_teleport_to_ai_point (object_get_parent player1) ps_block_coop_teleport/p1)
							)(begin
								(object_teleport_to_ai_point player1 ps_block_coop_teleport/p1)
						))
					)
					((volume_test_object tv_block_coop_jump_teleport player2)
						(if (unit_in_vehicle (player2))
							(begin
								(object_teleport_to_ai_point (object_get_parent player2) ps_block_coop_teleport/p2)
							)(begin
								(object_teleport_to_ai_point player2 ps_block_coop_teleport/p2)
						))
					)
					((volume_test_object tv_block_coop_jump_teleport player3)
						(if (unit_in_vehicle (player3))
							(begin
								(object_teleport_to_ai_point (object_get_parent player3) ps_block_coop_teleport/p3)
							)(begin
								(object_teleport_to_ai_point player3 ps_block_coop_teleport/p3)
						))
					)

				)

		false)
	1)





)

(script dormant	f_block_wraith_control

	(sleep_until (volume_test_players tv_block_tower) 5)

	(sleep_until
		(begin
		
			(if (volume_test_players tv_block_tower) (cs_run_command_script sq_block_wraith f_cs_block_wraith_tower ) )
			(sleep_until (not (volume_test_players tv_block_tower)) 5)
			
		false)
	30)

)

(script command_script f_cs_block_wraith_shoot

	(cs_abort_on_damage true)
	(cs_enable_moving true)
	(cs_enable_looking true)
	(cs_enable_targeting true)
	(cs_shoot_point true ps_block_wraith/shoot_01)
	(sleep_until (volume_test_players tv_block_wraith_active) 5)

)

(script command_script f_cs_block_wraith_tower

	(cs_enable_moving true)
	(cs_enable_looking true)
	(cs_enable_targeting true)
	(cs_shoot_point true ps_block_wraith/shoot_tower)	
	(sleep_until (not (volume_test_players tv_block_tower)) 5)

)

(script dormant f_block_title_control

	(sleep_until (>= objcon_block 20) 5)
	(tit_block)

)

(script dormant f_block_missionobj_control

	(sleep_until (>= objcon_block 20) 5)
	(sleep 220)
	(mo_blockade)
	(set s_music_drop 5)

)

(global short s_block_waypoint_timer_bridge 90)
(global short s_block_waypoint_timer_cave 240)
(script dormant f_block_waypoint_control

	; linear
	(sleep_until (>= objcon_block 10))
	(sleep_until (>= objcon_block 20) 5 (* 30 s_block_waypoint_timer_bridge))
	(if (not (>= objcon_block 20))
		(begin
			(f_blip_flag fl_block_waypoint_1 blip_destination)
			(sleep_until (>= objcon_block 20) 5)
			(f_unblip_flag fl_block_waypoint_1)
		)
	)

	(sleep_until (>= objcon_block 70) 5 (* 30 s_block_waypoint_timer_cave))
	(if (not (>= objcon_block 70))
		(begin
			(f_blip_flag fl_block_waypoint_2 blip_destination)
			(sleep_until (>= objcon_block 70) 5)
			(f_unblip_flag fl_block_waypoint_2)
		)
	)

)

(script dormant f_block_emile_control

	(sleep_until
		(and
			(volume_test_object tv_area_block_gulch o_emile)
			(volume_test_players tv_area_block_gulch)
		)
	)
	(ai_set_objective sq_emile obj_block_hum)
	(sleep 10)

	(f_ai_squad_group_vehicles_exit sq_emile gr_vehicles_hum)

)

(global short s_squad_group_vehicle_counter 0)
(script static void (f_ai_squad_group_vehicles_exit (ai exiter) (ai vehicle_group))

	(set s_squad_group_vehicle_counter (ai_squad_group_get_squad_count vehicle_group))
	
	(ai_vehicle_exit exiter)
	(cs_run_command_script exiter f_cs_abort)

	(sleep_until (begin
	
		(set s_squad_group_vehicle_counter (- s_squad_group_vehicle_counter 1))

		;; exit vehicles
		(vehicle_unload (ai_squad_group_get_squad vehicle_group s_squad_group_counter) "")
		(ai_vehicle_reserve (ai_squad_group_get_squad vehicle_group s_squad_group_counter) true)

		(<= s_squad_group_vehicle_counter 0)

	) 1)


)

(script dormant	f_block_save_control

	(wake f_block_save_combatend)

	(sleep_until (>= objcon_block 20) 5)
	(game_save_no_timeout)


	(sleep_until (>= objcon_block 60) 5)
	(game_save_no_timeout)

)

(script dormant f_block_save_combatend 

	(branch (>= objcon_tunnels 0) (f_abort))

	(sleep_until (> (ai_living_count obj_block_cov) 0) 1)
	(sleep_until (<= (ai_living_count gr_block_cov) 0))
	(game_save_no_timeout)

)

(script dormant	f_block_md_control

	(f_abort_md)

	; conditional
	; -----------------

	; dismount validation prompt
	(wake f_block_md_block_dismount)	
	
	; linear
	; -----------------

	(sleep_until (>= objcon_block 10) 1)
	(md_block_bridge)

	(sleep_until (>= objcon_block 20) 1)
	(md_block_warn)

	;(sleep_until (>= objcon_block 30))
	;(md_block_snipers)

	(sleep_until (>= objcon_block 30) 1)
	(md_block_wraith)

	(sleep_until 
		(or
			(>= objcon_block 60)
			(<= (ai_living_count obj_block_cov) 1)
			(<= (ai_living_count sq_block_wraith) 0)
		)
	1)

	(sleep_until (>= objcon_block 70) 1)

	; cave exit delay
	(sleep_until (>= objcon_block 70) 1 400)
	(if (not (>= objcon_block 70))
		(begin
			(md_block_gulch_delay_0)
		)
	)

	(sleep_until (>= objcon_block 70) 1 400)
	(if (not (>= objcon_block 70))
		(begin
			(md_block_gulch_delay_1)
		)
	)

)

(script dormant	f_block_md_block_dismount

	(branch
		(>= objcon_block 30)
		(f_abort_md)
	)

	(sleep_until
		(and
			(volume_test_players tv_block_bridge_near)
			(not b_players_any_in_vehicle)
		)
	)

	(md_block_dismount)

)

(script dormant	f_block_music_control

	(wake music_block)
	
	(sleep_until (> (ai_living_count obj_block_cov) 0) 1)

	(sleep_until
		(or
			(>= objcon_block 60)
			(<= (ai_living_count obj_block_cov) 0)
		)
	)
	(set s_music_block 1)

)


(script dormant f_block_spawn_control

	(sleep_until (>= objcon_block 17) 1)
	(sleep 30)
	
	(dprint "::: spawning all blockade squads")
	(f_squad_group_place gr_block_cov_init)

	(sleep_until (>= objcon_block 60) 1)

	(f_squad_group_place gr_block_cov_hill)
	(tick)
	(ai_grunt_kamikaze sq_block_grunt_hill)

)

; phantom
;============================================

(script dormant f_block_phantom_gulch
	(sleep_until (volume_test_players tv_block_phantom) 1)
	(garbage_collect_now)
	(tick)
	(ai_place sq_block_phantom_gulch)
)

(global vehicle v_block_phantom_gulch none)
(script command_script f_cs_block_phantom_gulch

	(cs_ignore_obstacles true)

	(dprint "phantom gulch")
	(set v_block_phantom_gulch (ai_vehicle_get_from_starting_location sq_block_phantom_gulch/driver_01))

	(f_load_phantom_cargo v_block_phantom_gulch "single" sq_block_wraith none)
	(object_set_velocity v_block_phantom_gulch 5)

	; enter
	;--------------------------------------------
	(cs_fly_by ps_block_phantom_gulch/move_00)
	(cs_fly_by ps_block_phantom_gulch/move_01)
	(cs_fly_by ps_block_phantom_gulch/move_02)
	(cs_fly_by ps_block_phantom_gulch/move_03)
	(cs_fly_by ps_block_phantom_gulch/move_04)
	
	; hover
	;--------------------------------------------
	(cs_fly_by ps_block_phantom_gulch/move_05)	
	(sleep 60)
	
	; lower
	;--------------------------------------------	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face ps_block_phantom_gulch/move_06 ps_block_phantom_gulch/move_06_face .1)
	(sleep 60)
	(f_unload_phantom_cargo (ai_vehicle_get ai_current_actor) "single")
	(sleep 120)
	;(cs_fly_to_and_face ps_block_phantom_gulch/move_06 ps_block_phantom_gulch/face_05 1)


	; rise ====================================================
	(cs_fly_by ps_block_phantom_gulch/move_05)
		
	; == exit ====================================================
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_block_phantom_gulch/move_07)
	(cs_fly_by ps_block_phantom_gulch/move_08)
	(ai_erase ai_current_squad)
	
)


(script dormant f_block_cleanup_control

	(sleep_until (volume_test_players tv_block_cleanup) 5)
	(f_block_despawn_all)
	(f_block_kill_scripts)

)

(script static void f_block_despawn_all

	(ai_erase gr_block_cov)

)

(script static void f_block_kill_scripts

	(sleep_forever f_block_objective_control)
	(sleep_forever f_block_title_control)
	(sleep_forever f_block_missionobj_control)
	(sleep_forever f_block_waypoint_control)
	(sleep_forever f_block_emile_control)
	(sleep_forever f_block_save_control)
	(sleep_forever f_block_save_combatend)
	(sleep_forever f_block_md_control)
	(sleep_forever f_block_md_block_dismount)
	(sleep_forever f_block_music_control)
	(sleep_forever f_block_spawn_control)
	(sleep_forever f_block_phantom_gulch)
	(sleep_forever f_block_wraith_control)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

; =================================================================================================
; =================================================================================================
; carter
; =================================================================================================
; =================================================================================================

(script dormant f_carter_objective_control
	(dprint "::: carter encounter :::")
	
	; wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))

	(set b_carter_ready true)

	; standard
	(wake f_carter_save_control)
	(wake f_carter_waypoint_control)
	(wake f_carter_md_control)
	(wake f_carter_cleanup_control)

	; encounter
	(wake f_carter_emile_control)
	(wake f_carter_cin_control)
	
	(set b_insertion_fade_in true)

	(sleep_until (volume_test_players tv_carter_10) 1)
	(dprint "objective control : carter.10")
	(set objcon_carter 10)

	(sleep_until (volume_test_players tv_carter_20) 1)
	(dprint "objective control : carter.20")
	(set objcon_carter 20)

	(sleep_until (volume_test_players tv_carter_30) 1)
	(dprint "objective control : carter.30")
	(set objcon_carter 30)

	(sleep_until (volume_test_players tv_carter_40) 1)
	(dprint "objective control : carter.40")
	(set objcon_carter 40)

)

(script dormant f_carter_save_control

	(sleep_until (>= objcon_carter 20) 5)
	(game_save_no_timeout)

)

(global short s_carter_waypoint_timer 90)
(script dormant f_carter_waypoint_control

	; nonlinear

	; linear
	(sleep_until (>= objcon_carter 10) 5)
	(sleep_until (>= objcon_carter 40) 5 (* 30 s_carter_waypoint_timer))
	(if (not (>= objcon_carter 40))
		(begin
			(f_blip_flag fl_carter_waypoint_1 blip_destination)
			(sleep_until (>= objcon_carter 40) 5)
			(f_unblip_flag fl_carter_waypoint_1)
		)
	)

)

(script dormant f_carter_emile_control

	(sleep_until
		(and
			(volume_test_object tv_area_carter o_emile)
			(volume_test_players tv_area_carter)
		)
	)
	(ai_set_objective sq_emile obj_carter_hum)
	(sleep 10)
	(cs_run_command_script sq_emile f_cs_abort)

)

(script dormant	f_carter_md_control

	(f_abort_md)

	(sleep_until (>= objcon_carter 30) 1)
	(md_carter_battle_0)

)

(global boolean b_carter_cin_done false)
(script dormant	f_carter_cin_control

	(sleep_until (>= objcon_carter 40) 1)

	(cinematic_enter 070la2_carter_death true)
	(f_cin_carter_prep)
  (f_play_cinematic_advanced 070la2_carter_death set_cave set_cave)
	(f_cin_carter_finish)
  (cinematic_exit 070la2_carter_death true)
	
)


(script static void f_cin_carter_prep

	(ai_erase sq_emile)
	(object_teleport_to_ai_point player0 ps_carter_cin/pre0)
	(object_teleport_to_ai_point player1 ps_carter_cin/pre1)
	(object_teleport_to_ai_point player2 ps_carter_cin/pre2)
	(object_teleport_to_ai_point player3 ps_carter_cin/pre3)

	; vehicles
	(object_destroy_type_mask 2)
	(add_recycling_volume_by_type tv_recycle_cave 0 1 1)

)

(script static void f_cin_carter_finish

	(f_emile_spawn sq_emile/sp_carter_cin obj_tunnels_hum)
	(object_teleport_to_ai_point player0 ps_carter_cin/p0)
	(object_teleport_to_ai_point player1 ps_carter_cin/p1)
	(object_teleport_to_ai_point player2 ps_carter_cin/p2)
	(object_teleport_to_ai_point player3 ps_carter_cin/p3)
	(object_teleport_to_ai_point ai_emile ps_carter_cin/emile)

)


(script dormant f_carter_cleanup_control

	(sleep_until (volume_test_players tv_carter_cleanup) 1)
	(f_carter_despawn_all)
	(f_carter_kill_scripts)

)

(script static void f_carter_despawn_all
	
	(ai_erase gr_carter_cov)
	(ai_erase gr_carter_hum_pelican)

)


(script static void f_carter_kill_scripts

	(sleep_forever f_carter_objective_control)
	(sleep_forever f_carter_save_control)
	(sleep_forever f_carter_waypoint_control)
	(sleep_forever f_carter_emile_control)
	(sleep_forever f_carter_md_control)
	(sleep_forever f_carter_cin_control)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

; =================================================================================================
; =================================================================================================
; tunnels
; =================================================================================================
; =================================================================================================

(script dormant f_tunnels_objective_control
	(dprint "::: tunnels encounter :::")
	
	; wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))

	(set b_tunnels_ready true)

	; standard scripts	
	(wake f_tunnels_save_control)
	(wake f_tunnels_waypoint_control)
	(wake f_tunnels_spawn_control)
	(wake f_tunnels_cleanup_control)
	(wake f_tunnels_md_control)
	(wake f_tunnels_music_control)
	(wake f_tunnels_emile_control)

	; encounter scripts	

	(set b_insertion_fade_in true)
	
	(sleep_until (volume_test_players tv_tunnels_10) 1)
	(dprint "objective control : tunnels.10")
	(set objcon_tunnels 10)

	(sleep_until (volume_test_players tv_tunnels_15) 1)
	(dprint "objective control : tunnels.15")
	(set objcon_tunnels 15)

	(soft_ceiling_enable camera_blocker_05 false)

	(sleep_until (volume_test_players tv_tunnels_20) 1)
	(dprint "objective control : tunnels.20")
	(set objcon_tunnels 20)
	
	(sleep_until (volume_test_players tv_tunnels_30) 1)
	(dprint "objective control : tunnels.30")
	(set objcon_tunnels 30)

	(sleep_until (volume_test_players tv_tunnels_40) 1)
	(dprint "objective control : tunnels.40")
	(set objcon_tunnels 40)

	(sleep_until
		(or
			(volume_test_players tv_tunnels_50_1)
			(volume_test_players tv_tunnels_50_2)
		)
	1)
	(dprint "objective control : tunnels.50")
	(set objcon_tunnels 50)

	(sleep_until (volume_test_players tv_tunnels_55) 1)
	(dprint "objective control : tunnels.55")
	(set objcon_tunnels 55)

	(sleep_until (volume_test_players tv_tunnels_60) 1)
	(dprint "objective control : tunnels.50")
	(set objcon_tunnels 60)

)

(script dormant f_tunnels_save_control

	(wake f_tunnels_save_combatend)

	(sleep_until (>= objcon_tunnels 15))
	(game_save_no_timeout)

	(sleep_until (>= objcon_tunnels 30))
	(game_save_no_timeout)

)

(script dormant f_tunnels_save_combatend 

	(branch (>= objcon_wall 0) (f_abort))

	(sleep_until (<= (ai_living_count gr_tunnels_cov) 0))
	(game_save_no_timeout)

)

(global short s_tunnels_waypoint_timer_entry 60)
(global short s_tunnels_waypoint_timer_exit 180)
(script dormant f_tunnels_waypoint_control

	; nonlinear

	; linear
	(sleep_until (>= objcon_tunnels 10))
	(sleep_until (>= objcon_tunnels 20) 5 (* 30 s_tunnels_waypoint_timer_entry))
	(if (not (>= objcon_tunnels 20))
		(begin
			(f_blip_flag fl_tunnels_waypoint_1 blip_destination)
			(sleep_until (>= objcon_tunnels 20) 5)
			(f_unblip_flag fl_tunnels_waypoint_1)
		)
	)

	(sleep_until (>= objcon_tunnels 50))

	(sleep_until (>= objcon_tunnels 60) 5 (* 30 s_tunnels_waypoint_timer_exit))
	(if (not (>= objcon_tunnels 60))
		(begin
			(f_blip_flag fl_tunnels_waypoint_2 blip_destination)
			(sleep_until (>= objcon_tunnels 60) 5)
			(f_unblip_flag fl_tunnels_waypoint_2)
		)
	)

)

(script dormant f_tunnels_emile_control

	(sleep_until
		(and
			(volume_test_object tv_area_tunnels o_emile)
			(volume_test_players tv_area_tunnels)
		)
	)
	(ai_set_objective sq_emile obj_tunnels_hum)
	(sleep 10)
	(ai_vehicle_exit sq_emile)
	(cs_run_command_script sq_emile f_cs_abort)

)

(script dormant f_tunnels_md_control

	(f_abort_md)

	(sleep_until (>= objcon_tunnels 20) 1)
	(md_tunnels_bugger_0)
	
	(sleep_until (>= objcon_tunnels 30) 1)
	(md_tunnels_bugger_1)

	(sleep_until
		(or
			(>= objcon_tunnels 60)
			(<= (ai_living_count obj_tunnels_cov) 1)
		)
	1)

	(sleep_until (>= objcon_tunnels 60) 1 (* 30 120))
	(if (not (>= objcon_tunnels 60))
		(begin
			(md_tunnels_delay_0)
		)
	)

	(sleep_until (>= objcon_tunnels 60) 1 (* 30 120))
	(if (not (>= objcon_tunnels 60))
		(begin
			(md_tunnels_delay_2)
		)
	)

)

(script dormant f_tunnels_spawn_control

	(sleep_until (>= objcon_tunnels 20))
	(ai_place	gr_tunnels_cov_init)
	
	(sleep_until (>= objcon_tunnels 30))
	(ai_place	gr_tunnels_cov_lake)

)

(script dormant	f_tunnels_music_control

	(wake music_tunnels)

)


(script static void f_tunnels_despawn_all

	(ai_erase	gr_tunnels_cov)

)

(script dormant f_tunnels_cleanup_control

	(sleep_until (volume_test_players tv_tunnels_cleanup) 5)
	(f_tunnels_despawn_all)
	(f_tunnels_kill_scripts)

)


(script static void f_tunnels_kill_scripts

	(sleep_forever f_tunnels_objective_control)
	(sleep_forever f_tunnels_save_control)
	(sleep_forever f_tunnels_save_combatend)
	(sleep_forever f_tunnels_waypoint_control)
	(sleep_forever f_tunnels_emile_control)
	(sleep_forever f_tunnels_md_control)
	(sleep_forever f_tunnels_spawn_control)	
	(sleep_forever f_tunnels_music_control)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	
)


; =================================================================================================
; =================================================================================================
; wall
; =================================================================================================
; =================================================================================================

(script dormant f_wall_objective_control
	(dprint "::: wall encounter :::")
	
	;wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))

	(set b_wall_ready true)

	; standard scripts
	(wake f_wall_missionobj_control)
	(wake f_wall_save_control)
	(wake f_wall_waypoint_control)
	(wake f_wall_spawn_control)
	(wake f_wall_music_control)
	(wake f_wall_md_control)
	(wake f_wall_cleanup_control)
	(wake f_wall_emile_control)

	; encounter scripts
	(wake f_wall_dropship_control)
	(wake f_wall_combat_refresh)

	(set b_insertion_fade_in true)
	(game_insertion_point_unlock 2)
	(f_loadout_set "boneyard")

	(sleep_until (volume_test_players tv_wall_10) 1)
	(dprint "objective control : wall.10")
	(set objcon_wall 10)

	(soft_ceiling_enable camera_blocker_06 false)

	(sleep_until (volume_test_players tv_wall_15) 1)
	(dprint "objective control : wall.15")
	(set objcon_wall 15)

	(sleep_until (volume_test_players tv_wall_20) 1)
	(dprint "objective control : wall.20")
	(set objcon_wall 20)

	(sleep_until (volume_test_players tv_wall_30) 1)
	(dprint "objective control : wall.30")
	(set objcon_wall 30)

	(sleep_until (volume_test_players tv_wall_40) 1)
	(dprint "objective control : wall.40")
	(set objcon_wall 40)

	(sleep_until (volume_test_players tv_wall_50) 1)
	(dprint "objective control : wall.50")
	(set objcon_wall 50)

	(sleep_until (volume_test_players tv_wall_60) 1)
	(dprint "objective control : wall.60")
	(set objcon_wall 60)

)

(script dormant f_wall_combat_refresh

	(sleep_until
		(begin
			(ai_renew gr_wall_cov)
			(ai_renew gr_wall_hum)
			(>= objcon_wall 15)
		)
	30)

)

(script dormant f_wall_missionobj_control

	(if b_ins_wall
		(begin
			(sleep 0)
		)
		(begin
			(sleep_until (>= objcon_wall 15) 5)		
		)
	)
	(mo_wall)

)

(script dormant f_wall_save_control

	(wake f_wall_save_combatend)

	(sleep_until (>= objcon_wall 20) 5)
	(game_save_no_timeout)

)

(script dormant f_wall_save_combatend

	(branch (>= objcon_factory 0) (f_abort))

	(sleep_until (<= (ai_living_count gr_wall_cov) 0))
	(game_save_no_timeout)

)

(script dormant f_wall_title_control

	(sleep_until (>= objcon_wall 15) 5)
	(tit_wall)

)

(global short s_wall_waypoint_timer 240)
(script dormant f_wall_waypoint_control

	(sleep_until (>= objcon_wall 10) 5)
	(sleep_until (>= objcon_wall 60) 5 (* 30 s_wall_waypoint_timer))
	(if (not (>= objcon_wall 60))
		(begin
			(f_blip_flag fl_wall_waypoint_1 blip_destination)
			(sleep_until (>= objcon_wall 60) 5)
			(f_unblip_flag fl_wall_waypoint_1)
		)
	)

)

(script dormant f_wall_emile_control

	(sleep_until
		(and
			(volume_test_object tv_area_wall o_emile)
			(volume_test_players tv_area_wall)
		)
	)
	(ai_set_objective sq_emile obj_wall_hum)
	(sleep 10)
	(ai_vehicle_exit sq_emile)
	(cs_run_command_script sq_emile f_cs_abort)

)

(script dormant f_wall_md_control

	(f_abort_md)

	; conditional
	; ---------------
	(wake f_wall_md_wall_marine_0)
	(wake f_wall_md_wall_marine_1)

	; linear
	(sleep_until (>= objcon_wall 10) 1)
	(md_wall_intro)
	
)

(global short s_wall_md_marine_idx 0)
(script dormant	f_wall_md_wall_marine_0

	(branch
		(>= objcon_wall 40)
		(f_abort_md)
	)

	(sleep_until (<= (objects_distance_to_object (players) sq_wall_marine_2/trooper_0) 6) 1)
	(sleep_forever f_wall_md_wall_marine_1)
	(set s_wall_md_marine_idx 0)
	(md_wall_marine_0_near)

	(sleep_until (<= (objects_distance_to_object (players) sq_wall_marine_2/trooper_0) 2) 1)
	(md_wall_marine_0)

)

(script dormant	f_wall_md_wall_marine_1

	(branch
		(>= objcon_wall 40)
		(f_abort_md)
	)

	(sleep_until (<= (objects_distance_to_object (players) sq_wall_marine_4/trooper_1) 6) 1)
	(sleep_forever f_wall_md_wall_marine_0)
	(set s_wall_md_marine_idx 1)
	(md_wall_marine_0_near)

	(sleep_until (<= (objects_distance_to_object (players) sq_wall_marine_4/trooper_1) 2) 1)
	(md_wall_marine_0)

)

(script dormant f_wall_music_control

	(wake music_wall)
	
	(sleep_until (= s_music_wall 1) 1)

	(sleep (* 30 140))
	
	(if (<= objcon_factory 50) (begin

		(set s_music_wall 2)

	)(begin

		(sleep_forever music_wall)
	
	))

)


(script dormant f_wall_dropship_control

	(set s_wave_spawning 0)

	(sleep_until (>= objcon_wall 20))
	;(ai_place sq_wall_phantom_w1_1)

)

(script command_script f_cs_wall_phantom_w1_1

	(set s_wave_spawning (+ s_wave_spawning 1))

	(f_load_phantom ai_current_squad "right" sq_wall_w1_1_1 none none none)

	; enter
	;--------------------------------------------
	(cs_fly_by ps_wall_phantom_w1_1/enter_01)
	(cs_fly_by ps_wall_phantom_w1_1/enter_02)
	
	; unload 1
	;--------------------------------------------
	(cs_fly_by ps_wall_phantom_w1_1/hover_01)
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face ps_wall_phantom_w1_1/drop_01 ps_wall_phantom_w1_1/drop_01_face 1)
	(f_unload_phantom ai_current_squad "dual")

	(sleep 30)
	(set s_wave_spawning (- s_wave_spawning 1))

	; exit
	;--------------------------------------------
	(cs_fly_to_and_face ps_wall_phantom_w1_1/hover_01 ps_wall_phantom_w1_1/drop_01_face 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_wall_phantom_w1_1/exit_01)
	(cs_fly_by ps_wall_phantom_w1_1/exit_02)
	(cs_fly_by ps_wall_phantom_w1_1/erase)
	(ai_erase ai_current_squad)

)

(script dormant f_wall_spawn_control
	(dprint "::: spawning all wall squads")

	(if (= s_special_elite 1) (ai_place sq_wall_bob) )

	(ai_place gr_wall_cov_init)
	(ai_place gr_wall_hum)

)

(script dormant f_wall_cleanup_control

	(sleep_until (volume_test_players tv_wall_cleanup) 5)
	(f_wall_despawn_all)
	(f_wall_kill_scripts)

)


(script static void f_wall_despawn_all
	(dprint "::: despawning all wall squads")

	(ai_erase gr_wall_cov)
	(ai_erase gr_wall_hum)

)

(script static void f_wall_kill_scripts

	(sleep_forever f_wall_objective_control)
	(sleep_forever f_wall_combat_refresh)
	(sleep_forever f_wall_missionobj_control)
	(sleep_forever f_wall_save_control)
	(sleep_forever f_wall_save_combatend)
	(sleep_forever f_wall_title_control)
	(sleep_forever f_wall_waypoint_control)
	(sleep_forever f_wall_emile_control)
	(sleep_forever f_wall_md_control)
	(sleep_forever f_wall_md_wall_marine_0)
	(sleep_forever f_wall_md_wall_marine_1)
	(sleep_forever f_wall_music_control)
	(sleep_forever f_wall_dropship_control)
	(sleep_forever f_wall_spawn_control)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	
)


; =================================================================================================
; =================================================================================================
; factory
; =================================================================================================
; =================================================================================================

(script dormant f_factory_objective_control
	(dprint "::: factory encounter :::")
	
	; wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))

	(set b_factory_ready true)

	; standard scripts
	(wake f_factory_save_control)
	(wake f_factory_waypoint_control)
	(wake f_factory_spawn_control)
	(wake f_factory_md_control)
	(wake f_factory_music_control)
	(wake f_factory_cleanup_control)
	(wake f_factory_emile_control)

	; encounter scripts
	(wake f_factory_squad_migrate)
	(wake f_factory_zoneset_door)
	(wake f_factory_bomb)

	(dprint "objective control : factory.1")
	(set objcon_factory 1)

	(set b_insertion_fade_in true)

	(sleep_until (volume_test_players tv_factory_10) 5)
	(dprint "objective control : factory.10")
	(set objcon_factory 10)

	(soft_ceiling_enable camera_blocker_07 false)

	(sleep_until (volume_test_players tv_factory_20) 5)
	(dprint "objective control : factory.20")
	(set objcon_factory 20)

	(sleep_until (volume_test_players tv_factory_25) 5)
	(dprint "objective control : factory.25")
	(set objcon_factory 25)

	(sleep_until (volume_test_players tv_factory_30) 5)
	(dprint "objective control : factory.30")
	(set objcon_factory 30)

	(sleep_until (volume_test_players tv_factory_40) 5)
	(dprint "objective control : factory.40")
	(set objcon_factory 40)

	(sleep_until (volume_test_players tv_factory_50) 5)
	(dprint "objective control : factory.50")
	(set objcon_factory 50)

	(sleep_until (volume_test_players tv_factory_60) 5)
	(dprint "objective control : factory.60")
	(set objcon_factory 60)

)

(script dormant f_factory_music_control

	(wake music_factory)

)

(script dormant f_factory_bomb

	(sleep_until (>= objcon_factory 60))

	(set s_music_factory 1)

	(set b_shake true)
	(sleep 60)

	(interpolator_start base_bombing)
	(sound_impulse_start sound\levels\020_base\base_scripted_expl1 none 1)

)


(script dormant f_factory_zoneset_door

	(sleep_until (>= objcon_factory 60) 1)
	(device_set_power dm_hall1_door 1)
	(device_operates_automatically_set dm_hall1_door false)
	(device_set_position dm_hall1_door 0)
	(sleep_until (= (device_get_position dm_hall1_door) 0) 1)
	(device_set_power dm_hall1_door 0)

	; coop teleport failsafe

	(if (game_is_cooperative)
		(begin
			(if
				(not
					(or
						(volume_test_object tv_area_hall_1 player0)
						(volume_test_object tv_area_crane player0)
					)
				)
				(begin
					(object_teleport_to_ai_point player0 ps_factory_hall1_spawn/p0)
				)
			)
		
			(if
				(not
					(or
						(volume_test_object tv_area_hall_1 player1)
						(volume_test_object tv_area_crane player1)
					)
				)
				(begin
					(object_teleport_to_ai_point player1 ps_factory_hall1_spawn/p1)
				)
			)
		
			(if
				(not
					(or
						(volume_test_object tv_area_hall_1 player2)
						(volume_test_object tv_area_crane player2)
					)
				)
				(begin
					(object_teleport_to_ai_point player2 ps_factory_hall1_spawn/p2)
				)
			)
		
			(if
				(not
					(or
						(volume_test_object tv_area_hall_1 player3)
						(volume_test_object tv_area_crane player3)
					)
				)
				(begin
					(object_teleport_to_ai_point player3 ps_factory_hall1_spawn/p3)
				)
			)
		)
	)

	(zone_set_trigger_volume_enable begin_zone_set:set_smelt true)

)

(script dormant f_factory_squad_migrate

	(sleep_until (>= objcon_factory 1))
	(ai_set_task gr_wall_hum obj_factory_hum gate_ship)

)

(script dormant f_factory_save_control

	(wake f_factory_save_combatend)

	(sleep_until (>= objcon_factory 20))
	(game_save_no_timeout)

	(sleep_until (>= objcon_factory 40))
	(game_save_no_timeout)

)

(script dormant f_factory_save_combatend

	(branch (>= objcon_crane 0) (f_abort))

	(sleep_until (<= (ai_living_count gr_factory_cov) 0))
	(game_save_no_timeout)

)

(global short s_factory_waypoint_timer 180)
(script dormant f_factory_waypoint_control

	(sleep_until (>= objcon_factory 10) 5)
	(sleep_until (>= objcon_factory 50) 5 (* 30 s_factory_waypoint_timer))
	(if (not (>= objcon_factory 50))
		(begin
			(f_blip_flag fl_factory_waypoint_1 blip_destination)
			(sleep_until (>= objcon_factory 50) 5)
			(f_unblip_flag fl_factory_waypoint_1)
		)
	)

)

(script dormant f_factory_emile_control

	(sleep_until
		(and
			(volume_test_object tv_area_factory o_emile)
			(volume_test_players tv_area_factory)
		)
	)
	(ai_set_objective sq_emile obj_factory_hum)
	(sleep 10)
	(ai_vehicle_exit sq_emile)
	(cs_run_command_script sq_emile f_cs_abort)

)

(script dormant f_factory_md_control

	(f_abort_md)

	; conditional
	; ---------------
	(wake f_factory_md_factory_marine_0)

	; linear
	(sleep_until (>= objcon_factory 20) 1 (* 30 120))
	(if (not (>= objcon_factory 20))
		(begin
			(md_factory_ship_delay_0)
		)
	)

	(sleep_until
		(or
			(>= objcon_factory 30)
			(<= (ai_task_count obj_factory_cov/gate_factory_ent) 1)
		)
	1)

	(sleep_until (>= objcon_factory 30) 1 (* 30 90))
	(if (not (>= objcon_factory 30))
		(begin
			(md_factory_delay_2)
		)
	)

	(sleep_until
		(or
			(>= objcon_factory 50)
			(<= (ai_task_count obj_factory_cov/gate_factory) 1)
		)
	1)

	(sleep_until (>= objcon_factory 50) 1 (* 30 90))
	(if (not (>= objcon_factory 50))
		(begin
			(md_factory_delay_3)
		)
	)

)

(script dormant	f_factory_md_factory_marine_0

	(sleep_until (volume_test_players tv_factory_marine_0))
	(md_factory_marine_0)

)

(script dormant f_factory_spawn_control
	(dprint "::: spawning all wall squads")

	(sleep_until (>= objcon_factory 10))

	(if (= s_special_elite 2) (ai_place sq_factory_bob) )

	(f_squad_group_place gr_factory_cov_init)
	(f_squad_group_place gr_factory_cov_rush)
	(f_squad_group_place gr_factory_hum_init)

	(if b_factory_ins
		(f_squad_group_place gr_factory_hum_ins)
	)

	(sleep_until (>= objcon_factory 30))
	(f_squad_group_place gr_factory_cov_inside)

)

(script dormant f_factory_cleanup_control

	(sleep_until (volume_test_players tv_factory_cleanup) 5)
	(f_factory_despawn_all)
	(f_factory_kill_scripts)

)

(script static void f_factory_despawn_all

	(ai_erase gr_factory_cov)

)

(script static void f_factory_kill_scripts

	(sleep_forever f_factory_objective_control)
	(sleep_forever f_factory_zoneset_door)
	(sleep_forever f_factory_squad_migrate)
	(sleep_forever f_factory_save_control)
	(sleep_forever f_factory_save_combatend)
	(sleep_forever f_factory_waypoint_control)
	(sleep_forever f_factory_emile_control)
	(sleep_forever f_factory_md_control)
	(sleep_forever f_factory_music_control)
	(sleep_forever f_factory_md_factory_marine_0)
	(sleep_forever f_factory_spawn_control)
	(sleep_forever f_factory_bomb)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

; =================================================================================================
; =================================================================================================
; crane
; =================================================================================================
; =================================================================================================

(global boolean b_crane_hunters_active false)
(script dormant f_crane_objective_control
	(dprint "::: crane encounter :::")
	
	(set b_crane_ready true)
	
	; standard scripts
	(wake f_crane_waypoint_control)
	(wake f_crane_spawn_control)
	(wake f_crane_save_control)
	(wake f_crane_music_control)
	(wake f_crane_md_control)
	(wake f_crane_cleanup_control)
	(wake f_crane_emile_control)
	(wake f_crane_zoneset_door)

	; encounter scripts
	(wake f_crane_phantom)
	(wake f_crane_catwalk_entry)
	(wake f_crane_combat_refresh)
	
	(set b_insertion_fade_in true)
	(f_loadout_set "smelter")

	(dprint "objective control : crane.01")
	(set objcon_crane 1)

	(sleep_until (volume_test_players tv_crane_10) 5)
	(dprint "objective control : crane.10")
	(set objcon_crane 10)

	(sleep_until (volume_test_players tv_crane_20) 5)
	(dprint "objective control : crane.20")
	(set objcon_crane 20)

	(sleep_until (volume_test_players tv_crane_30) 5)
	(dprint "objective control : crane.30")
	(set objcon_crane 30)

	(sleep_until (volume_test_players tv_crane_40) 5)
	(dprint "objective control : crane.40")
	(set objcon_crane 40)

	(sleep_until (volume_test_players tv_crane_45) 5)
	(dprint "objective control : crane.45")
	(set objcon_crane 45)

	(sleep_until (volume_test_players tv_crane_50) 5)
	(dprint "objective control : crane.50")
	(set objcon_crane 50)

	(sleep_until (volume_test_players tv_crane_53) 5)
	(dprint "objective control : crane.53")
	(set objcon_crane 53)

	(sleep_until (volume_test_players tv_crane_55) 5)
	(dprint "objective control : crane.55")
	(set objcon_crane 55)

	(soft_ceiling_enable camera_blocker_08 false)

	(sleep_until (volume_test_players tv_crane_60) 5)
	(dprint "objective control : crane.60")
	(set objcon_crane 60)

	(sleep_until (volume_test_players tv_crane_70) 5)
	(dprint "objective control : crane.70")
	(set objcon_crane 70)

	(sleep_until (volume_test_players tv_crane_75) 5)
	(dprint "objective control : crane.75")
	(set objcon_crane 75)

	(sleep_until (volume_test_players tv_crane_80) 5)
	(dprint "objective control : crane.80")
	(set objcon_crane 80)

)

(script dormant f_crane_zoneset_door

	(device_set_power dm_smelt_door 1)

	(sleep_until (>= objcon_crane 50) 1)
	(device_operates_automatically_set dm_smelt_door false)
	(device_set_position dm_smelt_door 0)
	(sleep_until (= (device_get_position dm_smelt_door) 0) 1)
	(device_set_power dm_smelt_door 0)
	(zone_set_trigger_volume_enable begin_zone_set:set_hall_2 true)

)

(script dormant f_crane_combat_refresh

	(sleep_until
		(begin
			(ai_renew gr_crane_cov_init)
			(>= objcon_crane 30)
		)
	5)

	(sleep_until
		(begin
			(ai_renew sq_crane_marine_low)
			(>= objcon_crane 45)
		)
	5)

)

(global short s_crane_waypoint_timer_platform 180)
(global short s_crane_waypoint_timer_exit 120)
(script dormant f_crane_waypoint_control

	(sleep_until (>= objcon_crane 10) 5)
	(sleep_until (>= objcon_crane 60) 5 (* 30 s_crane_waypoint_timer_platform))
	(if (not (>= objcon_crane 60))
		(begin
			(f_blip_flag fl_crane_waypoint_1 blip_destination)
			(sleep_until (>= objcon_crane 60) 5)
			(f_unblip_flag fl_crane_waypoint_1)
		)
	)

	(sleep_until (<= (ai_task_count obj_crane_cov/gate_hunter) 0))

	(sleep_until (>= objcon_crane 80) 5 (* 30 s_crane_waypoint_timer_exit))
	(if (not (>= objcon_crane 80))
		(begin
			(f_blip_flag fl_crane_waypoint_2 blip_destination)
			(sleep_until (>= objcon_crane 80) 5)
			(f_unblip_flag fl_crane_waypoint_2)
		)
	)

)

(script dormant f_crane_save_control

	(wake f_crane_save_combatend)

	(sleep_until (>= objcon_crane 30) 5)
	(game_save_no_timeout)

	(sleep_until (>= objcon_crane 55) 5)
	(game_save_no_timeout)

)

(script dormant f_crane_save_combatend

	(branch (>= objcon_drop 0) (f_abort))

	(sleep_until (<= (ai_living_count gr_crane_cov) 0))
	(game_save_no_timeout)

)

(script dormant f_crane_emile_control

	(sleep_until
		(and
			(volume_test_object tv_area_crane o_emile)
			(volume_test_players tv_area_crane)
		)
	)
	(ai_set_objective sq_emile obj_crane_hum)
	(sleep 10)
	(ai_vehicle_exit sq_emile)
	(cs_run_command_script sq_emile f_cs_abort)

)

(script dormant f_crane_music_control

	(wake music_crane)
	
	(sleep_until (>= objcon_crane 60) 1)
	(set s_music_crane 1)

)

(script dormant f_crane_md_control

	(f_abort_md)

	; linear
	; ---------------
	(sleep_until (>= objcon_crane 20) 1)
	(md_crane_intro)

	(sleep_until (>= objcon_crane 30) 1)
	(md_crane_combat)

	(sleep_until (>= objcon_crane 40) 1)
	(md_crane_phantom)

	(sleep_until
		(or
			(>= objcon_crane 50)
			(<= (ai_task_count obj_crane_cov/gate_interior) 1)
		)
	1)

	(sleep_until (>= objcon_crane 50) 1 (* 30 120))
	(if (not (>= objcon_crane 50))
		(begin
			(md_crane_room_delay_0)
		)
	)

	(sleep_until
		(or
			(>= objcon_crane 80)
			(and
				(<= (ai_task_count obj_crane_cov/gate_hunter) 0)
				(<= (ai_task_count obj_crane_cov/gate_skirmisher) 0)
			)
		)
	1)

	(sleep_until (>= objcon_crane 80) 1 (* 30 60))
	(if (not (>= objcon_crane 80))
		(begin
			(md_crane_outside_delay_0)
		)
	)

)

(script dormant f_crane_spawn_control
	(dprint "::: spawning all smelter squads")

	(ai_place gr_crane_cov_init)
	(ai_place gr_crane_hum_init)

	(sleep_until (>= objcon_crane 55))
	(ai_place gr_crane_cov_hunters)
	(ai_place sq_crane_skirmishers_1)
	(ai_place sq_crane_skirmishers_2)
	(tick)
	(ai_place sq_catwalk_marine_entry)

)

; phantom
;============================================
(script dormant f_crane_phantom

	(sleep_until (>= objcon_crane 30))
	(ai_place sq_crane_phantom)

)

(global vehicle v_crane_phantom none)
(global boolean b_crane_phantom_drop false)

(script command_script f_cs_crane_phantom

	(dprint "phantom crane")

	(wake f_crane_phantom_spawn_control)

	(set v_crane_phantom (ai_vehicle_get_from_starting_location sq_crane_phantom/driver_01))

	(f_load_phantom ai_current_squad "left" none none sq_crane_cov_backup none)
	;(f_load_phantom ai_current_squad "chute" sq_crane_hunter none none none)
	(set b_crane_hunters_active true)

	; spawning
	;--------------------------------------------
	;(ai_place sq_crane_phantom_hunter)
	(ai_force_active gr_crane_cov_phantom true)
	(sleep 5)
			
	; seating
	;--------------------------------------------	
	;(ai_vehicle_enter_immediate sq_crane_phantom_hunter v_crane_phantom "phantom_p_mr_f")
	;(sleep 1)

	; enter
	;--------------------------------------------
	(cs_fly_by ps_crane_phantom/approach_01)
	(cs_fly_by ps_crane_phantom/approach_02)

	; hover_02
	;--------------------------------------------
	(cs_fly_to_and_face ps_crane_phantom/hover_02 ps_crane_phantom/hover_02_face 1)
	(sleep 15)
	
	; drop_02
	;--------------------------------------------	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face ps_crane_phantom/drop_02 ps_crane_phantom/hover_02_face 1)


	(f_unload_phantom ai_current_squad "left")

	(sleep 150)

	; hover_03
	;--------------------------------------------
	(cs_fly_to_and_face ps_crane_phantom/hover_03 ps_crane_phantom/hover_03_face 1)
	(sleep 150)

	(f_unload_phantom ai_current_squad "chute")
	
	; == exit ====================================================
	(cs_fly_to_and_face ps_crane_phantom/hover_04 ps_crane_phantom/hover_04_face 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_crane_phantom/exit_01)
	(cs_fly_by ps_crane_phantom/exit_02)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(cs_fly_by ps_crane_phantom/erase)
	(ai_erase ai_current_squad)
	
)

(script dormant f_crane_phantom_spawn_control

	(sleep_until (volume_test_players tv_crane_phantom_exit) 5)
	(dprint "phantom can exit")
	(set b_crane_phantom_drop true)

)

(global boolean b_crane_catwalk_entry false)
(script dormant f_crane_catwalk_entry

	(sleep_until (> (ai_living_count gr_crane_cov_hunters) 0))
	(sleep_until (and (<= (ai_living_count gr_crane_cov_hunters) 0) (<= (ai_living_count sq_crane_skirmishers_1) 0) (<= (ai_living_count sq_crane_skirmishers_2) 0) ) 5)
	(device_set_power dm_catwalk_door_entry 1)
	(device_set_position dm_catwalk_door_entry .99)
	(set s_music_crane 2)

)

(script dormant f_crane_cleanup_control

	(sleep_until (volume_test_players tv_crane_cleanup) 5)
	(f_crane_despawn_all)
	(f_crane_kill_scripts)

)

(script static void f_crane_despawn_all
	(dprint "::: despawning all smelter squads")

	(ai_place gr_crane_cov)
	(ai_place gr_crane_hum)

)

(script static void f_crane_kill_scripts

	(sleep_forever f_crane_objective_control)
	(sleep_forever f_crane_zoneset_door)
	(sleep_forever f_crane_combat_refresh)
	(sleep_forever f_crane_waypoint_control)
	(sleep_forever f_crane_save_control)
	(sleep_forever f_crane_save_combatend)
	(sleep_forever f_crane_emile_control)
	(sleep_forever f_crane_music_control)
	(sleep_forever f_crane_md_control)
	(sleep_forever f_crane_spawn_control)
	(sleep_forever f_crane_phantom)
	(sleep_forever f_crane_phantom_spawn_control)
	(sleep_forever f_crane_catwalk_entry)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

; =================================================================================================
; =================================================================================================
; catwalk
; =================================================================================================
; =================================================================================================

(script dormant f_catwalk_objective_control
	(dprint "::: catwalk encounter :::")
	
	; wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))

	(set b_catwalk_ready true)
	
	; standard scripts
	(wake f_catwalk_save_control)
	(wake f_catwalk_waypoint_control)
	(wake f_catwalk_spawn_control)
	(wake f_catwalk_md_control)
	(wake f_catwalk_music_control)
	(wake f_catwalk_cleanup_control)
	(wake f_catwalk_emile_control)
	
	; encounter scripts
	(wake f_catwalk_cov_stairs)
	(wake f_catwalk_zoneset_door)
	(wake f_catwalk_bomb)

	(dprint "objective control : catwalk.1")
	(set objcon_catwalk 1)

	(set b_insertion_fade_in true)

	(sleep_until (volume_test_players tv_catwalk_10) 5)
	(dprint "objective control : catwalk.10")
	(set objcon_catwalk 10)

	(sleep_until (volume_test_players tv_catwalk_20) 5)
	(dprint "objective control : catwalk.20")
	(set objcon_catwalk 20)

	(sleep_until (volume_test_players tv_catwalk_30) 5)
	(dprint "objective control : catwalk.30")
	(set objcon_catwalk 30)

	(sleep_until (volume_test_players tv_catwalk_35) 5)
	(dprint "objective control : catwalk.35")
	(set objcon_catwalk 35)

	(sleep_until (volume_test_players tv_catwalk_40) 5)
	(dprint "objective control : catwalk.40")
	(set objcon_catwalk 40)

	(sleep_until (volume_test_players tv_catwalk_50) 5)
	(dprint "objective control : catwalk.50")
	(set objcon_catwalk 50)

	(sleep_until (volume_test_players tv_catwalk_60) 5)
	(dprint "objective control : catwalk.60")
	(set objcon_catwalk 60)

	(sleep_until (volume_test_players tv_catwalk_70) 5)
	(dprint "objective control : catwalk.70")
	(set objcon_catwalk 70)

	(sleep_until (volume_test_players tv_catwalk_80) 5)
	(dprint "objective control : catwalk.80")
	(set objcon_catwalk 80)

)

(script dormant f_catwalk_music_control

	(wake music_catwalk)

	(sleep_until (>= objcon_catwalk 10))
	(set s_music_catwalk 1)

)

(script dormant f_catwalk_bomb

	(sleep_until (>= objcon_catwalk 70) 1)
	(set b_shake true)
	(sleep 60)
	(interpolator_start base_bombing)
	(sound_impulse_start sound\levels\020_base\base_scripted_expl2 none 1)

)

(script dormant f_catwalk_zoneset_door

	(sleep_until (>= objcon_catwalk 80) 1)
	(device_set_power #_m70_door_small_06 1)
	(device_set_position #_m70_door_small_06 0)
	(device_operates_automatically_set #_m70_door_small_06 false)
	(sleep_until (= (device_get_position #_m70_door_small_06) 0) 1)
	(device_set_power #_m70_door_small_06 0)
	(zone_set_trigger_volume_enable begin_zone_set:set_final_0 true)

)

(script dormant f_catwalk_save_control

	(wake f_catwalk_save_combatend)

	(sleep_until (>= objcon_catwalk 10) 5)
	(game_save_no_timeout)

)

(script dormant f_catwalk_save_combatend

	(branch (>= objcon_platform 0) (f_abort))

	(sleep_until (<= (ai_living_count gr_catwalk_cov) 0))
	(game_save_no_timeout)

)

(global short s_catwalk_waypoint_timer 180)
(script dormant f_catwalk_waypoint_control

	(sleep_until (>= objcon_catwalk 10) 5)
	(sleep_until (>= objcon_catwalk 70) 5 (* 30 s_catwalk_waypoint_timer))
	(if (not (>= objcon_catwalk 70))
		(begin
			(f_blip_flag fl_catwalk_waypoint_1 blip_destination)
			(sleep_until (>= objcon_catwalk 70) 5)
			(f_unblip_flag fl_catwalk_waypoint_1)
		)
	)

)

(script dormant f_catwalk_emile_control

	(sleep_until
		(and
			(volume_test_object tv_area_catwalk o_emile)
			(volume_test_players tv_area_catwalk)
		)
	)
	(ai_set_objective sq_emile obj_catwalk_hum)
	(sleep 10)
	(ai_vehicle_exit sq_emile)
	(cs_run_command_script sq_emile f_cs_abort)

)

(script dormant f_catwalk_md_control

	(f_abort_md)

	; conditional
	; ---------------

	; linear
	; ---------------

	; low delay
	(sleep_until (>= objcon_catwalk 40) 1 (* 30 120))
	(if (not (>= objcon_catwalk 40))
		(begin
			(md_catwalk_floor_delay_0)
		)
	)

	(sleep_until (>= objcon_catwalk 40) 1 (* 30 60))
	(if (not (>= objcon_catwalk 40))
		(begin
			(md_catwalk_floor_delay_1)
		)
	)

	(sleep_until (>= objcon_catwalk 40) 1 (* 30 60))
	(if (not (>= objcon_catwalk 40))
		(begin
			(md_catwalk_floor_delay_2)
		)
	)

	; top delay
	(sleep_until (>= objcon_catwalk 80) 1 (* 30 90))
	(if (not (>= objcon_catwalk 80))
		(begin
			(md_catwalk_top_delay_0)
		)
	)

	(sleep_until (>= objcon_catwalk 80) 1)
	(md_catwalk_exit)

)

(global boolean b_catwalk_cov_stairs false)
(script dormant f_catwalk_cov_stairs

	(sleep_until (objects_can_see_object (players) sq_catwalk_cov_platform 15) 5)
	(set b_catwalk_cov_stairs true)

)

(script dormant f_catwalk_spawn_control

	(dprint "::: spawning all catwalk squads")

	(ai_place gr_catwalk_cov_init)
	(ai_place gr_catwalk_hum_init)
	(tick)
	(ai_braindead sq_catwalk_cov_elite true)

	(sleep_until (>= objcon_catwalk 30) 1)
	(ai_braindead sq_catwalk_cov_elite false)

	(sleep_until (>= objcon_catwalk 40) 1)
	(device_set_power #_m70_door_small_06 1)
	(ai_place sq_catwalk_cov_exit)
	(ai_place sq_catwalk_cov_exit_elites)

)

(script static void f_catwalk_despawn_all

	(ai_erase gr_catwalk_cov)
	(ai_erase gr_catwalk_hum)


)

(script dormant f_catwalk_cleanup_control

	(sleep_until (volume_test_players tv_catwalk_cleanup) 1)
	(f_catwalk_despawn_all)
	(f_catwalk_kill_scripts)

)

(script static void f_catwalk_kill_scripts

	(sleep_forever f_catwalk_objective_control)
	(sleep_forever f_catwalk_zoneset_door)
	(sleep_forever f_catwalk_save_control)
	(sleep_forever f_catwalk_save_combatend)
	(sleep_forever f_catwalk_waypoint_control)
	(sleep_forever f_catwalk_emile_control)
	(sleep_forever f_catwalk_md_control)
	(sleep_forever f_catwalk_cov_stairs)
	(sleep_forever f_catwalk_spawn_control)
	(sleep_forever f_catwalk_bomb)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

; =================================================================================================
; =================================================================================================
; platform
; =================================================================================================
; =================================================================================================

(global short s_platform_wave 0)
(global boolean b_platform_defended false)
(script dormant f_platform_objective_control
	(dprint "::: platform encounter :::")
	
	(set b_platform_ready true)
	
	; standard scripts		
	(wake f_platform_missionobj_control)	
	(wake f_platform_title_control)	
	(wake f_platform_spawn_control)
	(wake f_platform_music_control)
	(wake f_platform_md_control)
	(wake f_platform_save_control)
	(wake f_platform_cleanup_control)

	; encounter scripts	
	(wake f_platform_cannon_init)
	(wake f_platform_emile_control)
	(wake f_platform_finalbattle_control)
	(wake f_platform_zoneset_door)
	(wake f_platform_pillar)

	(dprint "objective control : platform.01")
	(if (not (> objcon_platform 1)) (set objcon_platform 1) )

	(set b_insertion_fade_in true)
	(game_insertion_point_unlock 4)
	(f_loadout_set "platform")

	(sleep_until (or (volume_test_players tv_platform_05) (> objcon_platform 5) ) 1)
	(dprint "objective control : platform.05")
	(if (not (> objcon_platform 5)) (set objcon_platform 5) )
	
	(sleep_until (or (volume_test_players tv_platform_10) (> objcon_platform 10) ) 1)
	(dprint "objective control : platform.10")
	(if (not (> objcon_platform 10)) (set objcon_platform 10) )

	(sleep_until (or (volume_test_players tv_platform_20) (> objcon_platform 20) ) 1)
	(dprint "objective control : platform.20")
	(if (not (> objcon_platform 20)) (set objcon_platform 20) )

	(sleep_until (or (volume_test_players tv_platform_25) (> objcon_platform 25) ) 1)
	(dprint "objective control : platform.25")
	(if (not (> objcon_platform 25)) (set objcon_platform 25) )

	(sleep_until (or (volume_test_players tv_platform_30) (> objcon_platform 30) ) 1)
	(dprint "objective control : platform.30")
	(if (not (> objcon_platform 30)) (set objcon_platform 30) )

	(sleep_until (or (volume_test_players tv_platform_40) (> objcon_platform 40) ) 1)
	(dprint "objective control : platform.40")
	(if (not (> objcon_platform 40)) (set objcon_platform 40) )

	(dprint "objective control : platform.50")
	(set objcon_platform 50)

	(sleep_until (>= s_platform_wave 1))
	(dprint "objective control : platform.60")
	(set objcon_platform 60)

	(sleep_until (>= s_platform_wave 2))
	(dprint "objective control : platform.70")
	(set objcon_platform 70)

	(sleep_until b_platform_defended)
	(dprint "objective control : platform.90")
	(set objcon_platform 90)

)


(script dormant f_platform_pillar

	(sleep_until
		(or 
			(>= objcon_platform 40)
			b_test_finalbattle
		)	
	1)

	(if (not (game_is_cooperative) ) (begin

		(ai_place sq_pillar_guns)
		(ai_cannot_die sq_pillar_guns true)
	
		(tick)
	
		(ai_vehicle_enter_immediate sq_pillar_guns/gun_01 (object_get_turret sc_poa 0) "")
		(ai_vehicle_enter_immediate sq_pillar_guns/gun_02 (object_get_turret sc_poa 1) "")
		(ai_vehicle_enter_immediate sq_pillar_guns/gun_03 (object_get_turret sc_poa 2) "")
		(ai_vehicle_enter_immediate sq_pillar_guns/gun_04 (object_get_turret sc_poa 3) "")
	
		(ai_force_active sq_pillar_guns true)
		(ai_set_targeting_group sq_pillar_guns 76)
		(ai_prefer_target_ai sq_pillar_guns gr_pillar_cov_air true)
		(ai_set_clump sq_pillar_guns 8888)
		(ai_disregard (ai_actors sq_pillar_guns) true)

	))

)


(script command_script f_cs_platform_pillar_turret_1

	(sleep_until
		(begin
			(cs_shoot_point true ps_platform_pillar/p0)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p1)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p2)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p3)
			(sleep 400)
			false
		)
	)

)

(script command_script f_cs_platform_pillar_turret_2

	(sleep_until
		(begin
			(cs_shoot_point true ps_platform_pillar/p0)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p1)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p2)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p3)
			(sleep 400)
			false
		)
	)

)


(script command_script f_cs_platform_pillar_turret_3

	(sleep_until
		(begin
			(cs_shoot_point true ps_platform_pillar/p0)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p1)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p2)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p3)
			(sleep 400)
			false
		)
	)

)


(script command_script f_cs_platform_pillar_turret_4

	(sleep_until
		(begin
			(cs_shoot_point true ps_platform_pillar/p0)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p1)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p2)
			(sleep 400)
			(cs_shoot_point true ps_platform_pillar/p3)
			(sleep 400)
			false
		)
	)

)

(script dormant f_platform_zoneset_door

	(sleep_until (or (volume_test_players tv_area_platform_low)(volume_test_players tv_area_platform_low_2) ) 1 )

	(device_set_power dm_platform_door 1)
	(device_operates_automatically_set dm_platform_door false)
	(device_set_position dm_platform_door 0)
	(sleep_until (= (device_get_position dm_platform_door) 0) 1)

	(print "preparing switch")
	(device_set_power dm_platform_door 0)

	(wake f_platfom_emile_split)
	
	(sleep 10)
	
	(zone_set_trigger_volume_enable begin_zone_set:set_final_1 true)
	(sleep (* 30 5))
	(zone_set_trigger_volume_enable zone_set:set_final_1 true)

)

(global boolean b_platform_emile_split_done false)
(global boolean b_platform_emile_in_gun false)
(script dormant f_platfom_emile_split

	(object_teleport_to_ai_point o_emile ps_platform_emile/mac)
	(sleep_forever f_emile_blip_kill)
	(f_unblip_ai ai_emile)
	(set b_platform_emile_split_done true)
	(sleep (* 30 15))
	(dprint "emile entering gun")	
	(set b_platform_emile_in_gun true)
	(ai_vehicle_enter_immediate ai_emile (ai_vehicle_get_from_starting_location sq_cannon_mac/clean) "mac_d")
	(ai_force_active ai_emile true)
	(ai_set_targeting_group ai_emile 76)
	(ai_set_clump ai_emile 7777)
	(ai_designer_clump_targeting_group 76)
	(ai_prefer_target_ai sq_emile gr_pillar_cov_air true)
	(dprint "emile in gun")	
	(md_platform_emilegun)

)


(script dormant f_platform_missionobj_control

	(if b_ins_platform
		(begin
			(mo_wall)
		)
	)

	(sleep_until (>= objcon_platform 50) 5)
	(sleep 220)
	(mo_platform)

)

(script dormant f_platform_title_control

	(sleep_until (>= objcon_platform 50) 5)
	(tit_platform)

)

(script dormant f_platform_save_control

	(sleep_until (>= objcon_platform 30) 1)
	(game_save_no_timeout)

	(sleep_until (>= objcon_platform 50) 5)
	(game_save_immediate)

	(sleep_until (>= objcon_platform 60) 5)
	(game_save_no_timeout)

	(sleep_until (>= objcon_platform 70) 5)
	(game_save_no_timeout)

	(sleep_until (>= objcon_platform 90) 5)
	(game_save_no_timeout)

)

(script dormant f_platform_cannon_init

	(sleep_until
		(or
			(>= objcon_platform 20)
			(> objcon_zealot 0)
			(> objcon_cannon 0)
			b_test_cruiser
		)
	1)
	(ai_place sq_cannon_mac/clean)

)

(script dormant f_platform_emile_control

	(sleep_until
		(and
			(volume_test_object tv_area_hall_2 o_emile)
			(volume_test_players tv_area_hall_2)
		)
	)
	(ai_set_objective sq_emile obj_platform_hum)
	(sleep 10)
	(ai_vehicle_exit sq_emile)
	(cs_run_command_script sq_emile f_cs_abort)

)

(script dormant f_platform_md_control

	(f_abort_md)

	(sleep_until (>= objcon_platform 30) 1)
	(f_abort_md)
	(md_platform_intro)

	(sleep_until (>= objcon_platform 50) 1)
	(sleep_until (>= objcon_platform 60) 1 (* 30 180))
	(if (not (>= objcon_platform 60))
		(begin
			(md_platform_wave_0_delay_0)
		)
	)

	(sleep_until (>= objcon_platform 60) 1)
	(md_platform_wave_1)

	; wave 1 delay
	(sleep_until (>= objcon_platform 70) 1 (* 30 180))
	(if (not (>= objcon_platform 70))
		(begin
			(md_platform_wave_1_delay_0)
		)
	)

	; wave 2
	(sleep_until (>= objcon_platform 70) 1)
	(sleep (* 30 5))
	(md_platform_wave_2)

	; wave 2 delay
	(sleep_until (>= objcon_platform 90) 1 (* 30 180))
	(if (not (>= objcon_platform 90))
		(begin
			(if (> (ai_living_count obj_platform_hum ) 0)
				(md_platform_wave_2_delay_0_marine)
				(md_platform_wave_2_delay_0)
			)
		)
	)

	; combat done
	(sleep_until (>= objcon_platform 90) 1)
	(sleep (* 30 5))
	(md_platform_done)

	(sleep (* 30 10))
	(md_platform_keyesenter)

)

(script dormant f_platform_finalbattle_control

	(if (not b_ins_platform_2) (begin

		(sleep_until
			(or
				(>= objcon_platform 10)
				b_test_finalbattle
			)
		)
		
		(flock_create "flc_pillar_warthog_01")
		(flock_create "flc_pillar_scorpion_01")
		(flock_create "flc_pillar_wraith_01")
		(flock_create "flc_pillar_ghost_01")
		(flock_create "flc_pillar_phantom_01")
		(flock_create "flc_pillar_banshee_01")
		(flock_create "flc_pillar_falcon_01")
		
		(sleep_until
			(or
				(>= objcon_platform 40)
				b_test_finalbattle
			)
		)
	
		(sleep (* 30 1))
		(wake f_platform_banshee_spawn)
		(wake f_platform_phantom_spawn)
	
		(sleep (* 30 20))
		(wake f_platform_scarab_1)
		(wake f_platform_scarab_2)

	))

)

(script static void f_platform_flock_delete

	(flock_delete "flc_pillar_phantom_01")
	(flock_delete "flc_pillar_banshee_01")
	(flock_delete "flc_pillar_falcon_01")

)

(global short s_platform_scarab_1_loops 15)
(global short s_platform_scarab_1_loop_idx 0)
(global short s_platform_scarab_1_drop_time 6)
(global short s_platform_scarab_1_idwlk_time 6)
(global short s_platform_scarab_1_walk_time 6)
(global short s_platform_scarab_1_wlkid_time 6)
(script dormant f_platform_scarab_1

	(object_create dm_platform_scarab_1)
	(device_set_power dm_platform_scarab_1 1)

	(device_set_position_track dm_platform_scarab_1 "device:scarab_drop" 0)
 	(print "init anim start")	
  (device_animate_position dm_platform_scarab_1 1 s_platform_scarab_1_drop_time 0.034 0.034 false)
	(sleep (- (* s_platform_scarab_1_drop_time 30) 2) )

	(device_set_position_track dm_platform_scarab_1 "device:idle_2_move_front" 0)
 	(print "init anim start")	
  (device_animate_position dm_platform_scarab_1 1 s_platform_scarab_1_idwlk_time 0.034 0.034 false)
	(sleep (- (* s_platform_scarab_1_idwlk_time 30) 2) )

	(sleep_until
		(begin
			(device_set_position_track dm_platform_scarab_1 "device:move_front" 0)	
  		(device_animate_position dm_platform_scarab_1 1 s_platform_scarab_1_walk_time 0.034 0.034 false)
			(set s_platform_scarab_1_loop_idx (+ s_platform_scarab_1_loop_idx 1))
			(sleep (- (* s_platform_scarab_1_walk_time 30) 2) )
			(>= s_platform_scarab_1_loop_idx s_platform_scarab_1_loops)
		)
	1)

	(device_set_position_track dm_platform_scarab_1 "device:move_front_2_idle" 0)
 	(print "init anim start")	
  (device_animate_position dm_platform_scarab_1 1 s_platform_scarab_1_wlkid_time 0.034 0.034 false)
	(sleep (- (* s_platform_scarab_1_wlkid_time 30) 2) )

  (sleep_until
    (begin
	    (device_set_position_track dm_platform_scarab_1 stationary_march 0)
	    (device_animate_position dm_platform_scarab_1 1.0 (random_range 7 10) 1.0 1.0 true)
	    (sleep_until (>= (device_get_position dm_platform_scarab_1) 1) 1)
	    (sleep (random_range 0 20))
    0)
  )

)

(global short s_platform_scarab_2_loops 15)
(global short s_platform_scarab_2_loop_idx 0)
(global short s_platform_scarab_2_drop_time 6)
(global short s_platform_scarab_2_idwlk_time 6)
(global short s_platform_scarab_2_walk_time 6)
(global short s_platform_scarab_2_wlkid_time 6)
(script dormant f_platform_scarab_2

	(sleep 35)

	(object_create dm_platform_scarab_2)
	(device_set_power dm_platform_scarab_2 1)

	(device_set_position_track dm_platform_scarab_2 "device:scarab_drop" 0)
 	(print "init anim start")	
  (device_animate_position dm_platform_scarab_2 1 s_platform_scarab_2_drop_time 0.034 0.034 false)
	(sleep (- (* s_platform_scarab_2_drop_time 30) 2) )

	(device_set_position_track dm_platform_scarab_2 "device:idle_2_move_front" 0)
 	(print "init anim start")	
  (device_animate_position dm_platform_scarab_2 1 s_platform_scarab_2_idwlk_time 0.034 0.034 false)
	(sleep (- (* s_platform_scarab_2_idwlk_time 30) 2) )

	(sleep_until
		(begin
			(device_set_position_track dm_platform_scarab_2 "device:move_front" 0)	
  		(device_animate_position dm_platform_scarab_2 1 s_platform_scarab_2_walk_time 0.034 0.034 false)
			(set s_platform_scarab_2_loop_idx (+ s_platform_scarab_2_loop_idx 1))
			(sleep (- (* s_platform_scarab_2_walk_time 30) 2) )
			(>= s_platform_scarab_2_loop_idx s_platform_scarab_2_loops)
		)
	1)

	(device_set_position_track dm_platform_scarab_2 "device:move_front_2_idle" 0)
 	(print "init anim start")	
  (device_animate_position dm_platform_scarab_2 1 s_platform_scarab_2_wlkid_time 0.034 0.034 false)
	(sleep (- (* s_platform_scarab_2_wlkid_time 30) 2) )

  (sleep_until
    (begin
	    (device_set_position_track dm_platform_scarab_2 stationary_march 0)
	    (device_animate_position dm_platform_scarab_2 1.0 (random_range 7 10) 1.0 1.0 true)
	    (sleep_until (>= (device_get_position dm_platform_scarab_2) 1) 1)
	    (sleep (random_range 0 20))
    0)
  )


)

(script static void f_platform_door_open

	(dprint "door opening")
	(device_operates_automatically_set #_m70_door_ff_01 false)
	(device_set_power #_m70_door_ff_01 1)
	(device_set_position #_m70_door_ff_01 .9)


)

(script static void f_platform_door_close

	(dprint "door opening")
	(device_set_power #_m70_door_ff_01 1)
	(device_operates_automatically_set #_m70_door_ff_01 false)
	(device_set_position #_m70_door_ff_01 1)
	(sleep_until (<= (device_get_position #_m70_door_ff_01) 0))
	(device_set_power #_m70_door_ff_01 0)

)

(script command_script f_cs_platform_emile_shoot

	(sleep_until
		(begin
			(cs_shoot_point true ps_platform_mac/p0)
			(sleep 120)
			(cs_shoot_point false ps_platform_mac/p0)
			(sleep 600)
			(cs_shoot_point true ps_platform_mac/p1)
			(sleep 120)
			(cs_shoot_point false ps_platform_mac/p1)
			(sleep 600)
			(cs_shoot_point true ps_platform_mac/p2)
			(sleep 120)
			(cs_shoot_point false ps_platform_mac/p2)
			(sleep 600)
			false
		)
	1)

)

(script dormant f_platform_music_control

	(wake music_platform)
	(wake f_platform_hammer_death)
	(wake f_platform_plasma_death)

	(sleep_until (>= objcon_platform 25) 1)
	(set s_music_platform 1)
	(set s_music_bravo 2)

	(sleep_until (>= objcon_platform 70) 1)
	(set s_music_platform 4)

	(sleep_until (>= objcon_platform 80) 1)
	(set s_music_platform 5)

)

(script dormant f_platform_hammer_death

	(sleep_until (> (ai_living_count sq_platform_w1_4b) 0))
	(sleep_until (<= (ai_living_count sq_platform_w1_4b) 0))
	(set s_music_platform 4)

)

(script dormant f_platform_plasma_death

	(sleep_until (> (ai_living_count sq_platform_w2_3/main) 0))
	(sleep_until (<= (ai_living_count sq_platform_w2_3/main) 0))
	(set s_music_platform 5)

)

(script dormant f_platform_spawn_control
	(dprint "::: spawning all platform squads")

	(sleep 10)

	(if (< objcon_platform 40)
		(begin

			(if
				(not (game_is_cooperative))
				(begin
					(ai_place sq_platform_marine_w0_1)
				)
			)

			(ai_place sq_platform_marine_w0_2)
			(ai_place sq_platform_cov_interior)

		)
	)

	(sleep_until
		(begin
			(ai_renew sq_platform_marine_w0_1)
			(ai_renew sq_platform_marine_w0_2)
			(ai_renew sq_platform_cov_interior)
			(>= objcon_platform 5)
		)
	2)

	(sleep_until (>= objcon_platform 40) 1)

	(if b_ins_platform_2 (begin
		(ai_place sq_platform_marine_w0_1_ins)
		(ai_place sq_platform_marine_w0_2_ins)
	))

	(ai_place sq_platform_w0_0a)
	(ai_place sq_platform_w0_0b)

	(ai_place sq_platform_phantom_w0_1)
	(sleep (* 30 8))
	(ai_place sq_platform_phantom_w0_2)

	; dropship 1
	(sleep_until
		(and
			(<= (ai_living_count gr_platform_cov) 2)
			(or
				(not b_platform_phantom_w0_1_spawn)
				(<= (object_get_health (ai_vehicle_get_from_squad sq_platform_phantom_w0_1 0) ) 0)
			)
			(or
				(not b_platform_phantom_w0_2_spawn)
				(<= (object_get_health (ai_vehicle_get_from_squad sq_platform_phantom_w0_2 0) ) 0)
			)
		)
	5)

	(ai_place sq_platform_phantom_w1_1)
	(ai_place sq_platform_phantom_w1_2)
	(sleep 90)
	(set s_platform_wave 1)
	(sleep 120)
	(ai_place sq_platform_pelican_drop)
	(sleep 30)
	(ai_reset_objective obj_platform_cov/gate_area)
	
	; dropship 2
	(sleep_until
		(and
			(<= (ai_living_count gr_platform_cov) 2)
			(or
				(not b_platform_phantom_w1_1_spawn)
				(<= (object_get_health (ai_vehicle_get_from_squad sq_platform_phantom_w1_1 0) ) 0)
			)
			(or
				(not b_platform_phantom_w1_2_spawn)
				(<= (object_get_health (ai_vehicle_get_from_squad sq_platform_phantom_w1_2 0) ) 0)
			)
		)
	5)

	;*

	(if (<= (ai_living_count gr_platform_hum_marines) 1)
		(begin
			(ai_place sq_platform_pelican_drop)
		)
	)

	*;

	(ai_place sq_platform_phantom_w2_1)
	(ai_place sq_platform_phantom_w2_2)
	(set s_platform_wave 2)
	(wake f_platform_bezerk)

	(sleep 30)
	(ai_reset_objective obj_platform_cov/gate_area)
	

	; keyes
	(sleep_until
		(and
			(or
				(not b_platform_phantom_w2_2_spawn)
				(<= (object_get_health (ai_vehicle_get_from_squad sq_platform_phantom_w2_1 0)) 0)
			)
			(or
				(not b_platform_phantom_w2_2_spawn)
				(<= (object_get_health (ai_vehicle_get_from_squad sq_platform_phantom_w2_2 0)) 0)
			)
		)
	5)

	(sleep_until
		(and
			(<= (ai_living_count gr_platform_cov) 3)
			(<= (ai_living_count sq_platform_w1_4b) 0)
			(<= (ai_living_count sq_platform_w1_4a) 0)
			(<= (ai_living_count sq_platform_w2_3/main) 0)
		)
	5)

	(wake f_platform_end_timer)
	(sleep_until
		(or
			(<= (ai_living_count gr_platform_cov) 2)
			(and
				(volume_test_players tv_platform_pad)
				b_platform_end_timer
			)
		)
	5)

	(set b_platform_defended true)
	(ai_place sq_platform_pelican_keyes/enter)
	(ai_place sq_platform_pelican_keyes_1)
	(wake f_platform_keyes_handoff)

)

(global boolean b_platform_end_timer false)
(script dormant f_platform_end_timer

	(sleep 450)
	(set b_platform_end_timer true)

)

(global boolean b_platform_bezerk false)
(script dormant f_platform_bezerk

	(sleep (* 30 480))
	(set b_platform_bezerk true)

)

(script dormant f_platform_banshee_spawn

	(sleep_until
		(begin
		
		(if (<= (ai_living_count sq_pillar_banshee_1) 0)(ai_place sq_pillar_banshee_1)(sleep 30))
		(if (<= (ai_living_count sq_pillar_banshee_2) 0)(ai_place sq_pillar_banshee_2)(sleep 30))
		(if (<= (ai_living_count sq_pillar_banshee_3) 0)(ai_place sq_pillar_banshee_3)(sleep 30))
		(if (<= (ai_living_count sq_pillar_banshee_4) 0)(ai_place sq_pillar_banshee_4)(sleep 30))
		(if (<= (ai_living_count sq_pillar_banshee_5) 0)(ai_place sq_pillar_banshee_5)(sleep 30))
		
		(ai_set_targeting_group gr_pillar_cov_air 76)

		b_platform_defended)

	30)

)


(script dormant f_platform_phantom_spawn

	(sleep_until
		(begin
		
		(if (<= (ai_living_count sq_pillar_phantom_1) 0)
			(begin
				(ai_place sq_pillar_phantom_1)
				(sleep 30)
			)
		)
		(if (<= (ai_living_count sq_pillar_phantom_2) 0)
			(begin
				(ai_place sq_pillar_phantom_2)
				(sleep 30)
			)
		)
		
		(ai_set_targeting_group gr_pillar_cov_air 76)

		b_platform_defended)

	30)

)

(script command_script f_cs_vehicle_scale

	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(tick)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 10))

)

(global boolean b_platform_phantom_w0_1_spawn false)
(script command_script f_cs_platform_phantom_w0_1

	(set b_platform_phantom_w0_1_spawn true)

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(f_load_phantom ai_current_squad "right" sq_platform_w0_2 sq_platform_w0_1 none none)
	(cs_fly_by ps_platform_phantom_w0_1/enter_01)
	(cs_fly_by ps_platform_phantom_w0_1/enter_02)
	(cs_vehicle_speed .5)	
	(cs_fly_to_and_face ps_platform_phantom_w0_1/hover_01 ps_platform_phantom_w0_1/hover_01_face .1)
	(sleep 1)
	(cs_fly_to_and_face ps_platform_phantom_w0_1/drop_01 ps_platform_phantom_w0_1/drop_01_face .1)
	(f_unload_phantom ai_current_squad "right")
	(sleep 30)
	(set b_platform_phantom_w0_1_spawn false)
	(cs_fly_to_and_face ps_platform_phantom_w0_1/hover_01 ps_platform_phantom_w0_1/hover_01_face 1)
	(ai_set_targeting_group ai_current_squad 76)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_platform_phantom_w0_1/exit_01)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(cs_fly_by ps_platform_phantom_w0_1/erase)
	(ai_erase ai_current_squad)

)

(global boolean b_platform_phantom_w0_2_spawn false)
(script command_script f_cs_platform_phantom_w0_2

	(set b_platform_phantom_w0_2_spawn true)

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(f_load_phantom ai_current_squad "right" sq_platform_w0_3 sq_platform_w0_4 none none)
	(cs_fly_by ps_platform_phantom_w0_2/enter_01)
	(cs_fly_by ps_platform_phantom_w0_2/enter_02)
	(cs_vehicle_speed .5)	
	(cs_fly_to_and_face ps_platform_phantom_w0_2/hover_01 ps_platform_phantom_w0_2/hover_01_face .1)
	(sleep 1)
	(cs_fly_to_and_face ps_platform_phantom_w0_2/drop_01 ps_platform_phantom_w0_2/drop_01_face .1)
	(f_unload_phantom ai_current_squad "right")
	(sleep 30)
	(set b_platform_phantom_w0_2_spawn false)
	(cs_fly_to_and_face ps_platform_phantom_w0_2/hover_01 ps_platform_phantom_w0_2/hover_01_face 1)
	(ai_set_targeting_group ai_current_squad 76)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_platform_phantom_w0_2/exit_01)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(cs_fly_by ps_platform_phantom_w0_2/erase)
	(ai_erase ai_current_squad)

)


(global boolean b_platform_phantom_w1_1_spawn false)
(script command_script f_cs_platform_phantom_w1_1

	(set b_platform_phantom_w1_1_spawn true)

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(f_load_phantom ai_current_squad "right" sq_platform_w1_1 sq_platform_w1_2 none none)
	(cs_fly_by ps_platform_phantom_w1_1/enter_01)
	(cs_fly_by ps_platform_phantom_w1_1/enter_02)
	(cs_fly_by ps_platform_phantom_w1_1/enter_03)
	(cs_vehicle_speed .5)	
	(cs_fly_to_and_face ps_platform_phantom_w1_1/hover_01 ps_platform_phantom_w1_1/hover_01_face .1)
	(sleep 1)
	(cs_fly_to_and_face ps_platform_phantom_w1_1/drop_01 ps_platform_phantom_w1_1/drop_01_face .1)
	(f_unload_phantom ai_current_squad "right")
	(sleep 30)
	(set b_platform_phantom_w1_1_spawn false)
	(cs_fly_to_and_face ps_platform_phantom_w1_1/hover_01 ps_platform_phantom_w1_1/hover_01_face 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_platform_phantom_w1_1/exit_01)
	(ai_set_targeting_group ai_current_squad 76)
	(cs_fly_by ps_platform_phantom_w1_1/exit_02)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(cs_fly_by ps_platform_phantom_w1_1/erase)
	(ai_erase ai_current_squad)

)

(global boolean b_platform_phantom_w1_2_spawn false)
(script command_script f_cs_platform_phantom_w1_2

	(set b_platform_phantom_w1_2_spawn true)

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(f_load_phantom ai_current_squad "left" sq_platform_w1_3 sq_platform_w1_4a sq_platform_w1_4b none)
	(cs_fly_by ps_platform_phantom_w1_2/enter_01)
	(cs_fly_by ps_platform_phantom_w1_2/enter_02)
	(cs_vehicle_speed .5)	
	(cs_fly_to_and_face ps_platform_phantom_w1_2/hover_01 ps_platform_phantom_w1_2/hover_01_face .1)
	(sleep 1)
	(cs_fly_to_and_face ps_platform_phantom_w1_2/drop_01 ps_platform_phantom_w1_2/drop_01_face .1)
	(f_unload_phantom ai_current_squad "left")
	(sleep 30)
	(set b_platform_phantom_w1_2_spawn false)
	(cs_fly_to_and_face ps_platform_phantom_w1_2/hover_01 ps_platform_phantom_w1_2/hover_01_face 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_platform_phantom_w1_2/exit_01)
	(ai_set_targeting_group ai_current_squad 76)
	(cs_fly_by ps_platform_phantom_w1_2/exit_02)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(cs_fly_by ps_platform_phantom_w1_2/erase)
	(ai_erase ai_current_squad)

)

(global boolean b_platform_phantom_w2_1_spawn false)
(script command_script f_cs_platform_phantom_w2_1

	(set b_platform_phantom_w2_1_spawn true)

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(f_load_phantom ai_current_squad "right" sq_platform_w2_1 sq_platform_w2_2 none none)
	(cs_fly_by ps_platform_phantom_w2_1/enter_01)
	(cs_fly_by ps_platform_phantom_w2_1/enter_02)
	(cs_vehicle_speed .5)	
	(cs_fly_to_and_face ps_platform_phantom_w2_1/hover_01 ps_platform_phantom_w2_1/hover_01_face .1)
	(sleep 1)
	(cs_fly_to_and_face ps_platform_phantom_w2_1/drop_01 ps_platform_phantom_w2_1/drop_01_face .1)
	(f_unload_phantom ai_current_squad "right")
	(sleep 30)
	(set b_platform_phantom_w2_1_spawn false)
	(cs_fly_to_and_face ps_platform_phantom_w2_1/hover_01 ps_platform_phantom_w2_1/hover_01_face 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_platform_phantom_w2_1/exit_01)
	(ai_set_targeting_group ai_current_squad 76)
	(cs_fly_by ps_platform_phantom_w2_1/exit_02)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(cs_fly_by ps_platform_phantom_w2_1/erase)
	(ai_erase ai_current_squad)

)

(global boolean b_platform_phantom_w2_2_spawn false)
(script command_script f_cs_platform_phantom_w2_2

	(set b_platform_phantom_w2_2_spawn true)

	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(cs_fly_by ps_platform_phantom_w2_2/enter_01)
	(cs_fly_by ps_platform_phantom_w2_2/enter_02)
	(cs_vehicle_speed .5)	
	(cs_fly_to_and_face ps_platform_phantom_w2_2/hover_01 ps_platform_phantom_w2_2/hover_01_face .1)
	(sleep (* 30 1))
	(cs_fly_to_and_face ps_platform_phantom_w2_2/drop_01 ps_platform_phantom_w2_2/drop_01_face .1)
	(sleep (* 30 1))
	(ai_place sq_platform_w2_3)
	(ai_vehicle_enter_immediate sq_platform_w2_3 (ai_vehicle_get ai_current_actor) "phantom_pc")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_pc")
	(sleep (* 30 3))
	(set b_platform_phantom_w2_2_spawn false)
	(cs_fly_to_and_face ps_platform_phantom_w2_2/hover_01 ps_platform_phantom_w2_2/hover_01_face 1)
	(ai_set_targeting_group ai_current_squad 76)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_platform_phantom_w2_2/exit_01)
	(cs_fly_by ps_platform_phantom_w2_1/exit_02)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(cs_fly_by ps_platform_phantom_w2_2/erase)
	(ai_erase ai_current_squad)


)

(script command_script f_cs_platform_pelican_drop

	(object_cannot_die ai_current_actor true)

	(if
		(game_is_cooperative)
		(begin
			(f_load_pelican ai_current_squad "dual" sq_platform_marine_drop_1 none)
		)
		(begin
			(f_load_pelican ai_current_squad "dual" sq_platform_marine_drop_1 sq_platform_marine_drop_2)
		)
	)


	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)

	; enter
	;--------------------------------------------
	(cs_fly_by ps_platform_pelican_drop/enter_01)
	(cs_fly_by ps_platform_pelican_drop/enter_02)
	(cs_fly_by ps_platform_pelican_drop/enter_03)
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face ps_platform_pelican_drop/hover_01 ps_platform_pelican_drop/hover_01_face 1)
	(cs_fly_to_and_face ps_platform_pelican_drop/drop_01 ps_platform_pelican_drop/drop_01_face 1)

	; unload
	;--------------------------------------------
	(f_unload_pelican_all ai_current_squad)
	
	(sleep 240)
	(unit_close ai_current_actor)

	; exit
	;--------------------------------------------
	(cs_fly_to_and_face ps_platform_pelican_drop/hover_01 ps_platform_pelican_drop/hover_01_face 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_platform_pelican_drop/exit_01)
	(cs_fly_by ps_platform_pelican_drop/erase)
	(ai_erase ai_current_squad)

)


(script command_script f_cs_platform_pelican_keyes_1

	(object_cannot_die ai_current_actor true)
	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)

	; enter
	;--------------------------------------------
	(cs_fly_by ps_platform_pelican_keyes_1/enter_01)
	(cs_fly_by ps_platform_pelican_keyes_1/enter_02)
	(cs_fly_by ps_platform_pelican_keyes_1/enter_03)
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face ps_platform_pelican_keyes_1/hover_01 ps_platform_pelican_keyes_1/hover_01_face 1)

)


(global boolean b_platform_keyes_handoff false)
(script dormant f_platform_keyes_handoff

	(sleep_until b_platform_keyes_landed 5)

	(sleep_until (volume_test_players tv_platform_keyes) 5)

	(set b_platform_keyes_handoff true)

	(zone_set_trigger_volume_enable begin_zone_set:set_final_1 false)
	(zone_set_trigger_volume_enable zone_set:set_final_1 false)

	(cinematic_enter 070lb_delivery true)
	(f_cin_delivery_prep)
  (f_play_cinematic_advanced 070lb_delivery set_package_cinematic set_final_2)
	(f_cin_delivery_finish)
  (cinematic_exit 070lb_delivery false)

	(set b_cannon_ready true)
	(set b_zealot_ready true)

)

(script static void f_cin_delivery_prep

	(set b_cin_delivery_rain true)
	(ai_erase sq_cannon_mac)
	(ai_erase sq_platform_pelican_keyes)
	(ai_erase sq_platform_pelican_keyes_1)
	(ai_erase gr_platform_hum)
	(ai_erase gr_platform_cov)

	(object_destroy_type_mask 2)

	(object_teleport_to_ai_point player0 ps_platform_cin/p0)
	(object_teleport_to_ai_point player1 ps_platform_cin/p1)
	(object_teleport_to_ai_point player2 ps_platform_cin/p2)
	(object_teleport_to_ai_point player3 ps_platform_cin/p3)

)

(script static void f_cin_delivery_finish

	(ai_place sq_cannon_mac/broken_glass)
	(ai_place sq_platform_pelican_keyes/exit)
	(ai_erase sq_emile)
	(f_package_destroy)

	(object_teleport_to_ai_point player0 ps_zealot_spawn/player0)
	(object_teleport_to_ai_point player1 ps_zealot_spawn/player1)
	(object_teleport_to_ai_point player2 ps_zealot_spawn/player2)
	(object_teleport_to_ai_point player3 ps_zealot_spawn/player3)

)

(global boolean b_platform_keyes_landed false)
(script command_script f_cs_platform_pelican_keyes

	(object_cannot_die ai_current_actor true)
	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(wake f_blip_keyes)
	(cs_fly_by ps_platform_pelican_keyes/enter_01 10)
	(cs_fly_by ps_platform_pelican_keyes/enter_02 10)
	(cs_fly_by ps_platform_pelican_keyes/enter_03 10)
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face ps_platform_pelican_keyes/hover_01 ps_platform_pelican_keyes/hover_01_face .25)
	(wake f_md_platform_keyesland)
	(set b_platform_keyes_landed true)
	(cs_fly_to_and_face ps_platform_pelican_keyes/drop_01 ps_platform_pelican_keyes/drop_01_face .25)

)


(script command_script f_cs_platform_pelican_keyes_exit

	(object_cannot_die ai_current_actor true)
	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(cs_fly_by ps_platform_pelican_keyes/exit_01 1)
	(cs_fly_by ps_platform_pelican_keyes/exit_02 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(cs_fly_by ps_platform_pelican_keyes/erase 1)
	(ai_erase ai_current_squad)

)


(script dormant f_blip_keyes

	(f_blip_ai sq_platform_pelican_keyes/enter blip_destination)

)


(script dormant f_md_platform_keyesland

	(if (not (volume_test_players tv_platform_keyes)) (begin

		(md_platform_keyesland)

	))

)

(script dormant f_platform_cleanup_control

	(sleep_until b_platform_keyes_handoff)
	(f_platform_despawn_all)
	(f_platform_kill_scripts)

)


(script static void f_platform_despawn_all

	(ai_erase gr_platform_cov)
	(ai_erase gr_platform_hum)

)

(script static void f_platform_kill_scripts

	(sleep_forever f_platform_objective_control)
	(sleep_forever f_platform_zoneset_door)
	(sleep_forever f_platform_missionobj_control)
	(sleep_forever f_platform_title_control)
	(sleep_forever f_platform_save_control)
	(sleep_forever f_platform_cannon_init)
	(sleep_forever f_platform_emile_control)
	(sleep_forever f_platform_md_control)
	(sleep_forever f_platform_finalbattle_control)
	(sleep_forever f_platform_scarab_1)
	(sleep_forever f_platform_scarab_2)
	(sleep_forever f_platform_spawn_control)
	(sleep_forever f_platform_banshee_spawn)
	(sleep_forever f_platform_phantom_spawn)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)


; =================================================================================================
; =================================================================================================
; zealot
; =================================================================================================
; =================================================================================================

(script dormant f_zealot_objective_control
	(dprint "::: zealot encounter :::")
	
	; wait until the zone is loaded
	;(sleep_until
		;(or
			;(= (current_zone_set_fully_active) 1)
			;(= (current_zone_set_fully_active) 2)))

	(set b_zealot_ready true)

	; standard scripts	
	(wake f_zealot_missionobj_control)
	(wake f_zealot_save_control)
	(wake f_zealot_hilite_control)
	(wake f_zealot_waypoint_control)
	(wake f_zealot_spawn_control)
	(wake f_zealot_music_control)
	(wake f_zealot_md_control)
	(wake f_zealot_cleanup_control)

	; encounter scripts	
	(wake f_zealot_elite_story_control)
	(wake f_zealot_cruiser)
	(wake f_zealot_door)
	(wake f_zealot_pillar_control)

	(dprint "objective control : zealot.1")
	(set objcon_zealot 1)

	(set b_insertion_fade_in true)

	(sleep_until (volume_test_players tv_zealot_platform_mid) 5)
	(dprint "objective control : zealot.20")
	(set objcon_zealot 20)

	(sleep_until (volume_test_players tv_zealot_stair) 5)
	(dprint "objective control : zealot.25")
	(set objcon_zealot 25)

	(sleep_until (volume_test_players tv_zealot_door) 5)
	(dprint "objective control : zealot.27")
	(set objcon_zealot 27)

	(sleep_until (volume_test_players tv_zealot_int_step) 5)
	(dprint "objective control : zealot.30")
	(set objcon_zealot 30)

	(sleep_until (volume_test_players tv_zealot_ledge) 5)
	(dprint "objective control : zealot.40")
	(set objcon_zealot 40)

	(sleep_until (volume_test_players tv_zealot_step_near) 5)
	(dprint "objective control : zealot.45")
	(set objcon_zealot 45)

	(sleep_until (volume_test_players tv_zealot_step) 5)
	(dprint "objective control : zealot.50")
	(set objcon_zealot 50)

	(sleep_until (volume_test_players tv_zealot_end) 5)
	(dprint "objective control : zealot.90")
	(set objcon_zealot 90)
	
)

(script dormant f_zealot_pillar_control

	(sleep_until
		(begin
			(scenery_animation_start sc_poa objects\vehicles\human\unsc_fleet\unsc_halcyon_class_cruiser_poa\unsc_halcyon_class_cruiser_poa any:thruster)
		false)
	(* 30 (random_range 10 20)))
	
)

(script dormant f_zealot_camointro

	(ai_set_active_camo sq_zealot_elite_ext_1 false)

	(sleep_until (>= objcon_zealot 20) 5)

	(cs_force_combat_status sq_zealot_elite_ext_1 2)
	(ai_set_active_camo sq_zealot_elite_ext_1 true)

)

(script dormant f_zealot_missionobj_control

	(sleep_until (>= objcon_zealot 1) 5)
	(mo_zealot)

)

(script dormant f_zealot_save_control

	(wake f_zealot_save_combatend)

	(sleep_until (>= objcon_zealot 1))
	(sleep (* 30 5))
	(game_save_no_timeout)

	(sleep_until (>= objcon_zealot 40))
	(game_save_no_timeout)

)

(script dormant f_zealot_save_combatend

	(branch (>= objcon_cannon 0) (f_abort))

	(sleep_until (<= (ai_living_count gr_zealot_cov) 0))
	(game_save_no_timeout)

)

(script dormant f_zealot_hilite_control

	(sleep_until
		(or
			(>= objcon_zealot 1)
			true
		)
	5)
	
	(sleep 120)
	
	(sleep_until
		(or
			(objects_can_see_object player0 sc_zealot_hilite_mac_marker 25)
			(objects_can_see_object player1 sc_zealot_hilite_mac_marker 25)
			(objects_can_see_object player2 sc_zealot_hilite_mac_marker 25)
			(objects_can_see_object player3 sc_zealot_hilite_mac_marker 25)
		)
	1)

	(f_hud_flash_object sc_zealot_hilite_mac)
	(object_destroy sc_zealot_hilite_mac)

)

(global short s_zealot_waypoint_timer_door 90)
(global short s_zealot_waypoint_timer_cannon 180)
(script dormant f_zealot_waypoint_control

	; nonlinear

	; linear
	(sleep_until (>= objcon_zealot 1))

	(sleep_until (>= objcon_zealot 27) 5 (* 30 s_zealot_waypoint_timer_door))
	(if (not (>= objcon_zealot 27))
		(begin
			(f_blip_flag fl_zealot_waypoint_1 blip_destination)
			(sleep_until (>= objcon_zealot 27) 5)
			(f_unblip_flag fl_zealot_waypoint_1)
		)
	)

	(sleep_until (>= objcon_cannon 10) 5 (* 30 s_zealot_waypoint_timer_cannon))
	(if (not (>= objcon_cannon 10))
		(begin
			(f_blip_flag fl_zealot_waypoint_2 blip_destination)
			(sleep_until (>= objcon_cannon 10) 5)
			(f_unblip_flag fl_zealot_waypoint_2)
		)
	)

)

(script dormant f_zealot_cruiser

	(set b_cruiser_moving true)

	(object_create dm_cannon_cruiser)
	(object_cannot_take_damage dm_cannon_cruiser)
	(device_set_position_immediate dm_cannon_cruiser 0)

	(sleep_until (>= objcon_zealot 1))
	(wake f_zealot_cruiser_move)

)

(script dormant f_zealot_cruiser_move

	(print "cruiser move")

	(device_set_position_track dm_cannon_cruiser "device:position" 0)
	(device_animate_position dm_cannon_cruiser .2 0.0 1 1 true)
	(device_animate_position dm_cannon_cruiser .4 90.0 1 1 true)

)

(script dormant f_zealot_md_control

	(f_abort_md)

	(sleep_until b_zealot_ready 1)
	(sleep (* 30 5))
	(md_zealot_gotogun)

	(sleep_until (>= objcon_zealot 90) 1 (* 30 120) )
	(if (not (>= objcon_zealot 90))
		(begin
			(md_zealot_delay_0)
		)
	)

	(sleep_until (>= objcon_zealot 90) 1 (* 30 120) )
	(if (not (>= objcon_zealot 90))
		(begin
			(md_zealot_delay_1)
		)
	)

	(sleep_until (>= objcon_zealot 90) 1 (* 30 120) )
	(if (not (>= objcon_zealot 90))
		(begin
			(md_zealot_delay_2)
		)
	)

)

(script dormant f_zealot_elite_story_control

	(sleep 0)

)

(script dormant f_zealot_music_control

	(wake music_zealot)
	
	(sleep_until (>= objcon_zealot 27) 5)
	(wake f_zealot_elite_death)

)

(global short s_zealot_elites_alive 0)
(script dormant f_zealot_elite_death

	(sleep_until
		(begin
			(set s_zealot_elites_alive 0)
			(if (> (ai_living_count sq_zealot_elite_zealot) 0) (set s_zealot_elites_alive (+ s_zealot_elites_alive 1)) )
			(if (> (ai_living_count sq_zealot_elite_int_1) 0) (set s_zealot_elites_alive (+ s_zealot_elites_alive 1)) )
			(if (> (ai_living_count sq_zealot_elite_int_2) 0) (set s_zealot_elites_alive (+ s_zealot_elites_alive 1)) )
			(if (> (ai_living_count sq_zealot_elite_ext_1) 0) (set s_zealot_elites_alive (+ s_zealot_elites_alive 1)) )
		(= s_zealot_elites_alive 1))
	)
	(set s_music_zealot 2)

)

(script dormant f_zealot_spawn_control

	(ai_place gr_zealot_cov_init)

)

(script dormant f_zealot_door

	(device_set_power #_m70_door_ff_01 1)
	(device_operates_automatically_set #_m70_door_ff_01 1)
	(device_closes_automatically_set #_m70_door_ff_01 1)
	(sleep_until (>= objcon_zealot 27) 5)
	(device_set_position #_m70_door_ff_01 .9)
	(sleep_until (>= (device_get_position #_m70_door_ff_01) .9) 1)
	(device_set_power #_m70_door_ff_01 0)
	(device_operates_automatically_set #_m70_door_ff_01 0)
	(device_closes_automatically_set #_m70_door_ff_01 0)


)

(script command_script f_cs_zealot_phantom

	;(f_load_phantom ai_current_squad "right" sq_zealot_elite_1 sq_zealot_elite_2 sq_zealot_elite_3 none)

	; enter
	;--------------------------------------------
	(cs_fly_by ps_zealot_phantom/enter_01)
	(cs_fly_by ps_zealot_phantom/enter_02)
	(cs_fly_by ps_zealot_phantom/enter_03)
	(cs_fly_to_and_face ps_zealot_phantom/hover_01 ps_zealot_phantom/hover_01_face 1)
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face ps_zealot_phantom/drop_01 ps_zealot_phantom/drop_01_face 1)

	; unload
	;--------------------------------------------
	;(f_unload_phantom ai_current_squad "right")

	; exit
	;--------------------------------------------
	(cs_fly_to_and_face ps_zealot_phantom/hover_01 ps_zealot_phantom/hover_01_face 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_zealot_phantom/exit_01)
	(cs_fly_by ps_zealot_phantom/erase)
	(ai_erase ai_current_squad)

)

(script command_script f_cs_combat_alert

	(dprint "alert!")
	(cs_force_combat_status ai_current_squad 3)
	
)

(script dormant f_zealot_cleanup_control

	(sleep_until (>= objcon_cannon 10) 1)
	(f_zealot_kill_scripts)
	;(f_zealot_despawn_all)

)

(script static void f_zealot_kill_scripts

	(sleep_forever f_zealot_objective_control)
	(sleep_forever f_zealot_camointro)
	(sleep_forever f_zealot_missionobj_control)
	;(sleep_forever f_zealot_save_control)
	;(sleep_forever f_zealot_save_combatend)
	(sleep_forever f_zealot_hilite_control)
	(sleep_forever f_zealot_waypoint_control)
	(sleep_forever f_zealot_cruiser)
	(sleep_forever f_zealot_cruiser_move)
	(sleep_forever f_zealot_md_control)
	(sleep_forever f_zealot_elite_story_control)
	(sleep_forever f_zealot_spawn_control)
	(sleep_forever f_zealot_door)
	(sleep_forever f_zealot_pillar_control)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

; =================================================================================================
; =================================================================================================
; cannon
; =================================================================================================
; =================================================================================================

(global boolean b_cruiser_kill false)
(global boolean b_cruiser_vulnerable false)
(global boolean b_cruiser_dead false)
(global boolean b_cruiser_moving false)

(script dormant f_cannon_objective_control
	(dprint "::: cannon encounter :::")

	; standard scripts
	(wake f_cannon_missionobj_control)
	(wake f_cannon_save_control)
	(wake f_cannon_spawn_control)
	(wake f_cannon_music_control)
	(wake f_cannon_md_control)
	(wake f_cannon_cleanup_control)

	; encounter scripts
	(wake f_cannon_cruiser)
	(wake f_train_mac)

	(dprint "objective control : cannon.1")
	(set objcon_cannon 1)
	(set b_insertion_fade_in true)

	(sleep_forever f_save_continuous)

	(sleep_until (volume_test_players tv_cannon_10) 1)
	(dprint "objective control : cannon.10")
	(set objcon_cannon 10)

	(sleep_until b_cruiser_vulnerable 1)
	(dprint "objective control : cannon.20")
	(set objcon_cannon 20)

	(sleep_until b_cruiser_dead 1)
	(dprint "objective control : cannon.30")
	(set objcon_cannon 30)

)

(script dormant f_cannon_missionobj_control

	(sleep_until (>= objcon_cannon 1) 5)
	(mo_cannon)

)

(script dormant f_cannon_save_control

	(game_save)

)

(script dormant f_cannon_spawn_control

	(sleep_until (>= objcon_cannon 10) 1)

	(dprint "starting spawns")
	(wake f_cannon_spawn_banshees)
	(wake f_cannon_spawn_phantoms)
	
)

(script dormant f_cannon_spawn_phantoms

	(ai_place sq_cannon_phantom_1)
	(sleep (* 30 2))
	(ai_place sq_cannon_phantom_2)
	(sleep (* 30 3))
	(ai_place sq_cannon_phantom_3)
	(sleep (* 30 2))

	(sleep_until
		(begin
			(if (<= (ai_living_count sq_cannon_phantom_1) 1) (ai_place sq_cannon_phantom_1) )
			(if (<= (ai_living_count sq_cannon_phantom_2) 1) (ai_place sq_cannon_phantom_2) )
			(if (<= (ai_living_count sq_cannon_phantom_3) 1) (ai_place sq_cannon_phantom_3) )
			(if (<= (ai_living_count sq_cannon_phantom_4) 1) (ai_place sq_cannon_phantom_4) )
			(sleep (* 30 3))
	false)
	)

)

(global short s_cannon_phantom_1 1)
(script command_script f_cs_cannon_phantom_1

	(cs_enable_targeting true)
	(cs_enable_looking true)

	(cs_vehicle_speed 2)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(cs_fly_to ps_cannon_phantom/01_enter_01 1)
	(cs_vehicle_speed .7)
	(cs_fly_to ps_cannon_phantom/01_enter_02 1)

	(sleep_until
		(begin
			(set s_cannon_phantom_1 (random_range 1 4))
			(if (= s_cannon_phantom_1 1)(begin
				(cs_fly_to_and_face ps_cannon_phantom/01_hover_01 ps_cannon_phantom/01_hover_01_face)
			))
			(if (= s_cannon_phantom_1 2)(begin
				(cs_fly_to_and_face ps_cannon_phantom/01_hover_02 ps_cannon_phantom/01_hover_02_face)
			))
			(if (= s_cannon_phantom_1 3)(begin
				(cs_fly_to_and_face ps_cannon_phantom/01_hover_03 ps_cannon_phantom/01_hover_03_face)
			))
		false)
	(* 30 (random_range 1 2) ) )

)

(global short s_cannon_phantom_2 1)
(script command_script f_cs_cannon_phantom_2

	(cs_enable_targeting true)
	(cs_enable_looking true)

	(cs_vehicle_speed 2)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(cs_fly_to ps_cannon_phantom/02_enter_01 1)
	(cs_vehicle_speed .7)
	(cs_fly_to ps_cannon_phantom/02_enter_02 1)

	(sleep_until
		(begin
			(set s_cannon_phantom_2 (random_range 1 4))
			(if (= s_cannon_phantom_2 1)(begin
				(cs_fly_to_and_face ps_cannon_phantom/02_hover_01 ps_cannon_phantom/02_hover_01_face)
			))
			(if (= s_cannon_phantom_2 2)(begin
				(cs_fly_to_and_face ps_cannon_phantom/02_hover_02 ps_cannon_phantom/02_hover_02_face)
			))
			(if (= s_cannon_phantom_2 3)(begin
				(cs_fly_to_and_face ps_cannon_phantom/02_hover_03 ps_cannon_phantom/02_hover_03_face)
			))
		false)
	(* 30 (random_range 1 2) ) )

)

(global short s_cannon_phantom_3 1)
(script command_script f_cs_cannon_phantom_3

	(cs_enable_targeting true)
	(cs_enable_looking true)

	(cs_vehicle_speed 2)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(cs_fly_to ps_cannon_phantom/03_enter_01 1)
	(cs_vehicle_speed .7)
	(cs_fly_to ps_cannon_phantom/03_enter_02 1)

	(sleep_until
		(begin
			(set s_cannon_phantom_3 (random_range 1 4))
			(if (= s_cannon_phantom_3 1)(begin
				(cs_fly_to_and_face ps_cannon_phantom/03_hover_01 ps_cannon_phantom/03_hover_01_face)
			))
			(if (= s_cannon_phantom_3 2)(begin
				(cs_fly_to_and_face ps_cannon_phantom/03_hover_02 ps_cannon_phantom/03_hover_02_face)
			))
			(if (= s_cannon_phantom_3 3)(begin
				(cs_fly_to_and_face ps_cannon_phantom/03_hover_03 ps_cannon_phantom/03_hover_03_face)
			))
		false)
	(* 30 (random_range 1 2) ) )

)

(global short s_cannon_phantom_4 1)
(script command_script f_cs_cannon_phantom_4

	(cs_enable_targeting true)
	(cs_enable_looking true)

	(cs_vehicle_speed 2)
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(cs_fly_to ps_cannon_phantom/04_enter_01 1)
	(cs_vehicle_speed .7)
	(cs_fly_to ps_cannon_phantom/04_enter_02 1)

	(sleep_until
		(begin
			(set s_cannon_phantom_4 (random_range 1 4))
			(if (= s_cannon_phantom_4 1)(begin
				(cs_fly_to_and_face ps_cannon_phantom/04_hover_01 ps_cannon_phantom/04_hover_01_face)
			))
			(if (= s_cannon_phantom_4 2)(begin
				(cs_fly_to_and_face ps_cannon_phantom/04_hover_02 ps_cannon_phantom/04_hover_02_face)
			))
			(if (= s_cannon_phantom_4 3)(begin
				(cs_fly_to_and_face ps_cannon_phantom/04_hover_03 ps_cannon_phantom/04_hover_03_face)
			))
		false)
	(* 30 (random_range 1 2) ) )

)

(script dormant f_cannon_spawn_banshees

	(ai_place sq_cannon_banshee_1)
	(sleep (* 30 4))
	(ai_place sq_cannon_banshee_2)
	(sleep (* 30 4))
	(ai_place sq_cannon_banshee_3)
	(sleep (* 30 4))

	(sleep_until
		(begin
			(if
				(< (ai_task_count obj_cannon_cov/gate_banshees) 2)
				(begin
					(ai_place sq_cannon_banshee_1)
					(sleep (* 30 4))
				)
			)
			false
		)	
	)

)

(script dormant f_cannon_md_control

	(f_abort_md)

	(sleep 150)

	(md_cannon_enter)

	(sleep_until (>= objcon_cannon 10) 5)

	(sleep_until (>= objcon_cannon 20) 1 (* 30 30))
	(if (not (>= objcon_cannon 20))
		(begin
			(md_cannon_move_0)
		)
	)

	(sleep_until (>= objcon_cannon 20) 5)

	(sleep_until (>= objcon_cannon 30) 1 (* 30 2))
	(if (not (>= objcon_cannon 30))
		(begin
			(md_cannon_fire_delay_0)
		)
	)

	(sleep_until (>= objcon_cannon 30) 1 (* 30 2))
	(if (not (>= objcon_cannon 30))
		(begin
			(md_cannon_fire_delay_1)
		)
	)

	(sleep_until (>= objcon_cannon 30) 1 (* 30 2))
	(if (not (>= objcon_cannon 30))
		(begin
			(md_cannon_fire_delay_2)
		)
	)

	(sleep_until (>= objcon_cannon 30) 1)

	(sleep_until (not g_dialog))
	(md_cannon_die)

)


(script dormant f_cannon_music_control

	(wake music_cannon)

)

(script dormant f_train_mac

	(sleep_until
		(or
			(vehicle_test_seat_unit (ai_vehicle_get_from_squad sq_cannon_mac 0) mac_d player0)
			(vehicle_test_seat_unit (ai_vehicle_get_from_squad sq_cannon_mac 0) mac_d player1)
			(vehicle_test_seat_unit (ai_vehicle_get_from_squad sq_cannon_mac 0) mac_d player2)
			(vehicle_test_seat_unit (ai_vehicle_get_from_squad sq_cannon_mac 0) mac_d player3)
		)	
	)

	(set s_music_zealot 2)
	(set s_music_cannon 1)

	(if (vehicle_test_seat_unit (ai_vehicle_get_from_squad sq_cannon_mac 0) mac_d player0) (f_train_mac_player player0))
	(if (vehicle_test_seat_unit (ai_vehicle_get_from_squad sq_cannon_mac 0) mac_d player1) (f_train_mac_player player1))
	(if (vehicle_test_seat_unit (ai_vehicle_get_from_squad sq_cannon_mac 0) mac_d player2) (f_train_mac_player player2))
	(if (vehicle_test_seat_unit (ai_vehicle_get_from_squad sq_cannon_mac 0) mac_d player3) (f_train_mac_player player3))

	(sleep (* 30 10))
	(set s_music_cannon 2)
	
)

(script static void (f_train_mac_player (player p))

	(f_hud_training p train_mac)

)

(script dormant f_cannon_cruiser

	(object_create_if_necessary dm_cannon_cruiser)

	(sleep_until (>= objcon_cannon 10))
	(if (not b_cruiser_moving)
		(device_set_position_track dm_cannon_cruiser "device:position" 0)
	)
	(device_animate_position dm_cannon_cruiser .4 0.0 .034 .034 true)
	(device_animate_position dm_cannon_cruiser 1 90 .034 .034 true)

	(sleep_until (>= (device_get_position dm_cannon_cruiser) .9) 1)
	(print "cruiser vulnerable")
	(object_create_anew sc_cannon_cruiser_target)
	(effect_new_on_object_marker levels\solo\m70\fx\glassing\glassing_init dm_cannon_cruiser fx_glass_hole)
	(f_blip_object sc_cannon_cruiser_target 16)
	(set b_cruiser_vulnerable true)
	(wake f_cannon_cruiser_kill)
	(set s_music_cannon 3)

	(sleep_until (< (object_get_health sc_cannon_cruiser_target) .76) 1)
	(set b_cruiser_dead true)
	(print "cruiser dead")
	(cinematic_enter 070lc_poa_launch true)
	(f_cin_outro_prep)
	(f_end_mission 070lc_poa_launch set_outro_cinematic)
	(game_won)

)


(script dormant f_cannon_cruiser_test

	(object_create_if_necessary dm_cannon_cruiser)

	(if (not b_cruiser_moving)
		(device_set_position_track dm_cannon_cruiser "device:position" 0)
	)

	(sleep_until
		(begin
			(device_animate_position dm_cannon_cruiser .4 0.0 .034 .034 true)
			(device_animate_position dm_cannon_cruiser 1 60 .034 .034 true)
		
			(sleep_until (>= (device_get_position dm_cannon_cruiser) .9) 1)
			(print "cruiser vulnerable")
			(object_create_anew sc_cannon_cruiser_target)
			(effect_new_on_object_marker levels\solo\m70\fx\glassing\glassing_init dm_cannon_cruiser fx_glass_hole)
			(f_blip_object sc_cannon_cruiser_target 16)
			(set b_cruiser_vulnerable true)
			(sleep_until (>= (device_get_position dm_cannon_cruiser) 1) 1)
			(sleep 300)
			(effect_new_on_object_marker levels\solo\m70\fx\glassing\glassing_main.effect dm_cannon_cruiser fx_glass_hole)
			(sleep 45)
		false)
	1)


)

(script dormant f_cannon_cruiser_kill

	(branch
		b_cruiser_dead
		(f_abort)
	)

	(sleep_until (>= (device_get_position dm_cannon_cruiser) 1) 1)
	(sleep 300)
	(effect_new_on_object_marker levels\solo\m70\fx\glassing\glassing_main.effect dm_cannon_cruiser fx_glass_hole)

	(sleep 45)
	(fade_out 1 1 1 0)

	(sleep 45)
	(unit_kill player0)
	(unit_kill player1)
	(unit_kill player2)
	(unit_kill player3)
		
)


(script static void f_cin_outro_prep

	(sleep_forever f_save_continuous)

	(wake f_outro_scarab_1)
	(wake f_outro_scarab_2)

	(f_objects_final_2_destroy)
	(f_objects_global_destroy)

	(f_platform_flock_delete)
	(ai_erase sq_cannon_mac)

)

(script dormant f_cannon_cleanup_control

	(sleep_until b_cruiser_dead 1)
	(f_cannon_kill_scripts)
	(f_cannon_despawn_all)

)

(script dormant f_outro_scarab_1
	(object_create dm_outro_scarab_1)
	(sleep_until
	  (begin
	    (device_set_position_track dm_outro_scarab_1 stationary_march 0)
	    (device_animate_position dm_outro_scarab_1 1.0 (random_range 7 10) 1.0 1.0 true)
	    (sleep_until (>= (device_get_position dm_outro_scarab_1) 1) 1)
	    (sleep (random_range 0 20))
	  0)
	)
)

(script dormant f_outro_scarab_2 
	(object_create dm_outro_scarab_2)
	(sleep_until
	  (begin
	    (device_set_position_track dm_outro_scarab_2 stationary_march 0)
	    (device_animate_position dm_outro_scarab_2 1.0 (random_range 7 10) 1.0 1.0 true)
	    (sleep_until (>= (device_get_position dm_outro_scarab_2) 1) 1)
	    (sleep (random_range 0 20))
	  0)
	)
)

(script static void f_cannon_kill_scripts

	(sleep_forever f_cannon_objective_control)
	(sleep_forever f_cannon_missionobj_control)
	(sleep_forever f_cannon_save_control)
	(sleep_forever f_cannon_spawn_control)
	(sleep_forever f_cannon_spawn_phantoms)
	(sleep_forever f_cannon_spawn_banshees)
	(sleep_forever f_cannon_md_control)
	;(sleep_forever f_cannon_load_player)
	(sleep_forever f_train_mac)
	;(sleep_forever f_cannon_cruiser)
	;(sleep_forever f_cannon_cruiser_move)
	;(sleep_forever f_cannon_cruiser_vulnerable)
	;(sleep_forever f_cannon_cruiser_die)
	;(sleep_forever f_cannon_cruiser_kill)
	(ai_dialogue_enable true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)


(script static void f_cannon_despawn_all

	(ai_erase gr_cannon_cov)

)

;----------------------------------------------------------------------------------------------------
; utility

(script static void (dprint (string s) )
	(if b_debug (print s))
)

(script static void (dbreak (string s) )
	;(if (or (not (editor_mode)) b_breakpoints) (breakpoint s))
	(sleep 0)
)

(script static void (md_print (string s) )
	(if b_md_print (print s))
)

(script static void f_abort
	(dprint "function aborted")
)

(script static void tick
	(sleep 1)
)

(script dormant f_checkpoint_generic

	(sleep_until (volume_test_players tv_checkpoint_1) 5)
	(dprint "trying to save")
	(game_save_no_timeout)
	(sleep_until (volume_test_players tv_checkpoint_2) 5)
	(dprint "trying to save")
	(game_save_no_timeout)

)

(script command_script f_cs_emile_mongoose_reenter

	(cs_enable_pathfinding_failsafe true)

	(sleep_until 
		(begin
			(dprint "get back in vehicle")
			(cs_go_to_vehicle v_mongoose_emile)
		(vehicle_test_seat v_mongoose_emile "mongoose_d"))
	30 )
	
)

(global boolean b_players_all_on_foot false)
(global boolean b_players_any_in_vehicle false)
(script dormant f_player_on_foot
	(sleep_until
		(begin
			(if
				(or
					(and
						(= (game_coop_player_count) 1)
						(= (unit_in_vehicle player0) true)
					)
					(and
						(= (game_coop_player_count) 2)
						(and
							(= (unit_in_vehicle player0) true)
							(= (unit_in_vehicle player1) true)
						)
					)
					(and
						(= (game_coop_player_count) 3)
						(and
							(= (unit_in_vehicle player0) true)
							(= (unit_in_vehicle player1) true)
							(= (unit_in_vehicle player2) true)
						)
					)
					(and
						(= (game_coop_player_count) 4)
						(and
							(= (unit_in_vehicle player0) true)
							(= (unit_in_vehicle player1) true)
							(= (unit_in_vehicle player2) true)
							(= (unit_in_vehicle player3) true)
						)
					)
				)
				(begin
					(set b_players_all_on_foot false)
					(set b_players_any_in_vehicle true)
				)
				(begin
					(set b_players_all_on_foot true)
					(set b_players_any_in_vehicle false)
				)
			)
		false)
	)
)

(global short s_squad_group_counter 0)
(script static void (f_squad_group_place (ai squad_group))

	(set s_squad_group_counter (ai_squad_group_get_squad_count squad_group))
	
	(sleep_until (begin
	
		(set s_squad_group_counter (- s_squad_group_counter 1))
		(ai_place (ai_squad_group_get_squad squad_group s_squad_group_counter))
		(<= s_squad_group_counter 0)

	) 1)

)

(script static boolean difficulty_is_normal_or_higher  

	(or 
		(= (game_difficulty_get) normal)  
		(= (game_difficulty_get) heroic)  
		(= (game_difficulty_get) legendary)  
	) 

) 
 
(script static boolean difficulty_is_heroic_or_higher  

	(or 
		(= (game_difficulty_get) heroic)  
		(= (game_difficulty_get) legendary)  
	) 

) 
 
(script static boolean difficulty_is_legendary  

	(= (game_difficulty_get) legendary) 

)  

; bodies
; -------------------------------------------------------------------------------------------------
(global short pose_against_wall_var1     0)
(global short pose_against_wall_var2     1)
(global short pose_against_wall_var3     2)
(global short pose_against_wall_var4     3)
(global short pose_on_back_var1          4)
(global short pose_on_back_var2          5)
(global short pose_on_side_var1          6)
(global short pose_on_side_var2          7)
(global short pose_on_back_var3          8)
(global short pose_face_down_var1        9)
(global short pose_face_down_var2        10)
(global short pose_on_side_var3          11)
(global short pose_on_side_var4          12)
(global short pose_face_down_var3        13)
(global short pose_on_side_var5          14)


(script static void (pose_body (object_name body_name) (short pose))
       (object_create body_name)
       (cond
              ((= pose pose_against_wall_var1) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_01))
              ((= pose pose_against_wall_var2) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_02))
              ((= pose pose_against_wall_var3) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_03))
              ((= pose pose_against_wall_var4) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_04))
              ((= pose pose_on_back_var1) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_05))
              ((= pose pose_on_back_var2) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_06))
              ((= pose pose_on_side_var1) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_07))
              ((= pose pose_on_side_var2) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_08))
              ((= pose pose_on_back_var3) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_09))
              ((= pose pose_face_down_var1) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_10))
              ((= pose pose_face_down_var2) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_11))
              ((= pose pose_on_side_var3) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_12))
              ((= pose pose_on_side_var4) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_13))
              ((= pose pose_face_down_var3) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_14))
              ((= pose pose_on_side_var5) (scenery_animation_start (scenery body_name) objects\characters\marine\marine deadbody_15))
       )             
)


;----------------------------------------------------------------------------------------------------
; shortcuts

; sh - half speed
(script static void sh
	(if (!= game_speed .5)
		(set game_speed .5)
		(set game_speed 1)
	)
)

; s0 - pause/unpause
(script static void p
	(if (!= game_speed 0)
		(set game_speed 0)
		(set game_speed 1)
	)
)

; s5 - game speed 5
(script static void s5
	(if (!= game_speed 5)
		(set game_speed 5)
		(set game_speed 1)
	)
)

; b - bsps
(script static void b
	(if ai_render_sector_bsps
		(begin
			(set ai_render_sector_bsps 0)
			(print "ai_render_sector_bsps off")
		)
		(begin
			(set ai_render_sector_bsps 1)
			(print "ai_render_sector_bsps on")
		)
	)
)

; o - objectives
(script static void o
	(if ai_render_objectives
		(begin
			(set ai_render_objectives 0)
			(print "render objectives off")
		)
		(begin
			(set ai_render_objectives 1)
			(print "render objectives on")
		)
	)
)


; d - decisions
(script static void d
	(if ai_render_decisions
		(begin
			(set ai_render_decisions 0)
			(print "ai_render_decisions off")
		)
		(begin
			(set ai_render_decisions 1)
			(print "ai_render_decisions on")
		)
	)
)

; c - command scripts
(script static void c
	(if ai_render_command_scripts
		(begin
			(set ai_render_command_scripts 0)
			(print "ai_render_command_scripts off")
		)
		(begin
			(set ai_render_command_scripts 1)
			(print "ai_render_command_scripts on")
		)
	)
)

; p - command scripts
(script static void t
	(if debug_performances
		(begin
			(set debug_performances 0)
			(print "debug_performances off")
		)
		(begin
			(set debug_performances 1)
			(print "debug_performances on")
		)
	)
)

(global boolean b_debug_scripting true)
; s - debug scripting
(script static void s
	(if b_debug_scripting
		(begin
			(debug_scripting false)
			(print "debug_scripting off")
			(set b_debug_scripting false)
		)
		(begin
			(debug_scripting true)
			(print "debug_scripting on")
			(set b_debug_scripting true)
		)
	)
)

; f - cinematic_fade_to_gameplay
(script static void f
	(print "cinematic_fade_to_gameplay")
	(cinematic_fade_to_gameplay)
)


; pr - ai render props
(script static void pr
	(if ai_render_props
		(begin
			(set ai_render_props 0)
			(print "ai_render_props off")
		)
		(begin
			(set ai_render_props 1)
			(print "ai_render_props on")
		)
	)
)

; be - ai render behavior stack
(script static void be
	(if ai_render_behavior_stack_all
		(begin
			(set ai_render_behavior_stack_all 0)
			(print "ai_render_behavior_stack_all off")
		)
		(begin
			(set ai_render_behavior_stack_all 1)
			(print "ai_render_behavior_stack_all on")
		)
	)
)


; de - ai render decisions
(script static void de
	(if ai_render_decisions
		(begin
			(set ai_render_decisions 0)
			(print "ai_render_decisions off")
		)
		(begin
			(set ai_render_decisions 1)
			(print "ai_render_decisions on")
		)
	)
)


;* commands
ai_render_tracked_props : shows scariness
ai_render_decisions : shows behaviors
ai_render_target : shows you the currently selected actor’s target
ai_render_sector_bsps : pathfinding debugging
ai_render_evaluations : shows you firing point evaluation results 
                ai_render_evaluations_text 
                ai_render_evaluations_detailed
                ai_render_evaluations_shading
                ai_render_evaluations_shading_none
                ai_render_evaluations_shading_#name of firing point evaluation tag#
ai_render_emotions : shows the danger level of an ai
ai_render_vehicle_turns : shows the trottle speed for an ai driving (must select the ai first)
ai_render_timeslices : shows how often an ai is checking for new firing points
ai_render_aiming_vectors : show the view lines the ai wants to look and and the ones he is looking at
ai_render_props : use this to show the objects in the world the ai can perceive (orphans and such)
ai_render_vision_cones : the visual representation of the perception cone model
*;

;globals

; longswords
; =================================================================================================
; make a longsword device activate. 
; device tag: sound\device_machines\040vc_longsword\start
; flyby sound tag: sound\device_machines\040vc_longsword\start
; =================================================================================================
; example: (f_ls_flyby my_longsword_device_machine)
;           (sound_impulse_start sound\device_machines\040vc_longsword\start none 1)
; =================================================================================================
(script static void (f_ls_flyby (device d))
      (device_animate_position d 0 0.0 0.0 0.0 true)
      (device_set_position_immediate d 0)
      (device_set_power d 0)
      (sleep 1)
      (device_set_position_track d device:position 0)
      (device_animate_position d 0.5 7.0 0.1 0.1 true))

; carpetbombs
; =================================================================================================
; spawn a trail of bombs across a point set.
; effect tag: fx\fx_library\explosions\reach_test_explosion_large\reach_test_explosion_large
; count: how many points are in the set?
; delay: time (in ticks) between the detonation of each bomb effect
; =================================================================================================
; example: (f_ls_carpetbomb pts_030 fx\my_explosion_fx 6 10)
; =================================================================================================
(global short global_s_current_bomb 0)
(script static void (f_ls_carpetbomb (point_reference p) (effect e) (short count) (short delay))
      (set global_s_current_bomb 0)
      (sleep_until
            (begin
                  (if b_debug_globals (dprint "boom..."))
                  (effect_new_at_point_set_point e p global_s_current_bomb)
                  (set global_s_current_bomb (+ global_s_current_bomb 1))
                  (sleep delay)
            (>= global_s_current_bomb count)) 1) 
)

; save scripts
; =================================================================================================
(global boolean b_save_continuous true)
(script continuous f_save_continuous

	(sleep_until b_insertion_fade_in)

	(sleep_until
		(begin
			(if b_save_continuous (begin
				(sleep_until (= (current_zone_set) (current_zone_set_fully_active)) 2)
				(sleep (* 30 5))
				(dprint "continuous save")
				(game_save_no_timeout)
			))
			false
		)
	(* 30 120))
)

; recycling scripts
; =================================================================================================
(script continuous f_recycle_all_continuous

	(sleep_until
		(begin
			(if (volume_test_players tv_recycle_dirt)
				(f_recycle_dirt_lite)
				(f_recycle_dirt)
			)
			(if (volume_test_players tv_recycle_drop)
				(f_recycle_drop_lite)
				(f_recycle_drop)
			)
			(if (volume_test_players tv_recycle_block)
				(f_recycle_block_lite)
				(f_recycle_block)
			)
			(if (volume_test_players tv_recycle_cave)
				(f_recycle_cave_lite)
				(f_recycle_cave)
			)
			(if (volume_test_players tv_recycle_bone)
				(f_recycle_bone_lite)
				(f_recycle_bone)
			)
			(if (volume_test_players tv_recycle_smelt)
				(f_recycle_smelt_lite)
				(f_recycle_smelt)
			)
			(if (volume_test_players tv_recycle_bgun)
				(f_recycle_bgun_lite)
				(f_recycle_bgun)
			)

			false
		)
	400)
)

(script static void f_recycle_dirt
	(add_recycling_volume tv_recycle_dirt 5 5)
)

(script static void f_recycle_dirt_lite
	; bipeds
	(add_recycling_volume_by_type tv_recycle_dirt 20 (* 30 4) 1)
	(sleep (* 30 5))
	; weapons
	(add_recycling_volume_by_type tv_recycle_dirt 30 (* 30 4) 4)
	(sleep (* 30 5))
	; equipment
	(add_recycling_volume_by_type tv_recycle_dirt 20 (* 30 4) 8)
	(sleep (* 30 5))
)


(script static void f_recycle_drop
	(add_recycling_volume tv_recycle_drop 5 5)
)

(script static void f_recycle_drop_lite
	; bipeds
	(add_recycling_volume_by_type tv_recycle_drop 25 (* 30 4) 1)
	(sleep (* 30 5))
	; weapons
	(add_recycling_volume_by_type tv_recycle_drop 30 (* 30 4) 4)
	(sleep (* 30 5))
	; equipment
	(add_recycling_volume_by_type tv_recycle_drop 20 (* 30 4) 8)
	(sleep (* 30 5))

)

(script static void f_recycle_block
	(add_recycling_volume tv_recycle_block 5 5)
)

(script static void f_recycle_block_lite
	; bipeds
	(add_recycling_volume_by_type tv_recycle_block 25 (* 30 4) 1)
	(sleep (* 30 5))
	; weapons
	(add_recycling_volume_by_type tv_recycle_block 30 (* 30 4) 4)
	(sleep (* 30 5))
	; equipment
	(add_recycling_volume_by_type tv_recycle_block 20 (* 30 4) 8)
	(sleep (* 30 5))
)

(script static void f_recycle_cave
	(add_recycling_volume tv_recycle_cave 5 5)
)

(script static void f_recycle_cave_lite
	; bipeds
	(add_recycling_volume_by_type tv_recycle_cave 25 (* 30 4) 1)
	(sleep (* 30 5))
	; weapons
	(add_recycling_volume_by_type tv_recycle_cave 30 (* 30 4) 4)
	(sleep (* 30 5))
	; equipment
	(add_recycling_volume_by_type tv_recycle_cave 20 (* 30 4) 8)
	(sleep (* 30 5))
)

(script static void f_recycle_bone
	(add_recycling_volume tv_recycle_bone 5 5)
)

(script static void f_recycle_bone_lite
	; bipeds
	(add_recycling_volume_by_type tv_recycle_bone 25 (* 30 4) 1)
	(sleep (* 30 5))
	; weapons
	(add_recycling_volume_by_type tv_recycle_bone 30 (* 30 4) 4)
	(sleep (* 30 5))
	; equipment
	(add_recycling_volume_by_type tv_recycle_bone 20 (* 30 4) 8)
	(sleep (* 30 5))
)

(script static void f_recycle_smelt
	(add_recycling_volume tv_recycle_smelt 5 5)
)

(script static void f_recycle_smelt_lite
	; bipeds
	(add_recycling_volume_by_type tv_recycle_smelt 25 (* 30 4) 1)
	(sleep (* 30 5))
	; weapons
	(add_recycling_volume_by_type tv_recycle_smelt 30 (* 30 54) 4)
	(sleep (* 30 5))
	; equipment
	(add_recycling_volume_by_type tv_recycle_smelt 20 (* 30 4) 8)
	(sleep (* 30 5))
)

(script static void f_recycle_bgun
	(add_recycling_volume tv_recycle_bgun 5 5)
)

(script static void f_recycle_bgun_lite
	; bipeds
	(add_recycling_volume_by_type tv_recycle_bgun 25 (* 30 4) 1)
	(sleep (* 30 5))
	; weapons
	(add_recycling_volume_by_type tv_recycle_bgun 30 (* 30 4) 4)
	(sleep (* 30 5))
	; equipment
	(add_recycling_volume_by_type tv_recycle_bgun 20 (* 30 4) 8)
	(sleep (* 30 5))
)

; test scripts
; =================================================================================================

(global boolean b_test_carterdeath false)
(script static void f_test_carterdeath

	(switch_zone_set set_cave)

	; teleport
	(object_teleport_to_ai_point player0 ps_carter_spawn/player0)
	(object_teleport_to_ai_point player1 ps_carter_spawn/player1)
	(object_teleport_to_ai_point player2 ps_carter_spawn/player2)
	(object_teleport_to_ai_point player3 ps_carter_spawn/player3)

	(set b_test_carterdeath true)	
	(wake f_carter_objective_control)

)

(global boolean b_test_finalbattle false)
(script static void f_test_finalbattle

	(switch_zone_set set_final_0)

	; teleport
	(object_teleport_to_ai_point player0 ps_platform_door_spawn/player0)
	(object_teleport_to_ai_point player1 ps_platform_door_spawn/player1)
	(object_teleport_to_ai_point player2 ps_platform_door_spawn/player2)
	(object_teleport_to_ai_point player3 ps_platform_door_spawn/player3)

	(set b_test_finalbattle true)	
	(wake f_platform_finalbattle_control)
	(wake f_platform_pillar)

)


(global boolean b_test_scarabdrop false)
(script static void f_test_scarabdrop

	(switch_zone_set set_dirt)

	; teleport
	(object_teleport_to_ai_point player0 ps_drop_test_spawn/player0)
	(object_teleport_to_ai_point player1 ps_drop_test_spawn/player1)
	(object_teleport_to_ai_point player2 ps_drop_test_spawn/player2)
	(object_teleport_to_ai_point player3 ps_drop_test_spawn/player3)

	(set b_test_scarabdrop true)	
	(wake f_drop_scarabs_start)

)


(global boolean b_test_cannon false)
(script static void f_test_cannon

	(switch_zone_set set_final_2)

	; teleport
	(object_teleport_to_ai_point player0 ps_cannon_spawn/player0)
	(object_teleport_to_ai_point player1 ps_cannon_spawn/player1)
	(object_teleport_to_ai_point player2 ps_cannon_spawn/player2)
	(object_teleport_to_ai_point player3 ps_cannon_spawn/player3)

	(set b_test_cannon true)	
	(wake f_platform_cannon_init)
	(wake f_cannon_objective_control)

)


(global boolean b_test_cruiser false)
(script static void f_test_cruiser

	(switch_zone_set set_final_2)

	; teleport
	(object_teleport_to_ai_point player0 ps_cannon_spawn/player0)
	(object_teleport_to_ai_point player1 ps_cannon_spawn/player1)
	(object_teleport_to_ai_point player2 ps_cannon_spawn/player2)
	(object_teleport_to_ai_point player3 ps_cannon_spawn/player3)

	(set objcon_cannon 10)
	(set b_test_cruiser true)	
	(wake f_platform_cannon_init)
	(wake f_cannon_cruiser)

)


(script static void f_test_platform_wave_0

	(ai_place sq_platform_phantom_w0_1)
	(sleep (* 30 8))
	(ai_place sq_platform_phantom_w0_2)
	(set s_platform_wave 0)
	(set objcon_platform 50)

)


(script static void f_test_platform_wave_1

	(ai_place sq_platform_phantom_w1_1)
	(ai_place sq_platform_phantom_w1_2)
	(set s_platform_wave 1)
	(set objcon_platform 50)

)


(script static void f_test_platform_wave_2

	(ai_place sq_platform_phantom_w2_2)
	(ai_place sq_platform_phantom_w2_1)
	(set s_platform_wave 2)
	(set objcon_platform 50)

)


;==============special elite=====================;
(global short s_special_elite 0)
(global boolean b_special false)
(global boolean b_special_win false)
(global short s_special_elite_ticks 600)

(script dormant special_elite
	(if (= s_special_elite 0)
	  (begin_random_count 1
	    (set s_special_elite 1)
	    (set s_special_elite 2)    
	  )
	)
	(sleep_until (> (ai_living_count gr_special_elite) 0)1)
	(sleep_until 
	  (and
			(< (ai_living_count gr_special_elite) 1)
			(= b_special_win true)
	  )
	1)
	(set b_special true)
	;(submit_incident "kill_elite_bob")
	(print "special win!")
)

(script command_script cs_special_elite
	(set b_special_win true)
	(cs_face_player true)
	(sleep 5)
	(print "special start")                
	(sleep_until
	  (or
	    (and
	      (or
	        (objects_can_see_object player0 (ai_get_object ai_current_actor) 10)
	        (< (objects_distance_to_object player0 (ai_get_object ai_current_actor))15)
	      )
	      (= (player_is_in_game player0) true)
	    )                              
	    (and
	      (or
	        (objects_can_see_object player1 (ai_get_object ai_current_actor) 10)
	        (< (objects_distance_to_object player1 (ai_get_object ai_current_actor))15)
	      )
	      (= (player_is_in_game player1) true)
	    )                                              
	    (and
	      (or
	        (objects_can_see_object player2 (ai_get_object ai_current_actor) 10)
	        (< (objects_distance_to_object player2 (ai_get_object ai_current_actor))15)
	      )
	      (= (player_is_in_game player2) true)
	    )                              
	    (and
	      (or
	        (objects_can_see_object player3 (ai_get_object ai_current_actor) 10)
	        (< (objects_distance_to_object player3 (ai_get_object ai_current_actor))15)
	      )
	      (= (player_is_in_game player3) true)
	    )                                                                                                                                              
	  )
	5)
	(cs_enable_moving true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_enable_dialogue true)          
	(print "special elite spotted")                               
	(sleep s_special_elite_ticks)
	(ai_set_active_camo ai_current_actor true)
	(sleep 30)
	(set b_special_win false)
	(print "special fail")
	(sleep 1)
	(ai_erase ai_current_actor)
)


(script static void (f_hud_spartan_waypoint_object (object spartan) (string_id spartan_hud) (short max_dist))
	(sleep_until
		(begin
			(cond
				((< (objects_distance_to_object spartan player0) .95)
					(begin
						(chud_track_object spartan false)
						(sleep 60)
					)
				)
				
				((> (objects_distance_to_object spartan player0) max_dist)
					(begin
						(chud_track_object spartan false)
						(sleep 60)
					)
				)
				
				((< (objects_distance_to_object spartan player0) 3)
					(begin
						(chud_track_object_with_priority spartan 22 spartan_hud)
						(sleep 60)
					)
				)
				
				((objects_can_see_object player0 spartan 10)
					(begin
						(chud_track_object_with_priority spartan 22 spartan_hud)
						(sleep 60)
					)
				)
				
				(true
					(begin
						(chud_track_object_with_priority spartan 5 "")
						;(sleep 30)
					)
				)
			)
		0)
	30)
	
)
; =================================================================================================
; music
; =================================================================================================

(global short s_music_dirt -1)
(script dormant music_dirt

	(sleep_until (>= s_music_dirt 1 ))
	(dprint "music deliver")
	(sound_looping_start levels\solo\m70\music\m70_music_01 none 1)

	(sleep_until (>= s_music_dirt 2 ))
	(dprint "music transport")
	(sound_looping_stop levels\solo\m70\music\m70_music_01)
	(sound_looping_start levels\solo\m70\music\m70_music_02 none 1)

)

(global short s_music_drop -1)
(script dormant music_drop

	(sleep_until (>= s_music_drop 1 ))
	(dprint "music gun it")
	(sound_looping_set_alternate levels\solo\m70\music\m70_music_02 true)	

	(sleep_until (>= s_music_drop 2 ))
	(dprint "music tunnel")
	(sound_looping_start levels\solo\m70\music\m70_music_03 none 1)

	(sleep_until (>= s_music_drop 3 ))
	(dprint "music jump")
	(sound_looping_stop levels\solo\m70\music\m70_music_02)

	(sleep_until (>= s_music_drop 4 ))
	(dprint "music jump end")
	(sound_looping_start levels\solo\m70\music\m70_music_04 none 1)

	(sleep_until (>= s_music_drop 5 ))
	(dprint "music caves")
	(sound_looping_stop levels\solo\m70\music\m70_music_03)

)

(global short s_music_block -1)
(script dormant music_block

	(sleep_until (>= s_music_block 1 ))
	(dprint "music block end")
	(sound_looping_start levels\solo\m70\music\m70_music_05 none 1)

	(sleep_until (>= s_music_block 2 ))
	(dprint "music situation")
	(sound_looping_stop levels\solo\m70\music\m70_music_05)

)

(global short s_music_tunnels -1)
(script dormant music_tunnels

	(sleep_until (>= s_music_tunnels 1 ))
	(dprint "music tunnels buggers")
	(sound_looping_start levels\solo\m70\music\m70_music_06 none 1)

	(sleep_until (>= s_music_tunnels 2 ))
	(dprint "music keyes")
	(sound_looping_stop levels\solo\m70\music\m70_music_06)

)

(global short s_music_wall -1)
(script dormant music_wall

	(sleep_until (>= s_music_wall 1 ))
	(dprint "music countdown")
	(sound_looping_start levels\solo\m70\music\m70_music_07 none 1)
	
	(sleep_until (>= s_music_wall 2 ))
	(dprint "music long fight")
	(sound_looping_start levels\solo\m70\music\m70_music_08 none 1)

)

(global short s_music_factory -1)
(script dormant music_factory

	(sleep_until (>= s_music_factory 1 ))
	(dprint "music bomb 1")
	(sound_looping_stop levels\solo\m70\music\m70_music_08)
	(sound_looping_start levels\solo\m70\music\m70_music_09 none 1)
	
)

(global short s_music_crane -1)
(script dormant music_crane

	(sleep_until (>= s_music_crane 1 ))
	(dprint "music hunters")
	(sound_looping_stop levels\solo\m70\music\m70_music_09)
	(sound_looping_start levels\solo\m70\music\m70_music_10 none 1)

	(sleep_until (>= s_music_crane 2 ))
	(dprint "music hunters dead")
	(sound_looping_stop levels\solo\m70\music\m70_music_10)

)

(global short s_music_catwalk -1)
(script dormant music_catwalk

	(sleep_until (>= s_music_catwalk 1 ))
	(dprint "music catwalks")
	(sound_looping_start levels\solo\m70\music\m70_music_11 none 1)

)

(global short s_music_platform -1)
(script dormant music_platform

	(sleep_until (>= s_music_platform 1 ))
	(dprint "music room")
	(sound_looping_stop levels\solo\m70\music\m70_music_11)

	(sleep_until (>= s_music_platform 2 ))
	(dprint "music pad")
	(sound_looping_start levels\solo\m70\music\m70_music_12 none 1)

	(sleep_until (>= s_music_platform 3 ))
	(dprint "music hold them")
	(sound_looping_start levels\solo\m70\music\m70_music_13 none 1)

	(sleep_until (>= s_music_platform 4 ))
	(dprint "music hammer or wave 2")
	(sound_looping_stop levels\solo\m70\music\m70_music_13)

	(sleep_until (>= s_music_platform 5 ))
	(dprint "music plasma dead")
	(sound_looping_start levels\solo\m70\music\m70_music_14 none 1)

)

(global short s_music_zealot -1)
(script dormant music_zealot

	(sleep_until (>= s_music_zealot 1 ))
	(dprint "music clear path")
	(sound_looping_start levels\solo\m70\music\m70_music_15 none 1)

	(sleep_until (>= s_music_zealot 2 ))
	(dprint "music final elite")
	(sound_looping_start levels\solo\m70\music\m70_music_16 none 1)

)

(global short s_music_cannon -1)
(script dormant music_cannon

	(sleep_until (>= s_music_cannon 1 ))
	(dprint "music enter gun")
	(sound_looping_stop levels\solo\m70\music\m70_music_15)

	(sleep_until (>= s_music_cannon 2 ))
	(dprint "music checkpoint")
	(sound_looping_stop levels\solo\m70\music\m70_music_16)
	(sound_looping_start levels\solo\m70\music\m70_music_17 none 1)

	(sleep_until (>= s_music_cannon 3 ))
	(dprint "music reticle")
	(sound_looping_stop levels\solo\m70\music\m70_music_17)

)

(global short s_music_alpha -1)
(script dormant music_alpha

	(sleep_until (>= s_music_alpha 1 ))
	(dprint "music alpha start")
	(sound_looping_start levels\solo\m70\music\m70_music_06 none 1)

	(sleep_until (>= s_music_alpha 2 ))
	(dprint "music alpha end")
	(sound_looping_stop levels\solo\m70\music\m70_music_06)

)

(global short s_music_bravo -1)
(script dormant music_bravo

	(sleep_until (>= s_music_bravo 1 ))
	(dprint "music bravo start")
	(sound_looping_start levels\solo\m70\music\m70_music_11 none 1)

	(sleep_until (>= s_music_bravo 2 ))
	(dprint "music bravo end")
	(sound_looping_stop levels\solo\m70\music\m70_music_11)

)

; =================================================================================================
; rain
; =================================================================================================

(global short s_rain_force -1)
(global short s_rain_force_last -1)

(script dormant f_rain

	(branch
		(= s_rain_force 0)
		(f_rain_kill)
	)

	(sleep_until
		(begin

			(if (not (= s_rain_force s_rain_force_last))
				(begin
				
					(dprint "changing rain")
					(set s_rain_force_last s_rain_force)

					(cond
						((= s_rain_force 1)
							(begin
								(dprint "off")
								(weather_animate_force off 1 (random_range 5 15))		
							)
						)
						((= s_rain_force 2)
							(begin
								(dprint "no rain")
								(weather_animate_force no_rain 1 (random_range 5 15))		
							)
						)
						((= s_rain_force 3)
							(begin
								(dprint "light change 1/2")
								(weather_animate_force no_rain 1 (random_range 5 15))	
								(set s_rain_force 4)
								(sleep (random_range (* 30 20)(* 30 60)))
							)
						)
						((= s_rain_force 4)
							(begin
								(dprint "light change 2/2")
								(weather_animate_force light_rain 1 (random_range 5 15))		
								(set s_rain_force 3)
								(sleep (random_range (* 30 20)(* 30 60)))
							)
						)
						((= s_rain_force 5)
							(begin
								(dprint "medium")
								(weather_animate_force light_rain 1 (random_range 5 15))		
							)
						)
						((= s_rain_force 6)
							(begin
								(dprint "medium change 1/2")
								(weather_animate_force light_rain 1 (random_range 5 15))	
								(set s_rain_force 7)
								(sleep (random_range (* 30 20)(* 30 60)))
							)
						)
						((= s_rain_force 7)
							(begin
								(dprint "medium change 2/2")
								(weather_animate_force heavy_rain 1 (random_range 5 15))		
								(set s_rain_force 6)
								(sleep (random_range (* 30 20)(* 30 60)))
							)
						)
						((= s_rain_force 8)
							(begin
								(dprint "heavy")
								(weather_animate_force heavy_rain 1 (random_range 5 15))		
							)
						)
						((= s_rain_force 9)
							(begin
								(dprint "cine rain")
								(weather_animate_force cine_rain 1 0)		
							)
						)
					)

				)
			)

		false)
	5)

)

(script static void f_rain_kill

	(weather_animate_force off 1 (random_range 5 15))	

)

; =================================================================================================
; music
; =================================================================================================

(script static void f_music_intro

	(dprint "music intro")
	
)

(script static void f_music_dirt

	(dprint "music dirt")

)

(script static void f_music_drop

	(dprint "music scarabdrop")

)

(script static void f_music_cave

	(dprint "music cave")

)


(script static void f_music_block

	(dprint "music blockade")

)

(script static void f_music_bone

	(dprint "music boneyard")

)

(script static void f_music_smelt

	(dprint "music smelter")

)


(script static void f_music_platform

	(dprint "music platform")

)

(script static void f_music_zealot

	(dprint "music zealot")

)

(script static void f_music_cannon

	(dprint "music cannon")

)

; =================================================================================================
; mission objectives
; =================================================================================================

(script static void mo_dirtroad

	(f_hud_obj_new prompt_dirtroad pause_dirtroad)

)


(script static void mo_blockade

	(f_hud_obj_new prompt_blockade pause_blockade)

)

(script static void mo_wall

	(f_hud_obj_new prompt_wall pause_wall)

)

(script static void mo_platform

	(f_hud_obj_new prompt_platform pause_platform)

)


(script static void mo_zealot

	(f_hud_obj_new prompt_zealot pause_zealot)

)


(script static void mo_cannon

	(f_hud_obj_new prompt_cannon pause_cannon)

)

; =================================================================================================
; chapter titles
; =================================================================================================

(script static void tit_dirt

	(f_hud_chapter ct_dirtroad)

)


(script static void tit_block

	(f_hud_chapter ct_blockade)

)


(script static void tit_wall

	(f_hud_chapter ct_wall)

)


(script static void tit_platform

	(f_hud_chapter ct_platform)

)

; =================================================================================================
; mission dialogue
; =================================================================================================

(script static void f_abort_md

	(ai_dialogue_enable true)
	(set g_dialog false)
	(ai_actor_dialogue_enable (object_get_ai o_emile) true)

)

; dirt road  ========================================================

(global boolean g_dialog false)
(script static void md_dirt_drop
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)


		(md_print "emile: still with us, commander?")
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0010)
		(md_print "carter: stay low -- let me draw the heat.  just deliver that package.")
		(f_md_object_play 0 none m70_0020)
		(set s_music_dirt 1)


	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_dirt_look
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "emile: six. there's our destination: pillar of autumn.")
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0030)
		(md_print "emile: race you to her.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0040)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_dirt_look_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "emile: hold up... contacts. they must have seen us drop.")
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0050)
		(md_print "emile: let's take 'em out -- we need those wheels.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0060)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_dirt_look_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: let's go, lieutenant!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0070)

	(set g_dialog false)
)


(script static void md_dirt_bridge_delay
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: let's head east across the bridge!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0080)

	(set g_dialog false)
)

; mongoose  ========================================================

(script static void md_goose_wheels
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: we got transport.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0090)
		(set s_music_dirt 2)

	(set g_dialog false)
)

(script static void md_goose_wheels_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: jump on that mongoose. let's spit some dirt.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0100)

	(set g_dialog false)
)

(script static void md_goose_wheels_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: what are you waiting for, six?")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0110)

	(set g_dialog false)
)

(script static void md_goose_pass
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: you think we got time to walk, lieutenant?")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0120)

	(set g_dialog false)
)

(global short s_md_goose_findnew 0)
(script static void md_goose_findnew

	(if (= s_md_goose_findnew 0) (md_goose_findnew_0))
	(if (= s_md_goose_findnew 1) (md_goose_findnew_1))

	(set s_md_goose_findnew (+ s_md_goose_findnew 1))
	(if (= s_md_goose_findnew 2) (set s_md_goose_findnew 0))

)

(script static void md_goose_findnew_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: six.  take that mongoose.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0130)

	(set g_dialog false)
)

(script static void md_goose_findnew_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: commandeer that mongoose, lieutenant.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0150)

	(set g_dialog false)
)

; scarab drop  ========================================================

(script static void md_drop_intro
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)

		(md_print "emile: scarabs -- do not engage!  gun it, six!")
		(f_md_ai_play (random_range 20 30) (object_get_ai o_emile) m70_0170)
		(set s_music_drop 1)
		(md_print "emile: noble. out of the drop zone! now!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0180)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_drop_carter
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "carter: get the package out of there!  remember your objective!")
		(f_md_object_play 0 none m70_0200)

	(set g_dialog false)
)

(script static void md_drop_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: don't stop, six!  push through these guys!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0190)

	(set g_dialog false)
)

(script static void md_drop_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: move it, lieutenant!  we gotta get to the autumn!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0210)

	(set g_dialog false)
)

; blockade  ========================================================

(script static void md_block_bridge
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "emile: bridge ahead is out, six -- gonna have to jump it!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0220)
		(set s_music_drop 3)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_block_dismount
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)

		(md_print "emile: looks like we can climb around to the south...")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0230)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_block_warn
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		;(md_print "emile: guess we're back on foot.  gotta deliver that package...")
		;(f_md_ai_play 0 sq_emile m70_0240)
		(md_print "carter: noble... enemy forces blocking the road ahead...")
		(f_md_object_play 0 none m70_0250)

	(set g_dialog false)
)

; not used
(script static void md_block_combat
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: contacts!")
		(f_md_ai_play (* 30 10) (object_get_ai o_emile) m70_0280)
		(md_print "emile: you wanna go?  try me!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0290)

	(set g_dialog false)
)

(script static void md_block_wraith
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: got a wraith!  southeast side!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0300)

	(set g_dialog false)
)


(script static void md_block_snipers
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: snipers!  high up, to the south!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0310)

	(set g_dialog false)
)

(script static void md_block_gulch_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)

		(md_print "carter: i show a cave system... near your location...")
		(f_md_object_play (random_range 30 60) none m70_0260)
		(md_print "emile: should be good cover. we'll find it, commander.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0270)
		;(md_print "emile: look for that cave system!")
		;(f_md_ai_play 0 sq_emile m70_0320)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_block_gulch_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: cave must be around here someplace...")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0330)

	(set g_dialog false)
)

(script static void md_block_gulch_delay_2
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: figure that cave's gotta be to the east or north...")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0340)

	(set g_dialog false)
)

(script static void md_block_cave
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "emile: get to that cave!  i'm right behind you!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0350)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_block_cave_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: caves, spartan. we gotta go!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0410)

	(set g_dialog false)
)

; carter  ========================================================

(script static void md_carter_battle_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)

		(set s_music_block 2)
		(md_print "carter: noble. you've got a... situation.")
		(f_md_object_play 0 none m70_0420)

	(ai_dialogue_enable true)
	(set g_dialog false)
)


(script static void md_carter_react
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "emile: crevice to the east.  let's go.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0500)

	(set g_dialog false)
)


; tunnels  ========================================================

(script static void md_tunnels_bugger_0
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "emile: buggers.  go quiet...")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0510)
		(set s_music_tunnels 1)

	(set g_dialog false)
)

(script static void md_tunnels_bugger_1
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "emile: more of 'em, six!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0520)

	(set g_dialog false)
)

(script static void md_tunnels_bugger_2
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "emile: gotta get out of these caves -- take the package to the autumn!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0530)

	(set g_dialog false)
)

(script static void md_tunnels_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "emile: keep moving, six.  gotta get that package to keyes.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0540)

	(set g_dialog false)
)

(script static void md_tunnels_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "emile: had enough of these caves...")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0550)

	(set g_dialog false)
)

(script static void md_tunnels_delay_2
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "emile: let's get the hell outta here.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0560)

	(set g_dialog false)
)

(script static void md_tunnels_delay_3
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "emile: better not be moving in circles...")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0570)

	(set g_dialog false)
)

; wall  ========================================================

(script static void md_wall_intro
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)	

		(set s_music_tunnels 2)
		(set s_music_alpha 2)
		(sleep 60)
		(md_print "keyes: this is captain keyes of the pillar of autumn.  we are tracking you, noble. ")
		(f_md_object_play (random_range 30 60) none m70_0580)
		(md_print "emile: we'll be there, sir.")
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0590)
		(md_print "keyes: better be, spartan, because my countdown has no abort.")
		(f_md_object_play 0 none m70_0600)
		(set s_music_wall 1)


	(ai_dialogue_enable true)
	(set g_dialog false)
)

(global ai ai_trooper_wall_1 none)
(script static void md_wall_marine_0_near
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(if (= s_wall_md_marine_idx 0) (vs_cast sq_wall_marine_2/trooper_0 false 10 "m70_0610"))
		(if (= s_wall_md_marine_idx 1) (vs_cast sq_wall_marine_4/trooper_1 false 10 "m70_0610"))
		(set ai_trooper_wall_1 (vs_role 1))
	
		(md_print "trooper: spartans!  over here!")
		(f_md_object_play 0 none m70_0610)

	(set g_dialog false)
)

(script static void md_wall_marine_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) false)

		(md_print "trooper: not looking good, sir.  coveys have taken the whole shipyard.")
		(f_md_ai_play (random_range 30 60) ai_trooper_wall_1 m70_0620)
		(md_print "emile: understood.  we gotta get to the dry-dock.  priority one.")
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0640)
		(md_print "trooper: keep heading east.  good luck.")
		(f_md_ai_play (random_range 30 60) ai_trooper_wall_1 m70_0650)
		(md_print "trooper: marines!  push 'em back!")
		(f_md_ai_play 0 ai_trooper_wall_1 m70_0660)

	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	(set g_dialog false)
)

; factory  ========================================================

(global ai ai_factory_marine_1 none)
(script static void md_factory_marine_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) false)
	
		(vs_cast sq_factory_marine_1 false 10 "m70_0670")
		(set ai_factory_marine_1 (vs_role 1))

		(md_print "trooper: sierra -- you made it!")
		(f_md_ai_play (random_range 30 60) ai_factory_marine_1 m70_0670)
		(md_print "emile: so far.  tac eval?")
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0680)
		(md_print "trooper: they got this facility covered from all angles.  we'll give you covering fire; take the flank -- there has to be a way around.")
		(f_md_ai_play (random_range 30 60) ai_factory_marine_1 m70_0690)
		(md_print "emile: we'll find it.  you just keep 'em busy.")
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0700)
		(md_print "trooper: you got it, sir.")
		(f_md_ai_play 0 ai_factory_marine_1 m70_0710)


	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	(set g_dialog false)
)

(script static void md_factory_ship_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: come on, six.  we gotta move through that facility ahead.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0730)

	(set g_dialog false)
)


(script static void md_factory_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: clock's ticking, lieutenant.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0740)

	(set g_dialog false)
)

(script static void md_factory_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: we don't have much time, noble six.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0750)

	(set g_dialog false)
)

(script static void md_factory_delay_2
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: gotta keep moving.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0760)

	(set g_dialog false)
)

(script static void md_factory_delay_3
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: autumn can't wait forever.")
		(f_md_ai_play (random_range 20 30) (object_get_ai o_emile) m70_0770)
		(md_print "emile: let's go, six!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0780)

	(set g_dialog false)
)

; crane  ========================================================

(global ai ai_trooper_crane_1 none)
(script static void md_crane_intro
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(vs_cast sq_crane_marine_control false 10 "m70_0790")
		(set ai_trooper_crane_1 (vs_role 1))
	
		(md_print "trooper: spartans! dry dock's through that structure 'cross the way!")
		(f_md_ai_play (random_range 20 30) ai_trooper_crane_1 m70_0790)
		(md_print "trooper: punch through! we'll back you up!")
		(f_md_ai_play 0 ai_trooper_crane_1 m70_0800)

	(set g_dialog false)
)

(script static void md_crane_combat
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: tangos!  both platforms!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0810)

	(set g_dialog false)
)

(script static void md_crane_phantom
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: watch that phantom!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0820)

	(set g_dialog false)
)

(script static void md_crane_room_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: head outside!  i'm right behind you!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0830)

	(set g_dialog false)
)

(script static void md_crane_hunters
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: hunters!  east platform!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0840)

	(set g_dialog false)
)

(script static void md_crane_outside_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: door to the east!  keep moving!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0850)

	(set g_dialog false)
)

; catwalks  ========================================================

(script static void md_catwalk_floor_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) false)
	
		(md_print "emile: high ground!  head up to the catwalks!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0860)

	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	(set g_dialog false)
)

(script static void md_catwalk_floor_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: better angles from the catwalks, six!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0870)

	(set g_dialog false)
)

(script static void md_catwalk_floor_delay_2
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: lieutenant!  we need to get up to those catwalks!")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0880)

	(set g_dialog false)
)

(script static void md_catwalk_top_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) false)
	
		(md_print "emile: let's find a way out, six. east door on the platform looks good.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0910)

	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	(set g_dialog false)
)

(script static void md_catwalk_exit
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) false)
	
		(md_print "keyes: keyes to noble team.  we're running out of time here, spartans.")
		(f_md_object_play (random_range 30 60) none m70_0920)
		(md_print "emile: solid copy, sir.  we're close.")
		(f_md_ai_play (random_range 20 30) (object_get_ai o_emile) m70_0930)
		(md_print "emile: last push, lieutenant.")
		(f_md_ai_play 0 (object_get_ai o_emile) m70_0940)

	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	(set g_dialog false)
)

; platform  ========================================================

(global ai ai_trooper_platform_1 none)
(script static void md_platform_intro
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) false)

		(vs_cast sq_platform_marine_w0_2/marine_1 false 10 "m70_0960")
		(set ai_trooper_platform_1 (vs_role 1))

		(md_print "emile: what's the situation?")
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0950)
		(md_print "trooper: we rigged a mass-driver up top.  we lose it, and the autumn has no covering fire! she'll never make orbit!")
		(f_md_ai_play (random_range 30 60) ai_trooper_platform_1 m70_0960)
		(md_print "emile: noble to keyes: we're at the pad.")
		(set s_music_platform 2)
		(f_md_ai_play (random_range 30 60) (object_get_ai o_emile) m70_0970)
		(md_print "keyes: copy, noble.  my pelican's ready; clear an lz and i'll meet you there.")
		(f_md_object_play (random_range 30 60) none m70_0980)
		(md_print "emile: will do, captain.  all right, six... this is it.")
		(f_md_ai_play (random_range 20 30) (object_get_ai o_emile) m70_0990)
		(md_print "emile: i'll man the big gun!  you just get to the platform and deliver that package!")
		(f_md_ai_play 10 (object_get_ai o_emile) m70_1000)

	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	(set g_dialog false)
)

(script static void md_platform_emilegun
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: i'm in position!  i'll take out as many dropships as i can!")
		(f_md_object_play 0 none m70_1010)

	(set g_dialog false)
)


(script static void md_platform_wave_0_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: do it, six!  kill those bastards!")
		(f_md_object_play 0 none m70_1030)

	(set g_dialog false)
)


(script static void md_platform_wave_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: hold 'em off until keyes gets here!")
		(f_md_object_play 0 none m70_1020)
		(set s_music_platform 3)

	(set g_dialog false)
)

(script static void md_platform_wave_1_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: take 'em out, lieutenant! clear the zone!")
		(f_md_object_play 0 none m70_1040)

	(set g_dialog false)
)

(script static void md_platform_wave_2
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "emile: we got more on the way!")
		(f_md_object_play 0 none m70_1050)

	(set g_dialog false)
)

(script static void md_platform_wave_2_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "trooper: spartan! we're gonna lose this position!")
		(f_md_object_play 0 none m70_1090)

	(set g_dialog false)
)


(script static void md_platform_wave_2_delay_0_marine
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "trooper: they're everywhere, spartan!  assist!")
		(f_md_object_play 0 none m70_1070)

	(set g_dialog false)
)

(script static void md_platform_done
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_actor_dialogue_enable (object_get_ai o_emile) false)

		(md_print "emile: noble to keyes: the pad is clear!")
		(f_md_object_play (random_range 30 60) none m70_1170)
		(md_print "keyes: on my way.")
		(f_md_object_play (random_range 30 60) none m70_1180)
		(md_print "emile: six. time for you to leave. get the package to the pad... and get your ass off this planet. i got your back.")
		(f_md_object_play 0 none m70_1190)

	(ai_actor_dialogue_enable (object_get_ai o_emile) true)
	(set g_dialog false)
)

(script static void md_platform_keyesenter
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "keyes: this is keyes.  on hot approach to platform delta.")
		(f_md_object_play 0 none m70_1200)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_platform_keyesland
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "keyes: ready to take possession of the package, noble.")
		(f_md_object_play 0 none m70_1210)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

; zealot  ========================================================

(script static void md_zealot_gotogun
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)	

		(md_print "keyes: noble six, get on that mass driver and clear me a path!")
		(f_md_object_play 0 none m70_1220)
		(set s_music_zealot 1)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_zealot_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)

		(md_print "keyes: spartan, do you copy?  heat up that gun!  we've got multiple craft bearing down on us!")
		(f_md_object_play 0 none m70_1230)

	(set g_dialog false)
)

(script static void md_zealot_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "keyes: we need you on that gun, noble!  or the autum's sitting in her grave!")
		(f_md_object_play 0 none m70_1240)

	(set g_dialog false)
)

(script static void md_zealot_delay_2
	(sleep_until (not g_dialog))
	(set g_dialog true)
	
		(md_print "keyes: you're going to have to take down that cruiser, spartan!")
		(f_md_object_play 0 none m70_1250)

	(set g_dialog false)
)

; cannon  ========================================================

(script static void md_cannon_enter
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "keyes: cruiser moving into position... i need it dead!")
		(f_md_object_play 0 none m70_1270)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_cannon_move_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)	

		(md_print "keyes: mass driver won't crack those shields... steady, spartan...")
		(f_md_object_play 0 none m70_1280)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_cannon_fire_delay_0
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "keyes: fire now, lieutenant!  hit her in the gut!")
		(f_md_object_play 0 none m70_1310)

	(ai_dialogue_enable true)
	(set g_dialog false)
)


(script static void md_cannon_fire_delay_1
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "keyes: you've got to fire now, spartan!  we won't survive another hit!")
		(f_md_object_play 0 none m70_1320)

	(ai_dialogue_enable true)
	(set g_dialog false)
)


(script static void md_cannon_fire_delay_2
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)
	
		(md_print "keyes: aim for the glassing port!")
		(f_md_object_play 0 none m70_1300)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

(script static void md_cannon_die
	(sleep_until (not g_dialog))
	(set g_dialog true)
	(ai_dialogue_enable false)	

		(md_print "keyes: no! she's glassing! do you copy, noble?  do you copy...?")
		(f_md_object_play 0 none m70_1330)

	(ai_dialogue_enable true)
	(set g_dialog false)
)

; =================================================================================================
; mission dialogue: main scripts
; =================================================================================================
(script static void (md_play_debug (short delay) (string line))
	(if dialogue (print line))
	(sleep delay))

(script static void (md_play (short delay) (sound line))
	(sound_impulse_start line none 1)
	(sleep (sound_impulse_language_time line))
	(sleep delay))

(script static boolean obj_dgate__0_0
(< objcon_dirt 50))

(script static boolean obj_dgate__0_1
(< objcon_dirt 60))

(script static boolean obj_dgate__0_6
(< objcon_dirt 60))

(script static boolean obj_dgate__0_8
(< objcon_dirt 60))

(script static boolean obj_dgate__0_10
(< objcon_dirt 60))

(script static boolean obj_dconvo_0_13
(f_dirt_convoy_search))

(script static boolean obj_dconvo_0_15
b_ridge_search)

(script static boolean obj_dconvo_0_16
(f_dirt_convoy_search))

(script static boolean obj_dconvo_0_17
(f_dirt_convoy_search))

(script static boolean obj_dgate__0_18
(< objcon_dirt 60))

(script static boolean obj_bgate__2_0
(< objcon_block 50))

(script static boolean obj_bgate__2_15
(>= objcon_block 40))

(script static boolean obj_bgate__2_17
(and (>= objcon_block 50) (= (ai_living_count sq_block_wraith) 0)  ))

(script static boolean obj_bgrunt_2_19
(< objcon_block 20))

(script static boolean obj_bgrunt_2_20
(< objcon_block 17))

(script static boolean obj_cgate__3_0
(< objcon_crane 50))

(script static boolean obj_cgate__3_1
(< objcon_crane 45))

(script static boolean obj_cgate__3_3
(< objcon_crane 50))

(script static boolean obj_clow_p_3_4
(< objcon_crane 40))

(script static boolean obj_cgate__3_7
(< objcon_crane 53))

(script static boolean obj_cunder_3_8
(volume_test_players tv_crane_area_under))

(script static boolean obj_chunte_3_12
(< objcon_crane 60))

(script static boolean obj_cskirm_3_21
(< objcon_crane 60))

(script static boolean obj_ccontr_4_0
(> (ai_task_count obj_crane_cov/gate_high) 1))

(script static boolean obj_clow_l_4_3
(< objcon_crane 45))

(script static boolean obj_cinit_4_5
(< objcon_crane 30))

(script static boolean obj_clow_l_4_6
(> (ai_task_count  obj_crane_cov/gate_low) 2))

(script static boolean obj_chigh_4_7
(> (ai_task_count obj_crane_cov/gate_middle) 1))

(script static boolean obj_cmiddl_4_8
(> (ai_task_count obj_crane_cov/gate_low) 1))

(script static boolean obj_clow_l_4_10
(> (ai_task_count  obj_crane_cov/gate_door) 2))

(script static boolean obj_cadvan_4_12
(< objcon_crane 40))

(script static boolean obj_cadvan_4_13
(< objcon_crane 45))

(script static boolean obj_cadvan_4_14
(< objcon_crane 55))

(script static boolean obj_cadvan_4_16
(< objcon_crane 50))

(script static boolean obj_demile_5_1
(not b_dirt_cov_alerted))

(script static boolean obj_demile_5_2
(> (ai_task_count obj_dirt_cov/gate_infantry) 8))

(script static boolean obj_demile_5_4
(> (ai_task_count obj_dirt_cov/gate_infantry) 12))

(script static boolean obj_demile_5_5
(<= objcon_dirt 10))

(script static boolean obj_demile_5_6
(< objcon_dirt 55))

(script static boolean obj_demile_5_7
(< objcon_dirt 40))

(script static boolean obj_demile_5_8
(< objcon_dirt 50))

(script static boolean obj_demile_5_9
(> (ai_task_count obj_dirt_cov/gate_infantry) 6))

(script static boolean obj_demile_5_10
(> (ai_task_count obj_dirt_cov/gate_infantry) 4))

(script static boolean obj_badvan_7_0
(> (ai_task_count obj_block_cov/gate_infantry) 12))

(script static boolean obj_badvan_7_3
(> (ai_task_count obj_block_cov/gate_infantry) 10))

(script static boolean obj_badvan_7_4
(> (ai_task_count obj_block_cov/gate_infantry) 8))

(script static boolean obj_badvan_7_5
(< objcon_block 70))

(script static boolean obj_binit_7_7
(< objcon_block 20))

(script static boolean obj_badvan_7_8
(< objcon_block 30))

(script static boolean obj_badvan_7_9
(< objcon_block 40))

(script static boolean obj_badvan_7_10
(or (and (< objcon_block 70)(> (ai_living_count sq_block_wraith) 1)) (and (< objcon_block 50)(>= (ai_living_count sq_block_wraith) 0))))

(script static boolean obj_badvan_7_11
(or (and (< objcon_block 70)(> (ai_living_count sq_block_wraith) 1)) (and (< objcon_block 60)(>= (ai_living_count sq_block_wraith) 0))))

(script static boolean obj_tbugge_8_4
(> objcon_tunnels 40))

(script static boolean obj_tbugge_8_6
(> objcon_tunnels 40))

(script static boolean obj_tgate__8_9
(< objcon_tunnels 55))

(script static boolean obj_twindo_8_12
(<= objcon_tunnels 40))

(script static boolean obj_tinit_9_0
(< objcon_tunnels 15))

(script static boolean obj_tadvan_9_2
(< objcon_tunnels 30))

(script static boolean obj_tadvan_9_3
(< objcon_tunnels 40))

(script static boolean obj_tadvan_9_4
(< objcon_tunnels 55))

(script static boolean obj_tadvan_9_5
(< objcon_tunnels 60))

(script static boolean obj_tadvan_9_7
(< objcon_tunnels 20))

(script static boolean obj_wleft__10_0
(< objcon_wall 40))

(script static boolean obj_wskirm_10_3
(and (volume_test_players tv_wall_left) (< objcon_wall 40)))

(script static boolean obj_wskirm_10_4
(and (volume_test_players tv_wall_left) (< objcon_wall 40)))

(script static boolean obj_wskirm_10_5
(< objcon_wall 40))

(script static boolean obj_wgate__10_8
(<= (ai_living_count obj_wall_cov) 4))

(script static boolean obj_wwait__10_10
(< objcon_wall 40))

(script static boolean obj_wwait__10_12
(< objcon_wall 40))

(script static boolean obj_wfallb_10_15
(< objcon_wall 60))

(script static boolean obj_wfallb_10_16
(< objcon_wall 50))

(script static boolean obj_wskirm_10_17
(< objcon_wall 40))

(script static boolean obj_wcente_10_18
(< objcon_wall 40))

(script static boolean obj_winit_11_5
(< objcon_wall 15))

(script static boolean obj_wgate__11_6
(and (<= (ai_task_count obj_wall_cov/left_middle) 2) (>= objcon_wall 30)))

(script static boolean obj_wgate__11_7
(and (<= (ai_task_count obj_wall_cov/center_middle) 2) (>= objcon_wall 30)))

(script static boolean obj_wgate__11_10
(and (<= (ai_task_count obj_wall_cov/fallback_crane) 2) (>= objcon_wall 40)))

(script static boolean obj_wgate__11_11
(and (<= (ai_task_count obj_wall_cov/fallback_ship) 2) (>= objcon_wall 50)))

(script static boolean obj_wadvan_11_14
(< objcon_wall 20))

(script static boolean obj_wadvan_11_16
(< objcon_wall 50))

(script static boolean obj_wadvan_11_17
(< objcon_wall 40))

(script static boolean obj_wadvan_11_18
(< objcon_wall 30))

(script static boolean obj_vemile_13_2
(> (ai_in_vehicle_count sq_emile) 0))

(script static boolean obj_fgate__14_6
(>= objcon_factory 30))

(script static boolean obj_fwreck_14_11
(< objcon_factory 25))

(script static boolean obj_fgate__14_15
(< objcon_factory 30))

(script static boolean obj_finit_15_1
(< objcon_factory 20))

(script static boolean obj_fgate__15_6
(<= (ai_task_count obj_factory_cov/wreck_right) 2))

(script static boolean obj_fgate__15_8
(<= (ai_living_count sq_factory_shade_1) 0))

(script static boolean obj_fgate__15_10
(<= (ai_task_count obj_factory_cov/gate_factory_ent) 2))

(script static boolean obj_fadvan_15_12
(< objcon_factory 25))

(script static boolean obj_fadvan_15_13
(< objcon_factory 30))

(script static boolean obj_fadvan_15_14
(< objcon_factory 40))

(script static boolean obj_fadvan_15_15
(< objcon_factory 50))

(script static boolean obj_cgate__16_2
(< objcon_catwalk 40))

(script static boolean obj_cgate__16_4
(< objcon_catwalk 35))

(script static boolean obj_celite_16_10
(< objcon_catwalk 40))

(script static boolean obj_celite_16_12
(< objcon_catwalk 30))

(script static boolean obj_cgate__16_13
(< objcon_catwalk 40))

(script static boolean obj_cinit_17_2
(< objcon_catwalk 20))

(script static boolean obj_cbecko_17_4
(and (< objcon_catwalk 1) (<= (ai_living_count gr_crane_cov_hunters) 0) (<= (ai_living_count sq_crane_skirmishers_1) 0) (<= (ai_living_count sq_crane_skirmishers_2) 0) ))

(script static boolean obj_cadvan_17_5
(< objcon_catwalk 30))

(script static boolean obj_cadvan_17_6
(< objcon_catwalk 40))

(script static boolean obj_cadvan_17_7
(< objcon_catwalk 60))

(script static boolean obj_zledge_18_5
(and (< objcon_zealot 40) (> (unit_get_health sq_zealot_elite_zealot) .8 )))

(script static boolean obj_zbay_r_18_7
(volume_test_players tv_zealot_bayright))

(script static boolean obj_zbay_l_18_9
(volume_test_players tv_zealot_bayleft))

(script static boolean obj_zstep__18_13
(< objcon_zealot 45))

(script static boolean obj_zgate__18_16
(< objcon_zealot 25))

(script static boolean obj_zelite_18_17
(< objcon_zealot 40))

(script static boolean obj_zengin_18_24
 (> (unit_get_health sq_zealot_engineer_1) .6 ))

(script static boolean obj_punder_19_0
(volume_test_players tv_platform_area_under))

(script static boolean obj_ptower_19_1
(volume_test_players tv_platform_area_towerlow))

(script static boolean obj_ptower_19_2
(volume_test_players tv_platform_area_towerroof))

(script static boolean obj_pledge_19_3
(volume_test_players tv_platform_area_ledge))

(script static boolean obj_pgate__19_4
(>= s_platform_wave 1))

(script static boolean obj_pgate__19_8
(< objcon_platform 40))

(script static boolean obj_pgate__19_10
(>= s_platform_wave 2))

(script static boolean obj_pgate__19_13
(>= s_platform_wave 0))

(script static boolean obj_psafer_19_15
(volume_test_players tv_platform_area_saferoom))

(script static boolean obj_pwave__19_17
(not b_platform_bezerk))

(script static boolean obj_pwave__19_18
(<= (ai_living_count obj_platform_cov) 9))

(script static boolean obj_pwave__19_23
b_platform_bezerk)

(script static boolean obj_pledge_20_2
(< s_platform_wave 1))

(script static boolean obj_proof_20_3
(< s_platform_wave 2))

(script static boolean obj_pgate__20_4
(< objcon_platform 30))

(script static boolean obj_pwindo_20_8
(<= (ai_task_count obj_platform_cov/gate_interior) 0))

(script static boolean obj_ptarge_20_9
b_platform_emile_split_done)

(script static boolean obj_padvan_20_10
(< objcon_platform 10))

(script static boolean obj_gbansh_25_3
(>= objcon_goose 17))

(script static boolean obj_gbansh_25_4
(>= objcon_goose 20))

(script static boolean obj_gbansh_25_5
(>= objcon_drop 20))

(script static boolean obj_gbansh_25_6
(>= objcon_drop 35))

(script static boolean obj_gbansh_25_7
(>= objcon_drop 45))
