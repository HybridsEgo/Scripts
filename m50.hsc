; =================================================================================================
; global_fork.hsc
; how to use:
; 	1. open your scenario in sapien
;	2. in the menu bar, open the "scenarios" menu, then select "add mission script"
;	3. point the dialogue to this file: main\data\globals\global_fork.hsc
; =================================================================================================
(global boolean b_debug_fork true)

;*
== load parameters ==
left, right, default, left_full, right_full, full
*;

(script static void (f_load_fork
								(vehicle fork)
								(string load_side)
								(ai load_squad_01)
								(ai load_squad_02)
								(ai load_squad_03)
								(ai load_squad_04)
				)
				
	(ai_place load_squad_01)
	(ai_place load_squad_02)
	(ai_place load_squad_03)
	(ai_place load_squad_04)
		(sleep 1)
		
	
	(cond
		; left 
		((= load_side "left")
						(begin
							(if b_debug_fork (print "load fork left..."))
							(ai_vehicle_enter_immediate load_squad_01 fork "fork_p_l")
							(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l")
							(ai_vehicle_enter_immediate load_squad_03 fork "fork_p_l")
							(ai_vehicle_enter_immediate load_squad_04 fork "fork_p_l")
						)
		)
		; right 
		((= load_side "right")
						(begin
							(if b_debug_fork (print "load fork right..."))
							(ai_vehicle_enter_immediate load_squad_01 fork "fork_p_r")
							(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_r")
							(ai_vehicle_enter_immediate load_squad_03 fork "fork_p_r")
							(ai_vehicle_enter_immediate load_squad_04 fork "fork_p_r")
							
						)
		)
		; dual 
		((= load_side "dual")
						(begin
							(if b_debug_fork (print "load fork dual..."))
							(ai_vehicle_enter_immediate load_squad_01 fork "fork_p_l")
							(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l")
							(ai_vehicle_enter_immediate load_squad_03 fork "fork_p_r")
							(ai_vehicle_enter_immediate load_squad_04 fork "fork_p_r")
						)
		)
		
		((= load_side "any")
						(begin
							(if b_debug_fork (print "load fork any..."))
							(ai_vehicle_enter_immediate load_squad_01 fork "fork_p")
							(ai_vehicle_enter_immediate load_squad_02 fork "fork_p")
							(ai_vehicle_enter_immediate load_squad_03 fork "fork_p")
							(ai_vehicle_enter_immediate load_squad_04 fork "fork_p")
						)
		)
	)
)

(script static void (f_load_fork_cargo
										(vehicle fork)		; the phantom you are loading the cargo in to 
										(string load_type)	; 1 - single load    ---   2 - double load 
										(ai load_squad_01)		; first squad to load
										(ai load_squad_02)		; second squad to load 
										(ai load_squad_03)		; third squad to load 
				)
	; place ai 
	
	; load into fork 
	(cond
		((= load_type "large")	
						(begin
							(ai_place load_squad_01)
								(sleep 1)
							(vehicle_load_magic fork "fork_lc" (ai_vehicle_get_from_squad load_squad_01 0))
						)
		)
		((= load_type "small")	
						(begin
							(ai_place load_squad_01)
							(ai_place load_squad_02)
							(ai_place load_squad_03)
								(sleep 1)
							(vehicle_load_magic fork "fork_sc01" (ai_vehicle_get_from_squad load_squad_01 0))
							(vehicle_load_magic fork "fork_sc02" (ai_vehicle_get_from_squad load_squad_02 0))
							(vehicle_load_magic fork "fork_sc03" (ai_vehicle_get_from_squad load_squad_03 0))
						)
		)
	)
)

; call this script when the fork is in place to drop off all the ai ====================================================================
(script static void (f_unload_fork
										(vehicle fork)
										(string drop_side)
				)
	
	(if b_debug_fork (print "opening fork..."))
	(unit_open fork)
	(sleep 30)
	; determine how to unload the phantom 
	(cond
		((= drop_side "left")	
						(begin
							(f_unload_fork_left fork)
							(sleep 75)
						)
		)

		((= drop_side "right")	
						(begin
							(f_unload_fork_right fork)
							(sleep 75)
						)
		)

		((= drop_side "dual")
						(begin
							(f_unload_fork_all fork)
							(sleep 75)
						)
		)
	)
	
	(if b_debug_fork (print "closing fork..."))
	(unit_close fork)	
)


(script static void (f_unload_fork_left	(vehicle fork))
	(begin_random
		(begin
			(vehicle_unload fork "fork_p_l1")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l2")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l3")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l4")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l5")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l6")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l7")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l8")
			(sleep (random_range 0 10))
		)
	)
)

(script static void (f_unload_fork_right (vehicle fork))
	(begin_random
		(begin
			(vehicle_unload fork "fork_p_r1")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r2")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r3")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r4")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r5")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r6")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r7")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r8")
			(sleep (random_range 0 10))
		)
	)
)

(script static void (f_unload_fork_all	(vehicle fork))
	(begin_random
		(begin
			(vehicle_unload fork "fork_p_l1")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l2")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l3")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l4")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l5")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l6")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l7")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_l8")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r1")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r2")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r3")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r4")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r5")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r6")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r7")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload fork "fork_p_r8")
			(sleep (random_range 0 10))
		)
	)
)

(script static void (f_unload_fork_cargo
										(vehicle fork)
										(string load_type)
				)
	; unload cargo seats 
	(cond
		((= load_type "large")	(vehicle_unload fork "fork_lc"))
		((= load_type "small")
								(begin_random
									(begin
										(vehicle_unload fork "fork_sc01")
										(sleep (random_range 15 30))
									)
									(begin
										(vehicle_unload fork "fork_sc02")
										(sleep (random_range 15 30))
									)
									(begin
										(vehicle_unload fork "fork_sc03")
										(sleep (random_range 15 30))
									)
								)
		)
		((= load_type "small01")
								(vehicle_unload fork "fork_sc01")
		)
		((= load_type "small02")
								(vehicle_unload fork "fork_sc02")
		)
		((= load_type "small03")
								(vehicle_unload fork "fork_sc03")
		)
	)
)
; ===============================================================================================================================================
; global hud ================================================================================================================================
; ===============================================================================================================================================
(script static void f_hud_obj_complete
	(objectives_clear)
	(chud_show_screen_objective campaign_hud_objcomplete)
	(sleep 160)
	(chud_show_screen_objective "")
)�tgbl���������������tgst��¯��¯tgda������; =================================================================================================
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
�tgbl���������������tgst�ð[�ð[tgda�����àç; =================================================================================================
; globals
; =================================================================================================

; debug options
(global boolean debug 				false)
(global boolean debug_objectives 	true)
(global boolean editor 				false)
(global boolean cinematics 			false)
(global boolean dialogue 			true)
(global boolean skip_intro			false)
(global boolean corvette_fx			false)

; insertion
(global short s_active_insertion_index 0)

; objective controls
(global short objcon_panoptical		-1)	
(global short objcon_towers			-1)
(global short objcon_interior		-1)
(global short objcon_canyonview		-1)
(global short objcon_atrium		 	-1)
(global short objcon_ready	-1)
(global short objcon_jetpack_low	-1)
(global short objcon_jetpack_high	-1)
(global short objcon_trophy	-1)
(global short objcon_ride			-1)
(global short objcon_starport		-1)

; waypoint timeout
(global short g_waypoint_timeout (* 30 90))

; =================================================================================================
; manassas startup - new alexandria
; =================================================================================================
(script startup manassas
	(print_difficulty)
	(if debug (print "::: m50 - manassas :::"))

	; snap to black 
	(fade_out 0 0 0 0)
	
	; object control
	(wake object_control)	
	(wake recycle_control)
	(wake special_elite)
	;(wake f_corvette_exterior)
	
	; coop initial profiles
	(if (game_is_cooperative)
		(begin
			(unit_add_equipment player0 profile_starting true false)
			(unit_add_equipment player1 profile_starting true false)
			(unit_add_equipment player2 profile_starting true false)
			(unit_add_equipment player3 profile_starting true false)
			
			; coop respawn profile
			(player_set_profile profile_starting)
;*
			(begin
				(player_set_profile profile_coop_respawn player0)
				(player_set_profile profile_coop_respawn player1)
				(player_set_profile profile_coop_respawn player2)
				(player_set_profile profile_coop_respawn player3))
*;
		)
	)
		
	; allegiances
	(ai_allegiance human player)
	(ai_allegiance player human)

; ============================================================================================		
	;set up soft ceilings
; ============================================================================================	
		
	;enable initially, always on 
	;(soft_ceiling_enable default 1)

	;enable initially, disable at jetpack_high
	(soft_ceiling_enable low_jetpack_blocker 0)

	;enable initially, disable at ride start
	(soft_ceiling_enable rail_blocker_01 1)

	;disabled initially, enabled after rooftop0
	(soft_ceiling_enable rail_blocker_02 0)
	
	;disabled initially, enable on begin zone switch 090
	(soft_ceiling_enable rail_blocker_03 0)

	;enable initially, disable after begin zone switch 090
	(soft_ceiling_enable rail_blocker_04 1)
	
	;enabled initially, disabled after zone switch 090
	(soft_ceiling_enable rail_blocker_05 1)
	
	;disabled initially, enable at begin transport vignette
	(soft_ceiling_enable rail_blocker_06 0)
	
	;disabled initially, enable at falcon unload
	(soft_ceiling_enable rail_blocker_07 0)
	
	;enabled initially, disable after starport setup
	(soft_ceiling_enable rail_blocker_08 1)
	

; ============================================================================================	
	
	; starting the game
	; ============================================================================================	
		; intro cinematic
	
	
	; choose the insertion point depending on the mode
	(if (or (not (editor_mode)) cinematics)
		(start)
			
		(begin
			(if debug (print "editor mode. snapping fade in..."))
			(fade_in 0 0 0 0)
		)
	)
	

	
	; encounters
	; ============================================================================================
	
		; panoptical
		; =======================================================================================
		;*
		(sleep_until	
			(or
				(volume_test_players tv_panoptical_start)
				(>= s_active_insertion_index s_index_panoptical))
		1)*;
		
		(sleep_until	
				(>= s_active_insertion_index s_index_panoptical)
		1)
		
		
		(if (<= s_active_insertion_index s_index_panoptical) (wake panoptical_objective_control))
		
		
		; towers
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_towers_start)
				(>= s_active_insertion_index s_index_towers))
		1)
		
		(if (<= s_active_insertion_index s_index_towers) (wake towers_objective_control))
		
		
		; interior
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_interior_start)
				(>= s_active_insertion_index s_index_interior))
		1)
		
		(if (<= s_active_insertion_index s_index_interior) (wake interior_objective_control))
		
		; canyonview
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_canyonview_start)
				(>= s_active_insertion_index s_index_canyonview))
		1)
		
		(if (<= s_active_insertion_index s_index_canyonview) (wake canyonview_objective_control))
		
		
		; atrium
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_atrium_start)
				(>= s_active_insertion_index s_index_atrium))
		1)
		
		;(if (<= s_active_insertion_index s_index_atrium) (wake atrium_objective_control))
		(if (<= s_active_insertion_index s_index_atrium) 
				(begin
					(sleep_until (= (current_zone_set_fully_active) 3))
					(wake atrium_objective_control)
				)
		)	
		
			
		; ready room
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_ready_start)
				(>= s_active_insertion_index s_index_ready))
		1)
		
		(if (<= s_active_insertion_index s_index_ready) (wake ready_objective_control))		
		
		; jetpack_low
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_jetpack_low_start)
				(>= s_active_insertion_index s_index_jetpack_low))
		1)
		
		(if (<= s_active_insertion_index s_index_jetpack_low) (wake jetpack_low_objective_control))
		

		; jetpack_high
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_jetpack_high_start)
				(>= s_active_insertion_index s_index_jetpack_high))
		1)
		
		(if (<= s_active_insertion_index s_index_jetpack_high) (wake jetpack_high_objective_control))
				
		; trophy
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_trophy_high_start)
				(volume_test_players tv_objcon_jetpack_high_060)
				(>= s_active_insertion_index s_index_trophy))
		1)
		
		(if (<= s_active_insertion_index s_index_trophy) (wake trophy_objective_control))
				
		; ride
		; =======================================================================================
		(sleep_until	
			(or
				;(volume_test_players tv_jetpack_start)
				(= b_jetpack_high_complete true)
				(>= s_active_insertion_index s_index_ride))
		1)
		
		(if (<= s_active_insertion_index s_index_ride) (wake ride_objective_control))
		
		; starport
		; =======================================================================================
		(sleep_until	
			(or
				(volume_test_players tv_starport_start01)
				(volume_test_players tv_starport_start02)
				(>= s_active_insertion_index s_index_starport))
		1)
		
		(if (<= s_active_insertion_index s_index_starport) (wake starport_objective_control))
)

; =================================================================================================
; start
; =================================================================================================
(script static void start		
	; figure out what insertion point to use
	(cond
		((= (game_insertion_point_get) 0) (ins_panoptical))
		((= (game_insertion_point_get) 1) (ins_ready))
		((= (game_insertion_point_get) 2) (ins_ride))
		((= (game_insertion_point_get) 3) (ins_starport))
		;((= (game_insertion_point_get) 4) (ins_))
		;((= (game_insertion_point_get) 5) (ins_ride_test))
		((= (game_insertion_point_get) 6) (ins_ambient_fx_test_panoptical))
		((= (game_insertion_point_get) 7) (ins_ambient_fx_test_canyonview))
		((= (game_insertion_point_get) 8) (ins_ambient_fx_test_jetpack))
		((= (game_insertion_point_get) 9) (ins_ambient_fx_test_starport))
;		((= (game_insertion_point_get) 10) (ins_ambient_fx_test))
;		((= (game_insertion_point_get) 11) (ins_transport_test))		
	)
)

; -------------------------------------------------------------------------------------------------
; recycle
; -------------------------------------------------------------------------------------------------
(global short s_recycle_interval 120)	; recycle interval in seconds
(script dormant recycle_control
	(sleep_until
		(begin
			(if debug (print "recycle interval hit..."))
			(if b_towers_started
				(begin
					(if debug (print "recycle volume activated for panoptical..."))
					(add_recycling_volume tv_recycle_panoptical 10 60)))
					
			(if b_interior_started
				(begin
					(if debug (print "recycle volume activated for towers..."))
					(add_recycling_volume tv_recycle_towers 10 60)))
					
			(if b_canyonview_started
				(begin
					(if debug (print "recycle volume activated for interior..."))
					(add_recycling_volume tv_recycle_interior 10 60)))
					
			(if b_atrium_started
				(begin
					(if debug (print "recycle volume activated for canyonview..."))
					(add_recycling_volume tv_recycle_canyonview 10 60)))
									
			(sleep (* s_recycle_interval 30))	; wait for next interval
			
			(or b_ready_started b_jetpack_low_started b_jetpack_high_started b_starport_started)
		)
	)
		
	(if debug (print "player has entered ready room. hardcore cleanup of all earlier encounters..."))
	(add_recycling_volume tv_recycle_panoptical 0 0)
	(add_recycling_volume tv_recycle_towers 0 0)
	(add_recycling_volume tv_recycle_interior 0 0)
	(add_recycling_volume tv_recycle_canyonview 0 0)
	(add_recycling_volume tv_recycle_atrium 0 0)
	
	(sleep_until 
		(begin
			(if debug (print "recycle interval hit..."))
			(if b_jetpack_low_started
				(begin
					(if debug (print "recycle volume activated for ready room..."))
					(add_recycling_volume tv_recycle_ready 10 60)))
					
			(if b_jetpack_high_started
				(begin
					(if debug (print "recycle volume activated for jetpack low..."))
					(add_recycling_volume tv_recycle_jetpack_low 10 60)))

			(if b_ride_started
				(begin
					(if debug (print "recycle volume activated for jetpack high..."))
					(add_recycling_volume tv_recycle_jetpack_high 10 60)))
	
			(if b_starport_started
				(begin
					(if debug (print "recycle volume activated for ride..."))
					(add_recycling_volume tv_recycle_ride 10 60)))
										
			(sleep (* s_recycle_interval 30))	; wait for next interval
			
			b_starport_started
		)
	)		
	
	(if debug (print "player has begun starport. hardcore cleanup of all earlier encounters..."))
	(add_recycling_volume tv_recycle_ready 0 0)
	(add_recycling_volume tv_recycle_jetpack_low 0 0)
	(add_recycling_volume tv_recycle_jetpack_high 0 0)
	(add_recycling_volume tv_recycle_ride 0 0)
)

; =================================================================================================
; fireteam setup
; =================================================================================================
(script startup fireteam_setup
	(sleep_until (> (player_count) 0))
		(if debug (print "setting up fireteams..."))
		(if (not (game_is_cooperative))
		(ai_player_add_fireteam_squad (player0) fireteam_player0))
;*		
		(if (game_is_cooperative)
			(begin
				(ai_player_add_fireteam_squad (player0) fireteam_player0)
				(ai_player_add_fireteam_squad (player1) fireteam_player0)
				(ai_player_add_fireteam_squad (player2) fireteam_player0)
				(ai_player_add_fireteam_squad (player3) fireteam_player0)
			))
*;
)

; =================================================================================================
; panoptical objective control
; =================================================================================================
(script dormant panoptical_objective_control

	(if (or (not (editor_mode)) cinematics)
		(begin 
			(if debug (print "starting with intro cinematic..."))
			(f_start_mission 050la_wake)
		)
	)
	
	(if debug (print "encounter start: panoptical"))
	(game_save)

	; music
	;(mus_play mus_e_low)

	(wake f_corvette_exterior)
	(wake ct_title_act1)
	(wake f_panoptical_fx_ambient)		
	(wake panoptical_longsword_cycle)
	(wake md_amb_traxus01)
	(wake md_amb_bombers)
	(wake panoptical_waypoint)
 	;(wake f_corvette_exterior)
	(wake unperch_panoptical_raven)
	;(wake panoptical_corvette_attack)
	;(wake fx_corvette_1)
	
	; flocks
	(flock_create fl_shared_banshee0)
	(flock_create fl_shared_falcon0)
	(flock_create fl_shared_banshee1)
	(flock_create fl_shared_falcon1)
	(flock_create fl_corvette_phantom1)
	;(flock_create fl_panoptical_raven0)
	
	;block camera
	(object_create sc_door_towers0)
	(object_create dm_condo_door0)
	
	(f_ai_place_vehicle_deathless_no_emp panoptical_falcon0)
	(f_ai_place_vehicle_deathless_no_emp panoptical_falcon1)
	;(sleep (* 30 5))
	;(ai_place panoptical_pelican0)
	
	(cinematic_exit 050la_wake true)
	
	(sleep_until b_towers_started)
	(if debug (print "cleaning up panoptical..."))
	;(ai_disposable gr_civilians_panoptical true)	
)

(script dormant unperch_panoptical_raven
	(sleep_until (volume_test_players tv_fl_panoptical_raven0))
	(flock_create fl_panoptical_raven0)
)

(script dormant panoptical_waypoint
	(sleep g_waypoint_timeout)
	(if (not b_towers_started)
		(f_blip_flag nav_panoptical_exit blip_default))
		
	(sleep_until b_towers_started 1)
	(f_unblip_flag nav_panoptical_exit)
	;(ai_disposable gr_civilians_panoptical true)
	(flock_stop fl_panoptical_raven0)
)
;*
(global boolean b_panoptical_escort false)
(script command_script cs_panoptical_pelican0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))

	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1.0)
	(cs_vehicle_boost true)	

	;(cs_fly_by pts_panoptical_evac/p_enter0)
	(cs_fly_by pts_panoptical_evac/p_enter1)
	(cs_fly_by pts_panoptical_evac/p_enter2)
	(cs_vehicle_speed 0.5)
	(cs_fly_by pts_panoptical_evac/p_hover0)
	(cs_vehicle_speed 0.3)
	(cs_fly_to_and_face pts_panoptical_evac/p_land0 pts_panoptical_evac/p_land0_facing 0.5)
	(sleep (* 30 2))
	(cs_fly_to_and_face pts_panoptical_evac/p_hover0 pts_panoptical_evac/p_exit0 0.5)
	(set b_panoptical_escort true)
	(cs_vehicle_speed 1.0)
	(cs_fly_to pts_panoptical_evac/p_exit1)
	(cs_fly_to pts_panoptical_evac/p_exit0)
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)
*;
(script command_script cs_panoptical_falcon0

	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))

	;(cs_ignore_obstacles true)
	;(cs_enable_pathfinding_failsafe true)	

	(cs_vehicle_speed_instantaneous 1.0)
	(cs_vehicle_boost true)	
	
	(cs_attach_to_spline "spline_panoptical_evac0")
	(cs_fly_to pts_panoptical_evac/f_exit0 10)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

(script command_script cs_panoptical_falcon1

	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	;(cs_ignore_obstacles true)
	;(cs_enable_pathfinding_failsafe true)
	
	(cs_vehicle_speed_instantaneous 1.0)
	(cs_vehicle_boost true)	
	(cs_attach_to_spline "spline_panoptical_evac1")
	(cs_fly_to pts_panoptical_evac/f_exit1 10)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)


; =================================================================================================
; towers objective control
; =================================================================================================
(global boolean b_towers_started false)
; -------------------------------------------------------------------------------------------------
(script dormant towers_objective_control
	(if debug (print "encounter start: towers"))
	(set b_towers_started true)
	
	(sleep_forever f_panoptical_fx_ambient)
	(wake f_towers_fx_ambient)
	(wake towers_longsword_cycle)
	(wake md_amb_cruiser01)
	(wake towers_waypoint)
	;(wake towers_patrol)
	
	; spawn
	(ai_place cov.towers.skirmishers)
	(ai_place cov.towers.skirmishers1)
;*
	(ai_place unsc.towers.marine)
	(sleep 1)
	(ai_disregard (ai_get_object unsc.towers.marine) true)
	(sleep 1)
	(thespian_performance_setup_and_begin condo_skirmishers "" 0)
*;

	(device_operates_automatically_set dm_condo_door0 false)
	(device_closes_automatically_set dm_condo_door0 false)
	(device_set_position  dm_condo_door0 1)
	
	(sleep_until b_canyonview_started)
	(if debug (print "cleaning up towers..."))
	(ai_disposable gr_cov_towers true)
)


(script static void towers_skirmisher_escape
	;(cs_enable_targeting false)	
	;(cs_go_to 020_towers_skirmishers/leap)
	;(cs_go_to 020_towers_skirmishers/escape)	
	;(ai_erase ai_current_actor)
	
	;migrate skirmishers to interior objective
	(ai_set_objective gr_cov_towers obj_interior_cov)
	
	(sleep (* 30 5))
	
	(device_operates_automatically_set dm_condo_door0 true)
	(device_closes_automatically_set dm_condo_door0 true)
	
	(game_save)
)

;*
(script command_script cs_towers_skirmisher_escape
	;(cs_enable_targeting false)	
	;(cs_go_to 020_towers_skirmishers/leap)
	;(cs_go_to 020_towers_skirmishers/escape)	
	;(ai_erase ai_current_actor)
	
	;migrate skirmishers to interior objective
	(ai_set_objective ai_current_actor obj_interior_cov)
	(device_closes_automatically_set dm_condo_door0 true)	
)
*;
(script dormant towers_waypoint
	(sleep g_waypoint_timeout)
	(if (not b_interior_started)
		(f_blip_flag nav_towers_exit blip_default))
		
	(sleep_until b_interior_started 5)
	(f_unblip_flag nav_towers_exit)
)

(script dormant towers_patrol
	(sleep_until (or
		(volume_test_players tv_towers_stair_left)
		(volume_test_players tv_towers_stair_right)) 5)
		
	(ai_place towers_cov_inf0)
)
;*
(script static boolean (sleep_skirm0 (ai my_actor)) 
	(or
		;(>= (ai_combat_status my_actor) 5)
		(> (object_get_recent_shield_damage (ai_get_object my_actor)) 0)
		(> (object_get_recent_body_damage (ai_get_object my_actor)) 0)
		(volume_test_players tv_skirm0_interupt)
	)
)

(script static void (skirm_interupt (ai ai_civilian))
	(print "kill civilian")
	(ai_kill ai_civilian)
)
*;

; =================================================================================================
; interior objective control
; =================================================================================================
(global boolean b_interior_started false)
(global boolean b_kamikaze false)
; -------------------------------------------------------------------------------------------------
(script dormant interior_objective_control
	(if debug (print "encounter start: interior"))
	(set b_interior_started true)
	(game_save)
	(set objcon_interior 0)
		
	(ai_disposable gr_cov_panoptical true)
	(ai_disposable unsc.towers.marine true)
	
	(sleep_forever panoptical_longsword_cycle)
	(sleep_forever towers_longsword_cycle)
	(sleep_forever f_towers_fx_ambient)
	
	(object_cinematic_visibility sc_corvette1 true)
	
	; flocks
	(flock_create fl_interior_rats0)
	
	; scripts
	(wake ct_training_ui_vision)
	(wake interior_spawn_kamikazes)
	;(wake interior_music)	
	(wake interior_waypoint)
	(wake interior_sound_crash)

			
	; objective control
	(sleep_until (volume_test_players tv_objcon_interior_10) 1)
		(if debug (print "objective control: interior 10"))
		(set objcon_interior 10)
		
	(sleep_until (volume_test_players tv_objcon_interior_20) 1)
		(if debug (print "objective control: interior 20"))
		(set objcon_interior 20)

	(mus_start mus_02)

	(sleep_until (volume_test_players tv_objcon_interior_25) 1)
		(if debug (print "objective control: interior 25"))
		(set objcon_interior 25)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_interior_30) 1)
		(if debug (print "objective control: interior 30"))
		(set objcon_interior 30)
		
		(device_set_position_immediate dm_condo_door0 0)
		;(device_operates_automatically_set dm_condo_door0 false)
		(sleep 1)
		(device_set_power dm_condo_door0 0)

	(sleep_until (volume_test_players tv_objcon_interior_40) 1)
		(if debug (print "objective control: interior 40"))
		(set objcon_interior 40)
		
	(sleep_until (volume_test_players tv_objcon_interior_50) 1)
		(if debug (print "objective control: interior 50"))
		(set objcon_interior 50)

		
	(sleep_until (volume_test_players tv_objcon_interior_60) 1)
		(if debug (print "objective control: interior 60"))
		(set objcon_interior 60)
		(wake ambient_spawn_dropships)
		(wake ambient_wraith_shells_a)
		(wake ambient_wraith_shells_b)
		
	(sleep_until b_canyonview_started)
	(if debug (print "cleaning up interior..."))
	(ai_disposable gr_cov_interior true)
)

(script dormant interior_spawn_kamikazes
		(ai_place cov.interior.grunts.1)

	(sleep_until (>= objcon_interior 20) 1)
		(ai_place cov.interior.grunts.2)

	(sleep_until (>= objcon_interior 30) 1)
		(ai_place cov.interior.grunts.3a)
		(ai_place cov.interior.grunts.3b)
		(ai_place cov.interior.grunts.3c)
	
	(sleep_until (>= objcon_interior 40) 1)
		(ai_place cov.interior.grunts.4a)
		(ai_place cov.interior.grunts.4b)
		(ai_place cov.interior.grunts.4c)
		(ai_place cov.interior.grunts.5a)
		(ai_place cov.interior.grunts.5b)
		(ai_place cov.interior.grunts.5c)
	
	(sleep_until (>= objcon_interior 50) 1)
		(ai_place cov.interior.grunts.phalanx1a)
		(ai_place cov.interior.grunts.phalanx1b)
		(ai_place cov.interior.grunts.phalanx1c)
		
		(ai_place cov.interior.grunts.phalanx2a)
		(ai_place cov.interior.grunts.phalanx2b)
		(ai_place cov.interior.grunts.phalanx2c)

)

;*
(script dormant interior_music
	(mus_play mus_e_high)
	
	(sleep_until (>= objcon_interior 50))
		(sleep 30)
		(if debug (print "music swell..."))
		(snd_play mus_swell)
		
	(sleep_until (= b_canyonview_started true))
			
		(mus_stop mus_e_high)
		(mus_stop mus_e_low)
		(mus_stop mus_a_spook)
		(mus_stop mus_a_spook_fx)
)
*;

(script dormant interior_sound_crash
	;*
	(sleep_until (>= objcon_interior 10))
		(if debug (print "longsword incoming..."))
		(ls_flyby_sound)
		(sleep (random_range 60 120))
		(if debug (print "longsword bomb..."))
		(snd_play snd_tower_fall)
		(cs_run_command_script cov.interior.grunts.1 cs_wakeup)
		(cs_run_command_script cov.interior.grunts.2 cs_wakeup)
		(cs_run_command_script cov.interior.grunts.3a cs_wakeup)
		(cs_run_command_script cov.interior.grunts.3b cs_wakeup)
		(cs_run_command_script cov.interior.grunts.3c cs_wakeup)
		(cs_run_command_script cov.interior.grunts.4a cs_wakeup)
		(cs_run_command_script cov.interior.grunts.4b cs_wakeup)
		(cs_run_command_script cov.interior.grunts.4c cs_wakeup)
		(cs_run_command_script cov.interior.grunts.5a cs_wakeup)
		(cs_run_command_script cov.interior.grunts.5b cs_wakeup)
		(cs_run_command_script cov.interior.grunts.5c cs_wakeup)
		(cam_shake 0.2 1 3)
		
	
	(sleep_until (>= objcon_interior 30))
		(sleep (random_range 30 180))
		(if debug (print "longsword incoming..."))
		(ls_flyby_sound)
		(sleep (random_range 60 120))
		(if (> (random_range 0 100) 25)
			(begin
				(if debug (print "longsword bomb..."))
				(snd_play snd_tower_fall)
		(cs_run_command_script cov.interior.grunts.1 cs_wakeup)
		(cs_run_command_script cov.interior.grunts.2 cs_wakeup)
		(cs_run_command_script cov.interior.grunts.3a cs_wakeup)
		(cs_run_command_script cov.interior.grunts.3b cs_wakeup)
		(cs_run_command_script cov.interior.grunts.3c cs_wakeup)
		(cs_run_command_script cov.interior.grunts.4a cs_wakeup)
		(cs_run_command_script cov.interior.grunts.4b cs_wakeup)
		(cs_run_command_script cov.interior.grunts.4c cs_wakeup)
		(cs_run_command_script cov.interior.grunts.5a cs_wakeup)
		(cs_run_command_script cov.interior.grunts.5b cs_wakeup)
		(cs_run_command_script cov.interior.grunts.5c cs_wakeup)
				(cam_shake 0.2 1 3)
			)
			(if debug (print "the rng is watching out for you..."))
		)
		
		*;
	(sleep_until (>= objcon_interior 50))
		(sleep (random_range 30 180))
		(if debug (print "longsword incoming..."))
		;(ls_flyby_sound)
		(sleep (random_range 60 120))
		(if (> (random_range 0 100) 25)
			(begin
				(if debug (print "longsword bomb..."))
					; shot!
					(snd_play sound\weapons\mac_gun\mac_gun_m50\mac_gun_m50.sound)
					;(snd_play sound\weapons\covy_gun_tower\c_gun_tower_fire_surr.sound)
					(sleep 66)
					(snd_play sound\levels\120_halo\trench_run\island_creak.sound)
					(cam_shake 0.2 1 3)
					(interpolator_start base_bombing)
			
					(cs_run_command_script cov.interior.grunts.1 cs_wakeup)
					(cs_run_command_script cov.interior.grunts.2 cs_wakeup)
					(cs_run_command_script cov.interior.grunts.3a cs_wakeup)
					(cs_run_command_script cov.interior.grunts.3b cs_wakeup)
					(cs_run_command_script cov.interior.grunts.3c cs_wakeup)
					(cs_run_command_script cov.interior.grunts.4a cs_wakeup)
					(cs_run_command_script cov.interior.grunts.4b cs_wakeup)
					(cs_run_command_script cov.interior.grunts.4c cs_wakeup)
					(cs_run_command_script cov.interior.grunts.5a cs_wakeup)
					(cs_run_command_script cov.interior.grunts.5b cs_wakeup)
					(cs_run_command_script cov.interior.grunts.5c cs_wakeup)
			)
			(if debug (print "the rng is watching out for you..."))
		)
)

(script command_script cs_wakeup
	(cs_force_combat_status ai_current_actor 2))

(script dormant go_wild
	(sleep_until
		(begin
			(sleep (* 30 1))
			(ai_place_cue interior_grunt_kamikaze)
			(sleep 10)
			(ai_remove_cue interior_grunt_kamikaze)
		false)
	)
)

(script dormant ct_training_ui_vision
	(sleep_until (>= objcon_interior 10))
	(if (not (difficulty_is_legendary))
		(begin
			(f_hud_training player0 ct_training_vision)
			(f_hud_training player1 ct_training_vision)
			(f_hud_training player2 ct_training_vision)
			(f_hud_training player3 ct_training_vision)
		)
	)
)
	
;*
(script dormant interior_waypoint
	(sleep g_waypoint_timeout)
	(if (and (not b_canyonview_started) (<= objcon_interior 20))
		(f_blip_flag nav_interior_10 blip_default))

	(sleep_until (>= objcon_interior 25) 1)
	(f_unblip_flag nav_interior_10)
		
	(sleep g_waypoint_timeout)
	(sleep_until (>= objcon_interior 40) 1)
	(if (not b_canyonview_started)
		(f_blip_flag nav_interior_exit blip_default))
		
	(sleep_until b_canyonview_started 1)
	(f_unblip_flag nav_interior_exit)
)
*;


(script dormant interior_waypoint
	(sleep_until
		(begin
			(sleep g_waypoint_timeout)

				(cond 
						(; condition #1
							(or (volume_test_players tv_interior_wp_01)(volume_test_players tv_interior_wp_01a))
							; blip waypoint
							(begin
								(f_blip_flag nav_interior_01 blip_default)
								(sleep_until (not (or (volume_test_players_all tv_interior_wp_01)(volume_test_players_all tv_interior_wp_01a))) 1)
								(f_unblip_flag nav_interior_01)
							)
						)
						
						(; condition #2
							(volume_test_players tv_interior_wp_02)
							; blip waypoint
							(begin
								(f_blip_flag nav_interior_02 blip_default)
								(sleep_until (not (volume_test_players_all tv_interior_wp_02)) 1)
								(f_unblip_flag nav_interior_02)
							)
						)
						
						(; condition #3
							(volume_test_players tv_interior_wp_03)
							; blip waypoint
							(begin
								(f_blip_flag nav_interior_03 blip_default)
								(sleep_until (not (volume_test_players_all tv_interior_wp_03)) 1)
								(f_unblip_flag nav_interior_03)
							)
						)
						
						(; condition #4
							(volume_test_players tv_interior_wp_04)
							; blip waypoint
							(begin
								(f_blip_flag nav_interior_04 blip_default)
								(sleep_until (not (volume_test_players_all tv_interior_wp_04)) 1)
								(f_unblip_flag nav_interior_04)
							)
						)
						
						(; condition #5
							(volume_test_players tv_interior_wp_05)
							; blip waypoint
							(begin
								(f_blip_flag nav_interior_05 blip_default)
								(sleep_until (not (volume_test_players_all tv_interior_wp_05)) 1)
								(f_unblip_flag nav_interior_05)
							)
						)
				)

		b_canyonview_started)
	)
)
	

; =================================================================================================
; canyonview encounter control
; =================================================================================================
(global boolean b_canyonview_started false)
;(global boolean b_canyonview_complete 	false)
;
(global boolean b_cv_counter_started false)
(global boolean b_cv_chieftain_delivered false)
(global boolean b_cv_complete false)
(global boolean b_cv_cinematic_complete false)
; -------------------------------------------------------------------------------------------------
(script dormant canyonview_objective_control
	(if debug (print "encounter start: canyon view"))
	(set b_canyonview_started true)
	;(game_save)
	(set objcon_canyonview 0)
	
	(ai_disposable towers_cov_inf0 true)
	(ai_set_objective fireteam_player0 obj_canyonview_unsc); fireteam player 0
		
	; spawn
	(ai_place cv_unsc_echo_inf0)
	(sleep 1)
	(ai_cannot_die cv_unsc_echo_inf0 true)
	
	(if (not (game_is_cooperative))
		(begin
			(ai_place cv_unsc_echo_inf1)
			(sleep 1)
			(ai_cannot_die cv_unsc_echo_inf1 true)
		)
	)

	(ai_place panoptical_civilians0)
	(sleep 1)
	
	;perf
	(ai_force_low_lod panoptical_civilians0)
	
	(ai_disregard (ai_get_object panoptical_civilians0) true)
	(thespian_performance_setup_and_begin panoptical_injured "" 0)

	
	;(sleep_until (= (current_zone_set_fully_active) 0) 1)

	;(ai_place gr_cov_cv_initial)
	;(ai_place cv_cov_initial_inf1)
	;(ai_place cv_cov_initial_inf2)
	(sleep 1)

	(thespian_folder_activate th_canyon)
	
	; wake subsequent scripts
	(wake brute_intro)
	(wake fork_intro)
	(wake canyonview_counterattack)	
	;(wake canyonview_longsword_cycle)
	;(wake canyonview_music)
	;(wake canyonview_cinematic)
	;(wake f_canyon_fx_ambient)
	(wake canyonview_waypoint)

	;block camera
	(object_create dm_atrium_ctyd_door2)
	(object_create sc_atrium_ctyd_door1)
	(object_create sc_atrium_ctyd_door0)

	; flocks
	(flock_stop fl_interior_rats0)
		
	; mission dialogue
	;(wake md_canyonview_marine_intro)
	(wake md_cv_trooper_intro)
	
	; objective control
	(sleep_until (volume_test_players tv_objcon_canyonview_010) 1)
		(if debug (print "objective control: canyonview 010"))
		(set objcon_canyonview 10)
		(game_save)
		
	(mus_stop mus_02)
		
	(sleep_until (volume_test_players tv_objcon_canyonview_020) 1)
		(if debug (print "objective control: canyonview 020"))
		(set objcon_canyonview 20)
		(wake canyonview_zone_set_control)
		
	(sleep_until (volume_test_players tv_objcon_canyonview_030) 1)
		(if debug (print "objective control: canyonview 030"))
		(set objcon_canyonview 30)
		;(game_save)
		
	(sleep_until (volume_test_players tv_objcon_canyonview_040) 1)
		(if debug (print "objective control: canyonview 040"))
		(set objcon_canyonview 40)
		;(game_save)
		
	(sleep_until (volume_test_players tv_objcon_canyonview_050) 1)
		(if debug (print "objective control: canyonview 050"))
		(set objcon_canyonview 50)
		
	(sleep_until (volume_test_players tv_objcon_canyonview_060) 1)
		(if debug (print "objective control: canyonview 060"))
		(set objcon_canyonview 60)
		
	(sleep_until (volume_test_players tv_objcon_canyonview_070) 1)
		(if debug (print "objective control: canyonview 070"))
		(set objcon_canyonview 70)
		
	(sleep_until b_atrium_started)
	(if debug (print "cleaning up canyonview..."))
	(ai_disposable gr_cov_cv true)
	(ai_kill_silent panoptical_civilians0)
	(thespian_folder_deactivate th_canyon)
)


;(script dormant canyonview_music
	;(mus_play mus_canyonview))

;*
(script dormant canyonview_cinematic
	;(sleep_until (volume_test_players tv_canyonview_cinematic) 1)
	(cin_canyonview)
)
*;

(script dormant canyonview_counterattack
	(sleep 30)
	(sleep_until (f_task_is_empty obj_canyonview_cov/gate_main))
			
	(if debug (print "starting counterattack..."))
	(game_save)
	;prevent load hitch
	(sleep 90)

	(set b_cv_counter_started true)

	(ai_migrate gr_unsc fireteam_player0)
	(ai_set_objective fireteam_player0 obj_canyonview_unsc);fireteam player 0
	
	; coop comabat profile
	(if (game_is_cooperative)
	(player_set_profile profile_combat)
;*
			(begin
				(player_set_profile profile_combat player0)
				(player_set_profile profile_combat player1)
				(player_set_profile profile_combat player2)
				(player_set_profile profile_combat player3)
			)
*;
	)
	
	(sleep_until (= (current_zone_set_fully_active) 3))
	(sleep 10)
	
	;(ai_teleport gr_unsc canyonview_hacks/lower)
	;(ai_teleport fireteam_player0 canyonview_hacks/lower)
	
	(ai_place cs_counter_inf0)
	;(wake atrium_civilians)
	(device_set_position dm_canyonview_door1 1)
	(sleep 1)
	
	(sleep_until (f_task_is_empty obj_canyonview_cov/gate_main))
	
	(set b_cv_complete true)
	(sleep (random_range (* 30 3) (* 30 5)))
	(wake md_cv_encounter_complete)
	
	(if debug (print "counterattack complete..."))	
	
	;migrate troopers to atrium encounter
	(ai_set_objective fireteam_player0 obj_atrium_unsc)
		
)

(script static boolean cv_player_near_troopers
;*	
	(or
		(and
			(< (objects_distance_to_object (ai_get_object cv_unsc_echo_inf0) (player0)) 8.0)
			(> (objects_distance_to_object (ai_get_object cv_unsc_echo_inf0) (player0)) 0))

		(and
			(< (objects_distance_to_object (ai_get_object cv_unsc_echo_inf1) (player0)) 8.0)
			(> (objects_distance_to_object (ai_get_object cv_unsc_echo_inf1) (player0)) 0))
	)
*;
(and
			(< (objects_distance_to_object (ai_get_object gr_unsc) (player0)) 8.0)
			(> (objects_distance_to_object (ai_get_object gr_unsc) (player0)) 0))
)

;*
(script command_script cs_cv_counter_fork0
	; initial setup
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost true)
	
	;(f_load_phantom (ai_vehicle_get ai_current_actor) "right" cov.canyonview.reinforce.1 cov.canyonview.reinforce.2 none none)
	
	; dropship entry
	(cs_fly_by pts_cv_counter_fork0/entry1)
	(cs_fly_by pts_cv_counter_fork0/entry0)
	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face pts_cv_counter_fork0/hover pts_cv_counter_fork0/land_facing 0.25)
	(sleep 30)
	
	; dropship is now hovering
	(cs_vehicle_boost false)
	(cs_vehicle_speed 0.3)
	
	(cs_fly_to_and_face pts_cv_counter_fork0/land pts_cv_counter_fork0/land_facing 0.25)
	(sleep 30)
	
	; dropship has landed
	;(f_unload_phantom (ai_vehicle_get ai_current_actor) "right")
	;(ai_place cov.canyonview.reinforce.1)
	;(ai_place cov.canyonview.reinforce.2)
	(sleep 90)
	(ai_place cv_cov_counter_chieftain)
	(ai_place cv_cov_counter_chieftain_guards)
	(set b_cv_chieftain_delivered true)
	
	; delivery is complete
	(cs_fly_to_and_face pts_cv_counter_fork0/hover  pts_cv_counter_fork0/land_facing 0.5)
	(sleep 60)
	(ai_erase ai_current_squad)
	
	;(cs_vehicle_speed 1)
	;(cs_vehicle_boost true)
	;(cs_fly_by 000_canyonview_fork/entry0)
	
	; dropship is out of sight, now erase it
	
)
*;

(script dormant brute_intro
	;(wake canyon_civilians_far)		
	;(f_ai_place_vehicle_deathless cov.canyonview.dropship.intro.1)
	
	(ai_place cv_civilians_near0)
	(ai_place cv_civilians_near1)
	(ai_place cv_civilians_near2)

	(ai_place cv_civilian0)
	(ai_place cv_civilian1)
	(ai_place cv_civilian2)	
	(ai_place cv_cov_brute_intro0)
	(ai_place cv_cov_brute_intro1)
	(ai_place cv_cov_brute_intro2)

	(thespian_performance_setup_and_begin canyonview_brute0 "" 0)
	(thespian_performance_setup_and_begin canyonview_brute1 "" 0)
	(thespian_performance_setup_and_begin canyonview_brute2	 "" 0)
	
	(ai_disregard (ai_get_object cv_civilian0) true)
	(ai_disregard (ai_get_object cv_civilian1) true)
	(ai_disregard (ai_get_object cv_civilian2) true)
	;(ai_disregard gr_cv_brute_vignette true)

	;perf
	(ai_force_low_lod cv_civilian0)
	(ai_force_low_lod cv_civilian1)
	(ai_force_low_lod cv_civilian2)	
	;(ai_force_low_lod cv_civilians_near0)
	(ai_force_low_lod cv_civilians_near1)
	(ai_force_low_lod cv_civilians_near2)

	(sleep_until (>= objcon_canyonview 10)5)
	
	(wake canyonview_longsword_cycle)
	(wake f_canyon_fx_ambient)
	(wake md_canyonview_civilian_intro)
	;(ai_cannot_die cv_unsc_echo_inf0 false)
	;(ai_cannot_die cv_unsc_echo_inf1 false)	
	(ai_cannot_die gr_unsc false)
)

(script static boolean (sleep_brute0 (ai my_actor)) 
	(or
		;(>= (ai_combat_status my_actor) 5)
		;(> (object_get_recent_shield_damage (ai_get_object my_actor)) 0)
		;(> (object_get_recent_body_damage (ai_get_object my_actor)) 0)
		(<= (ai_strength my_actor) .50)
		(volume_test_players tv_brute0_interupt)
	)
)

(script static boolean (branch_brute1 (ai my_actor)) 
	(or
		;(>= (ai_combat_status my_actor) 5)
		;(> (object_get_recent_shield_damage (ai_get_object my_actor)) 0)
		;(> (object_get_recent_body_damage (ai_get_object my_actor)) 0)
		(<= (ai_strength my_actor) .50)
		(volume_test_players tv_brute1_interupt)
	)
)

(script static boolean (branch_brute2 (ai my_actor)) 
	(or
		;(>= (ai_combat_status my_actor) 5)
		(> (object_get_recent_shield_damage (ai_get_object my_actor)) 0)
		(> (object_get_recent_body_damage (ai_get_object my_actor)) 0)
		(volume_test_players tv_brute2_interupt)
		(<= (ai_task_count obj_canyonview_cov/gate_main) 1)
	)
)

(script static void (brute_interupt (ai ai_civilian))
	(print "kill civilian")
	(ai_kill ai_civilian)
)

(script command_script cs_canyonview_brute_alert
	(sleep_until (> (ai_combat_status ai_current_actor) 3) 5)
	(ai_set_objective ai_current_actor obj_canyonview_cov)
)

(script command_script cs_canyon_civilians_escape
	(cs_enable_targeting false)
		
	(cs_go_to canyon_civilians/leap)
	;(device_closes_automatically_set dm_condo_door0 true)

	(cs_go_to canyon_civilians/escape)
	
	(ai_erase ai_current_actor)
)

(script command_script cs_canyon_civilians_escape_far
	(cs_enable_targeting false)
	(unit_set_stance (ai_get_unit ai_current_actor) "panic")
			
	(cs_go_to canyon_civilians/leap_far)
	(cs_go_to canyon_civilians/escape_far)
	
	(ai_erase ai_current_actor)
)

(script dormant canyon_civilians_far
	(ai_place cv_brutes_far0)
	(sleep_until
		(begin
			(ai_place cv_civilians_far0)

			;perf
			(ai_force_low_lod cv_civilians_far0)

			(sleep_until (f_ai_is_defeated cv_civilians_far0))
		b_cv_complete)
	)
)


;*
(script command_script cs_cv_brute_fork0
	;(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 0.5)

	;(f_load_fork (ai_vehicle_get ai_current_actor) "left" cv_cov_counter_chieftain cv_cov_counter_guards none none)
									
	(ai_place cv_cov_counter_chieftain)
	(ai_place cv_cov_counter_guards/bodyguard0)
	(ai_place cv_cov_counter_guards/bodyguard1)
	(sleep 1)
									
	(if b_debug_fork (print "load fork left..."))
	;(ai_vehicle_enter_immediate load_squad_01 fork "fork_p_l1")
	;(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l2")
	(ai_vehicle_enter_immediate cv_cov_counter_guards/bodyguard0 (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l3")
	(ai_vehicle_enter_immediate cv_cov_counter_chieftain (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l4")
	(ai_vehicle_enter_immediate cv_cov_counter_guards/bodyguard1 (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l6")
	;(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l6")
	;(ai_vehicle_enter_immediate load_squad_03 fork "fork_p_l7")
	;(ai_vehicle_enter_immediate load_squad_04 fork "fork_p_l8")					
		
	(sleep_until (volume_test_players tv_cv_brute_intro)5)	
		
	; dropship entry
	(unit_open (ai_vehicle_get ai_current_actor))
	;(cs_fly_by pts_cv_brute_fork0/entry0)
	(cs_fly_to_and_face pts_cv_brute_fork0/entry0 pts_cv_brute_fork0/entry_facing)
		(cs_fly_to_and_face pts_cv_brute_fork0/entry1 pts_cv_brute_fork0/entry1_facing)
	;(cs_custom_animation cv_cov_counter_guards/bodyguard0  true objects\characters\brute\brute "m50_tuning_fork_l3:taunt" true) 
	(sleep (* 30 2))
	(unit_close (ai_vehicle_get ai_current_actor))
	
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face pts_cv_brute_fork0/hover pts_cv_brute_fork0/land_facing 0.25)
	(sleep 10)

	; dropship is now hovering
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 0.3)
	
	(cs_fly_to_and_face pts_cv_brute_fork0/land pts_cv_brute_fork0/land_facing 0.25)
	;(sleep (* 30 1))
	
	; dropship has landed
	(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l3")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l4")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l6")
	(sleep 1)

	(ai_erase cv_cov_counter_chieftain)
	(ai_erase cv_cov_counter_guards)
	(sleep 1)

	(ai_place cv_cov_counter_chieftain)
	(ai_place cv_cov_counter_guards/bodyguard0)
	(ai_place cv_cov_counter_guards/bodyguard1)
	(sleep 1)
									
	(if b_debug_fork (print "load fork left..."))
	;(ai_vehicle_enter_immediate load_squad_01 fork "fork_p_l1")
	;(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l2")
	(ai_vehicle_enter_immediate cv_cov_counter_guards/bodyguard0 (ai_vehicle_get ai_current_actor) "fork_p_l3")
	(ai_vehicle_enter_immediate cv_cov_counter_chieftain (ai_vehicle_get ai_current_actor) "fork_p_l4")
	(ai_vehicle_enter_immediate cv_cov_counter_guards/bodyguard1 (ai_vehicle_get ai_current_actor) "fork_p_l6")
	;(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l6")
	;(ai_vehicle_enter_immediate load_squad_03 fork "fork_p_l7")
	;(ai_vehicle_enter_immediate load_squad_04 fork "fork_p_l8")			
	(sleep 1)
	
	(f_unload_fork (ai_vehicle_get ai_current_actor) "left")
	(sleep (* 30 1))
	(set b_cv_chieftain_delivered true)
	
	; delivery is complete
	(cs_fly_to_and_face pts_cv_brute_fork0/hover  pts_cv_brute_fork0/land_facing 0.5)
	(sleep 10)
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 1.0)
	(cs_fly_by pts_cv_brute_fork0/exit0)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)

)
*;

(global boolean b_brute_fork_load false)
(global boolean b_brute_taunt false)

(script dormant fork_intro
	(f_ai_place_vehicle_deathless fork_brutes)
	;(ai_place fork_brutes)
	(sleep 1)
	(ai_set_blind fork_brutes/brute4 true)
	(ai_cannot_die fork_brutes/brute3 true)
	(ai_cannot_die fork_brutes/brute2 true)
	(ai_cannot_die fork_brutes/brute1 true)



	
	;(ai_set_targeting_group fork_brutes/brute4 4 false)
;*	
	(sleep_until b_brute_fork_load)
	;(sleep (* 30 1))
	(load_brute_fork)

	(sleep_until b_brute_taunt)
	(cs_run_command_script fork_brutes/brute4 cs_cv_brute_fork2)
*;
)

(script command_script cs_cv_brute_fork1
	;(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)
		
	(sleep_until (volume_test_players tv_cv_brute_intro)5)	
		
	; dropship entry
	(set b_brute_fork_load true)
	;(load_brute_fork)
			(print "load_brute_fork")
			(unit_open (ai_vehicle_get_from_spawn_point fork_brutes/brute4))
			(unit_enter_vehicle_immediate (ai_get_unit fork_brutes/brute1) (ai_vehicle_get_from_spawn_point fork_brutes/brute4) "m50_tuning_fork_l3")
			(unit_enter_vehicle_immediate (ai_get_unit fork_brutes/brute2) (ai_vehicle_get_from_spawn_point fork_brutes/brute4) "m50_tuning_fork_l4")
			(unit_enter_vehicle_immediate (ai_get_unit fork_brutes/brute3) (ai_vehicle_get_from_spawn_point fork_brutes/brute4) "m50_tuning_fork_l6")
	
	(cs_fly_to_and_face pts_cv_brute_fork0/entry0 pts_cv_brute_fork0/entry_facing)	
	;(cs_fly_to_and_face pts_cv_brute_fork0/entry1 pts_cv_brute_fork0/entry1_facing)	
			(sleep (* 30 2.0))
			(set b_brute_taunt true)
	;(cs_run_command_script fork_brutes/brute4 cs_cv_brute_fork2)
			(sleep (* 30 2.0))
			(ai_set_targeting_group fork_brutes/brute4 4 false)
			(unit_close (ai_vehicle_get ai_current_actor))
			
			;(cs_vehicle_boost false)
			(cs_vehicle_speed 0.6)
			(cs_fly_to_and_face pts_cv_brute_fork0/hover pts_cv_brute_fork0/land_facing 0.25)
			(sleep 10)
		
			; dropship is now hovering
			;(cs_vehicle_boost false)
			(cs_vehicle_speed 0.3)
			
			(cs_fly_to_and_face pts_cv_brute_fork0/land pts_cv_brute_fork0/land_facing 0.25)
			;(sleep (* 30 1))
			
			; dropship has landed
			(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l3")
			(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l4")
			(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l6")
			(sleep 1)
		
			(ai_cannot_die fork_brutes/brute3 false)
			(ai_cannot_die fork_brutes/brute2 false)
			(ai_cannot_die fork_brutes/brute1 false)
	
			(ai_erase fork_brutes/brute1)
			(ai_erase fork_brutes/brute2)
			(ai_erase fork_brutes/brute3)
			(sleep 1)
		
			(ai_place cv_cov_counter_chieftain)
			(ai_place cv_cov_counter_guards/bodyguard0)
			(ai_place cv_cov_counter_guards/bodyguard1)
			(sleep 1)
											
			(if b_debug_fork (print "load fork left..."))
			(print " now")
			(sleep 120)
			;(ai_vehicle_enter_immediate load_squad_01 fork "fork_p_l1")
			;(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l2")
			(ai_vehicle_enter_immediate cv_cov_counter_guards/bodyguard0 (ai_vehicle_get ai_current_actor) "fork_p_l3")
			(ai_vehicle_enter_immediate cv_cov_counter_chieftain (ai_vehicle_get ai_current_actor) "fork_p_l4")
			(ai_vehicle_enter_immediate cv_cov_counter_guards/bodyguard1 (ai_vehicle_get ai_current_actor) "fork_p_l6")
			;(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l6")
			;(ai_vehicle_enter_immediate load_squad_03 fork "fork_p_l7")
			;(ai_vehicle_enter_immediate load_squad_04 fork "fork_p_l8")			
			(sleep 1)
			
			(f_unload_fork (ai_vehicle_get ai_current_actor) "left")
			(sleep (* 30 1))
			(set b_cv_chieftain_delivered true)
			
			; delivery is complete
			(cs_fly_to_and_face pts_cv_brute_fork0/hover  pts_cv_brute_fork0/land_facing 0.5)
			(sleep 10)
			;(cs_vehicle_boost false)
			(cs_vehicle_speed 1.0)
			(cs_fly_by pts_cv_brute_fork0/exit0)
		
			;scale down
			(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
			(sleep (* 30 5))
			
			;checking to see if the brutes are on top of the balcony, and if so kill them
			(if 
				(or
					(volume_test_objects tv_cv_hack (ai_actors cv_cov_counter_chieftain) )
					(volume_test_objects tv_cv_hack (ai_actors cv_cov_counter_guards) )
				)
				(begin
					(print "killing dudes")
					(ai_kill cv_cov_counter_chieftain)
					(ai_kill cv_cov_counter_guards)
				)
			)
			
			(sleep 1)			
			(ai_erase ai_current_squad)
)

(script command_script cs_cv_brute_fork2
	(sleep (* 30 2))
	(unit_close (ai_vehicle_get ai_current_actor))
	
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face pts_cv_brute_fork0/hover pts_cv_brute_fork0/land_facing 0.25)
	(sleep 10)

	; dropship is now hovering
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 0.3)
	
	(cs_fly_to_and_face pts_cv_brute_fork0/land pts_cv_brute_fork0/land_facing 0.25)
	;(sleep (* 30 1))
	
	; dropship has landed
	(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l3")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l4")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "m50_tuning_fork_l6")
	(sleep 1)

	(ai_erase fork_brutes/brute1)
	(ai_erase fork_brutes/brute2)
	(ai_erase fork_brutes/brute3)
	(sleep 1)

	(ai_place cv_cov_counter_chieftain)
	(ai_place cv_cov_counter_guards/bodyguard0)
	(ai_place cv_cov_counter_guards/bodyguard1)
	(sleep 1)
									
	(if b_debug_fork (print "load fork left..."))
	;(ai_vehicle_enter_immediate load_squad_01 fork "fork_p_l1")
	;(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l2")
	(ai_vehicle_enter_immediate cv_cov_counter_guards/bodyguard0 (ai_vehicle_get ai_current_actor) "fork_p_l3")
	(ai_vehicle_enter_immediate cv_cov_counter_chieftain (ai_vehicle_get ai_current_actor) "fork_p_l4")
	(ai_vehicle_enter_immediate cv_cov_counter_guards/bodyguard1 (ai_vehicle_get ai_current_actor) "fork_p_l6")
	;(ai_vehicle_enter_immediate load_squad_02 fork "fork_p_l6")
	;(ai_vehicle_enter_immediate load_squad_03 fork "fork_p_l7")
	;(ai_vehicle_enter_immediate load_squad_04 fork "fork_p_l8")			
	(sleep 1)
	
	(f_unload_fork (ai_vehicle_get ai_current_actor) "left")
	(sleep (* 30 1))
	(set b_cv_chieftain_delivered true)
	
	; delivery is complete
	(cs_fly_to_and_face pts_cv_brute_fork0/hover  pts_cv_brute_fork0/land_facing 0.5)
	(sleep 10)
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 1.0)
	(cs_fly_by pts_cv_brute_fork0/exit0)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)

)

(script static void load_brute_fork
	(print "load_brute_fork")
	(unit_open (ai_vehicle_get_from_spawn_point fork_brutes/brute4))
	(unit_enter_vehicle_immediate (ai_get_unit fork_brutes/brute1) (ai_vehicle_get_from_spawn_point fork_brutes/brute4) "m50_tuning_fork_l3")
	(unit_enter_vehicle_immediate (ai_get_unit fork_brutes/brute2) (ai_vehicle_get_from_spawn_point fork_brutes/brute4) "m50_tuning_fork_l4")
	(unit_enter_vehicle_immediate (ai_get_unit fork_brutes/brute3) (ai_vehicle_get_from_spawn_point fork_brutes/brute4) "m50_tuning_fork_l6")

	;(sleep (* 30 1))
	;(cs_custom_animation fork_brutes/brute1 true objects\characters\brute\brute "m50_tuning_fork_l3:taunt" true)
	(sleep (* 30 2))
	(set b_brute_taunt true)
)

(script dormant canyonview_zone_set_control
	;(device_set_power dm_interior_door1 1)
	(device_set_position_immediate dm_interior_door1 0)
	(sleep_until (= (device_get_position dm_interior_door1)0))

	(teleport_players_not_in_volume 
		tv_cv_teleport1 
		cf_teleport_cv0
		cf_teleport_cv1
		cf_teleport_cv2
		cf_teleport_cv3)
                                         
	(prepare_to_switch_to_zone_set set_atrium_040_050_060)
	;prevent hitch
	(sleep (* 30 12))
	;(sleep_until b_cv_counter_started)
	
	(switch_zone_set set_atrium_040_050_060)
	
	(object_cinematic_visibility sc_corvette1 false)	
)	


(global boolean b_canyonview_timeout false)
(script dormant canyonview_waypoint_timeout
	(sleep g_waypoint_timeout)
	(set b_canyonview_timeout true)
)

(script dormant canyonview_waypoint
	(wake canyonview_waypoint_timeout)
	(sleep_until 
		(and 
			b_canyonview_timeout
			b_cv_counter_started
			;b_cv_complete
		)
	)
;*
(script dormant canyonview_waypoint
	(sleep g_waypoint_timeout)
*;
	(if (not b_atrium_started)
		(f_blip_flag nav_canyonview_exit blip_default))
		;(chud_track_object_with_priority nav_canyonview_exit 21))
		
	(sleep_until b_atrium_started 5)
	(f_unblip_flag nav_canyonview_exit)
)

(script command_script cs_set_stance_panic
	(unit_set_stance (ai_get_unit ai_current_actor) "panic")
)

(script command_script cs_set_stance_none
	(unit_set_stance (ai_get_unit ai_current_actor) "")
)

; =================================================================================================
; atrium objective control
; =================================================================================================
(global boolean b_atrium_started false)
(global boolean b_atrium_counterattack_started false)
(global boolean b_atrium_complete false)
(global boolean b_atrium_timeout false)
(global boolean b_md_defend_complete false)
(global short g_atrium_civ_current -1)
(global short g_atrium_civ_desired 6)
(global short g_atrium_unsc_current -1)
(global short g_atrium_unsc_desired 4)
; -------------------------------------------------------------------------------------------------

(script dormant atrium_objective_control
	(if debug (print "encounter start: atrium"))
	(set b_atrium_started true)
	(game_save)
	(set objcon_atrium 0)
	
	;(ai_disposable gr_civilian_cv true)
	(ai_disposable gr_civilians_panoptical true)
	(thespian_folder_activate th_atrium)
		
	(ai_set_objective fireteam_player0 obj_atrium_unsc); fireteam player 0
	;(ai_migrate <squad> fireteam_player0); adds ai to fireteam squad
	;(ai_migrate fireteam_player0 atrium_unsc_troopers)

	; spawn
	(kill_ambient_dropships)
	
	(ai_place gr_cov_atrium_initial)
	(sleep 1)
	
	; scripts
	(wake atrium_combat_progression)
	(wake atrium_civilians)
	
	(sleep_forever ambient_wraith_shells_a)
	(sleep_forever ambient_wraith_shells_b)
	;(sleep_forever canyon_civilians_far)
	(sleep_forever f_canyon_fx_ambient)
	
	;(wake md_traxus_ai01)
	;(wake md_traxus_evac_loop)
	(wake md_traxus_ai_elevator)
	(wake md_atrium_elevator_call)
	;(wake md_atrium_counterattack)
	(wake md_atrium_hunters_arrive)
	(wake md_atrium_hunters_defeated)
	;(wake md_atrium_shut_off)
	(wake f_atrium_fx_ambient)

	(wake md_info_booth)
	(wake md_atrium_ai_response)

	(wake atrium_waypoint)
	
	; flocks	
	(flock_delete fl_interior_rats0)
	
	; objective control
	(sleep_until (volume_test_players tv_objcon_atrium_005) 1)
		(if debug (print "objective control: atrium 005"))
		(set objcon_atrium 5)	
		
	(sleep_until (volume_test_players tv_objcon_atrium_010) 1)
		(if debug (print "objective control: atrium 010"))
		(set objcon_atrium 10)	
		
	(sleep_until (volume_test_players tv_objcon_atrium_020) 1)
		(if debug (print "objective control: atrium 020"))
		(set objcon_atrium 20)	
		
	(sleep_until (volume_test_players tv_objcon_atrium_030) 1)
		(if debug (print "objective control: atrium 030"))
		(set objcon_atrium 30)	
		
	(sleep_until (volume_test_players tv_objcon_atrium_040) 1)
		(if debug (print "objective control: atrium 040"))
		(set objcon_atrium 40)	
		
	(sleep_until (volume_test_players tv_objcon_atrium_050) 1)
		(if debug (print "objective control: atrium 050"))
		(set objcon_atrium 50)	
		
	(sleep_until (volume_test_players tv_objcon_atrium_060) 1)
		(if debug (print "objective control: atrium 060"))
		(set objcon_atrium 60)	

	(sleep_until (volume_test_players tv_objcon_atrium_070) 1)
		(if debug (print "objective control: atrium 070"))
		(set objcon_atrium 70)	
		
		;(ai_erase_all)
		(garbage_collect_unsafe)
				
	(sleep_until b_ready_started)
	(if debug (print "cleaning up atrium..."))
	(ai_disposable gr_cov_atrium true)
	(ai_disposable gr_civilians_atrium true)
	(ai_disposable atrium_unsc_troopers true)
	(ai_disposable atrium_unsc_troopers1 true)
	
	(ai_erase gr_cov_atrium)
	(ai_erase gr_civilians_atrium)
	(ai_erase gr_civilian_cv)
	(ai_erase atrium_unsc_troopers)
	(ai_erase atrium_unsc_troopers1)
	
	(thespian_folder_deactivate th_atrium)
			
)

(script dormant atrium_combat_progression

;*
(set g_atrium_civ_current (ai_task_count obj_atrium_unsc/gate_civilians))
(if (< g_atrium_civ_current g_atrium_civ_desired)
	(ai_place atrium_civilians3 (- g_atrium_civ_desired g_atrium_civ_current)))		
*;

(sleep 10)

	;perf
	(if (game_is_cooperative)
			(set g_atrium_unsc_desired (- g_atrium_unsc_desired 2))
	)
	
	(set g_atrium_unsc_current (ai_task_count obj_atrium_unsc/gate_marines))
	(if (< g_atrium_unsc_current g_atrium_unsc_desired)
		(ai_place atrium_unsc_troopers (- g_atrium_unsc_desired g_atrium_unsc_current)))		

	(if (not (game_is_cooperative))
		(ai_player_add_fireteam_squad player0 atrium_unsc_troopers))
	;	(ai_migrate atrium_unsc_troopers fireteam_player0)

	(sleep_until (>= objcon_atrium 40))
	(device_set_power dm_atrium_ctyd_door2 1)

	;(sleep_until (f_ai_is_defeated gr_cov_atrium_initial))
	 (sleep_until
		 (and
				(> (device_get_position atrium_elevator_call) 0)
				;(f_ai_is_defeated gr_cov_atrium_initial)
				(<= (ai_task_count obj_atrium_cov/gate_initial) 1)
			) 
		1)

	(mus_start mus_03)
		
(set g_atrium_civ_current (ai_task_count obj_atrium_unsc/gate_civilians))
(if (< g_atrium_civ_current g_atrium_civ_desired)
	(ai_place atrium_civilians3 (- g_atrium_civ_desired g_atrium_civ_current)))		
	
(set g_atrium_unsc_current (ai_task_count obj_atrium_unsc/gate_marines))
(if (< g_atrium_unsc_current g_atrium_unsc_desired)
	(ai_place atrium_unsc_troopers1 (- g_atrium_unsc_desired g_atrium_unsc_current)))		

	(if (not (game_is_cooperative))
		(ai_player_add_fireteam_squad player0 atrium_unsc_troopers1))
	;(ai_migrate atrium_unsc_troopers1 fireteam_player0)
	
	;(sleep 1)
	;(device_set_position dm_atrium_closet0 1)
	;(device_set_position dm_atrium_closet1 1)
	
	(set b_atrium_counterattack_started true)
	(game_save)

	;(device_closes_automatically_set dm_atrium_ctyd_door1 false)
	;(device_closes_automatically_set dm_atrium_ctyd_door2 false)
			
	; send in the hunters
	(sleep (* 30 2))
	;(mus_stop_immediate mus_canyonview)
	(sleep (* 30 2))
	(game_save_no_timeout)
	;(mus_play mus_taiko)
	(sleep (* 30 2))
		
	; start randomly sending waves at the player
;*
	(begin_random
		; left dropship
		(begin
			(sleep (random_range 30 90))
			(if debug (print "sending in left dropship..."))
			(atrium_select_dropship_squad)
			(ai_place atrium_cov_ds0)		
			(sleep 1)
			;(sleep_until (> (ai_task_count obj_atrium_cov/gate_dropships) 0))
			;(sleep_until (<= (ai_task_count obj_atrium_cov/gate_dropships) 0))
			(game_save)
		)
		
		; right dropship
		(begin
			(sleep (random_range 30 90))
			(if debug (print "sending in right dropship..."))
			(atrium_select_dropship_squad)
			(ai_place atrium_cov_ds1)
			(sleep 1)
			;(sleep_until (> (ai_task_count obj_atrium_cov/gate_dropships) 0))
			;(sleep_until (<= (ai_task_count obj_atrium_cov/gate_dropships) 0))
			(game_save)
		)		
	)
*;
	(wake md_atrium_counterattack)
			; right dropship	
			(sleep (random_range 30 90))
			(if debug (print "sending in right dropship..."))
			;(atrium_select_dropship_squad)
			;(ai_place atrium_cov_ds1)
			(f_ai_place_vehicle_deathless atrium_cov_ds1)
			(sleep 1)
			;(sleep_until (> (ai_task_count obj_atrium_cov/gate_dropships) 0))
			;(sleep_until (<= (ai_task_count obj_atrium_cov/gate_dropships) 0))
			(game_save)		

	;(ai_place atrium_cov_ds2)	; place the hunter dropships
	;(ai_place atrium_cov_ds3)
	(sleep (random_range 30 90))
	(f_ai_place_vehicle_deathless atrium_cov_ds3)
	(sleep 1)
	
	; hunter check
	;(sleep_until (> (ai_living_count atrium_cov_hunters) 0))
	;(sleep_until (f_ai_is_defeated atrium_cov_hunters))
	
	;	wait until squads are out of the phantoms
	;(sleep_until (!= (f_task_is_empty obj_atrium_cov/hunters))
		(sleep_until 
			;(and
				;(<= (ai_living_count atrium_cov_ds2)4) 
				(<= (ai_living_count atrium_cov_ds3)4)
			;)
		5)
	
	(sleep (* 30 6))
	;	wait until all squads are dead
	;(sleep_until (f_task_is_empty obj_atrium_cov/gate_main))
	(sleep_until
		(and
			(<= (ai_task_count obj_atrium_cov/gate_main) 1)
			(<= (ai_task_count obj_atrium_cov/game_hammer) 0)
		)
	)
	(set b_atrium_complete true)
	(game_save)
	
	;(mus_stop mus_taiko)
	(sleep 90)
	(ai_place atrium_unsc_elevator/atrium)
	(device_set_position dm_atrium_elevator_door0 1)
	(f_blip_object atrium_elevator_switch blip_interface)

	(sleep_until (> (device_get_position atrium_elevator_switch) 0))
	(device_set_power atrium_elevator_switch 0)
	(f_unblip_object atrium_elevator_switch)
	
	;(ai_erase fireteam_player0)
	(if (not (game_is_cooperative))
		(ai_player_remove_fireteam_squad player0 fireteam_player0))
	
	;make sure players are in elevator
	(device_set_position_track atrium_elevator_platform position 0)
	(device_animate_position atrium_elevator_platform 0.12 2.00 .125 .125 false)
	
  (sleep_until (>= (device_get_position atrium_elevator_platform) .12))
	(device_set_position dm_atrium_elevator_door0 0)
 	
	(if (not (volume_test_object tv_md_traxus_elevator player0))
		(begin
			(object_teleport_to_ai_point player0 pts_elevator_teleport/p0)
		)	
	)

	(if (not (volume_test_object tv_md_traxus_elevator player1))
		(begin
			(object_teleport_to_ai_point player1 pts_elevator_teleport/p1)
		)	
	)

	(if (not (volume_test_object tv_md_traxus_elevator player2))
		(begin
			(object_teleport_to_ai_point player2 pts_elevator_teleport/p2)
		)	
	)

	(if (not (volume_test_object tv_md_traxus_elevator player3))
		(begin
			(object_teleport_to_ai_point player3 pts_elevator_teleport/p3)
		)	
	)

	(sleep 10)
	
	(mus_stop mus_03)
	
	;(device_set_position atrium_elevator_platform 1)
	(device_animate_position atrium_elevator_platform .8125 20 1 1 false)
	(wake md_ready_intro)
	
	(sleep_until (>= (device_get_position atrium_elevator_platform) .8125) 1)
	(device_set_position dm_atrium_elevator_door1 1)
	(sleep_until (>= (device_get_position dm_atrium_elevator_door1) 1) 1)
	(device_animate_position atrium_elevator_platform 1 2 .125 .125 false)	
)

;*
; -------------------------------------------------------------------------------------------------
(global ai atrium_dropship_squad0 none)
(global ai atrium_dropship_squad1 none)

(script static void atrium_select_dropship_squad
	(cond
		; -------------------------------------------------------------------------------------------------
		; condition #1, neither squad has spawned
		(
			(and 
				(<= (ai_spawn_count gr_cov_atrium_concussion) 0) 
				(<= (ai_spawn_count gr_cov_atrium_rangers) 0) 
			)

			; choose one of the squads to be loaded into the phantom
			(begin
				(if (< (random_range 0 100) 50)
					; concussion squad chosen
					(begin
						(set atrium_dropship_squad0 atrium_cov_concussion_inf0)
						(set atrium_dropship_squad1 none)
					)
					; rangers chosen
					(begin
						(set atrium_dropship_squad0 atrium_cov_rangers_inf0)
						;(set atrium_dropship_squad1 atrium_cov_rangers_inf1)
						(set atrium_dropship_squad1 none)
					)
				)
			)
		)
		
		; -------------------------------------------------------------------------------------------------
		; condition #2, concussion squad has spawned but rangers have not
		(
			(and
				(> (ai_spawn_count gr_cov_atrium_concussion) 0) 
				(<= (ai_spawn_count gr_cov_atrium_rangers) 0) 		
			)
			
			(begin
				(begin
					(set atrium_dropship_squad0 atrium_cov_rangers_inf0)
					;(set atrium_dropship_squad1 atrium_cov_rangers_inf1)
					(set atrium_dropship_squad1 none)
				)
			)
		)
		
		; -------------------------------------------------------------------------------------------------
		; condition #3, rangers have spawned but concussion squad has not
		(
			(and
				(<= (ai_spawn_count gr_cov_atrium_concussion) 0) 
				(> (ai_spawn_count gr_cov_atrium_rangers) 0) 		
			)
			
			(begin
				(begin
					(set atrium_dropship_squad0 atrium_cov_concussion_inf0)
						(set atrium_dropship_squad1 none)
				)
			)
		)		
	)
)
*;
;*
(script command_script cs_atrium_ds0_deliver
;*	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))

	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost false)
	
	;(f_load_fork (ai_vehicle_get ai_current_actor)	"left" atrium_dropship_squad0 atrium_dropship_squad1 none none)
	(f_load_phantom (ai_vehicle_get ai_current_actor) "left" atrium_dropship_squad0 atrium_dropship_squad1 none none)
	(cs_fly_by pts_atrium_dropship0/entry0)
	(cs_vehicle_speed 0.4)
	(cs_fly_to pts_atrium_dropship0/hover)
	(sleep 30)
	(cs_vehicle_speed 0.3)
	(cs_fly_to_and_face pts_atrium_dropship0/land pts_atrium_dropship0/land_facing 0.5)
	(sleep 60)
	;(f_unload_fork (ai_vehicle_get ai_current_actor) "left")
	(f_unload_phantom (ai_vehicle_get ai_current_actor) "left")
	(cs_fly_to_and_face pts_atrium_dropship0/hover pts_atrium_dropship0/land_facing)
	(sleep 60)
	(cs_fly_to pts_atrium_dropship0/exit0 5)
	
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(ai_erase ai_current_squad)
)
*;

(script command_script cs_atrium_ds1_deliver
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))

	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)
	;(cs_vehicle_boost false)	
	
	;(f_load_fork (ai_vehicle_get ai_current_actor)	"right" atrium_dropship_squad0 atrium_dropship_squad1 none none)
	;(f_load_phantom (ai_vehicle_get ai_current_actor) "right" atrium_dropship_squad0 atrium_dropship_squad1 none none)
	;(f_load_phantom (ai_vehicle_get ai_current_actor) "right" atrium_cov_concussion_inf0 atrium_cov_rangers_inf0 none none)
	;(f_load_phantom (ai_vehicle_get ai_current_actor) "right" atrium_cov_captain1 atrium_cov_rangers_inf0 none none)
	;(f_load_phantom (ai_vehicle_get ai_current_actor) "right" atrium_cov_captain1 atrium_cov_counter_inf2 atrium_cov_counter_inf3 none)

	; place ai 
	(ai_place atrium_cov_captain1)
	(ai_place atrium_cov_counter_inf2)
	(ai_place atrium_cov_counter_inf3)
		(sleep 1)
						
	(if b_debug_phantom (print "load phantom right..."))
	(ai_vehicle_enter_immediate atrium_cov_counter_inf3 (ai_vehicle_get ai_current_actor) "phantom_p_rb")
	(ai_vehicle_enter_immediate atrium_cov_counter_inf2 (ai_vehicle_get ai_current_actor) "phantom_p_rf")
	(ai_vehicle_enter_immediate atrium_cov_captain1 (ai_vehicle_get ai_current_actor) "phantom_p_mr_b")
	;(ai_vehicle_enter_immediate load_squad_04 phantom "phantom_p_mr_b")
	
	(cs_fly_by pts_atrium_dropship1/entry0)
	(cs_vehicle_speed 0.8)
	(cs_fly_to pts_atrium_dropship1/hover)
	;(sleep 30)
	(cs_vehicle_speed 0.4)
	;(cs_fly_to_and_face pts_atrium_dropship1/land0 pts_atrium_dropship1/land0_facing 0.5)
	(cs_fly_to_and_face pts_atrium_dropship1/land pts_atrium_dropship1/land_facing 0.25)
	(sleep 60)
	
	;(f_unload_fork (ai_vehicle_get ai_current_actor) "right")
	;(f_unload_phantom (ai_vehicle_get ai_current_actor) "right")

	(unit_open (ai_vehicle_get ai_current_actor))
	(sleep 60)
	(f_unload_ph_right (ai_vehicle_get ai_current_actor))
	(sleep 75)
	(unit_close (ai_vehicle_get ai_current_actor))

	(sleep (* 30 8))

	(unit_open (ai_vehicle_get ai_current_actor))
	(sleep 60)
	(f_unload_ph_mid_right (ai_vehicle_get ai_current_actor))
	(sleep 75)
	(unit_close (ai_vehicle_get ai_current_actor))
	
	(cs_fly_to_and_face pts_atrium_dropship1/hover pts_atrium_dropship1/land_facing)
	(sleep 60)
	;(cs_fly_to pts_atrium_dropship1/entry0)
	(cs_fly_to pts_atrium_dropship1/exit0)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

;*
(script command_script cs_atrium_ds2_deliver
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)
	;(cs_vehicle_boost false)	
	
	(f_load_phantom (ai_vehicle_get ai_current_actor)	"left" atrium_cov_hunter0 none none none)
	
	(cs_fly_by pts_atrium_dropship2/entry0)
	(cs_vehicle_speed 0.4)
	(cs_fly_to pts_atrium_dropship2/hover)
	(sleep 30)
	(cs_vehicle_speed 0.3)
	(cs_fly_to_and_face pts_atrium_dropship2/land pts_atrium_dropship2/land_facing 0.5)
	(sleep 60)
	
	;(ai_place atrium_cov_hunters/hunter0)
	(f_unload_phantom (ai_vehicle_get ai_current_actor) "left")
	
	(cs_fly_to_and_face pts_atrium_dropship2/hover pts_atrium_dropship2/land_facing)
	(sleep 60)
	(cs_fly_to pts_atrium_dropship2/entry0)
	(cs_fly_to pts_atrium_dropship2/exit0)
	
	(ai_erase ai_current_squad)
)
*;

(script command_script cs_atrium_ds3_deliver
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))

	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)
	;(cs_vehicle_boost false)	
	
	;(f_load_phantom (ai_vehicle_get ai_current_actor)	"left" atrium_cov_hunter0 atrium_cov_hunter1 atrium_cov_counter_inf0 none)
	;(f_load_phantom (ai_vehicle_get ai_current_actor)	"left" atrium_cov_captain0 atrium_cov_captain1 atrium_cov_counter_inf0 none)
	(f_load_phantom (ai_vehicle_get ai_current_actor)	"left" atrium_cov_captain0 atrium_cov_counter_inf0 atrium_cov_counter_inf1 none)
		
	(cs_fly_by pts_atrium_dropship4/entry0)
	(cs_vehicle_speed 0.9)
	(cs_fly_to pts_atrium_dropship4/hover)
	(sleep 30)
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face pts_atrium_dropship4/land pts_atrium_dropship4/land_facing 0.5)
	(sleep 60)
	
	;(ai_place atrium_cov_hunters/hunter1)
	(f_unload_phantom (ai_vehicle_get ai_current_actor) "left")
	
	(cs_fly_to_and_face pts_atrium_dropship4/hover pts_atrium_dropship4/land_facing)
	(sleep 60)
	;(cs_fly_to pts_atrium_dropship4/entry0)
	(cs_fly_to pts_atrium_dropship4/exit0)
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

(script dormant atrium_civilians
	(ai_place atrium_civilians0)
	(ai_place atrium_civilians1)
	;(ai_place atrium_civilians2)
	;(ai_place atrim_unsc_turret0)
	(sleep 1)
	;carryover canyon civilians?
	(ai_set_objective gr_civilian_cv obj_atrium_unsc)
	;(ai_set_objective gr_civilian_cv obj_atrium_unsc)
	
	;perf
	(ai_force_low_lod gr_civilian)
	
	;perf
	(sleep_until (>= objcon_atrium 40))
	(ai_place atrium_civilians2)
	(ai_force_low_lod gr_civilian)

	(sleep_until b_atrium_complete)
	(ai_force_full_lod gr_civilian)
)

(script command_script cs_elevator_hack
	(cs_go_to elevator_hack/p0)
)

(script dormant atrium_waypoint_timeout
	(sleep g_waypoint_timeout)
	(set b_atrium_timeout true)
)


(script dormant atrium_waypoint
	(wake atrium_waypoint_timeout)
	(sleep_until 
		(or 
			b_atrium_timeout
			(volume_test_players tv_objcon_atrium_060)
			(<= (ai_task_count obj_atrium_cov/gate_initial) 1)
		)
	)

;*
(script dormant atrium_waypoint
	(sleep g_waypoint_timeout)
*;
	(if (not b_ready_started)
		(f_blip_object atrium_elevator_call blip_interface))
		
	(sleep_until (or
								(>= (device_get_position atrium_elevator_call) 1)
								b_atrium_counterattack_started) 5)

	(f_unblip_object atrium_elevator_call)
	;(sleep g_waypoint_timeout)
	(sleep_until b_md_defend_complete)
	(f_blip_flag nav_atrium_10 blip_defend)
	
	(sleep_until b_atrium_complete 5)
	(f_unblip_flag nav_atrium_10)
)


(script command_script cs_atrium_hunter0_enter
	;(cs_enable_targeting false)
	(cs_abort_on_alert true)
	(cs_abort_on_damage true)
	
	(cs_go_to pts_atrium_hunters/hunter0_p0)
	(cs_go_to pts_atrium_hunters/hunter0_p1)
)

(script command_script cs_atrium_hunter1_enter
	;(cs_enable_targeting false)
	(cs_abort_on_alert true)
	(cs_abort_on_damage true)
	
	(cs_go_to pts_atrium_hunters/hunter1_p0)
	(cs_go_to pts_atrium_hunters/hunter1_p1)
)

(script command_script cs_atrium_machinegun1
	(ai_vehicle_enter ai_current_actor ve_atrium_machinegun1)
)

; -------------------------------------------------------------------------------------------------
; jetpack ready room and intro
; -------------------------------------------------------------------------------------------------
(global boolean b_ready_started false)
(global boolean b_ready_complete false)
(global boolean b_ready_player_has_jetpack false)
; -------------------------------------------------------------------------------------------------
(script dormant ready_objective_control
	(if debug (print "encounter start: ready room"))
	(set b_ready_started true)
	;(game_save)
	(set objcon_ready 0)
	
			;place ai
			(ai_place rr_unsc_inf0)
			(sleep 1)
			(ai_set_targeting_group rr_unsc_inf0 1 true);troopers shooting at banshees
			(ai_place rr_unsc_medic0)			
			(ai_place rr_civilians0)
			(sleep 1)
			(thespian_performance_setup_and_begin ready_injured "" 0)

	(game_insertion_point_unlock 1)

	;(mus_play mus_jetpack)	
	(sleep_longswords) 
	(sleep_forever panoptical_longsword_cycle)
	(sleep_forever towers_longsword_cycle)
	(sleep_forever md_traxus_evac_loop)
	(sleep_forever f_atrium_fx_ambient)
	(sleep_forever md_info_booth)
	
	;temp memory cleanup
	;(kill_ambient_dropships)
	(garbage_collect_now)
	
	; wake subsequent scripts
	(wake ct_title_act2)
	(wake ready_fork0_main)
	(wake jl_suit_up_sequence)
	(wake th_ready_point) ;moved to thespian
	(wake ready_waypoint)
	(wake remove_ready_triage)
	(wake migrate_elevator)
	
	(wake f_jetpack_fx_ambient)
	(wake jetpack_longsword_cycle)
	(m50_terminals); place story objects
	
	;(game_save_no_timeout)
	
	; objective control
	(sleep_until (volume_test_players tv_objcon_ready_010) 1)
		(if debug (print "objective control: ready 010"))
		(set objcon_ready 10)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_ready_020) 1)
		(if debug (print "objective control: ready 020"))
		(set objcon_ready 20)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_ready_030) 1)
		(if debug (print "objective control: ready 030"))
		(set objcon_ready 30)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_ready_040) 1)
		(if debug (print "objective control: ready 040"))
		(set objcon_ready 40)
		(game_save)

	;(soft_ceiling_enable low_jetpack_blocker 1)

	(sleep_until (volume_test_players tv_objcon_ready_050) 1)
		(if debug (print "objective control: ready 050"))
		(set objcon_ready 50)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_ready_060) 1)
		(if debug (print "objective control: ready 060"))
		(set objcon_ready 60)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_ready_070) 1)
		(if debug (print "objective control: ready 070"))
		(set objcon_ready 70)
		;(game_save)

	(sleep_until (volume_test_players tv_objcon_ready_080) 1)
		(if debug (print "objective control: ready 080"))
		(set objcon_ready 80)
		(game_save)
		(thespian_performance_kill_by_name ready_odsts_breach)
			
	(wake md_jp_flourish)		
				
	(sleep_until (volume_test_players tv_objcon_ready_090) 1)
		(if debug (print "objective control: ready 090"))
		(set objcon_ready 90)
		(game_save)
		
		
	(sleep_until b_jetpack_low_started)
	(if debug (print "cleaning up ready room..."))
	
	(object_destroy sc_ready_civilian_fm1)
	(object_destroy sc_ready_civilian_fm2)
	(object_destroy sc_ready_civilian_fm3)
	(object_destroy sc_ready_civilian_m1)
	(object_destroy sc_ready_civilian_m2)
	(object_destroy sc_ready_civilian_m3)

	
)
   
(script dormant migrate_elevator
	(sleep_until (>= (device_get_position dm_atrium_elevator_door1) 1) 1)

	(ai_set_objective atrium_unsc_elevator obj_readyroom_unsc)
	(ai_set_objective gr_civilian obj_readyroom_unsc)	
)
  
(script dormant th_ready_point
	(sleep_until (>= objcon_ready 10) 1)
	
	(vs_cast rr_unsc_medic0 false 10 "m50_0570")
	(set trooper4 (vs_role 1))
	(thespian_performance_setup_and_begin ready_point "" 0)
)
    
(script dormant jl_suit_up_sequence
	(if debug (print "starting odst suit up vignette..."))
	
	(sleep_until (>= objcon_ready 20) 1)
	(ai_place unsc_jl_doorman)
	
	(ai_place unsc_jl_odsts/ready0)
	(ai_place unsc_jl_odsts/ready1)

	;perf
	(if (not (game_is_cooperative))	
		(begin
			(ai_place unsc_jl_odsts1/ready0)
			(ai_place unsc_jl_odsts1/ready1)
		)
	)

	;(wake jl_odst_renew)
	
	(sleep_until (>= objcon_ready 50) 1)
	(wake md_ready_odst_intro)

	(sleep_until (>= objcon_ready 60) 1)	 
	(thespian_performance_setup_and_begin ready_odsts_suit_up "" 0)
	(wake md_ready_odst_intro2)

	(wake ready_blip_jetpacks)

	(sleep_until (ready_player_has_jetpack) 1)
		
	; coop jetpack profile
	(if (game_is_cooperative)
		(player_set_profile profile_jetpack)
;*
		(begin		
			(player_set_profile profile_jetpack player0)
			(player_set_profile profile_jetpack player1)
			(player_set_profile profile_jetpack player2)
			(player_set_profile profile_jetpack player3)
		)
*;
	)
	(wake md_ready_player_get_jetpack)
	
	(if debug (print "starting odst breach vignette..."))
	(thespian_performance_kill_by_name ready_odsts_suit_up)
	(thespian_performance_setup_and_begin ready_odsts_breach "" 0)

	(ai_set_objective unsc_jl_odsts obj_readyroom_unsc)

	;(ai_set_targeting_group unsc_jl_odsts 1 false)
	;(ai_set_targeting_group unsc_jl_odsts1 1 false)
	(ai_set_targeting_group gr_unsc_odst 1 true)
	
	;(wake md_jp_doors_open) ;moved to thespian odsts_breach
	
	(sleep_until (>= objcon_ready 70) 1)
	(thespian_performance_setup_and_begin ready_odsts_wave "" 0)

	
	(sleep_until (>= objcon_ready 90) 1)
;*
	(ai_set_objective unsc_jl_odsts obj_jetpack_low_unsc)
	(ai_set_objective unsc_jl_odsts1 obj_jetpack_low_unsc)		
	(ai_set_targeting_group unsc_jl_odsts -1 false)
	(ai_set_targeting_group unsc_jl_odsts1 -1 false)
*;

	(ai_set_objective gr_unsc_odst obj_jetpack_low_unsc)		
	(ai_set_targeting_group gr_unsc_odst -1 true)
)

(script command_script cs_jl_odsts_wave
	;(sleep_until (volume_test_players tv_jl_odsts_start) 1)
	(if debug (print "waving!"))
	;(cs_custom_animation_loop objects\characters\marine\marine "combat:rifle:wave" true)
	;(sleep (unit_get_custom_animation_time (ai_get_unit ai_current_actor)))
	;(cs_stop_custom_animation)
	;(cs_action_at_player ai_action_signal_move)
)
        

(script dormant ready_blip_jetpacks
	;(f_blip_object jetpack_rack0 blip_recover)
	;(f_blip_object jetpack_rack1 blip_recover)
	;(chud_track_object_with_priority jetpack_rack0 21)
	;(chud_track_object_with_priority jetpack_rack1 21)	
	(f_blip_object_offset jetpack_rack0 21 1);2 ordinance
	(f_blip_object_offset jetpack_rack1 21 1);2 ordinance
		
	(sleep_until (ready_player_has_jetpack))
	;(game_save_no_timeout)
	(f_unblip_object jetpack_rack0)
	(f_unblip_object jetpack_rack1)
	

	(if (not (difficulty_is_legendary))
		(begin
				
			(if (>= (game_coop_player_count) 4)
				(wake ct_training_ui_jetpack3))
			
			(if (>= (game_coop_player_count) 3)
				(wake ct_training_ui_jetpack2))
			
			(if (>= (game_coop_player_count) 2)
				(wake ct_training_ui_jetpack1))
				
			(if (>= (game_coop_player_count) 1)
				(wake ct_training_ui_jetpack0))
		)
	)			
)


(script dormant ready_spawn_odsts
	(sleep_until (>= objcon_ready 80) 1)
)

(script dormant ready_fork0_main
	(sleep_until (>= objcon_ready 20) 1)

;*
	(f_ai_place_vehicle_deathless rr_cov_fork0)
	(sleep 1)
	(ai_set_targeting_group rr_cov_fork0 1 false)
*;
	(ai_place rr_cov_banshee01)
	(ai_place rr_cov_banshee02)
	(ai_place rr_cov_banshee03)
	(sleep 1)
	(ai_set_targeting_group rr_cov_banshee01 1 true)
	(ai_set_targeting_group rr_cov_banshee02 1 true)
	(ai_set_targeting_group rr_cov_banshee03 1 true)

	(sleep_until 
		(and
			(<= (ai_living_count rr_cov_banshee01) 0)
			(<= (ai_living_count rr_cov_banshee02) 0)
			(<= (ai_living_count rr_cov_banshee03) 0)
			(sleep_until (>= objcon_ready 50) 1)))
			
	(ai_place rr_cov_banshee01)
	(ai_place rr_cov_banshee02)
	(ai_place rr_cov_banshee03)
	(sleep 1)
	(ai_set_targeting_group rr_cov_banshee01 1 true)
	(ai_set_targeting_group rr_cov_banshee02 1 true)
	(ai_set_targeting_group rr_cov_banshee03 1 true)
;*	
	(sleep_until 
		(and
			(<= (ai_living_count rr_cov_banshee01) 0)
			(<= (ai_living_count rr_cov_banshee02) 0)
			(<= (ai_living_count rr_cov_banshee03) 0)
			(sleep_until (>= objcon_ready 80) 1)))
			
	(ai_place rr_cov_banshee01)
	(ai_place rr_cov_banshee02)
	(ai_place rr_cov_banshee03)
	(sleep 1)
	(ai_set_targeting_group rr_cov_banshee01 1 true)
	(ai_set_targeting_group rr_cov_banshee02 1 true)
	(ai_set_targeting_group rr_cov_banshee03 1 true)
*;
)

(script command_script cs_rr_fork0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_attach_to_spline "spline_rr_flyby0")
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .6)

	(cs_fly_by pts_rr_fork0/flyby)
	(cs_fly_by pts_rr_fork0/flyby0)
	(cs_vehicle_speed .4)
;*
	(cs_fly_by pts_rr_fork0/flyby1)
	(cs_fly_by pts_rr_fork0/flyby2)
*;
	(cs_fly_by pts_rr_fork0/flyby3)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))	
	(ai_erase ai_current_squad)
)

(script command_script cs_rr_banshee01
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_rr_banshees/enter_01 10)
	(cs_fly_by pts_rr_banshees/approach_01 10)
	(cs_vehicle_boost false)
	(cs_fly_by pts_rr_banshees/dive_01)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_rr_banshees/turn_01)
	(cs_vehicle_boost true)
	(cs_fly_by pts_rr_banshees/exit_01)
	(cs_fly_by pts_rr_banshees/remove_01)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
)

(script command_script cs_rr_banshee02
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_rr_banshees/enter_02 10)
	(cs_fly_by pts_rr_banshees/approach_02 10)
	(cs_vehicle_boost false)
	(cs_fly_by pts_rr_banshees/dive_02)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_rr_banshees/turn_02)
	(cs_vehicle_boost true)
	(cs_fly_by pts_rr_banshees/exit_02)
	
	(if
		(and
			(>= (ai_living_count rr_cov_banshee01) 0)
			(>= (ai_living_count rr_cov_banshee02) 0)
			(>= (ai_living_count rr_cov_banshee03) 0)
			(>= objcon_ready 50))
			
		(begin
			(cs_vehicle_boost false)
			(cs_fly_by pts_rr_banshees/split_02 10)
			(cs_fly_by pts_rr_banshees/approach_02 10)
			(cs_fly_by pts_rr_banshees/dive_02)
			(cs_vehicle_speed .9)    
			(cs_fly_by pts_rr_banshees/turn_02)
			(cs_vehicle_boost true)
			(cs_fly_by pts_rr_banshees/exit_02)
		)
	)

	
	(cs_fly_by pts_rr_banshees/remove_02)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
)


(script command_script cs_rr_banshee03
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_rr_banshees/enter_03 10)
	(cs_fly_by pts_rr_banshees/approach_03 10)
	(cs_vehicle_boost false)
	(cs_fly_by pts_rr_banshees/dive_03)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_rr_banshees/turn_03)
	(cs_vehicle_boost true)
	(cs_fly_by pts_rr_banshees/exit_03)

	(if
		(and
			(>= (ai_living_count rr_cov_banshee01) 0)
			(>= (ai_living_count rr_cov_banshee02) 0)
			(>= (ai_living_count rr_cov_banshee03) 0)
			(>= objcon_ready 50))
			
		(begin
			(cs_vehicle_boost false)
			(cs_fly_by pts_rr_banshees/split_03 10)
			(cs_fly_by pts_rr_banshees/approach_03 10)
			(cs_fly_by pts_rr_banshees/dive_03)
			(cs_vehicle_speed .9)    
			(cs_fly_by pts_rr_banshees/turn_03)
			(cs_vehicle_boost true)
			(cs_fly_by pts_rr_banshees/exit_03)
		)
	)

	(cs_fly_by pts_rr_banshees/remove_03)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
)

(script static boolean ready_player_has_jetpack
	(or
		(unit_has_equipment (player0) objects\equipment\jet_pack\jet_pack.equipment)
		(unit_has_equipment (player1) objects\equipment\jet_pack\jet_pack.equipment)
		(unit_has_equipment (player2) objects\equipment\jet_pack\jet_pack.equipment)
		(unit_has_equipment (player3) objects\equipment\jet_pack\jet_pack.equipment))
)

;this will break coop
(script dormant unblip_jetpacks	
;*
	(if (>= (game_coop_player_count) 4)
		(sleep_until
			(and
				(unit_has_equipment (player1) objects\equipment\jet_pack\jet_pack.equipment)
				(unit_has_equipment (player2) objects\equipment\jet_pack\jet_pack.equipment)
				(unit_has_equipment (player3) objects\equipment\jet_pack\jet_pack.equipment)) 1))
	
	(if (>= (game_coop_player_count) 3)
		(sleep_until
			(and
				(unit_has_equipment (player1) objects\equipment\jet_pack\jet_pack.equipment)
				(unit_has_equipment (player2) objects\equipment\jet_pack\jet_pack.equipment)) 1))
	
	(if (>= (game_coop_player_count) 2)
		(sleep_until
				(unit_has_equipment (player1) objects\equipment\jet_pack\jet_pack.equipment) 1))

	(sleep_until
		(unit_has_equipment (player0) objects\equipment\jet_pack\jet_pack.equipment) 1)
*;	
	(f_unblip_object jetpack_rack0)
	(f_unblip_object jetpack_rack1)
)
				
(script dormant remove_ready_triage
 (sleep_until b_jetpack_low_started)
 
 (soft_ceiling_enable low_jetpack_blocker 1) 
 
 (ai_set_objective unsc_jl_doorman obj_readyroom_unsc)
 
 (ai_disposable rr_civilians0 true)
 (ai_disposable rr_unsc_inf0 true)
 (ai_disposable atrium_unsc_elevator true)
 (ai_disposable unsc_jl_doorman true)
 (ai_disposable rr_unsc_medic0 true)
  
 (sleep_until  
	 (and
			(volume_test_object tv_ready_triage (ai_get_object rr_unsc_inf0))
			;(volume_test_object tv_ready_triage (ai_get_object unsc_jl_doorman))
			(!= (volume_test_players tv_ready_triage) true)
			(= (device_get_position dm_ready_door0) 0))) 

	;(device_operates_automatically_set dm_ready_door0 false)
	(device_one_sided_set dm_ready_door0 true)

 (ai_erase rr_civilians0)
 (ai_erase rr_unsc_inf0)
 (ai_erase atrium_unsc_elevator)
 ;(ai_erase unsc_jl_doorman)
 (ai_erase rr_unsc_medic0)
)

(script command_script cs_remove_ready_triage
	(cs_go_to pts_ready_remove/p0)
	(sleep_until 
		;(and
			;(volume_test_object tv_ready_triage (ai_get_object ai_current_actor))
			;(!= (volume_test_players tv_ready_triage) true)
			(= (device_get_position dm_ready_door0) 1)
		;)
	)

	(ai_erase ai_current_actor)
)

(script dormant jl_odst_renew		
	(sleep_until
		(begin
			(ai_renew unsc_jl_odsts)
			(ai_renew unsc_jl_odsts1)
		false)
	(* 30 10))
)

(script dormant ready_waypoint
	(sleep g_waypoint_timeout)
	(if (not b_jetpack_low_started)
		(f_blip_flag nav_ready_10 blip_default))
		;(chud_track_object_with_priority nav_ready_10 21))
			
	(sleep_until (>= objcon_ready 60) 5)
	(f_unblip_flag nav_ready_10)
)

(script static void m50_terminals
			(if (or (difficulty_is_normal)(difficulty_is_heroic)(difficulty_is_legendary))
				(object_create terminal_m50)
			)
			
			(if (difficulty_is_legendary)
				(object_create terminal_m50_15)
			)	
)

;(global boolean g_balcony_brute false)

; -------------------------------------------------------------------------------------------------
; jetpack low objective control
; -------------------------------------------------------------------------------------------------
(global boolean b_jetpack_low_started false)
(global boolean b_jetpack_low_complete false)
(global boolean b_jetpack_low_assault_start false)
(global boolean b_jetpack_complete		false)
(global short g_ready_odst_current -1)
(global short g_ready_odst_desired 4)
; -------------------------------------------------------------------------------------------------
(script dormant jetpack_low_objective_control
	(if debug (print "encounter start: jetpack low"))
	(set b_jetpack_low_started true)
	(game_save_no_timeout)
	;(set objcon_jetpack_low 0)
	(set objcon_jetpack_low 50)

	; scripts
	(wake jetpack_spawn_control)
	;(wake md_jp_player_crosses)
	(wake jetpack_elevator_marker)
	(wake jetpack_low_waypoint)
	(wake jetpack_low_music_control)
	
	; objective control
;*	(sleep_until (volume_test_players tv_objcon_jetpack_low_010) 1)
		(if debug (print "objective control: jetpack 010"))
		(set objcon_jetpack_low 10)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_020) 1)
		(if debug (print "objective control: jetpack 020"))
		(set objcon_jetpack_low 20)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_030) 1)
		(if debug (print "objective control: jetpack 030"))
		(set objcon_jetpack_low 30)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_040) 1)
		(if debug (print "objective control: jetpack 040"))
		(set objcon_jetpack_low 40)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_050) 1)
		(if debug (print "objective control: jetpack 050"))
		(set objcon_jetpack_low 50)
		(game_save)
*;		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_060) 1)
		(if debug (print "objective control: jetpack 060"))
		(set objcon_jetpack_low 60)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_070) 1)
		(if debug (print "objective control: jetpack 070"))
		(set objcon_jetpack_low 70)
		(game_save)
		
	(mus_stop mus_09); from ready insertion
	(mus_start mus_04)
	
			
	(sleep_until (volume_test_players tv_objcon_jetpack_low_080) 1)
		(if debug (print "objective control: jetpack 080"))
		(set objcon_jetpack_low 80)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_090) 1)
		(if debug (print "objective control: jetpack 090"))
		(set objcon_jetpack_low 90)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_100) 1)
		(if debug (print "objective control: jetpack 100"))
		(set objcon_jetpack_low 100)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_110) 1)
		(if debug (print "objective control: jetpack 110"))
		(set objcon_jetpack_low 110)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_120) 1)
		(if debug (print "objective control: jetpack 120"))
		(set objcon_jetpack_low 120)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_130) 1)
		(if debug (print "objective control: jetpack 130"))
		(set objcon_jetpack_low 130)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_140) 1)
		(if debug (print "objective control: jetpack 140"))
		(set objcon_jetpack_low 140)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_150) 1)
		(if debug (print "objective control: jetpack 150"))
		(set objcon_jetpack_low 150)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_160) 1)
		(if debug (print "objective control: jetpack 160"))
		(set objcon_jetpack_low 160)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_low_170) 1)
		(if debug (print "objective control: jetpack 170"))
		(set objcon_jetpack_low 170)
		(game_save)
		
	(sleep_until b_jetpack_high_started)
	(if debug (print "cleaning up jetpack low..."))
	(ai_disposable gr_cov_jl true)
	;carry over lobby unsc
	(ai_set_objective jl_unsc_inf1c obj_jetpack_high_unsc)
)


(script dormant jetpack_spawn_control
	(ai_place gr_cov_jl_initial)
	
	;perf
	;*
	(if (not (game_is_cooperative))
		(ai_place jl_unsc_inf0)
	)
	*;
	
	(sleep 1)
	;(ai_cannot_die jl_unsc_inf0 true)
	;(ai_cannot_die unsc_jl_odsts true)
	;(f_blip_ai_forever jetpack_low_odsts)
	
	(sleep_until (>= objcon_jetpack_low 110))	
	(ai_place gr_cov_jl_a)

	;perf	
	(if (game_is_cooperative)
		(set g_ready_odst_desired (- g_ready_odst_desired 2))
	)
	
	(set g_ready_odst_current (ai_task_count obj_jetpack_low_unsc/gate_odsts))
	(if (< g_ready_odst_current g_ready_odst_desired)
		(ai_place jl_odst_inf0 (- g_ready_odst_desired g_ready_odst_current)))		

	(if (not (game_is_cooperative))
		(ai_player_add_fireteam_squad player0 jl_odst_inf0))
	;(ai_migrate jl_odst_inf0 fireteam_player0)	
;*
	(device_set_position dm_jl_door0 1)
	(device_operates_automatically_set dm_jl_door0 true)
	(device_set_position dm_jl_door1 1)
	(device_operates_automatically_set dm_jl_door1 true)
	;(device_set_position dm_jl_door2 1)
	;(device_operates_automatically_set dm_jl_door2 true)
*;		
	(sleep_until (>= objcon_jetpack_low 140))
	(ai_place gr_unsc_jl_lobby)
	;(ai_place jl_cov_lobby_inf0)
	(ai_cannot_die gr_unsc_jl_lobby true)
	;(ai_cannot_die jl_cov_lobby_inf0 true)
	
	(sleep_until b_jetpack_high_started)
	(ai_cannot_die gr_unsc_jl_lobby false)
	;(ai_cannot_die jl_cov_lobby_inf0 false)
	
	(ai_disposable unsc_jl_odsts true)
	(ai_disposable gr_unsc_jl true)
)


(script dormant jetpack_elevator_marker
	(sleep_until (>= objcon_jetpack_low 160))
	
	(md_jp_take_elevator)
	(mus_stop mus_04)
)

(script dormant jetpack_low_waypoint
	(sleep g_waypoint_timeout)
	(if (not b_jetpack_high_started)
		(f_blip_flag nav_jetpack_low_10 blip_default))
		;(chud_track_object_with_priority nav_jetpack_low_10 21))
		
	(sleep_until (>= objcon_jetpack_low 150) 5)
	(f_unblip_flag nav_jetpack_low_10)
	
	(f_blip_flag nav_jetpack_low_exit blip_default)
	;(chud_track_object_with_priority nav_jetpack_low_exit 21)
		
	(sleep_until b_jetpack_high_started 5)
	(f_unblip_flag nav_jetpack_low_exit)
)

(script dormant jetpack_low_music_control
	(sleep_until
		(or 
			(<= (ai_task_count obj_jetpack_low_cov/gate_crane) 2) 
			(>= objcon_jetpack_low 100)
		)
	)
	
	(mus_alt mus_04)

	(sleep_until
			(>= objcon_jetpack_low 120)
	)	
	
	(mus_start mus_05)
)

; encounter control
; -------------------------------------------------------------------------------------------------
(script command_script cs_jl_a_b0_helper
	(if debug (print "helping the odsts across the chasm"))
	(cs_enable_pathfinding_failsafe true)
	(cs_go_to pts_jetpack_infantry/jl_a_b0_helper_start)
	(sleep 90)
	(cs_go_to pts_jetpack_infantry/jl_a_b0_helper_dest)
)


; -------------------------------------------------------------------------------------------------
; jetpack high
; -------------------------------------------------------------------------------------------------
(global boolean b_jetpack_high_started false)
(global boolean b_jetpack_high_complete false)
(global short g_jh_civ_current -1)
(global short g_jh_civ_desired 6)
(global short g_jh_odst_current -1)
(global short g_jh_odst_desired 2)
(global boolean b_place_jh_hill false)
; -------------------------------------------------------------------------------------------------
(script dormant jetpack_high_objective_control
	(if debug (print "encounter start: jetpack high"))
	(set b_jetpack_high_started true)
	(game_save)	
	
	(thespian_folder_activate th_jetpack)
	(soft_ceiling_enable low_jetpack_blocker 0)
	(set objcon_jetpack_high 0)
	
	(teleport_players_not_in_volume tv_jetpack_high_teleport
		spawn_jetpack_high_player0
		spawn_jetpack_high_player1
		spawn_jetpack_high_player2
		spawn_jetpack_high_player3
	)

	(device_one_sided_set dm_jh_lobby0 true)
	(device_set_position dm_jh_lobby0 0)

	;temp cleanup
	(ai_erase gr_cov_jl)
	(ai_erase gr_unsc_ready)
	(ai_erase gr_unsc_odst)
	(ai_erase gr_unsc_jl_initial)
	(ai_disposable gr_unsc_jl true)
	;(ai_erase unsc_jl_doorman)
	;(ai_erase rr_unsc_inf0)
	;(ai_erase gr_cov_jl)
	
	(objects_manage_4b)
	
	(garbage_collect_now)

	; wake subsequent scripts
	(wake jh_spawn_control)
	(wake jetpack_high_waypoint)
	(wake md_jp_second_floor)
	(wake md_jp_theres_the_pad)
	(wake jh_senses)
	
	; flocks
	
	; objective control
	(sleep_until (volume_test_players tv_objcon_jetpack_high_001) 1)
		(if debug (print "objective control: jetpack 001"))
		(set objcon_jetpack_high 1)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_high_005) 1)
		(if debug (print "objective control: jetpack 005"))
		(set objcon_jetpack_high 5)
		(game_save)

	(sleep_until (volume_test_players tv_objcon_jetpack_high_006) 1)
		(if debug (print "objective control: jetpack 006"))
		(set objcon_jetpack_high 6)
		(game_save)
				
	(sleep_until (volume_test_players tv_objcon_jetpack_high_007) 1)
		(if debug (print "objective control: jetpack 007"))
		(set objcon_jetpack_high 7)
		(game_save)
		
		(mus_stop mus_05)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_high_010) 1)
		(if debug (print "objective control: jetpack 010"))
		(set objcon_jetpack_high 10)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_high_020) 1)
		(if debug (print "objective control: jetpack 020"))
		(set objcon_jetpack_high 20)
		(game_save_no_timeout)
		
	(sleep_until (volume_test_players tv_objcon_jetpack_high_030) 1)
		(if debug (print "objective control: jetpack 030"))
		(set objcon_jetpack_high 30)
		(game_save)

		(if (= s_special_elite 2)
			(begin
				(ai_place special_elite2)
				(sleep 1)
				(ai_disregard (ai_actors special_elite2) true)
			)
		)
		
	(sleep_until (or
		(volume_test_players tv_objcon_jetpack_high_040a)
		(volume_test_players tv_objcon_jetpack_high_040b)
		(volume_test_players tv_objcon_jetpack_high_050)
		(volume_test_players tv_objcon_jetpack_high_060)
		(volume_test_players tv_jetpack_high_stairs_top))1)
		
		(if debug (print "objective control: jetpack 040"))
		(set objcon_jetpack_high 40)
		(game_save)	
			
	(sleep_until (or
		(volume_test_players tv_objcon_jetpack_high_050)
		(volume_test_players tv_objcon_jetpack_high_060)
		(volume_test_players tv_jetpack_high_stairs_top))1)

		(if debug (print "objective control: jetpack 050"))
		(set objcon_jetpack_high 50)
		(game_save)	
		
	(sleep_until (or
		(volume_test_players tv_objcon_jetpack_high_060)
		(volume_test_players tv_jetpack_high_stairs_top))1)
		
		(if debug (print "objective control: jetpack 060"))
		(set objcon_jetpack_high 60)
		(game_save)	
	
)

; spawn scripts
; -------------------------------------------------------------------------------------------------
(script dormant jh_spawn_control
	; place ai cov
	;(ai_place cov_jetpack_high_ph0)
	(f_ai_place_vehicle_deathless cov_jetpack_high_ph0)
	
	;(ai_place gr_cov_jh_initial)
	(ai_place jh_cov_tree_snipers_inf0)
	(ai_place jh_cov_tree_inf0)
;* perf
	(ai_place jh_cov_hill_landing_inf0)
	(ai_place jh_cov_hill_landing_inf1c)
	(ai_place jh_cov_hill_landing_inf1b)
	(ai_place jh_cov_hill_landing_inf1a)
	(ai_place jh_cov_hill_snipers_inf0)
	(ai_place jh_cov_hill_stairs_inf0)
	(ai_place jh_cov_hill_stairs_inf1)
	(ai_place jh_cov_hill_concussion_inf0)
*;
	(sleep 1)
	;(ai_cannot_die gr_cov_jh_initial true)
	(ai_cannot_die jh_cov_tree_snipers_inf0 true)
	(ai_cannot_die jh_cov_tree_inf0 true)
;* perf
	(ai_cannot_die jh_cov_hill_landing_inf0 true)
	(ai_cannot_die jh_cov_hill_landing_inf1c true)
	(ai_cannot_die jh_cov_hill_landing_inf1b true)
	(ai_cannot_die jh_cov_hill_landing_inf1a true)
	(ai_cannot_die jh_cov_hill_snipers_inf0 true)
	(ai_cannot_die jh_cov_hill_stairs_inf0 true)
	(ai_cannot_die jh_cov_hill_stairs_inf1 true)
	(ai_cannot_die jh_cov_hill_concussion_inf0 true)
*;
	; place ai unsc
	;(ai_place gr_unsc_jh_initial)
	(ai_place jh_unsc_odst_balcony_inf0/sp_jh)
	(ai_place jh_unsc_odst_tree_inf0/sp_jh)
	(ai_place jh_unsc_mars_tree_inf0/sf_jh)	
	;(ai_place jh_civilians0/sf_jh)
	(ai_place jh_civilians0/sp_jh0)
	(ai_place jh_civilians0/sp_jh1)
	(ai_place jh_civilians0/sp_jh2)
	(ai_place jh_civilians0/sp_jh3)

	;perf
	(if (not (game_is_cooperative))
		(begin
			(ai_place jh_unsc_mars_balcony_inf0/sf_jh)
			(ai_place jh_civilians0/sp_jh4)
			(ai_place jh_civilians0/sp_jh5)
		)
	)
	
	;perf
	(ai_force_low_lod gr_civilian)
	(ai_lod_full_detail_actors 15)
	
	(sleep 1)	
	;(ai_cannot_die gr_unsc_jh_initial true)
;*
	(ai_cannot_die jh_unsc_mars_tree_inf0 true)
	(ai_cannot_die jh_unsc_mars_balcony_inf0 true)
	(ai_cannot_die jh_unsc_odst_balcony_inf0 true)
	(ai_cannot_die jh_unsc_odst_tree_inf0 true)
	(ai_cannot_die jh_civilians0 true)
*;
	(ai_cannot_die gr_jh_unsc true)
	(ai_cannot_die gr_jh_odst true)
	(ai_cannot_die gr_jh_civilian true)

	(sleep_until (>= objcon_jetpack_high 20))
	(set b_place_jh_hill true)
	
	(ai_place jh_cov_hill_landing_inf0)
	(ai_place jh_cov_hill_landing_inf1c)
	(ai_place jh_cov_hill_landing_inf1b)
	(ai_place jh_cov_hill_landing_inf1a)
	(ai_place jh_cov_hill_snipers_inf0)
	(ai_place jh_cov_hill_stairs_inf0)
	(ai_place jh_cov_hill_stairs_inf1)
	(ai_place jh_cov_hill_concussion_inf0)

	(sleep_until (>= objcon_jetpack_high 40))

	;perf
	(if (game_is_cooperative)
		(begin
			(set g_jh_civ_desired (- g_jh_civ_desired 2))
			(set g_jh_odst_desired (- g_jh_odst_desired 2))
		)
	)
		
	(set g_jh_civ_current (ai_living_count gr_jh_civilian))
	(if (< g_jh_civ_current g_jh_civ_desired)
		(ai_place jh_civilians1 (- g_jh_civ_desired g_jh_civ_current)))		
		
	(set g_jh_odst_current (ai_task_count obj_jetpack_high_unsc/gate_odst))
	(if (< g_jh_odst_current g_jh_odst_desired)
		(ai_place jh_odst_inf0 (- g_jh_odst_desired g_jh_odst_current)))		
	
		(if (not (game_is_cooperative))
			(ai_player_add_fireteam_squad player0 jh_odst_inf0))
		;(ai_migrate jh_odst_inf0 fireteam_player0)
	
	;perf
	(ai_force_low_lod gr_civilian)
	
)

(script static void jetpack_high_migrate_tree_odst
	(if debug (print "migrating tree odst to balcony odst"))
	(ai_migrate jh_unsc_odst_tree_inf0 jh_unsc_odst_balcony_inf0)
	;*
	(if debug (print "resetting targeting groups for marines and odsts"))
	(ai_set_targeting_group jh_unsc_mars_tree_inf0 -1 true)
	(ai_set_targeting_group jh_unsc_odst_tree_inf0 -1 true)	
	*;
)

(global boolean b_jh_phantom0_exit false)

(script dormant jh_senses
	
	;*	
	;allow sniper to magically see unsc mars & odst tree
	(ai_magically_see jh_unsc_mars_tree_inf0 jh_cov_tree_snipers_inf0)
	(ai_magically_see jh_cov_tree_snipers_inf0 jh_unsc_mars_tree_inf0)
	(ai_magically_see jh_unsc_odst_tree_inf0 jh_cov_tree_snipers_inf0)
	(ai_magically_see jh_cov_tree_snipers_inf0 jh_unsc_odst_tree_inf0)
	
	;allow turret to magically see unsc mars & odst tree
	(ai_magically_see jh_unsc_mars_tree_inf0 jh_cov_tree_turret_inf0)
	(ai_magically_see jh_cov_tree_turret_inf0 jh_unsc_mars_tree_inf0)
	(ai_magically_see jh_unsc_odst_tree_inf0 jh_cov_tree_turret_inf0)
	(ai_magically_see jh_cov_tree_turret_inf0 jh_unsc_odst_tree_inf0)
*;	
	
	;*
	(ai_set_targeting_group jh_unsc_mars_tree_inf0 1 true)
	(ai_set_targeting_group jh_unsc_odst_tree_inf0 1 true)
	(ai_set_targeting_group jh_unsc_odst_balcony_inf0 1 true)
	(ai_set_targeting_group jh_cov_tree_snipers_inf0 1 true)
	(ai_set_targeting_group jh_cov_tree_turret_inf0 1 true)

	(ai_set_targeting_group cov_jetpack_high_ph0 1 true)
	*;
	
	(sleep_until (>= objcon_jetpack_high 7) 5)	
	;cov
	(ai_cannot_die jh_cov_tree_snipers_inf0 false)
	(ai_cannot_die jh_cov_tree_inf0 false)
	(ai_cannot_die jh_cov_hill_landing_inf0 false)
	(ai_cannot_die jh_cov_hill_landing_inf1c false)
	(ai_cannot_die jh_cov_hill_landing_inf1b false)
	(ai_cannot_die jh_cov_hill_landing_inf1a false)
	(ai_cannot_die jh_cov_hill_snipers_inf0 false)
	(ai_cannot_die jh_cov_hill_stairs_inf0 false)
	(ai_cannot_die jh_cov_hill_stairs_inf1 false)
	(ai_cannot_die jh_cov_hill_concussion_inf0 false)
	(sleep_until b_jh_phantom0_exit)
	;unsc
	;(ai_cannot_die gr_unsc_jh_initial true)
;*
	(ai_cannot_die jh_unsc_mars_tree_inf0 false)
	(ai_cannot_die jh_unsc_mars_balcony_inf0 false)
	(ai_cannot_die jh_unsc_odst_balcony_inf0 false)
	(ai_cannot_die jh_unsc_odst_tree_inf0 false)
	(ai_cannot_die jh_civilians0 false)	
*;
	(ai_cannot_die gr_jh_unsc false)
	(ai_cannot_die gr_jh_odst false)
	(ai_cannot_die gr_jh_civilian false)

	;(wake jh_odst_renew)

;*	
	(sleep_until (>= objcon_jetpack_high 20) 5)
	(if debug (print "reseting jetpack_hight targeting groups"))
	;cov
	(ai_set_targeting_group jh_cov_tree_snipers_inf0 1 true)
	(ai_set_targeting_group jh_cov_tree_turret_inf0 1 true)
	(ai_set_targeting_group jh_cov_tree_inf0 1 true)
	(ai_set_targeting_group jh_cov_tree_inf1 1 true)
	;unsc
	(ai_set_targeting_group jh_unsc_mars_tree_inf0 -1 true)
	(ai_set_targeting_group jh_unsc_odst_tree_inf0 1 true)
	(ai_set_targeting_group jh_unsc_odst_balcony_inf0 1 true)
*;
)

(script command_script cs_jetpack_high_phantom0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))

	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1.0)

	(f_load_phantom (ai_vehicle_get ai_current_actor) "left" jh_cov_tree_inf1 none none none)
	(cs_fly_by pts_jetpack_high_ph0/entry3)
	(cs_fly_by pts_jetpack_high_ph0/entry2)	
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face pts_jetpack_high_ph0/land pts_jetpack_high_ph0/land_facing 0.25)
	(f_unload_phantom (ai_vehicle_get ai_current_actor) "left")
	;(sleep (* 30 1))
	(cs_fly_to_and_face pts_jetpack_high_ph0/entry1 pts_jetpack_high_ph0/hover_facing .25)
	
	(sleep_until (>= objcon_jetpack_high 7)1)
	(cs_fly_to_and_face pts_jetpack_high_ph0/exit0 pts_jetpack_high_ph0/exit1 0.25)
	(cs_vehicle_speed 0.8)
	(cs_fly_by pts_jetpack_high_ph0/exit1)
	(set b_jh_phantom0_exit true)
	(cs_fly_by pts_jetpack_high_ph0/exit2)
	(cs_fly_by pts_jetpack_high_ph0/erase)
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	
	(ai_erase ai_current_squad)
)

(global boolean b_jh_timeout false)
(script dormant jh_waypoint_timeout
	(sleep g_waypoint_timeout)
	(set b_jh_timeout true)
)

(script dormant jh_odst_renew
	(sleep_until
		(begin
			(ai_renew jh_unsc_odst_balcony_inf0)
			(ai_renew jh_unsc_odst_tree_inf0)
			(ai_renew jh_odst_inf0)
		false)
	(* 30 10))
)

(script dormant jetpack_high_waypoint
	;(sleep g_waypoint_timeout)
	(wake jh_waypoint_timeout)
	(if (not b_trophy_started)
		(f_blip_flag nav_jetpack_high_5 blip_default))
		
	(sleep_until (>= objcon_jetpack_high 5) 5)
	(f_unblip_flag nav_jetpack_high_5)

	(wake hud_flash_evac)
	(sleep_until (>= objcon_jetpack_high 6) 5 (* 30 30))
	(f_blip_flag nav_jetpack_high_6 blip_default)
		
	(sleep_until (>= objcon_jetpack_high 6) 5)
	(f_unblip_flag nav_jetpack_high_6)
	
	(sleep_until 
		(or 
			b_jh_timeout
			(volume_test_players tv_objcon_jetpack_high_050)
			(<= (ai_task_count obj_jetpack_high_cov/gate_main) 1)
		)
	)
	(f_blip_flag nav_jetpack_high_exit blip_default)
		
	(sleep_until b_trophy_started 5)
	(f_unblip_flag nav_jetpack_high_exit)
)

; -------------------------------------------------------------------------------------------------
; trophy
; -------------------------------------------------------------------------------------------------
(global boolean b_trophy_started false)
(global boolean b_trophy_counterattack false)
(global boolean b_trophy_complete false)
(global short g_trophy_civ_current -1)
(global short g_trophy_civ_desired 8)
(global short g_trophy_odst_current -1)
(global short g_trophy_odst_desired 2)

; -------------------------------------------------------------------------------------------------
(script dormant trophy_objective_control
	(if debug (print "encounter start: trophy"))
	(set b_trophy_started true)
	(game_save)	

	(ai_disposable gr_cov_jh true)
	(garbage_collect_now)

	;	begin trophy room encounter
	(wake trophy_spawn)
	(wake md_jp_clear_the_pad)
	(wake trophy_waypoint)
	(wake trophy_doors)
	
	; objective control
	(set objcon_trophy 0)


	(sleep_until (or 
		(volume_test_players tv_objcon_trophy_005)
		(volume_test_players	tv_pad_entrance_mid)
		(volume_test_players	tv_pad_entrance_right)
		(volume_test_players	tv_pad_entrance_left)
		(volume_test_players tv_objcon_trophy_030)
		(volume_test_players tv_objcon_trophy_040))1)
		(if debug (print "objective control: jetpack 005"))
		(set objcon_trophy 5)
		(game_save)
		
	(sleep_until (or 
		(volume_test_players	tv_pad_entrance_mid)
		(volume_test_players	tv_pad_entrance_right)
		(volume_test_players	tv_pad_entrance_left)
		(volume_test_players tv_objcon_trophy_030)
		(volume_test_players tv_objcon_trophy_040))1)
		(if debug (print "objective control: jetpack 010"))
		(set objcon_trophy 10)
		(game_save)
		
	(sleep_until (or 
		(volume_test_players	tv_pad_interior_mid)
		(volume_test_players	tv_pad_interior_right)
		(volume_test_players	tv_pad_interior_left)
		(volume_test_players tv_objcon_trophy_030)
		(volume_test_players tv_objcon_trophy_040))1)
		(if debug (print "objective control: jetpack 020"))
		(set objcon_trophy 20)
		(game_save)
		
	(sleep_until (or 
		(volume_test_players tv_objcon_trophy_030)
		(volume_test_players tv_objcon_trophy_040)) 1)
		(if debug (print "objective control: jetpack 030"))
		(set objcon_trophy 30)
		(game_save)

	(sleep_until (volume_test_players tv_objcon_trophy_040) 1)
		(if debug (print "objective control: jetpack 040"))
		(set objcon_trophy 40)
		(game_save)
	
)
; spawn scripts
; -------------------------------------------------------------------------------------------------

(script dormant trophy_spawn
	;perf
	(ai_lod_full_detail_actors 15)

	(f_ai_place_vehicle_deathless cov_trophy_ph1)
	(f_ai_place_vehicle_deathless_no_emp trohpy_dogfight_unsc0)

	(if debug (print "loading gunner_right"))
	(ai_place trohpy_dogfight_unsc1/gunner)
	(sleep 10)
	(ai_cannot_die trohpy_dogfight_unsc1/gunner true)
	(ai_force_low_lod trohpy_dogfight_unsc0)
	(vehicle_load_magic (ai_vehicle_get trohpy_dogfight_unsc0/pilot) "falcon_g_r" (ai_get_object trohpy_dogfight_unsc1/gunner))

	
	(ai_place trophy_cov_inf0) 
	(ai_place trophy_cov_inf1)
	(ai_place trophy_cov_inf3)
	;(ai_place jh_cov_pad_inf0)
	;(ai_place trophy_cov_final)
	(ai_place trophy_cov_snipers_inf0)
	(ai_place trophy_cov_snipers_inf1)
	
	;(ai_place trophy_civilians0)
	;(ai_place trophy_civilians1)	
	;(ai_cannot_die trophy_civilians0 true)
	;(ai_cannot_die trophy_civilians1 true)
	;(ai_disregard (ai_actors trophy_civilians0) true)
	;(ai_disregard (ai_actors trophy_civilians1) true)
	
	;carry over jh unsc
	(ai_migrate gr_jh_odst gr_unsc_odst)
	(ai_migrate gr_jh_odst_reinforce gr_unsc_odst)
	(ai_set_objective gr_jh_unsc obj_trophy_unsc)
	;(ai_set_objective gr_jh_unsc obj_trophy_unsc);jl_unsc_inf1c
	(ai_set_objective gr_jh_odst obj_trophy_unsc)
	
	;(ai_migrate gr_jh_civilian gr_trophy_civilians)
	(ai_migrate jh_civilians0 trophy_civilians0)
	(ai_migrate jh_civilians1 trophy_civilians0)
		(sleep 1)
	;(ai_set_objective gr_jh_civilian obj_trophy_unsc)
	(ai_set_objective trophy_civilians0 obj_trophy_unsc)
	
	(sleep_until (>= objcon_trophy 5))
	(ai_place jh_cov_pad_inf0)
	(ai_place trophy_cov_final)
			
	(sleep_until (>= objcon_trophy 20))
	(f_ai_place_vehicle_deathless cov_trophy_ph0)

;	wait until squad is out of phantom
	(sleep_until (<= (ai_living_count cov_trophy_ph0)4) 5)
;	wait until all squads are dead
	(sleep_until (f_task_is_empty obj_trophy_cov/gate_main))
  ;*(sleep_until (and
		(f_ai_is_defeated jh_cov_pad_inf0)
		(f_ai_is_defeated trophy_cov_inf0)
		(f_ai_is_defeated trophy_cov_bug0)
		(f_ai_is_defeated trophy_cov_bug1)
		(f_ai_is_defeated trophy_cov_bug2)
		(f_ai_is_defeated trophy_cov_final)
	))*;

(set g_trophy_civ_current (ai_living_count gr_trophy_civilians));gr_civilian
(if (< g_trophy_civ_current g_trophy_civ_desired)
	(ai_place trophy_civilians1 (- g_trophy_civ_desired g_trophy_civ_current)))		
	
(set g_trophy_odst_current (ai_task_count obj_trophy_unsc/gate_odst))
(if (< g_trophy_odst_current g_trophy_odst_desired)
	(ai_place trophy_odst_inf0 (- g_trophy_odst_desired g_trophy_odst_current)))		

	;perf
	(ai_force_low_lod gr_civilian)

	(if (not (game_is_cooperative))
		(ai_player_add_fireteam_squad player0 trophy_odst_inf0))
	;(ai_migrate jh_odst_inf0 fireteam_player0)
		
	(set b_jetpack_high_complete true)
	(f_unblip_flag objective_traxus_pad)
	(f_unblip_ai jetpack_high_odsts)
	;(mus_stop mus_jetpack)
	
	(unit_set_stance gr_civilian "")
	
	(sleep_until b_starport_started)
	(if debug (print "cleaning up jetpack high..."))
	(ai_disposable gr_cov_jh true)
)

(script command_script cs_trophy_phantom0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))

	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1.0)
	(f_load_phantom (ai_vehicle_get ai_current_actor) "left" trophy_cov_inf2 jh_cov_pad_inf1 none none)
	(cs_fly_by pts_trophy_ph0/entry4 5)
	(cs_fly_by pts_trophy_ph0/entry3 5)
	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face pts_trophy_ph0/entry2 pts_trophy_ph0/land 0.35)

	(sleep_until (or 
		(<= (ai_living_count obj_trophy_cov) 4)
		(>= objcon_trophy 40)))

	(cs_fly_by pts_trophy_ph0/entry2 5)
	(cs_fly_by pts_trophy_ph0/entry1 5)
;	(cs_fly_by pts_trophy_ph0/entry0 0.35)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face pts_trophy_ph0/land pts_trophy_ph0/land_facing 0.35)
	(sleep 120)
	(f_unload_phantom (ai_vehicle_get ai_current_actor) "left")
	(set b_trophy_counterattack true)
	(cs_fly_to_and_face pts_trophy_ph0/hover pts_trophy_ph0/hover_facing)
	(sleep 90)
	(cs_vehicle_speed 0.8)
	(cs_fly_by pts_trophy_ph0/exit0)
	(cs_fly_by pts_trophy_ph0/exit1)
	(cs_fly_by pts_trophy_ph0/exit2)
	(cs_fly_by pts_trophy_ph0/erase)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

(script command_script cs_trophy_phantom1
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_ignore_obstacles true)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1.0)
	;(f_load_phantom (ai_vehicle_get ai_current_actor) "right" trophy_cov_inf0 trophy_cov_inf1 none none)
	;(f_load_phantom_cargo (ai_vehicle_get ai_current_actor) "2" trophy_cov_shade0 trophy_cov_shade1)

	(ai_place trophy_cov_shade0)
	(ai_place trophy_cov_shade1)
	(sleep 1)
;*
	(ai_cannot_die trophy_cov_shade0 true)
	(ai_cannot_die trophy_cov_shade1 true)
*;	
	(vehicle_load_magic (ai_vehicle_get_from_starting_location cov_trophy_ph1/pilot) "phantom_sc01" (ai_vehicle_get_from_starting_location trophy_cov_shade0/gunner))
	(vehicle_load_magic (ai_vehicle_get_from_starting_location cov_trophy_ph1/pilot) "phantom_sc02" (ai_vehicle_get_from_starting_location trophy_cov_shade1/gunner))
	
	(cs_fly_by pts_trophy_ph1/entry3)
	(cs_fly_by pts_trophy_ph1/entry2)
	(cs_fly_by pts_trophy_ph1/entry1)
	;(cs_vehicle_speed 0.5)
	;(cs_fly_by pts_trophy_ph1/hover 1)
	(cs_vehicle_speed 0.35)	
	(cs_fly_to_and_face pts_trophy_ph1/land0 pts_trophy_ph1/land0_facing 0.25)
	(sleep (* 30 2))
	;(f_unload_phantom (ai_vehicle_get ai_current_actor) "right")
	;(f_unload_phantom_cargo (ai_vehicle_get ai_current_actor) "1")
	(vehicle_unload (ai_vehicle_get_from_starting_location cov_trophy_ph1/pilot) "phantom_sc01")

	(cs_fly_to_and_face pts_trophy_ph1/land1 pts_trophy_ph1/land1_facing 0.25)
	(sleep (* 30 2))
	;(f_unload_phantom (ai_vehicle_get ai_current_actor) "right")
	;(f_unload_phantom_cargo (ai_vehicle_get ai_current_actor) "1")
	(vehicle_unload (ai_vehicle_get_from_starting_location cov_trophy_ph1/pilot) "phantom_sc02")

	(wake shade_kill)
					
	(cs_fly_to_and_face pts_trophy_ph1/hover pts_trophy_ph1/hover_facing 0.25)
	(sleep (* 30 1))

	(objects_attach sc_trophy_shade0 "marker01" (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner) "")
	(objects_attach sc_trophy_shade1 "marker01" (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner) "")
	(sleep 10)
	(objects_detach sc_trophy_shade0 (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner))
	(objects_detach sc_trophy_shade1 (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner))
	
	(cs_vehicle_speed 0.8)
	(cs_fly_by pts_trophy_ph1/exit1)	
	(cs_fly_by pts_trophy_ph1/exit2)
	(cs_fly_by pts_trophy_ph1/erase)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

(script command_script cs_trohpy_dogfight_unsc0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))

	(cs_enable_pathfinding_failsafe true)
	
	;fly to first hover point
	(cs_fly_by pts_trophy_dogfight/entry0 2)
	
	(cs_fly_by pts_trophy_dogfight/entry1 2)
;*
	(ai_set_targeting_group trohpy_dogfight_unsc0 7)
	(ai_set_targeting_group trophy_cov_shade0 7)
	(ai_set_targeting_group trophy_cov_shade1 7)
	(ai_set_targeting_group cov_trophy_ph1 7)
*;	
	(cs_fly_to pts_trophy_dogfight/hover0 10)
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face pts_trophy_dogfight/hover0 pts_trophy_dogfight/hover0_facing 0.5)
	
	;(ai_set_blind ai_current_squad true)
	(sleep (* 30 4))
	(cs_fly_to_and_face pts_trophy_dogfight/hover1 pts_trophy_dogfight/hover0_facing 0.5)
	(sleep (* 30 4))
	(cs_fly_to_and_face pts_trophy_dogfight/hover2 pts_trophy_dogfight/hover0_facing 0.5)
	(sleep (* 30 4))
	(cs_fly_to_and_face pts_trophy_dogfight/hover0 pts_trophy_dogfight/hover0_facing 0.5)

	;exit
	(cs_vehicle_speed 0.8)
	(cs_fly_by pts_trophy_dogfight/exit0)	
;*
	(ai_set_targeting_group trophy_cov_shade0 -1)
	(ai_set_targeting_group trophy_cov_shade1 -1)
	
	(ai_cannot_die trophy_cov_shade0 false)
	(ai_cannot_die trophy_cov_shade1 false)
*;	
	(cs_fly_by pts_trophy_dogfight/erase0)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

(script static boolean jetpack_high_rush_pad
	(or
		(volume_test_players tv_pad_interior_left)
		(volume_test_players tv_pad_interior_mid)
		(volume_test_players tv_pad_interior_right))
)

(script dormant trophy_doors

	(device_set_position dm_trophy_door1 1);open
	(sleep_until (= (device_get_position dm_trophy_door1) 1) 1)
	(device_operates_automatically_set dm_trophy_door1 false)
	(device_closes_automatically_set dm_trophy_door1 false)

	(sleep_until b_trophy_complete)
	(device_operates_automatically_set dm_trophy_door1 true)
	(device_closes_automatically_set dm_trophy_door1 true)
;*
	;6-9 were locked
	(device_operates_automatically_set dm_trophy_door7 true)
	(device_operates_automatically_set dm_trophy_door9 true)
*;
)

(script dormant shade_kill
	(sleep_until 
		(or
			(not (vehicle_test_seat (ai_vehicle_get trophy_cov_shade0/gunner) "shade_d"))
			(not (vehicle_test_seat (ai_vehicle_get trophy_cov_shade1/gunner) "shade_d"))
		)
	)
	
			(if (not (vehicle_test_seat (ai_vehicle_get trophy_cov_shade0/gunner) "shade_d")) 
				(unit_kill (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner))
			)

				
			(if (not (vehicle_test_seat (ai_vehicle_get trophy_cov_shade1/gunner) "shade_d")) 
				(unit_kill (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner))
			)

	(sleep_until 
		(and
			(not (vehicle_test_seat (ai_vehicle_get trophy_cov_shade0/gunner) "shade_d"))
			(not (vehicle_test_seat (ai_vehicle_get trophy_cov_shade1/gunner) "shade_d"))
		)
	)
	
			(if (not (vehicle_test_seat (ai_vehicle_get trophy_cov_shade0/gunner) "shade_d")) 
				(unit_kill (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner))
			)

				
			(if (not (vehicle_test_seat (ai_vehicle_get trophy_cov_shade1/gunner) "shade_d")) 
				(unit_kill (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner))
			)
)

(script dormant trophy_waypoint
	(sleep g_waypoint_timeout)
	(if (not b_trophy_complete)
			;(f_blip_flag objective_traxus_pad blip_neutralize));blip_defend
		(begin
			(if (>= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner)) 0) 
				(f_blip_object (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner) blip_neutralize)	
			)
				
			(if (>= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner)) 0) 
				(f_blip_object (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner) blip_neutralize)
			)
		)
	)

	(sleep_until 
		(or
			(<= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner)) 0)
			(<= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner)) 0)
		)
	)
	
			(if (<= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner)) 0) 
				(f_unblip_object (ai_get_object trophy_cov_shade0))
			)

				
			(if (<= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner)) 0) 
				(f_unblip_object (ai_get_object trophy_cov_shade1))
			)

	(sleep_until 
		(and
			(<= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner)) 0)
			(<= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner)) 0)
		)
	)
	
			(if (<= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade0/gunner)) 0) 
				(f_unblip_object (ai_get_object trophy_cov_shade0))
			)
				
			(if (<= (object_get_health (ai_vehicle_get_from_spawn_point trophy_cov_shade1/gunner)) 0) 
				(f_unblip_object (ai_get_object trophy_cov_shade1))
			)
)



; =================================================================================================
; ride
; =================================================================================================
(global boolean b_ride_started false)
(global boolean b_ride_complete false)
(global boolean b_ride_falcon_landed false)
(global boolean b_ride_falcon0_landed false)
(global boolean b_ride_player_in_falcon false)
(global boolean b_ride_sync false)
(global boolean b_falcon_sync false)
(global boolean b_falcon0_sync false)
(global vehicle v_ride_falcon none)
(global vehicle v_ride_falcon0 none)
; -------------------------------------------------------------------------------------------------
(script dormant ride_objective_control
	(if debug (print "encounter start: ride"))
	(set b_trophy_complete true)
	;(set b_ride_started true)
	(game_save)	
	(set objcon_ride 0)
	(game_insertion_point_unlock 2)
	
	(sleep_forever f_jetpack_fx_ambient)
		
	(wake ride_progression)
	
		(sleep_until (volume_test_players tv_ride_objcon_010) 1)
		(if debug (print "objective control: ride 010"))
		(set objcon_ride 10)
		(game_save)		
;*
		(sleep_until (volume_test_players tv_ride_objcon_020) 1)
		(if debug (print "objective control: ride 020"))
		(set objcon_ride 20)
		(game_save)
		
		(sleep_until (volume_test_players tv_ride_objcon_030) 1)
		(if debug (print "objective control: ride 030"))
		(set objcon_ride 30)
		(game_save)
		
		(sleep_until (volume_test_players tv_ride_objcon_040) 1)
		(if debug (print "objective control: ride 040"))
		(set objcon_ride 40)
		(game_save)

		(sleep_until (volume_test_players tv_ride_objcon_050) 1)
		(if debug (print "objective control: ride 050"))
		(set objcon_ride 50)
		(game_save)
		
		(sleep_until (volume_test_players tv_ride_objcon_060) 1)
		(if debug (print "objective control: ride 060"))
		(set objcon_ride 60)
		(game_save)
	*;		
		(sleep_until (volume_test_players tv_ride_objcon_070) 1)
		(if debug (print "objective control: ride 070"))
		(set objcon_ride 70)
		(game_save)		
		
		(sleep_until (volume_test_players tv_ride_objcon_080) 1)
		(if debug (print "objective control: ride 080"))
		(set objcon_ride 80)
		(game_save)

		(sleep_until (volume_test_players tv_ride_objcon_085) 1)
		(if debug (print "objective control: ride 085"))
		(set objcon_ride 85)
		(game_save)
		
		(sleep_until (volume_test_players tv_ride_objcon_090) 1)
		(if debug (print "objective control: ride 090"))
		(set objcon_ride 90)
		(game_save)
		
		(sleep_until (volume_test_players tv_ride_objcon_095) 1)
		(if debug (print "objective control: ride 095"))
		(set objcon_ride 95)
		(game_save)
				
		(sleep_until (volume_test_players tv_ride_objcon_100) 1)
		(if debug (print "objective control: ride 100"))
		(set objcon_ride 100)
		(game_save)

		(sleep_until (volume_test_players tv_ride_objcon_105) 1)
		(if debug (print "objective control: ride 105"))
		(set objcon_ride 105)
		(game_save)

		(sleep_until (volume_test_players tv_ride_objcon_110) 1)
		(if debug (print "objective control: ride 110"))
		(set objcon_ride 110)
		(game_save)

		(sleep_until (volume_test_players tv_ride_objcon_115) 1)
		(if debug (print "objective control: ride 115"))
		(set objcon_ride 115)
		(game_save)

		(sleep_until (volume_test_players tv_ride_objcon_120) 1)
		(if debug (print "objective control: ride 120"))
		(set objcon_ride 120)
		(game_save)
		
		(sleep_until (volume_test_players tv_ride_objcon_130) 1)
		(if debug (print "objective control: ride 130"))
		(set objcon_ride 130)
		(game_save)
)

(script static void ride_load_passengers ;gunner seat = falcon_g_l
	;reserve gunner seats, 
	(ai_vehicle_reserve_seat v_ride_falcon "falcon_g_l" true)
	(ai_vehicle_reserve_seat v_ride_falcon "falcon_g_r" true)
	(ai_vehicle_reserve_seat v_ride_falcon "falcon_p_l1" true)
	(ai_vehicle_reserve_seat v_ride_falcon "falcon_p_r1" true)
	(ai_vehicle_reserve_seat v_ride_falcon0 "falcon_g_l" true)
	(ai_vehicle_reserve_seat v_ride_falcon0 "falcon_g_r" true)
	(ai_vehicle_reserve_seat v_ride_falcon0 "falcon_p_l1" true)
	(ai_vehicle_reserve_seat v_ride_falcon "falcon_p_r1" true)
		
	;disable driver/bench seats
	(vehicle_set_player_interaction v_ride_falcon "falcon_d" false false)
	(vehicle_set_player_interaction v_ride_falcon "falcon_p_bench" false false)
	(vehicle_set_player_interaction v_ride_falcon "falcon_b_d" false false)
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_d" false false)
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_p_bench" false false)
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_b_d" false false)

	;disallow players to enter before vehicles land
	(vehicle_set_player_interaction v_ride_falcon "falcon_g_l" false false)
	(vehicle_set_player_interaction v_ride_falcon "falcon_g_r" false false)
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_g_l" false false)
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_g_r" false false)

	;disable passenger seats
	(vehicle_set_player_interaction v_ride_falcon "falcon_p_r1" false false)
	(vehicle_set_player_interaction v_ride_falcon "falcon_p_l1" false false)
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_p_r1" false false)
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_p_l1" false false)
	
	;load falcon passengers
	;perf
	(if (not (game_is_cooperative))
		(begin
			(if debug (print "loading passenger_right_1"))
			(ai_place ride_passengers/passenger0)
			(sleep 10)	
			(vehicle_load_magic v_ride_falcon "falcon_p_r1" (ai_get_object ride_passengers/passenger0))
		
			(if debug (print "loading passenger_left_1"))
			(ai_place ride_passengers/passenger1)
			(sleep 10)
			(vehicle_load_magic v_ride_falcon "falcon_p_l1" (ai_get_object ride_passengers/passenger1))
		)
	)

	;load falcon0 passengers
	;perf
	(if (not (game_is_cooperative))
		(begin
			(if debug (print "loading passenger_right_1"))
			(ai_place ride_passengers0/passenger0)
			(sleep 10)
			(vehicle_load_magic v_ride_falcon0 "falcon_p_r1" (ai_get_object ride_passengers0/passenger0))
			
			(if debug (print "loading passenger_left_1"))
			(ai_place ride_passengers0/passenger1)
			(sleep 10)
			(vehicle_load_magic v_ride_falcon0 "falcon_p_l1" (ai_get_object ride_passengers0/passenger1))	
		)
	)


	;fill seats based on coop
	(if (<= (game_coop_player_count) 3)
		(begin
			(if debug (print "loading gunner_right"))
			(ai_place ride_passengers0/passenger2)
			(sleep 10)
			(vehicle_load_magic v_ride_falcon0 "falcon_g_r" (ai_get_object ride_passengers0/passenger2))
			(vehicle_set_player_interaction v_ride_falcon0 "falcon_g_r" false false)		
		))
		
	(if (<= (game_coop_player_count) 2)
		(begin
			(if debug (print "loading gunner_right"))
			(ai_place ride_passengers/passenger2)
			(sleep 10)
			(vehicle_load_magic v_ride_falcon "falcon_g_r" (ai_get_object ride_passengers/passenger2))
			(vehicle_set_player_interaction v_ride_falcon "falcon_g_r" false false)
		))

	(if (<= (game_coop_player_count) 1)
		(begin
			(if debug (print "loading gunner_left"))
			(ai_place ride_passengers/passenger3)
			(sleep 10)
			(vehicle_load_magic v_ride_falcon0 "falcon_g_l" (ai_get_object ride_passengers/passenger3))
			(vehicle_set_player_interaction v_ride_falcon0 "falcon_g_l" false false)
		))

	;perf
	(ai_force_low_lod ride_passengers)
	(ai_force_low_lod ride_passengers0)	
)

(script command_script cs_ride_vehicle_enter
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_ignore_obstacles true)
	(cs_vehicle_speed 0.8)
	(cs_attach_to_spline "spline_falcon_ride_enter")

	(cs_fly_by falcon_enter/entry1)
	(cs_vehicle_speed 0.5)

	(cs_fly_by falcon_enter/entry0)
	(cs_vehicle_speed 0.2)
	
	(cs_fly_to falcon_enter/hover)
	(cs_attach_to_spline "")
	
	(cs_fly_to_and_face falcon_enter/hover falcon_enter/land_facing 1.0)
	(sleep 30)
	(cs_vehicle_speed 0.1)
	(cs_fly_to_and_face falcon_enter/land falcon_enter/land_facing 0.5)	
	;(vehicle_hover v_ride_falcon true)
	(set b_ride_falcon_landed true)
)

(script command_script cs_ride_vehicle0_enter
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_ignore_obstacles true)
	(cs_vehicle_speed 0.8)
	(cs_attach_to_spline "spline_falcon_ride0_enter")

	(cs_fly_by falcon0_enter/entry1)
	(cs_vehicle_speed 0.5)

	(cs_fly_by falcon0_enter/entry0)
	(cs_vehicle_speed 0.2)
	
	(cs_fly_to falcon0_enter/hover)
	(cs_attach_to_spline "")
	
	(cs_fly_to_and_face falcon0_enter/hover falcon0_enter/land_facing 1.0)
	(sleep 30)
	(cs_vehicle_speed 0.1)
	(cs_fly_to_and_face falcon0_enter/land falcon0_enter/land_facing 0.5)
	;(vehicle_hover v_ride_falcon0 true)
	(set b_ride_falcon0_landed true)
)

(script command_script cs_ride_vehicle_route
	(cs_enable_pathfinding_failsafe true)
	(cs_ignore_obstacles true)
	(cs_vehicle_speed 0.2)
	
	;(vehicle_hover v_ride_falcon false)
	(cs_fly_to_and_face falcon_enter/hover falcon_enter/land_facing 1)
	(sleep (* 30 1))
	(cs_fly_to_and_face falcon_ride/evac falcon_ride/evac_facing 1)
	;(wake md_ride)

	(sleep (* 30 2))
	;(set b_falcon_sync true)
	(set b_falcon_evac_hover true)

	(sleep_until b_falcon_goto_load_hover)
	(cs_attach_to_spline "spline_falcon_ride")
	(cs_vehicle_speed 0.6)
		
	(cs_fly_by falcon_ride/rooftop0_start 1)
	(set b_rooftop0_start true)
	(cs_vehicle_speed 0.4)
	(cs_fly_by falcon_ride/rooftop0_finish 1)	
	(set b_rooftop0_finish true)
	(cs_vehicle_speed 0.8)

	(cs_fly_to falcon_ride/load_zone 5)
	(cs_vehicle_speed 0.3)
	(set b_falcon_load_hover true)
	(cs_fly_to_and_face falcon_ride/load_hover falcon_ride/load_zone_facing 1)
	
	(sleep_until b_falcon_goto_lz_hover)
	(cs_vehicle_speed 0.7)
	
	(cs_fly_by falcon_ride/rooftop2_start 5)
	(set b_rooftop2_start true)
	
	(cs_fly_by falcon_ride/transport 5)
	(set b_falcon_transport true)
	(cs_vehicle_speed 0.9)	

	(cs_fly_by falcon_ride/park 5)
	(set b_falcon_park true)

	(cs_fly_by falcon_ride/lz_setup 5)
	(set b_falcon_lz_setup true)

  (cs_fly_to falcon_ride/park_detach 5)
	(cs_attach_to_spline "")
	(cs_vehicle_speed 0.3)
	(cs_fly_to_and_face falcon_ride/lz_hover falcon_ride/lz_hover_facing 0.5)
	(set b_falcon_lz_hover true)
	(sleep_until b_starport_monologue)
)

(script command_script cs_ride_vehicle0_route
	(cs_enable_pathfinding_failsafe true)
	(cs_ignore_obstacles true)
	(cs_vehicle_speed 0.2)
	
	;(vehicle_hover v_ride_falcon0 false)
	(cs_fly_to_and_face falcon0_enter/hover falcon0_enter/land_facing 1)
	(sleep (* 30 1))
	(cs_fly_to_and_face falcon0_ride/evac falcon0_ride/evac_facing 1)

	(sleep (* 30 2))
	(set b_falcon0_evac_hover true)

	(sleep_until b_falcon0_goto_load_hover)	
	(cs_attach_to_spline "spline_falcon0_ride")
	(cs_vehicle_speed 0.6)

	(cs_fly_by falcon0_ride/rooftop0_start 1)
	(set b_rooftop0_start true)
	(cs_vehicle_speed 0.4)
	(cs_fly_by falcon0_ride/rooftop0_finish 1)
	(set b_rooftop0_finish true)
	(cs_vehicle_speed 0.8)
	
	(cs_fly_to falcon0_ride/load_zone 5)
	(cs_vehicle_speed 0.3)
	(set b_falcon0_load_hover true)

	(cs_fly_to_and_face falcon0_ride/load_hover falcon0_ride/load_zone_facing 1)
	
	(sleep_until b_falcon0_goto_lz_hover)
	(cs_vehicle_speed 0.7)
	
	(cs_fly_by falcon0_ride/rooftop2_start 5)
	(set b_rooftop2_start true)

	(cs_fly_by falcon0_ride/transport 5)
	(set b_falcon0_transport true)
	(cs_vehicle_speed 0.9)	

	(cs_fly_by falcon0_ride/park 5)
	(set b_falcon0_park true)

	(cs_fly_by falcon0_ride/lz_setup 5)
	(set b_falcon0_lz_setup true)
	
  (cs_fly_to falcon0_ride/park_detach 5)  
	(cs_attach_to_spline "")
	(cs_vehicle_speed 0.3)	
	(cs_fly_to_and_face falcon0_ride/lz_hover falcon0_ride/lz_hover_facing 0.5)
	(set b_falcon0_lz_hover true)
	(sleep_until b_starport_monologue)
)

(script command_script cs_duvall_falcon
	(cs_enable_pathfinding_failsafe true)
	(cs_ignore_obstacles true)
	
	(cs_vehicle_speed 0.1)
	(cs_fly_to_and_face falcon_ride/hover falcon_ride/hover_facing 0.25)	
  (cs_fly_to_and_face falcon_ride/land falcon_ride/land_facing 0.25)
	(if debug (print "unloading falcon..."))
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_p")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_g")
	(ai_vehicle_reserve v_ride_falcon true)
	(vehicle_set_player_interaction (ai_vehicle_get ai_current_actor) "falcon_g_l" false false)
	(vehicle_set_player_interaction (ai_vehicle_get ai_current_actor) "falcon_g_r" false false)
	(set b_falcon_unloaded true)
)

(script command_script cs_duvall_falcon0
	(cs_enable_pathfinding_failsafe true)
	(cs_ignore_obstacles true)
	
	(cs_vehicle_speed 0.1)
	(cs_fly_to_and_face falcon0_ride/hover falcon0_ride/hover_facing 0.25)
	(cs_fly_to_and_face falcon0_ride/land falcon0_ride/land_facing 0.25)			
	(if debug (print "unloading falcon0..."))
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_p")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_g")
	(ai_vehicle_reserve v_ride_falcon0 true)
	(vehicle_set_player_interaction (ai_vehicle_get ai_current_actor) "falcon_g_l" false false)
	(vehicle_set_player_interaction (ai_vehicle_get ai_current_actor) "falcon_g_r" false false)
	(set b_falcon0_unloaded true)
)
	
(script dormant allegiance_broken_ride
	(sleep_until
		(begin
			(if (ai_allegiance_broken player human)
				(begin
					(vehicle_unload (ai_vehicle_get_from_starting_location ride_falcon/pilot) "falcon_g")
					(vehicle_unload (ai_vehicle_get_from_starting_location ride_falcon0/pilot) "falcon_g")
					(unit_add_equipment player0 profile_starting true true)
					(unit_add_equipment player1 profile_starting true true)
					(unit_add_equipment player2 profile_starting true true)
					(unit_add_equipment player3 profile_starting true true)
					
					(sleep (* 30 3))
					(unit_kill (unit (player0)))
					(if (game_is_cooperative)
						(begin
							(unit_kill (unit (player1)))
							(unit_kill (unit (player2)))
							(unit_kill (unit (player3)))
						)
					)
										
				)
			)
		b_starport_started)
	)
)

; -------------------------------------------------------------------------------------------------
(global boolean b_falcon_evac_hover false)
(global boolean b_falcon0_evac_hover false)
(global boolean b_falcon_goto_load_hover false)
(global boolean b_falcon0_goto_load_hover false)
(global boolean b_falcon_load_hover false)
(global boolean b_falcon0_load_hover false)
(global boolean b_falcon_goto_lz_hover false)
(global boolean b_falcon0_goto_lz_hover false)
(global boolean b_falcon_lz_setup false)
(global boolean b_falcon0_lz_setup false)
(global boolean b_falcon_lz_hover false)
(global boolean b_falcon0_lz_hover false)
(global boolean b_starport_intro false)
(global boolean b_falcon_transport false)
(global boolean b_falcon0_transport false)
(global boolean b_falcon_park false)
(global boolean b_falcon0_park false)
(global boolean b_banshee0_start false)
(global boolean b_rooftop0_start false)
(global boolean b_rooftop1_start false)
(global boolean b_rooftop2_start false)
(global boolean b_rooftop0_finish false)
(global boolean b_rooftop1_finish false)
(global boolean b_rooftop2_finish false)
(global boolean b_falcon_unloaded false)
(global boolean b_falcon0_unloaded false)
(global short g_falcon_vitality 100)
; -------------------------------------------------------------------------------------------------

(script dormant ride_progression
;wait for trophy to finish 
; -------------------------------------------------------------------------------------------------
	(sleep_until b_trophy_complete)
; -------------------------------------------------------------------------------------------------
	;start trophy complete dialogue
	(wake md_jetpack_complete)
	;complete trophy objective
		;md_jetpack_complete calls ct_objective_traxus_complete
		
	;set up terrace and roof evacs
	(f_ai_place_vehicle_deathless traxus_evac_pelican0)
	(sleep (* 30 2))
	(f_ai_place_vehicle_deathless traxus_evac_pelican2)
	(sleep (* 30 2))

	;send flacons to land
	(f_ai_place_vehicle_deathless_no_emp ride_falcon)
	;(object_cannot_take_damage (ai_get_unit ride_falcon))
	(sleep (* 30 3))
	(f_ai_place_vehicle_deathless_no_emp ride_falcon0)	
	;(object_cannot_take_damage (ai_get_unit ride_falcon0))
	(sleep 1)
	(set v_ride_falcon (ai_vehicle_get ride_falcon/pilot))
	(set v_ride_falcon0 (ai_vehicle_get ride_falcon0/pilot))
	(sleep 1)
	(ride_load_passengers)
				
;wait until falcon has landed
; -------------------------------------------------------------------------------------------------
	(sleep_until b_ride_falcon_landed)
; -------------------------------------------------------------------------------------------------
	;start ride dialogue
	(wake md_ride_start)
	;initiate starport objective
		;md_ride_start calls ct_objective_transport_start
		
;wait for falcons to sync
; -------------------------------------------------------------------------------------------------
(sleep_until
	(or
		b_ride_falcon_landed
		b_ride_falcon0_landed))
; -------------------------------------------------------------------------------------------------
	;unlock player seats
	;allow players to enter falcon gunner seats but not exit
	(vehicle_set_player_interaction v_ride_falcon "falcon_g_l" true false)
	(vehicle_set_player_interaction v_ride_falcon "falcon_g_r" true false)
	;allow players to enter falcon0 gunner seats but not exit
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_g_l" true false)
	(vehicle_set_player_interaction v_ride_falcon0 "falcon_g_r" true false)
				
	;start get in reminder dialogue
	;(wake md_ride_pilot_master)
	
	;start timeout for bliping falcons
		;md_ride_start sleeps and checks before blip

;wait until player is in falcon
; -------------------------------------------------------------------------------------------------
	(sleep_until 
		(or
			(player_in_vehicle (ai_vehicle_get ride_falcon/pilot))
			(player_in_vehicle (ai_vehicle_get ride_falcon0/pilot))
		)
	5)
; -------------------------------------------------------------------------------------------------	
	(set b_ride_player_in_falcon true)
	(if debug (print "player is in the falcon..."))
	
	(if (game_is_cooperative)
		(begin
			(sleep (* 30 5))			
			(sleep_until
				(begin			
					;seat player0
					(if (= (unit_in_vehicle_type player0 20) false)
						(begin
							(cond ;test seats until emtpy is found 
								(; condition #1
									(!= (vehicle_test_seat v_ride_falcon "falcon_g_l") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_l" player0)
									(unit_enter_vehicle_immediate player0 v_ride_falcon "falcon_g_l")
								)
								
								(; condition #2
									(!= (vehicle_test_seat v_ride_falcon0 "falcon_g_l") true)
									;(vehicle_load_magic v_ride_falcon0 "falcon_g_l" player0)
									(unit_enter_vehicle_immediate player0 v_ride_falcon0 "falcon_g_l")
								)
								
								(; condition #3
									(!= (vehicle_test_seat v_ride_falcon "falcon_g_r") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_r" player0)
									(unit_enter_vehicle_immediate player0 v_ride_falcon "falcon_g_r")
								)
								
								(; condition #2
									(!= (vehicle_test_seat v_ride_falcon0 "falcon_g_r") true)
									;(vehicle_load_magic v_ride_falcon0 "falcon_g_r" player0)
									(unit_enter_vehicle_immediate player0 v_ride_falcon0 "falcon_g_r")
								)
		
							)
						)
					)
					
					;seat player1
					(if (= (unit_in_vehicle_type player1 20) false)
						(begin
							(cond ;test seats until emtpy is found 
								(; condition #1
									(!= (vehicle_test_seat v_ride_falcon "falcon_g_l") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_l" player1)
									(unit_enter_vehicle_immediate player1 v_ride_falcon "falcon_g_l")
								)
								
								(; condition #2
									(!= (vehicle_test_seat v_ride_falcon0 "falcon_g_l") true)
									;(vehicle_load_magic v_ride_falcon0 "falcon_g_l" player1)
									(unit_enter_vehicle_immediate player1 v_ride_falcon0 "falcon_g_l")
								)
								
								(; condition #3
									(!= (vehicle_test_seat v_ride_falcon "falcon_g_r") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_r" player1)
									(unit_enter_vehicle_immediate player1 v_ride_falcon "falcon_g_r")
								)
								
								(; condition #2
									(!= (vehicle_test_seat v_ride_falcon0 "falcon_g_r") true)
									;(vehicle_load_magic v_ride_falcon0 "falcon_g_r" player1)
									(unit_enter_vehicle_immediate player1 v_ride_falcon0 "falcon_g_r")
								)
							)
						)
					)
					
					;seat player2
					(if (= (unit_in_vehicle_type player2 20) false)
						(begin
							(cond ;test seats until emtpy is found 
								(; condition #1
									(!= (vehicle_test_seat v_ride_falcon "falcon_g_l") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_l" player2)
									(unit_enter_vehicle_immediate player2 v_ride_falcon "falcon_g_l")
								)
								
								(; condition #2
									(!= (vehicle_test_seat v_ride_falcon0 "falcon_g_l") true)
									;(vehicle_load_magic v_ride_falcon0 "falcon_g_l" player2)
									(unit_enter_vehicle_immediate player2 v_ride_falcon0 "falcon_g_l")
								)
								
								(; condition #3
									(!= (vehicle_test_seat v_ride_falcon "falcon_g_r") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_r" player2)
									(unit_enter_vehicle_immediate player2 v_ride_falcon "falcon_g_r")
								)
								
								(; condition #2
									(!= (vehicle_test_seat v_ride_falcon0 "falcon_g_r") true)
									;(vehicle_load_magic v_ride_falcon0 "falcon_g_r" player2)
									(unit_enter_vehicle_immediate player2 v_ride_falcon0 "falcon_g_r")
								)
							)
						)
					)
					
					;seat player3
					(if (= (unit_in_vehicle_type player3 20) false)
						(begin
							(cond ;test seats until emtpy is found 
								(; condition #1
									(!= (vehicle_test_seat v_ride_falcon "falcon_g_l") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_l" player3)
									(unit_enter_vehicle_immediate player3 v_ride_falcon "falcon_g_l")
								)
								
								(; condition #2
									(!= (vehicle_test_seat v_ride_falcon0 "falcon_g_l") true)
									;(vehicle_load_magic v_ride_falcon0 "falcon_g_l" player3)
									(unit_enter_vehicle_immediate player3 v_ride_falcon0 "falcon_g_l")
								)
								
								(; condition #3
									(!= (vehicle_test_seat v_ride_falcon "falcon_g_r") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_r" player3)
									(unit_enter_vehicle_immediate player3 v_ride_falcon "falcon_g_r")
								)
								
								(; condition #2
									(!= (vehicle_test_seat v_ride_falcon0 "falcon_g_r") true)
									;(vehicle_load_magic v_ride_falcon "falcon_g_r" player3)
									(unit_enter_vehicle_immediate player3 v_ride_falcon0 "falcon_g_r")
								)
							)
						)
					)
	
				;sleep until all players in falcon
				(and
					(or (= (unit_in_vehicle_type player0 20) true) (not (player_is_in_game player0)))
					(or (= (unit_in_vehicle_type player1 20) true) (not (player_is_in_game player1)))
					(or (= (unit_in_vehicle_type player2 20) true) (not (player_is_in_game player2)))
					(or (= (unit_in_vehicle_type player3 20) true) (not (player_is_in_game player3)))
				)
					
				)
			)
		)
	)
	
	;set ride started
	;(set respawn_players_into_friendly_vehicle true)
	(game_safe_to_respawn false)
	(set b_ride_started true)
	(f_unblip_object (ai_vehicle_get ride_falcon/pilot))
	(f_unblip_object (ai_vehicle_get ride_falcon0/pilot))
	
	;set up soft ceiling/kill volumes
	(soft_ceiling_enable rail_blocker_01 0)
	(kill_volume_disable kill_soft_jetpack0)
	(kill_volume_disable kill_soft_starport0)
	(kill_volume_disable kill_soft_starport1)
	
	(wake allegiance_broken_ride)
	
	;garbage collect
	(nuke_all_covenant)
	(nuke_all_longswords)	
	(thespian_folder_deactivate th_jetpack)
	(garbage_collect_unsafe)

	(object_destroy_folder dm_070)
	(object_destroy_folder dc_070)
	(object_destroy_folder eq_070)
	(object_destroy_folder wp_070)
	;(object_destroy_folder bp_070)
	(object_destroy_folder sc_070)
	(object_destroy_folder cr_070)
	;(object_destroy_folder ve_070)
	
	;send falcons to evac hover
	(sleep (* 30 2))
	(cs_run_command_script ride_falcon/pilot cs_ride_vehicle_route)
	
	(mus_stop mus_10); from ride insertion
	(mus_start mus_07)
	
	(sleep (* 30 3))
	(cs_run_command_script ride_falcon0/pilot cs_ride_vehicle0_route)

	;set up chapter title
	(wake ct_title_act3)

	;start dialogue "we've all got orders...
	(wake md_ride)
	
	;send in pad evac
	(f_ai_place_vehicle_deathless traxus_evac_pelican1)
	
	;finish terrace evac
	;(f_load_troopers_evac0 traxus_evac_pelican0/pilot traxus_evac_pelican0 evac_delay sq_evac0_m0)

;wait for pad evac to finish
; -------------------------------------------------------------------------------------------------
	;(sleep (* 30 15))
	(sleep_until b_evac1_complete)
; -------------------------------------------------------------------------------------------------
	;start dialogue "loaded ready to go...
	(wake md_ride_chatter1)
	
; -------------------------------------------------------------------------------------------------	
;wait for falcons to sync
; -------------------------------------------------------------------------------------------------
(sleep_until
	(and
		b_falcon_evac_hover
		b_falcon0_evac_hover))
; -------------------------------------------------------------------------------------------------
	;send terrace evac
	(cs_run_command_script traxus_evac_pelican0/pilot cs_terminal_pelican0_exit)	
			
	;send falcons to load hover 
	(set b_falcon_goto_load_hover true)
	(set b_falcon0_goto_load_hover true)
	
	;start dialogue "midtowns too hot...
	(sleep (* 30 1))
	(wake md_ride2)

	;send bob
	(if (= s_special_elite 1)
		(begin
			(ai_place special_elite1)
			(sleep 1)
			(ai_disregard (ai_actors special_elite1) true)
		)
	)
					
	;set up rooftop0
	(object_create_folder cr_rooftop)
	(object_create_folder sc_rooftop)
	
	(ai_place ride_rooftop0_inf0)
	(ai_place ride_rooftop0_inf1)
	;(ai_place ride_rooftop0_shade1)
	;(ai_place ride_rooftop0_shade2)
	(ai_place ride_rooftop0_inf2)
	(ai_place ride_rooftop0_inf3)
	(ai_place ride_rooftop0_unsc0)
	(ai_place ride_rooftop0_civ0)
	(ai_place ride_rooftop0_civ1)
	(sleep 1)
	(ai_set_targeting_group gr_rooftop0_cov 1 false)
	(ai_set_targeting_group gr_rooftop0_unsc 1 false)
	(ai_set_targeting_group gr_rooftop0_civilians 1 false)
	(ai_set_targeting_group ride_rooftop0_inf0 1 true)
	(ai_set_targeting_group ride_rooftop0_inf1 1 true)
	;(ai_set_targeting_group ride_rooftop0_shade1 1 true)
	;(ai_set_targeting_group ride_rooftop0_shade2 1 true)
	
	;perf
	(ai_force_low_lod gr_civilian)
		
;wait until terrace evac is in position
; -------------------------------------------------------------------------------------------------
	(sleep_until b_banshee0_start)
; -------------------------------------------------------------------------------------------------
	;send banshee0
	(wake ride_banshee_cleanup)
	(ai_place ride_banshee0)
	(ai_place ride_banshee00)
	(ai_place ride_banshee000)
	(sleep 1)
	(ai_set_targeting_group ride_banshee0 2 false)
	(ai_set_targeting_group ride_banshee00 2 false)
	(ai_set_targeting_group ride_banshee000 2 false)
	(ai_set_targeting_group traxus_evac_pelican0 2 false)

	(ai_set_clump ride_banshee0 14)
	(ai_set_clump ride_banshee00 14)
	(ai_set_clump ride_banshee000 14)
	(ai_designer_clump_perception_range 500)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee0/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee0/spawn_points_0) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee00/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee00/spawn_points_0) g_falcon_vitality 0)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee000/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee000/spawn_points_0) g_falcon_vitality 0)
	
	;start dialogue "banhsees on my tail...
	(wake md_ride_chatter2)
		
	;send pad evac
	(cs_run_command_script traxus_evac_pelican1/pilot cs_terminal_pelican1_exit)
			
;wait until player can see rooftop0
; -------------------------------------------------------------------------------------------------
	(sleep_until b_rooftop0_start)
; -------------------------------------------------------------------------------------------------
	;advance rooftop0
 		;task conditional > (b_rooftop0_start)
	;set up evac rooftop0
	;(f_load_troopers_evac0 traxus_evac_pelican2/pilot traxus_evac_pelican2 evac_delay ride_rooftop0_civ0)

	(nuke_all_unsc)
	
	; flocks
	(flock_stop fl_shared_banshee0)
	(flock_stop fl_shared_falcon0)
	(flock_stop fl_shared_banshee1)
	(flock_stop fl_shared_falcon1)
	(flock_stop fl_corvette_phantom1)

	(flock_create fl_shared_banshee3)
	(flock_create fl_shared_falcon3)


;wait until either falcon is at rooftop0 finish
; -------------------------------------------------------------------------------------------------
(sleep_until b_rooftop0_finish)
; -------------------------------------------------------------------------------------------------

	;(nuke_all_unsc)

	;send first banshee set
	(ai_place ride_banshee01)
	(ai_place ride_banshee02)
	(ai_place ride_banshee03)
	(sleep 1)

	(ai_set_clump ride_banshee01 15)
	(ai_set_clump ride_banshee02 15)
	(ai_set_clump ride_banshee03 15)
	(ai_designer_clump_perception_range 500)
	
	(ai_set_targeting_group ride_banshee01 1 true)
	(ai_set_targeting_group ride_banshee02 1 true)
	(ai_set_targeting_group ride_banshee03 1 true)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee01/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee01/spawn_points_0) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee02/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee02/spawn_points_0) g_falcon_vitality 0)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee03/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee03/spawn_points_0) g_falcon_vitality 0)


	;set up rooftop1
	(ai_place ride_rooftop1_inf0)
	(ai_place ride_rooftop1_inf1)
	(ai_place ride_rooftop1_inf2)
	(ai_place ride_rooftop1_civ1)
	(ai_place ride_rooftop1_civ0)
	(ai_place ride_rooftop1_unsc0)
	
	;perf
	(ai_force_low_lod gr_civilian)

	(sleep 1)
	(ai_set_targeting_group gr_rooftop1_cov 1 false)
	(ai_set_targeting_group gr_rooftop1_unsc 1 false)
	(ai_set_targeting_group gr_rooftop1_civilians 1 false)
	(ai_set_targeting_group ride_rooftop1_inf0 1 false)
	
;wait until falcons are at load hover
; -------------------------------------------------------------------------------------------------
(sleep_until
	(and
		b_falcon_load_hover
		b_falcon0_load_hover))
; -------------------------------------------------------------------------------------------------
	;clean up rooftop0
	(ai_erase ride_rooftop0_inf0)
	(ai_erase ride_rooftop0_inf1)
	(ai_erase ride_rooftop0_inf2)
	(ai_erase ride_rooftop0_inf3)
	(ai_erase ride_rooftop0_unsc0)
	(ai_erase ride_rooftop0_civ0)
	(ai_erase ride_rooftop0_civ1)
	(ai_erase traxus_evac_pelican0)
	(ai_erase traxus_evac_pelican1)
	(ai_erase traxus_evac_pelican2)
	
	;advance rooftop1
	(set b_rooftop1_start true)
	
	;soft ceiling
	(soft_ceiling_enable rail_blocker_02 1)
; -------------------------------------------------------------------------------------------------
;wait for falcons to sync
; -------------------------------------------------------------------------------------------------
(sleep_until
	(and
		b_falcon_load_hover
		b_falcon0_load_hover))
; -------------------------------------------------------------------------------------------------
	;soft ceiling
	(soft_ceiling_enable rail_blocker_03 1)
	(soft_ceiling_enable rail_blocker_04 0)
	
	;begin zone switch
	(prepare_to_switch_to_zone_set set_starport_090)
	
;wait until zone is loaded
; -------------------------------------------------------------------------------------------------
	(sleep (* 30 15));calculate time to load 090		
	(if (editor_mode)
		(switch_zone_set set_starport_090))
	(switch_zone_set set_starport_090)					
	(sleep_until (= (current_zone_set_fully_active) 5))
; -------------------------------------------------------------------------------------------------
	;soft ceiling
	(soft_ceiling_enable rail_blocker_05 0)

	;send falcons to transport start
	(set b_falcon_goto_lz_hover true)
	(set b_falcon0_goto_lz_hover true)
		
	;start starport dialogue	
	(wake md_starport_intro)
		
	;set up shore vehicles
	(ai_place ride_shore_wraith0)
	(ai_place ride_shore_wraith1)
	(ai_place ride_shore_warthog0)
	(sleep (* 30 1))
	(ai_place ride_shore_warthog1)
	(sleep (* 30 1))
	(ai_place ride_shore_warthog2)
	(sleep 1)
	(ai_set_targeting_group ride_shore_wraith0 2 false)
	(ai_set_targeting_group ride_shore_wraith1 2 false)
	(ai_set_targeting_group ride_shore_warthog0 2 false)
	(ai_set_targeting_group ride_shore_warthog1 2 false)
	(ai_set_targeting_group ride_shore_warthog2 2 false)

;*	
	;send dogfight ai
	(ai_place ride_dogfight_cov0)
	(ai_place ride_dogfight_cov1)
	(ai_place ride_dogfight_cov2)
	(sleep 1)
	(ai_set_clump ride_dogfight_cov0 15)
	(ai_set_clump ride_dogfight_cov1 15)
	(ai_set_clump ride_dogfight_cov2 15)
	(ai_designer_clump_perception_range 500)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov0/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov0/spawn_points_0) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov0/spawn_points_1) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov0/spawn_points_1) g_falcon_vitality 0)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov0/spawn_points_2) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov0/spawn_points_2) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov1/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov1/spawn_points_0) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov1/spawn_points_1) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov1/spawn_points_1) g_falcon_vitality 0)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov1/spawn_points_2) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov1/spawn_points_2) g_falcon_vitality 0)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov2/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov2/spawn_points_0) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov2/spawn_points_1) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov0/spawn_points_1) g_falcon_vitality 0)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov2/spawn_points_2) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_dogfight_cov2/spawn_points_2) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_shore_wraith0/pilot) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_shore_wraith0/pilot) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_shore_wraith1/pilot) (* g_falcon_vitality 2) 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_shore_wraith1/pilot) (* g_falcon_vitality 2) 0)
*;

	;flocks
	(flock_stop fl_shared_banshee3)
	(flock_stop fl_shared_falcon3)
	
	(flock_create fl_shared_banshee2)
	(flock_create fl_shared_falcon2)
	(flock_create fl_corvette_phantom2)
		
	;send phantom
	(ai_place ride_phantom0)
	
;wait until player can see rooftop2
; -------------------------------------------------------------------------------------------------
	(sleep_until b_rooftop2_start)
; -------------------------------------------------------------------------------------------------
	;clean up rooftop1
	(ai_erase ride_rooftop1_inf0)
	(ai_erase ride_rooftop1_inf1)
	(ai_erase ride_rooftop1_inf2)
	(ai_erase ride_rooftop1_civ0)
	(ai_erase ride_rooftop1_civ1)
	(ai_erase ride_rooftop1_unsc0)	  
	(object_destroy_folder cr_rooftop)
	(object_destroy_folder sc_rooftop)
	;set up rooftop2

	;advance rooftop2
	;task conditional > (b_rooftop2_start)
	
	;send 2nd set of banshees
	(ai_place ride_banshee04)
	(ai_place ride_banshee05)
	(ai_place ride_banshee06)
	(sleep 1)

	(ai_set_clump ride_banshee04 15)
	(ai_set_clump ride_banshee05 15)
	(ai_set_clump ride_banshee06 15)
	(ai_designer_clump_perception_range 500)
	
	(ai_set_targeting_group ride_banshee04 4 true)
	(ai_set_targeting_group ride_banshee05 4 true)
	(ai_set_targeting_group ride_banshee06 4 true)
	(ai_set_targeting_group ride_falcon 4)
	(ai_set_targeting_group ride_falcon0 4)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee04/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee04/spawn_points_0) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee05/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee05/spawn_points_0) g_falcon_vitality 0)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee06/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee06/spawn_points_0) g_falcon_vitality 0)
	
	;start corvette turrets
	(wake f_corvette_starport)
 
;wait until falcons reach transport start
; -------------------------------------------------------------------------------------------------
(sleep_until
	(or
		b_falcon_transport
		b_falcon0_transport))
; -------------------------------------------------------------------------------------------------
	;soft ceiling
	(soft_ceiling_enable rail_blocker_06 1)
	(soft_ceiling_enable rail_blocker_08 0)
	
	;start transport vignette
	  (wake civilian_transport_takeoff)
	  ;(set transport_finish false)

	;delay event start - now in takeoff script	
	;(set transport_start true)

	;(sleep (* 30 8))
	;send 3rd banshee set
	(ai_place ride_banshee07)
	(ai_place ride_banshee08)
	(ai_place ride_banshee09)	
	(sleep 1)

	(ai_set_clump ride_banshee07 15)
	(ai_set_clump ride_banshee08 15)
	(ai_set_clump ride_banshee09 15)
	(ai_designer_clump_perception_range 500)

	(ai_set_targeting_group ride_banshee07 1 true)
	(ai_set_targeting_group ride_banshee08 1 true)
	(ai_set_targeting_group ride_banshee09 1 true)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee07/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee07/spawn_points_0) g_falcon_vitality 0)

	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee08/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee08/spawn_points_0) g_falcon_vitality 0)
	
	(unit_set_current_vitality (ai_vehicle_get_from_starting_location ride_banshee09/spawn_points_0) g_falcon_vitality 0)
	(unit_set_maximum_vitality (ai_vehicle_get_from_starting_location ride_banshee09/spawn_points_0) g_falcon_vitality 0) 


; -------------------------------------------------------------------------------------------------
(sleep_until
	(or
		b_falcon_park
		b_falcon0_park))
; -------------------------------------------------------------------------------------------------

	;clean up shore
	(ai_erase gr_ride_shore)

; -------------------------------------------------------------------------------------------------
;*
(sleep_until
	(or
		b_falcon_lz_setup
		b_falcon0_lz_setup))
*;
; -------------------------------------------------------------------------------------------------
	;set up lz encounter - starport spawn script waits for above to place lz ai
 
 
;wait until falcons are at lz hover
; -------------------------------------------------------------------------------------------------
; -------------------------------------------------------------------------------------------------
;wait for falcons to sync
; -------------------------------------------------------------------------------------------------
(sleep_until
	(and
		b_falcon_lz_hover
		b_falcon0_lz_hover))
; -------------------------------------------------------------------------------------------------
	;soft ceiling
	(soft_ceiling_enable rail_blocker_07 1)
	
	;flocks
	(flock_delete fl_shared_banshee3)
	(flock_delete fl_shared_falcon3)
	
	;advance lz encounter
	;set up duvall performance
	;(thespian_performance_setup_and_begin starport_intro "" 0)	
	(set b_starport_intro true)
	
	;blip duvaull
	(f_blip_ai starport_unsc_command 5)

;wait until monologue finishes
; -------------------------------------------------------------------------------------------------
	(sleep_until b_starport_monologue)
	(f_unblip_ai starport_unsc_command)
	(ride_banshee789_remove)
; -------------------------------------------------------------------------------------------------
	;send falcons to land
 	(cs_run_command_script ride_falcon/pilot cs_duvall_falcon)
	(cs_run_command_script ride_falcon0/pilot cs_duvall_falcon0) 
	(wake force_unload)
;wait until falcons have unloaded
; -------------------------------------------------------------------------------------------------
(sleep_until
	(and
		b_falcon_unloaded
		b_falcon0_unloaded))
; -------------------------------------------------------------------------------------------------
	;set up soft ceiling/kill volumes
	(kill_volume_enable kill_soft_jetpack0)
	(kill_volume_enable kill_soft_starport0)
	(kill_volume_enable kill_soft_starport1)
	
	;(set respawn_players_into_friendly_vehicle false)
	(game_safe_to_respawn true)
	
	;set ride complete
	(wake md_starport_objectives)
	
	;perf
	(ai_lod_full_detail_actors 20)
	
	;advance lz encounter
	(ai_set_objective ride_passengers obj_starport_unsc)
	(ai_set_objective ride_passengers0 obj_starport_unsc)

	;send falcons to exit	
	(sleep (* 30 3))
	(cs_run_command_script ride_falcon/pilot cs_ride_vehicle_exit)
	(cs_run_command_script test_falcon/pilot cs_ride_vehicle_exit)
	(sleep (* 30 3))
	(cs_run_command_script ride_falcon0/pilot cs_ride_vehicle0_exit)
	(cs_run_command_script test_falcon0/pilot cs_ride_vehicle_exit)
)

(script dormant force_unload
	(sleep (* 30 15))
	(vehicle_unload v_ride_falcon "falcon_p")
	(vehicle_unload v_ride_falcon "falcon_g")
	(vehicle_unload v_ride_falcon0 "falcon_p")
	(vehicle_unload v_ride_falcon0 "falcon_g")

	(set b_falcon_unloaded true)
	(set b_falcon0_unloaded true)
)

(script command_script cs_ride_vehicle_exit
	(cs_enable_pathfinding_failsafe true)
	(cs_ignore_obstacles true)
	
	(cs_vehicle_speed 0.2)
	(cs_fly_to_and_face falcon_exit/p0 falcon_exit/p1 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by falcon_exit/p1 5)
	(cs_fly_by falcon_exit/p2 5)
	(cs_fly_by falcon_exit/p3 5)
	(ai_erase ai_current_actor) 
)

(script command_script cs_ride_vehicle0_exit
	(cs_enable_pathfinding_failsafe true)
	(cs_ignore_obstacles true)
	(sleep (* 30 3))
		
	(cs_vehicle_speed 0.2)
	(cs_fly_to_and_face falcon0_exit/p0 falcon0_exit/p1 1)
	(cs_vehicle_speed 1.0)
	(cs_fly_by falcon0_exit/p1 5)
	(cs_fly_by falcon0_exit/p2 5)
	(cs_fly_by falcon0_exit/p3 5)
	(ai_erase ai_current_actor) 
)

(script command_script cs_terminal_pelican0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)

	;(ai_place sq_evac0_m0)
	
	(cs_fly_by 000_terminal_pelicans/pelican0_enter_p1 5)
	(cs_fly_by 000_terminal_pelicans/pelican0_enter_p2a 5)
	(cs_vehicle_speed 0.8)
			
	(cs_fly_to 000_terminal_pelicans/pelican0_hover 1)
	(cs_fly_to_and_face 000_terminal_pelicans/pelican0_land 000_terminal_pelicans/pelican0_land_facing .25)
	;(sleep (* 30 2))
	;(vehicle_hover (ai_vehicle_get ai_current_actor) true)
	;(unit_open (ai_vehicle_get ai_current_actor))
	;(f_load_troopers_evac1 traxus_evac_pelican0/pilot traxus_evac_pelican0 300 sq_evac0_m0)
)

(script command_script cs_terminal_pelican0_exit
	(unit_close (ai_vehicle_get ai_current_actor))
	(sleep (* 30 0))
	;(ai_erase sq_evac0_m0)
	;(vehicle_hover (ai_vehicle_get ai_current_actor) false)
	(cs_vehicle_speed 0.4)
	(cs_fly_by 000_terminal_pelicans/pelican0_hover 2)
	;(cs_attach_to_spline "spline_pelican0_exit")
	(cs_vehicle_speed 0.6)
	(cs_fly_by 000_terminal_pelicans/pelican0_p1 2)
	(cs_vehicle_speed 0.8)
	(set b_banshee0_start true)
	
	(cs_fly_to 000_terminal_pelicans/pelican0_exit 2)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

(global boolean b_evac1_landed false)
(global short evac_delay (* 30 10))
(script command_script cs_terminal_pelican1
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)
	
	;(ai_place sq_evac1_m1)
	(set g_trophy_civ_desired 10)
	(set g_trophy_civ_current (ai_living_count gr_trophy_civilians));gr_civilian
	(if (< g_trophy_civ_current g_trophy_civ_desired)
		(ai_place sq_evac1_m1 (- g_trophy_civ_desired g_trophy_civ_current)))			
	
	(ai_migrate gr_trophy_civilians sq_evac1_m1);gr_civilian
	(sleep 1)		
	;(unit_set_stance (ai_get_unit sq_evac1_m1) panic)
	
	;perf
	;(ai_force_low_lod gr_civilian)
	(ai_force_full_lod gr_trophy_civilians);force high detail ai for these characters	
	
	(cs_fly_by 000_terminal_pelicans/pelican1_enter_p1)
	(cs_vehicle_speed 0.6)
	(set b_evac1_landed true)
	(cs_fly_to_and_face 000_terminal_pelicans/pelican1_land 000_terminal_pelicans/pelican1_land_facing .25)
	(f_load_troopers_evac1 traxus_evac_pelican1/pilot traxus_evac_pelican1 evac_delay sq_evac1_m1)
)

(script command_script cs_terminal_pelican1_exit	
	(unit_close (ai_vehicle_get ai_current_actor))
	;(ai_erase sq_evac1_m1)
	;(vehicle_hover (ai_vehicle_get ai_current_actor) false)
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 0.4)

	(cs_fly_by 000_terminal_pelicans/pelican1_hover 2)			
	;(cs_attach_to_spline "spline_pelican1_exit")
	(cs_vehicle_speed 1.0)
	(cs_fly_by 000_terminal_pelicans/pelican1_p1 2)			
	(cs_fly_to 000_terminal_pelicans/pelican1_exit 2)
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

(script command_script cs_terminal_pelican2
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1.0)
	
	;(ai_place sq_evac2_m2)
	(cs_fly_by 000_terminal_pelicans/pelican2_enter_p1)
	(cs_fly_by 000_terminal_pelicans/pelican2_enter_p2)
	(cs_vehicle_speed 0.6)
	;(cs_fly_to_and_face 000_terminal_pelicans/pelican2_hover 000_terminal_pelicans/pelican2_land_facing .25)
	(cs_fly_to_and_face 000_terminal_pelicans/pelican2_land 000_terminal_pelicans/pelican2_land_facing .25)
	;(vehicle_hover (ai_vehicle_get ai_current_actor) true)
	;(unit_open (ai_vehicle_get ai_current_actor))
)

(script command_script cs_terminal_pelican2_exit	
	(unit_close (ai_vehicle_get ai_current_actor))
	;(ai_erase sq_evac2_m2)
	;(vehicle_hover (ai_vehicle_get ai_current_actor) false)
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 0.4)

	(cs_fly_by 000_terminal_pelicans/pelican2_hover 2)			
	(cs_attach_to_spline "spline_pelican1_exit")
	(cs_vehicle_speed 1.0)
			
	(cs_fly_to 000_terminal_pelicans/pelican2_exit 2)
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 5))
	(sleep (* 30 5))
	(ai_erase ai_current_squad)
)

(script static void (f_load_troopers_evac0 (ai driver)(ai driver_squad) (short delay) (ai troopers))
	(if (> (ai_living_count troopers) 0)
 		(begin
			;(sleep (* 30 1))
      (unit_open (ai_vehicle_get driver))
      (vehicle_hover (ai_vehicle_get_from_spawn_point driver) true)           
      (sleep (* 30 2))
      (ai_vehicle_enter troopers (ai_vehicle_get_from_spawn_point driver) "pelican_p")
      (sleep_until (= (f_all_squad_in_vehicle troopers driver_squad) true)5 delay)
      ;(sleep delay)
      (vehicle_hover (ai_vehicle_get_from_spawn_point driver) false)
      (unit_close (ai_vehicle_get driver))
      (sleep 30)
			(vehicle_unload (ai_vehicle_get ai_current_actor) "")
			(ai_erase troopers)
     )
   )
)
(global boolean b_evac1_complete false)
(script static void (f_load_troopers_evac1 (ai driver)(ai driver_squad) (short delay) (ai troopers))
	(if (> (ai_living_count troopers) 0)
 		(begin
			;(sleep (* 30 1))
      (unit_open (ai_vehicle_get driver))
      (vehicle_hover (ai_vehicle_get_from_spawn_point driver) true)           
      (sleep (* 30 2))
      (ai_vehicle_enter troopers (ai_vehicle_get_from_spawn_point driver) "pelican_p")
      (set b_evac1_complete true)
      (sleep_until (= (f_all_squad_in_vehicle troopers driver_squad) true)5 delay)
      ;(sleep delay)
      (vehicle_hover (ai_vehicle_get_from_spawn_point driver) false)
      (unit_close (ai_vehicle_get driver))
      (sleep 30)
			(vehicle_unload (ai_vehicle_get ai_current_actor) "")
			(ai_erase troopers)
     )
   ;else
	   (begin
		   (sleep (* 30 2))
		   (set b_evac1_complete true)
	   )
   
   )
)

(script dormant ride_banshee_cleanup
	(sleep_until	b_rooftop0_finish)
	(ai_kill ride_banshee0)
	(ai_kill ride_banshee00)
	(ai_kill ride_banshee000)

	(sleep_until	b_falcon_transport)
	(ai_kill ride_banshee01)
	(ai_kill ride_banshee02)
	(ai_kill ride_banshee03)

	(sleep_until	b_starport_started)
	(ai_kill ride_banshee04)
	(ai_kill ride_banshee05)
	(ai_kill ride_banshee06)

	(sleep_until	b_starport_monologue)
	(ai_kill ride_banshee07)
	(ai_kill ride_banshee08)
	(ai_kill ride_banshee09)
)

(script command_script cs_ride_banshee0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)

	(cs_fly_by pts_ride_banshees_000/enter_01 10)
;*
	(cs_fly_by pts_ride_banshees_000/approach_01 10)
	(cs_fly_by pts_ride_banshees_000/dive_01)
	(cs_fly_by pts_ride_banshees_000/turn_01)
	(cs_fly_by pts_ride_banshees_000/exit_01)

	(if
		(and
			(>= (ai_living_count ride_banshee0) 0)
			(>= (ai_living_count ride_banshee00) 0)
			(>= (ai_living_count ride_banshee000) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_000/split_01)
			(cs_fly_by pts_ride_banshees_000/approach_01)
			(cs_fly_by pts_ride_banshees_000/dive_01)
			(cs_fly_by pts_ride_banshees_000/turn_01)
			(cs_fly_by pts_ride_banshees_000/exit_01)
		)
	)	
	
	(cs_fly_by pts_ride_banshees_000/remove_01)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee00
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)

	(cs_fly_by pts_ride_banshees_000/enter_02 10)
;*
	(cs_fly_by pts_ride_banshees_000/approach_02 10)
	(cs_fly_by pts_ride_banshees_000/dive_02)
	(cs_fly_by pts_ride_banshees_000/turn_02)
	(cs_fly_by pts_ride_banshees_000/exit_02)

	(if
		(and
			(>= (ai_living_count ride_banshee0) 0)
			(>= (ai_living_count ride_banshee00) 0)
			(>= (ai_living_count ride_banshee000) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_000/split_02)
			(cs_fly_by pts_ride_banshees_000/approach_02)
			(cs_fly_by pts_ride_banshees_000/dive_02)
			(cs_fly_by pts_ride_banshees_000/turn_02)
			(cs_fly_by pts_ride_banshees_000/exit_02)
		)
	)	
	
	(cs_fly_by pts_ride_banshees_000/remove_02)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee000
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)

	(cs_fly_by pts_ride_banshees_000/enter_03 10)
;*
	(cs_fly_by pts_ride_banshees_000/approach_03 10)
	(cs_fly_by pts_ride_banshees_000/dive_03)
	(cs_fly_by pts_ride_banshees_000/turn_03)
	(cs_fly_by pts_ride_banshees_000/exit_03)

	(if
		(and
			(>= (ai_living_count ride_banshee0) 0)
			(>= (ai_living_count ride_banshee00) 0)
			(>= (ai_living_count ride_banshee000) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_000/split_03)
			(cs_fly_by pts_ride_banshees_000/approach_03)
			(cs_fly_by pts_ride_banshees_000/dive_03)
			(cs_fly_by pts_ride_banshees_000/turn_03)
			(cs_fly_by pts_ride_banshees_000/exit_03)
		)
	)	
	
	(cs_fly_by pts_ride_banshees_000/remove_03)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(global boolean b_banshee_attack false)
;*
	(if (> game_coop_player_count 2)
		(set b_banshee_attack true)
	)

	(if b_banshee_attack
		(ai_set_blind ai_current_actor false)
	)

	(if (not b_banshee_attack)
		(ai_set_blind ai_current_actor true)
	)
*;

(script command_script cs_ride_banshee01
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_123/enter_01 10)
	(cs_fly_by pts_ride_banshees_123/approach_01)
	(cs_fly_by pts_ride_banshees_123/dive_01)
;*
	;(cs_vehicle_boost false)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_ride_banshees_123/turn_01)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_123/exit_01)
	(cs_fly_by pts_ride_banshees_123/remove_01)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee02
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_123/enter_02 10)
	(cs_fly_by pts_ride_banshees_123/approach_02)
	(cs_fly_by pts_ride_banshees_123/dive_02)
	;(cs_vehicle_boost false)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_ride_banshees_123/turn_02)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_123/exit_02)
	
	(if
		(or
			(>= (ai_living_count ride_banshee01) 0)
			(>= (ai_living_count ride_banshee02) 0)
			(>= (ai_living_count ride_banshee03) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_123/split_02)
));*
			(cs_vehicle_boost true)	
			;(cs_fly_by pts_ride_banshees_123/approach_02)
			(cs_fly_by pts_ride_banshees_123/dive_02)
			;(cs_vehicle_boost false)
			(cs_vehicle_speed .9)    
			(cs_fly_by pts_ride_banshees_123/turn_02)
			(cs_vehicle_boost true)
			(cs_fly_by pts_ride_banshees_123/exit_02)
		)
	)
	
	(cs_fly_by pts_ride_banshees_123/remove_02)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee03
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_123/enter_03 10)
	(cs_fly_by pts_ride_banshees_123/approach_03)
	(cs_fly_by pts_ride_banshees_123/dive_03)
	;(cs_vehicle_boost false)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_ride_banshees_123/turn_03)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_123/exit_03)
	
	(if
		(or
			(>= (ai_living_count ride_banshee01) 0)
			(>= (ai_living_count ride_banshee02) 0)
			(>= (ai_living_count ride_banshee03) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_123/split_03)
));*
			(cs_vehicle_boost true)
			;(cs_fly_by pts_ride_banshees_123/approach_03)
			(cs_fly_by pts_ride_banshees_123/dive_03)
			;(cs_vehicle_boost false)
			(cs_vehicle_speed .9)    
			(cs_fly_by pts_ride_banshees_123/turn_03)
			(cs_vehicle_boost true)
			(cs_fly_by pts_ride_banshees_123/exit_03)
		)
	)
	
	(cs_fly_by pts_ride_banshees_123/remove_03)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee123_swarm1
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	;(cs_fly_by pts_ride_banshees_123/turn_01 10)
	;(cs_fly_by pts_ride_banshees_123/exit_01 10)
	(cs_fly_by pts_ride_banshees_123/swarm1 10)
)

(script command_script cs_ride_banshee123_swarm2
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_123/exit_01 10)
	(cs_fly_by pts_ride_banshees_123/swarm2 10)
)

(script static void ride_banshee123_remove
	(cs_run_command_script ride_banshee01 cs_ride_banshee123_remove)
	(cs_run_command_script ride_banshee02 cs_ride_banshee123_remove)
	(cs_run_command_script ride_banshee03 cs_ride_banshee123_remove)
)

(script command_script cs_ride_banshee123_remove
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_123/remove_01 10)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
)

(script command_script cs_ride_banshee04
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/enter_01 10)
	(cs_fly_by pts_ride_banshees_456/approach_01 10)
	(cs_fly_by pts_ride_banshees_456/dive_01)
;*
	;(cs_vehicle_boost false)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_ride_banshees_456/turn_01)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/exit_01)
	(cs_fly_by pts_ride_banshees_456/remove_01)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee05
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/enter_02 10)
	(cs_fly_by pts_ride_banshees_456/approach_02 10)
	(cs_fly_by pts_ride_banshees_456/dive_02)
;*
	;(cs_vehicle_boost false)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_ride_banshees_456/turn_02)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/exit_02)
	
	(if
		(or
			(>= (ai_living_count ride_banshee04) 0)
			(>= (ai_living_count ride_banshee05) 0)
			(>= (ai_living_count ride_banshee06) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_456/split_02)
			(cs_vehicle_boost true)
			;(cs_fly_by pts_ride_banshees_456/approach_02)
			(cs_fly_by pts_ride_banshees_456/dive_02)
			;(cs_vehicle_boost false)
			(cs_vehicle_speed .9)    
			(cs_fly_by pts_ride_banshees_456/turn_02)
			(cs_vehicle_boost true)
			(cs_fly_by pts_ride_banshees_456/exit_02)
		)
	)
	
	(cs_fly_by pts_ride_banshees_456/remove_02)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee06
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/enter_03 10)
	(cs_fly_by pts_ride_banshees_456/approach_03 10)
	(cs_fly_by pts_ride_banshees_456/dive_03)
;*	
	;(cs_vehicle_boost false)
	(cs_vehicle_speed .9)    
	(cs_fly_by pts_ride_banshees_456/turn_03)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/exit_03)
	
	(if
		(or
			(>= (ai_living_count ride_banshee04) 0)
			(>= (ai_living_count ride_banshee05) 0)
			(>= (ai_living_count ride_banshee06) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_456/split_03)
			(cs_vehicle_boost true)
			;(cs_fly_by pts_ride_banshees_456/approach_03)
			(cs_fly_by pts_ride_banshees_456/dive_03)
			;(cs_vehicle_boost false)
			(cs_vehicle_speed .9)    
			(cs_fly_by pts_ride_banshees_456/turn_03)
			(cs_vehicle_boost true)
			(cs_fly_by pts_ride_banshees_456/exit_03)
		)
	)
	
	(cs_fly_by pts_ride_banshees_456/remove_03)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)


(script command_script cs_ride_banshee456_swarm1
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/enter_01 10)
	(cs_fly_by pts_ride_banshees_456/approach_01 10)
	(cs_fly_by pts_ride_banshees_456/swarm1 10)
)

(script command_script cs_ride_banshee456_swarm2
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/turn_01 10)
	(cs_fly_by pts_ride_banshees_456/exit_01 10)
	(cs_fly_by pts_ride_banshees_456/split_01 10)
	(cs_fly_by pts_ride_banshees_456/swarm2 10)
)

(script static void ride_banshee456_remove
	(cs_run_command_script ride_banshee04 cs_ride_banshee456_remove)
	(cs_run_command_script ride_banshee05 cs_ride_banshee456_remove)
	(cs_run_command_script ride_banshee06 cs_ride_banshee456_remove)
)

(script command_script cs_ride_banshee456_remove
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_456/remove_01 10)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
)

(script command_script cs_ride_banshee07
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/enter_01)
	(cs_fly_by pts_ride_banshees_789/approach_01)
	(cs_fly_by pts_ride_banshees_789/dive_01)
	(cs_fly_by pts_ride_banshees_789/swarm1)
;*
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/exit_01)

	(if
		(or
			(>= (ai_living_count ride_banshee07) 0)
			(>= (ai_living_count ride_banshee08) 0)
			(>= (ai_living_count ride_banshee09) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_789/split_01)
			;(cs_fly_by pts_ride_banshees_456/approach_01)
			;(cs_fly_by pts_ride_banshees_789/dive_01)
			(cs_fly_by pts_ride_banshees_789/turn_01)
			(cs_fly_by pts_ride_banshees_789/exit_01)
		)
	)
	
	(cs_fly_by pts_ride_banshees_789/remove_01)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee08
;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/enter_01)
	(cs_fly_by pts_ride_banshees_789/approach_01)
	(cs_fly_by pts_ride_banshees_789/dive_01)
	(cs_fly_by pts_ride_banshees_789/swarm1)
;*
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/exit_01)

	(if
		(or
			(>= (ai_living_count ride_banshee07) 0)
			(>= (ai_living_count ride_banshee08) 0)
			(>= (ai_living_count ride_banshee09) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_789/split_01)
			;(cs_fly_by pts_ride_banshees_456/approach_01)
			;(cs_fly_by pts_ride_banshees_789/dive_01)
			(cs_fly_by pts_ride_banshees_789/turn_01)
			(cs_fly_by pts_ride_banshees_789/exit_01)
		)
	)
	
	(cs_fly_by pts_ride_banshees_789/remove_01)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee09
;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	                
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/enter_01)
	(cs_fly_by pts_ride_banshees_789/approach_01)
	(cs_fly_by pts_ride_banshees_789/dive_01)
	(cs_fly_by pts_ride_banshees_789/swarm1)
;*
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/exit_01)

	(if
		(or
			(>= (ai_living_count ride_banshee07) 0)
			(>= (ai_living_count ride_banshee08) 0)
			(>= (ai_living_count ride_banshee09) 0)
			;(>= objcon_ride 50)
		)
			
		(begin
			(cs_fly_by pts_ride_banshees_789/split_01)
			;(cs_fly_by pts_ride_banshees_456/approach_01)
			;(cs_fly_by pts_ride_banshees_789/dive_01)
			(cs_fly_by pts_ride_banshees_789/turn_01)
			(cs_fly_by pts_ride_banshees_789/exit_01)
		)
	)
	
	(cs_fly_by pts_ride_banshees_789/remove_01)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_ride_banshee789_swarm1
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/swarm1 10)
)

(script command_script cs_ride_banshee789_swarm2
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/swarm2 10)
)

(script command_script cs_ride_banshee789_swarm3
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/swarm3 10)
)

(script static void ride_banshee789_remove
	(cs_run_command_script ride_banshee07 cs_ride_banshee789_remove)
	(cs_run_command_script ride_banshee08 cs_ride_banshee789_remove)
	(cs_run_command_script ride_banshee09 cs_ride_banshee789_remove)
)

(script command_script cs_ride_banshee789_remove
	(cs_vehicle_boost true)
	(cs_fly_by pts_ride_banshees_789/remove_01 10)

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 2.5))
	(sleep (* 30 2.5))	
	(ai_erase ai_current_squad)
)

(script command_script cs_ride_phantom0_route
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	
  (cs_vehicle_speed 0.8)
	(cs_fly_by phantom0_ride/p0 5)
	(cs_vehicle_speed 0.4)
	(cs_fly_by phantom0_ride/p1 5)
	;(cs_fly_to_and_face phantom0_ride/p1 phantom0_ride/tower_facing1 5)
	(cs_fly_by phantom0_ride/p2 5)
	;(cs_fly_to_and_face phantom0_ride/p2 phantom0_ride/p3 5)
	(cs_fly_by phantom0_ride/p3 5)
	(cs_fly_by phantom0_ride/p4 5)
	;(sleep 350)
	(ai_erase ai_current_squad)
)

(script command_script cs_ride_falcon1
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_boost true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_shoot true)

  (cs_vehicle_speed 0.3)
  
  (cs_fly_by falcon1_ride/p0 5)  
  (cs_fly_by falcon1_ride/p1 5)

	(ai_erase ai_current_squad)
)

(script command_script cs_ride_falcon2
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_boost true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_shoot true)
  (cs_vehicle_speed 1.0)
  
  (cs_fly_by falcon2_ride/p0 5)  
  (cs_fly_by falcon2_ride/p1 5)

	(ai_erase ai_current_squad)
)

;*
(script command_script cs_ride_fork0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
  (cs_vehicle_speed_instantaneous 1.0)
  
  (cs_fly_by pts_ride_fork/enter 5)  
  (cs_vehicle_boost false)
  (cs_vehicle_speed 0.4)
  (cs_fly_to_and_face pts_ride_fork/hover pts_ride_fork/hover_facing 5)  
  (sleep (* 30 5))
  (cs_vehicle_boost true)
  (cs_vehicle_speed 1.0)
  (cs_fly_by pts_ride_fork/exit 5)

	(ai_erase ai_current_squad)
)
*;
;*
(script dormant ride_longsword_01
	(object_create ls_ride_01)
	(sleep 60)
	(ls_flyby ls_ride_01)
	(sleep 10)
	(ls_flyby_sound)
	(ls_flyby_delay)
)

(script dormant ride_longsword_02
	(object_create ls_ride_02)
	(sleep 60)
	(ls_flyby ls_ride_02)
	(sleep 10)
	(ls_flyby_sound)
	(ls_flyby_delay)
)

(script dormant ride_longsword_03
	(object_create ls_ride_03)
	
	(ls_flyby ls_ride_03)
	(sleep 10)
	(ls_flyby_sound)
	(ls_flyby_delay)
)

(script dormant ride_longsword_04
	(object_create ls_ride_04)
	
	(ls_flyby ls_ride_04)
	(sleep 10)
	(ls_flyby_sound)
	(ls_flyby_delay)
)
*;



; =================================================================================================
; starport
; =================================================================================================
(global boolean b_starport_started false)
(global boolean b_starport_turret1_ready false)
(global boolean b_starport_turret0_ready false)
(global boolean b_starport_defenses_fired false)
(global boolean b_starport_music_start false)
(global boolean b_starport_music_alt false)
(global boolean b_starport_music_stop false)
(global boolean b_starport_monologue false)
(global vehicle v_starport_falcon0 none)
(global vehicle v_starport_falcon1 none)
(global boolean b_players_all_on_foot false)
(global boolean b_players_any_in_vehicle false)
(global short g_starport_unsc_current -1)
(global short g_starport_unsc_desired 8)
(global short g_starport_cov_current -1)
(global short g_starport_cov_desired 12)
(global boolean g_skimishers_loaded false)
;(global boolean b_players_driving false)
; -------------------------------------------------------------------------------------------------
(script dormant starport_objective_control
	(if debug (print "encounter start: starport"))
	(set b_starport_started true)
	(game_save)	
	(set objcon_starport 0)
	
	; objectives
	;(ai_set_objective fireteam_player0 obj_starport_unsc)
	
	
	(if debug (print "cleaning up ride..."))
	;(ai_disposable gr_ride_shore true)
			
	; flocks
		
	; scripts
	(wake f_starport_fx_ambient)
	;(wake fx_corvette_2)
	;(wake fx_corvette_3)
	(wake starport_spawn_control)
	(wake starport_ghosts_spawn_control)
	(wake starport_chief_spawn_control)
	(wake starport_turret0_control)
	(wake starport_turret1_control)
	(wake starport_firing_control)
	(wake starport_wraith0_firing_control)
	;(wake starport_wraith1_firing_control)
	(wake starport_pelican0_control)
	(wake starport_pelican1_control)
	(wake starport_wraith0_save_control)
	(wake starport_wraith1_save_control)
	(wake f_player_on_foot)
	(wake starport_waypoint)
	(wake starport_bob)
	
	; mission dialogue
	;(wake md_starport_objectives)
	(wake md_starport_complete)
	
	; music
	;(wake mus_starport_master)
	; scripts
	;(wake starport_wraith0_firing_control)

	
	(sleep_until (volume_test_players tv_objcon_starport_010) 1)
		(if debug (print "objective control: starport 010"))
		(set objcon_starport 10)
;*
		(ai_cannot_die starport_cov_inf0 false)
		(ai_cannot_die starport_cov_inf1 false)
		(ai_cannot_die gr_starport_unsc_initial false)
*;
		(ai_enter_squad_vehicles gr_starport_unsc_initial)
		
	(sleep_until (volume_test_players tv_objcon_starport_020) 1)
		(if debug (print "objective control: starport 020"))
		(set objcon_starport 20)
		(game_save)
		
	(sleep_until (volume_test_players tv_objcon_starport_030) 1)
		(if debug (print "objective control: starport 030"))
		(set objcon_starport 30)

	(sleep_until (volume_test_players tv_objcon_starport_040) 1)
		(if debug (print "objective control: starport 040"))
		(set objcon_starport 40)

		;(ai_cannot_die starport_unsc_mars1 false)
		(ai_place starport_unsc_mars1)
		(ai_place starport_unsc_mong1)
		
	(sleep_until (and b_starport_turret0_ready b_starport_turret1_ready))
	;(cinematic_set_title ct_objective_fire_missiles)
	(game_save)

	(sleep_until b_starport_defenses_fired)
	(sleep 1)

	(cinematic_enter 050lb_reunited false)

	;(sleep_until b_md_is_playing)
	(sleep objective_delay)
	;kill flocks
	(flock_delete fl_shared_banshee2)
	(flock_delete fl_shared_falcon2)
	(flock_delete fl_corvette_phantom2)

	;cleanup
	(ai_erase gr_cov)
	(ai_erase gr_unsc)
	(garbage_collect_now)
		
	(cin_outro)
	(game_won)
)

;*
(script dormant mus_starport_master
	(sleep_until b_starport_music_start 1)
	(sound_looping_start mus_starport none 1)
	
	(sleep_until (and b_starport_turret0_ready b_starport_turret1_ready))
	(sound_looping_set_alternate mus_starport true)
	
	(sleep_until b_starport_defenses_fired)
	(sound_looping_stop mus_starport)
)
*;

(script dormant starport_pelican0_control
	(sleep_until (volume_test_players tv_md_starport_battery0))
	(f_ai_place_vehicle_deathless_no_emp starport_unsc_m0_pelican)
	;(ai_place starport_unsc_m0_pelican)

	(sleep_until b_starport_turret0_ready)
	(cs_run_command_script starport_unsc_m0_pelican/pilot cs_starport_m0_pelican_land)		
)

(script dormant starport_pelican1_control
	(sleep_until (volume_test_players tv_md_starport_battery1))
	(f_ai_place_vehicle_deathless_no_emp starport_unsc_m1_pelican)
	;(ai_place starport_unsc_m1_pelican)
	
	(sleep_until b_starport_turret1_ready)
	(cs_run_command_script starport_unsc_m1_pelican/pilot cs_starport_m1_pelican_land)		
)

(script dormant starport_spawn_control
	;perf
	(sleep_until
		(or
			b_falcon_lz_setup
			b_falcon0_lz_setup
		)
	)

	;place unsc
	(ai_place starport_unsc_mars0)
	(ai_place starport_unsc_hog0)
	(ai_place starport_unsc_hog1)
	(ai_place starport_unsc_mong0)
	
	;(ai_place starport_unsc_mars1)
	;(ai_place starport_unsc_mong1)
	
	(ai_place starport_unsc_command)
	(sleep 1)
	(thespian_performance_setup_and_begin starport_intro "" 0)
	
	;place covenant
	(ai_place starport_cov_inf0)
	(ai_place starport_cov_inf1)
	(sleep 1)
	
	
	(ai_disregard (ai_actors starport_unsc_command) true)

	(ai_disregard (players) true)
	(ai_disregard (ai_actors ride_falcon) true)
	(ai_disregard (ai_actors ride_falcon0) true)


	(ai_cannot_die starport_unsc_command true)

	(sleep_until b_starport_monologue)	
	
	(ai_disregard (ai_actors starport_unsc_command) false)
	(ai_disregard (players) false)
	(ai_disregard (ai_actors ride_falcon) false)
	(ai_disregard (ai_actors ride_falcon0) false)
	(ai_disregard (ai_actors ride_passengers) false)
	(ai_disregard (ai_actors ride_passengers0) false)
	(ai_disregard (ai_actors gr_unsc) false)

	(ai_set_targeting_group ride_passengers -1 true)
	(ai_set_targeting_group ride_passengers0 -1 true)
			
	(ai_place starport_cov_bridge_inf0)
	;(ai_place starport_cov_snipers_inf0)
	;(ai_place starport_cov_snipers_inf1)
	;(ai_place starport_cov_terminal_inf0)
	(wake starport_wraith1_firing_control)
			
	(ai_place starport_cov_mis0_inf0)
	(ai_place starport_cov_mis0_inf1)
	
	(ai_place starport_cov_mis1_inf0)
	(ai_place starport_cov_mis1_inf1)
	
	(ai_place starport_cov_glass_inf0)

	;(ai_place starport_cov_terminal_chief0)
	;(ai_place starport_cov_terminal_chief1)
	
	(sleep_until (and b_starport_turret0_ready b_starport_turret1_ready))
	
	(f_ai_place_vehicle_deathless starport_phantom0)	
	(ai_place starport_cov_terminal_inf0)
	(ai_place starport_cov_terminal_inf1)

	;(ai_place starport_cov_terminal_chief0)
	;(ai_place starport_cov_terminal_chief1)
)
(script dormant starport_chief_spawn_control
	(sleep_until 
		(or
			(and b_starport_turret0_ready b_starport_turret1_ready)
			(volume_test_players tv_md_starport_terminal)
		)
	)

	(ai_place starport_cov_terminal_chief0)
	(ai_place starport_cov_terminal_chief1)
)


; -------------------------------------------------------------------------------------------------
(script dormant starport_ghosts_spawn_control
	(sleep_until (>= objcon_starport 1))
	(sleep (random_range 150 180))
	
	(ai_place starport_cov_ghost0)
	(ai_place starport_cov_ghost1)	
	
	(sleep 1)
	(wake ghost0_reserve)
	(wake ghost1_reserve)
	
	(sleep_until 
		(and
			(<= (ai_task_count obj_starport_cov_vehicles/gate_ghosts) 0)
			b_starport_turret0_ready
			b_starport_turret1_ready
		)
	)

	(sleep (random_range 90 180))
	(if (< (random_range 0 100) 50)
		(ai_place starport_cov_ghosts_ds0)
		(ai_place starport_cov_ghosts_ds1))
	
	(wake ghost2_reserve)
	(wake ghost3_reserve)
	
;*	
	(sleep_until 
		(begin
			(sleep_until (<= (ai_task_count obj_starport_cov_vehicles/gate_ghosts) 0))
			(if (< (random_range 0 100) 50)
				(ai_place starport_cov_ghosts_ds0)
				(ai_place starport_cov_ghosts_ds1)
			)
			(sleep 90)
		false)
	)
*;
	
)


(script dormant ghost0_reserve
	;wait for a ghost to not have a driver
	(sleep_until 
			(not (vehicle_test_seat (ai_vehicle_get starport_cov_ghost0/pilot) "ghost_d"))
	)

	;reserve seat
	(ai_vehicle_reserve (ai_vehicle_get_from_spawn_point starport_cov_ghost0/pilot) true)
)

(script dormant ghost1_reserve
	;wait for a ghost to not have a driver
	(sleep_until 
			(not (vehicle_test_seat (ai_vehicle_get starport_cov_ghost1/pilot) "ghost_d"))
	)

	;reserve seat
	(ai_vehicle_reserve (ai_vehicle_get_from_spawn_point starport_cov_ghost1/pilot) true)
)

(script dormant ghost2_reserve
	;wait for a ghost to not have a driver
	(sleep_until 
			(not (vehicle_test_seat (ai_vehicle_get starport_cov_ghost2/pilot) "ghost_d"))
	)

	;reserve seat
	(ai_vehicle_reserve (ai_vehicle_get_from_spawn_point starport_cov_ghost2/pilot) true)
)

(script dormant ghost3_reserve
	;wait for a ghost to not have a driver
	(sleep_until 
			(not (vehicle_test_seat (ai_vehicle_get starport_cov_ghost3/pilot) "ghost_d"))
	)

	;reserve seat
	(ai_vehicle_reserve (ai_vehicle_get_from_spawn_point starport_cov_ghost3/pilot) true)
)

(script command_script cs_starport_ghosts_dropship0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	;(cs_vehicle_boost false)
	(cs_vehicle_speed 1)
		
	; place everyone
	(ai_place starport_cov_ghost2)
	(ai_place starport_cov_ghost3)
	(sleep 1)

	(vehicle_load_magic (ai_vehicle_get_from_starting_location starport_cov_ghosts_ds0/pilot) "fork_sc" (ai_vehicle_get_from_starting_location starport_cov_ghost2/pilot))
	(vehicle_load_magic (ai_vehicle_get_from_starting_location starport_cov_ghosts_ds0/pilot) "fork_sc" (ai_vehicle_get_from_starting_location starport_cov_ghost3/pilot))
		
	(cs_fly_by starport_ghosts_dropship0/entry1)
	(cs_fly_by starport_ghosts_dropship0/entry0)
	(cs_fly_to starport_ghosts_dropship0/hover 5)
	(sleep 30)

	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face starport_ghosts_dropship0/land starport_ghosts_dropship0/land_facing 1)
	(sleep 10)
	
	(vehicle_unload (ai_vehicle_get_from_starting_location starport_cov_ghosts_ds0/pilot) "fork_sc")
	(sleep 30)
	
	(cs_fly_to_and_face starport_ghosts_dropship0/hover starport_ghosts_dropship0/land_facing 0.25)
	(cs_vehicle_speed 1)
	(cs_fly_by starport_ghosts_dropship0/exit0)
	(cs_fly_by starport_ghosts_dropship0/exit1)
	(cs_fly_by starport_ghosts_dropship0/exit2)
	(cs_fly_by starport_ghosts_dropship0/erase)	
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(ai_erase ai_current_squad)	
)

(script command_script cs_starport_ghosts_dropship1
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 1)
	
	; place everyone
	(ai_place starport_cov_ghost2)
	(ai_place starport_cov_ghost3)
	(sleep 1)

	(vehicle_load_magic (ai_vehicle_get_from_starting_location starport_cov_ghosts_ds1/pilot) "fork_sc" (ai_vehicle_get_from_starting_location starport_cov_ghost2/pilot))
	(vehicle_load_magic (ai_vehicle_get_from_starting_location starport_cov_ghosts_ds1/pilot) "fork_sc" (ai_vehicle_get_from_starting_location starport_cov_ghost3/pilot))
	
	(cs_fly_by starport_ghosts_dropship1/entry1)
	(cs_fly_by starport_ghosts_dropship1/entry0)
	(cs_fly_to starport_ghosts_dropship1/hover 5)
	(sleep 30)
	
	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face starport_ghosts_dropship1/land starport_ghosts_dropship1/land_facing 0.25)
	(sleep 10)

	(vehicle_unload (ai_vehicle_get_from_starting_location starport_cov_ghosts_ds1/pilot) "fork_sc")
	(sleep 30)

	(cs_fly_to_and_face starport_ghosts_dropship1/hover starport_ghosts_dropship1/land_facing 0.25)
	(cs_vehicle_speed 1)
	(cs_fly_by starport_ghosts_dropship1/exit0)
	(cs_fly_by starport_ghosts_dropship1/exit1)
	(cs_fly_by starport_ghosts_dropship1/exit2)
	(cs_fly_by starport_ghosts_dropship1/erase)	

	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))	
	(ai_erase ai_current_squad)	
)

(script dormant starport_wraith0_save_control
	(sleep_until (f_ai_is_defeated starport_cov_wraith0))
	(game_save_no_timeout)
)

(script dormant starport_wraith1_save_control
	(sleep_until (f_ai_is_defeated starport_cov_wraith1))
	(game_save_no_timeout)
)


(script command_script cs_starport_phantom0
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_boost true)
	(cs_vehicle_speed 1)
	(cs_ignore_obstacles true)
	
	(f_load_fork (ai_vehicle_get ai_current_actor)	"right" starport_cov_phantom0_inf0 none none none)

	;perf
	(set g_starport_cov_current (ai_task_count obj_starport_cov/gate_main))
	(if (< g_starport_cov_current g_starport_cov_desired)
		(begin
			(f_load_fork (ai_vehicle_get ai_current_actor)	"left" starport_cov_phantom0_inf1 none none none)
			(set g_skimishers_loaded true)
		)
	)
		
	(cs_fly_by starport_ph0/entry2)
	(cs_fly_by starport_ph0/entry1)
	(cs_vehicle_boost false)
	(cs_fly_by starport_ph0/entry0)
	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face starport_ph0/hover starport_ph0/hover_facing 1)
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face starport_ph0/land starport_ph0/land_facing .25)
	
	;(f_unload_fork_all (ai_vehicle_get ai_current_actor))
	(f_unload_fork (ai_vehicle_get ai_current_actor) "right")

	;perf
	(if g_skimishers_loaded			
		(f_unload_fork (ai_vehicle_get ai_current_actor) "left"))
	(sleep 90)
	
	(cs_fly_to_and_face starport_ph0/hover starport_ph0/hover_facing 1)
	(cs_vehicle_speed 1)
	(cs_fly_by starport_ph0/exit)
	(cs_fly_by starport_ph0/exit0)
	(cs_fly_by starport_ph0/exit1)
	(cs_fly_by starport_ph0/erase)
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))	
	(ai_erase ai_current_squad)
)

; -------------------------------------------------------------------------------------------------
(script dormant starport_wraith0_firing_control
	(ai_place starport_cov_wraith0)
	(sleep 1)
	(cs_run_command_script starport_cov_wraith0/pilot cs_starport_wraith0_fire_starport)
	
	(sleep_until 
		(or 
			(<= (object_get_health (ai_vehicle_get starport_cov_wraith0/pilot)) 0.9)
			(and
				(<= (ai_living_count starport_cov_inf0) 1)
				(<= (ai_living_count starport_cov_inf1) 1)
			)
		)
	)

	;(sleep 150)
	(cs_run_command_script starport_cov_wraith0/pilot cs_starport_wraith0_fire_shore)
	
	(sleep_until (>= objcon_starport 30))
	(sleep 150)
	(cs_run_command_script starport_cov_wraith0/pilot cs_exit)
)

(script command_script cs_starport_wraith0_fire_starport
	(sleep_until
		(begin
			(cs_go_to 090_wraiths/wraith0_starport_fp)
			(begin_random
				(begin 
					(cs_shoot_point true 090_wraiths/wraith0_target0)
					(sleep (random_range 90 150)))
				(begin 
					(cs_shoot_point true 090_wraiths/wraith0_target1)
					(sleep (random_range 90 150)))
				(begin 
					(cs_shoot_point true 090_wraiths/wraith0_target2)
					(sleep (random_range 90 150)))
			)
		false
		)
	)
)

(script command_script cs_starport_wraith0_fire_shore
	(cs_shoot_point true 090_wraiths/p7)
	(sleep (random_range 90 150))
	(cs_shoot_point true 090_wraiths/p8)
	(sleep (random_range 90 150))
	
	(sleep_until
		(begin
			(cs_go_to 090_wraiths/wraith0_shore_fp)
			(begin_random
				(begin 
					(cs_shoot_point true 090_wraiths/p0)
					(sleep (random_range 90 150)))
				(begin 
					(cs_shoot_point true 090_wraiths/p1)
					(sleep (random_range 90 150)))
				(begin 
					(cs_shoot_point true 090_wraiths/p2)
					(sleep (random_range 90 150)))
			)
		false
		)
	)
)

(script command_script cs_starport_wraith0_fire_mound
	(cs_shoot_point true 090_wraiths/p6)
	(sleep (random_range 90 150))
	
	(cs_shoot_point true 090_wraiths/p6)
	(sleep (random_range 90 150))
	
	(sleep_until
		(begin
			(begin_random
				(begin 
					(cs_shoot_point true 090_wraiths/p4)
					(sleep (random_range 90 150)))
				(begin 
					(cs_shoot_point true 090_wraiths/p5)
					(sleep (random_range 90 150)))
				(begin 
					(cs_shoot_point true 090_wraiths/p6)
					(sleep (random_range 90 150)))
			)
		false
		)
	)
)
; -------------------------------------------------------------------------------------------------
(script dormant starport_wraith1_firing_control
	(ai_place starport_cov_wraith1)
	(cs_run_command_script starport_cov_wraith1/pilot cs_starport_wraith1_fire)
	
	(sleep_until (>= objcon_starport 30))
	(sleep 150)
	(cs_run_command_script starport_cov_wraith1/pilot cs_exit)
)

(script command_script cs_starport_wraith1_fire
	(sleep_until
		(begin
			(cs_go_to 090_wraiths/wraith1_starport_fp)
			(begin_random
				(begin 
					(cs_shoot_point true 090_wraiths/wraith1_target0)
					(sleep (random_range 90 150)))
				(begin 
					(cs_shoot_point true 090_wraiths/wraith1_target1)
					(sleep (random_range 90 150)))
				(begin 
					(cs_shoot_point true 090_wraiths/wraith1_target2)
					(sleep (random_range 90 150)))
			)
		false
		)
	)
)


(script static void starport_load_m0_falcon ; "falcon_g_r"
	; load falcon passengers, disable interaction
	(vehicle_set_player_interaction v_starport_falcon0 "falcon_d" false false)
	(vehicle_set_player_interaction v_starport_falcon0 "falcon_p_bench" false false)
	(vehicle_set_player_interaction v_starport_falcon0 "falcon_b_d" false false)
	(vehicle_set_player_interaction v_starport_falcon0 "falcon_p_r1" false false)
	(vehicle_set_player_interaction v_starport_falcon0 "falcon_p_r2" false false)
	(vehicle_set_player_interaction v_starport_falcon0 "falcon_p_l1" false false)
	(vehicle_set_player_interaction v_starport_falcon0 "falcon_p_l2" false false)

	(ai_vehicle_reserve_seat v_starport_falcon0 "falcon_p_l1" true)
	(ai_vehicle_reserve_seat v_starport_falcon0 "falcon_p_l2" true)
	(ai_vehicle_reserve_seat v_starport_falcon0 "falcon_p_r1" true)
	(ai_vehicle_reserve_seat v_starport_falcon0 "falcon_p_r2" true)
	(ai_vehicle_reserve_seat v_starport_falcon0 "falcon_g_r" true)
	(ai_vehicle_reserve_seat v_starport_falcon0 "falcon_g_l" true)
	
	;perf
	(if (game_is_cooperative)
			(set g_starport_unsc_desired 6));(- g_starport_unsc_desired 2)
	
	(set g_starport_unsc_current (ai_task_count obj_starport_unsc/gate_main))
	(if (< g_starport_unsc_current g_starport_unsc_desired)
		(begin
			(if debug (print "loading passenger_left_1"))
			(ai_place starport_unsc_m0_inf0/passenger0)
			(sleep 10)
			(vehicle_load_magic v_starport_falcon0 "falcon_p_l1" (ai_get_object starport_unsc_m0_inf0/passenger0))
		
			(if debug (print "loading passenger_right_1"))
			(ai_place starport_unsc_m0_inf0/passenger2)
			(sleep 10)
			(vehicle_load_magic v_starport_falcon0 "falcon_p_r1" (ai_get_object starport_unsc_m0_inf0/passenger2))
		)	
	)

;*
	(if (not (game_is_cooperative))
		(begin
			(if debug (print "loading passenger_left_1"))
			(ai_place starport_unsc_m0_inf0/passenger0)
			(sleep 10)
			(vehicle_load_magic v_starport_falcon0 "falcon_p_l1" (ai_get_object starport_unsc_m0_inf0/passenger0))
		
			(if debug (print "loading passenger_right_1"))
			(ai_place starport_unsc_m0_inf0/passenger2)
			(sleep 10)
			(vehicle_load_magic v_starport_falcon0 "falcon_p_r1" (ai_get_object starport_unsc_m0_inf0/passenger2))
		)
	)
*;
	(if debug (print "loading passenger_left_gunner"))
	(ai_place starport_unsc_m0_inf0/passenger1)
	(sleep 10)
	(vehicle_load_magic v_starport_falcon0 "falcon_g_l" (ai_get_object starport_unsc_m0_inf0/passenger1))

	(if debug (print "loading passenger_right_gunner"))
	(ai_place starport_unsc_m0_inf0/passenger3)
	(sleep 10)
	(vehicle_load_magic v_starport_falcon0 "falcon_g_r" (ai_get_object starport_unsc_m0_inf0/passenger3))
)

(script static void starport_load_m1_falcon
	; load falcon passengers, disable interaction
	(vehicle_set_player_interaction v_starport_falcon1 "falcon_d" false false)
	(vehicle_set_player_interaction v_starport_falcon1 "falcon_p_bench" false false)
	(vehicle_set_player_interaction v_starport_falcon1 "falcon_b_d" false false)
	(vehicle_set_player_interaction v_starport_falcon1 "falcon_p_r1" false false)
	(vehicle_set_player_interaction v_starport_falcon1 "falcon_p_r2" false false)
	(vehicle_set_player_interaction v_starport_falcon1 "falcon_p_l1" false false)
	(vehicle_set_player_interaction v_starport_falcon1 "falcon_p_l2" false false)
	
	(ai_vehicle_reserve_seat v_starport_falcon1 "falcon_p_l1" true)
	(ai_vehicle_reserve_seat v_starport_falcon1 "falcon_p_l2" true)
	(ai_vehicle_reserve_seat v_starport_falcon1 "falcon_p_r1" true)
	(ai_vehicle_reserve_seat v_starport_falcon1 "falcon_p_r2" true)
	(ai_vehicle_reserve_seat v_starport_falcon1 "falcon_g_r" true)
	(ai_vehicle_reserve_seat v_starport_falcon1 "falcon_g_l" true)

	;perf
	(if (game_is_cooperative)
			(set g_starport_unsc_desired 6));(- g_starport_unsc_desired 2)
	
	(set g_starport_unsc_current (ai_task_count obj_starport_unsc/gate_main))
	(if (< g_starport_unsc_current g_starport_unsc_desired)
		(begin
			(if debug (print "loading passenger_left_1"))
			(ai_place starport_unsc_m1_inf0/passenger0)
			(sleep 10)
			(vehicle_load_magic v_starport_falcon1 "falcon_p_l1" (ai_get_object starport_unsc_m1_inf0/passenger0))
		
			(if debug (print "loading passenger_right_1"))
			(ai_place starport_unsc_m1_inf0/passenger2)
			(sleep 10)
			(vehicle_load_magic v_starport_falcon1 "falcon_p_r1" (ai_get_object starport_unsc_m1_inf0/passenger2))
		)
	)
;*	
	(if (not (game_is_cooperative))
		(begin
			(if debug (print "loading passenger_left_1"))
			(ai_place starport_unsc_m1_inf0/passenger0)
			(sleep 10)
			(vehicle_load_magic v_starport_falcon1 "falcon_p_l1" (ai_get_object starport_unsc_m1_inf0/passenger0))
		
			(if debug (print "loading passenger_right_1"))
			(ai_place starport_unsc_m1_inf0/passenger2)
			(sleep 10)
			(vehicle_load_magic v_starport_falcon1 "falcon_p_r1" (ai_get_object starport_unsc_m1_inf0/passenger2))
		)
	)
*;
	(if debug (print "loading passenger_left_gunner"))
	(ai_place starport_unsc_m1_inf0/passenger1)
	(sleep 10)
	(vehicle_load_magic v_starport_falcon1 "falcon_g_l" (ai_get_object starport_unsc_m1_inf0/passenger1))
	
	(if debug (print "loading passenger_right_gunner"))
	(ai_place starport_unsc_m1_inf0/passenger3)
	(sleep 10)
	(vehicle_load_magic v_starport_falcon1 "falcon_g_r" (ai_get_object starport_unsc_m1_inf0/passenger3))
)

(script command_script cs_starport_m0_pelican_enter
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)

	(set v_starport_falcon0 (ai_vehicle_get_from_starting_location starport_unsc_m0_pelican/pilot))
	(starport_load_m0_falcon)
			
	;(cs_fly_by starport_m0_pelican/entry2)
	(cs_fly_by starport_m0_pelican/entry1)
	;(cs_vehicle_speed 0.7)
	(cs_fly_by starport_m0_pelican/entry0)
	(cs_vehicle_speed 0.4)	
			
	(sleep_until
		(begin
			(begin_random
				(begin
					(cs_fly_to_and_face starport_m0_pelican/p0 starport_m0_pelican/hover)
					(sleep (* 30 5))
				)
				(begin
					(cs_fly_to_and_face starport_m0_pelican/p1 starport_m0_pelican/hover)
					(sleep (* 30 5))
				)
				(begin
					(cs_fly_to_and_face starport_m0_pelican/p2 starport_m0_pelican/hover)
					(sleep (* 30 5))
				)
			)
		0)
	)
	
;*
	(cs_fly_to starport_m0_pelican/hover 1)
	(cs_vehicle_speed 0.2)
	(sleep 30)
	
	(cs_fly_to_and_face starport_m0_pelican/land starport_m0_pelican/land_facing 0.5)
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_p")
	(sleep 90)
	
	(thespian_performance_setup_and_begin starport_turret0_activate "" 0)
		
	(cs_fly_to_and_face starport_m0_pelican/hover starport_m0_pelican/exit0 0.5)
	(cs_vehicle_speed 1)
	(cs_fly_by starport_m0_pelican/exit0)
	(cs_fly_by starport_m0_pelican/exit1)
	(cs_fly_by starport_m0_pelican/erase)	
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(ai_erase ai_current_squad)
*;
)

(script command_script cs_starport_m1_pelican_enter
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)
	
	(set v_starport_falcon1 (ai_vehicle_get_from_starting_location starport_unsc_m1_pelican/pilot))
	(starport_load_m1_falcon)	

	;(cs_fly_by starport_m1_pelican/entry2)
	(cs_fly_by starport_m1_pelican/entry1)
	;(cs_vehicle_speed 0.7)
	(cs_vehicle_boost false)
	(cs_fly_by starport_m1_pelican/entry0)
	(cs_vehicle_speed 0.4)
		
	(sleep_until
		(begin	
			(begin_random
				(begin
					(cs_fly_to_and_face starport_m1_pelican/p0 starport_m1_pelican/hover)
					(sleep (* 30 5))
				)
				(begin
					(cs_fly_to_and_face starport_m1_pelican/p1 starport_m1_pelican/hover)
					(sleep (* 30 5))
				)
				(begin
					(cs_fly_to_and_face starport_m1_pelican/p2 starport_m1_pelican/hover)
					(sleep (* 30 5))
				)
			)
		0)
	)
	
;*
	(cs_fly_to starport_m1_pelican/hover 1)
	(cs_vehicle_speed 0.2)
	(sleep 30)
		
	(cs_fly_to_and_face starport_m1_pelican/land starport_m1_pelican/land_facing 0.5)
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_p")
	(sleep 90)
	
	(thespian_performance_setup_and_begin starport_turret1_activate "" 0)
	
	(cs_fly_to_and_face starport_m1_pelican/hover starport_m1_pelican/exit0 0.5)
	(cs_vehicle_speed 1)
	(cs_fly_by starport_m1_pelican/exit0)
	(cs_fly_by starport_m1_pelican/exit1)
	(cs_fly_by starport_m1_pelican/erase)
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(ai_erase ai_current_squad)
*;
)


(script command_script cs_starport_m0_pelican_land
;*
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)

	(set v_starport_falcon0 (ai_vehicle_get_from_starting_location starport_unsc_m0_pelican/pilot))
	(starport_load_m0_falcon)
			
	;(cs_fly_by starport_m0_pelican/entry2)
	(cs_fly_by starport_m0_pelican/entry1)
	;(cs_vehicle_speed 0.7)
	(cs_fly_by starport_m0_pelican/entry0)
*;
	(cs_vehicle_speed 0.4)
	(cs_fly_to starport_m0_pelican/hover 1)
	(cs_vehicle_speed 0.2)
	(sleep 30)
	
	(cs_fly_to_and_face starport_m0_pelican/land starport_m0_pelican/land_facing 0.5)
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_p")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_g")
	(sleep 90)
	
	(thespian_performance_setup_and_begin starport_turret0_activate "" 0)
		
	(cs_fly_to_and_face starport_m0_pelican/hover starport_m0_pelican/exit0 0.5)
	(cs_vehicle_speed 1)
	(cs_fly_by starport_m0_pelican/exit0)
	(cs_fly_by starport_m0_pelican/exit1)
	(cs_fly_by starport_m0_pelican/erase)	
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(ai_erase ai_current_squad)
)

(script command_script cs_starport_m1_pelican_land
;*
	;scale up
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(sleep 1)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 (* 30 5))
	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)
	
	(set v_starport_falcon1 (ai_vehicle_get_from_starting_location starport_unsc_m1_pelican/pilot))
	(starport_load_m1_falcon)	

	;(cs_fly_by starport_m1_pelican/entry2)
	(cs_fly_by starport_m1_pelican/entry1)
	;(cs_vehicle_speed 0.7)
	(cs_vehicle_boost false)
	(cs_fly_by starport_m1_pelican/entry0)
*;
	(cs_vehicle_speed 0.4)
	(cs_fly_to starport_m1_pelican/hover 1)
	(cs_vehicle_speed 0.2)
	(sleep 30)
		
	(cs_fly_to_and_face starport_m1_pelican/land starport_m1_pelican/land_facing 0.5)
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_p")
	(vehicle_unload (ai_vehicle_get ai_current_actor) "falcon_g")
	(sleep 90)
	
	(thespian_performance_setup_and_begin starport_turret1_activate "" 0)
	
	(cs_fly_to_and_face starport_m1_pelican/hover starport_m1_pelican/exit0 0.5)
	(cs_vehicle_speed 1)
	(cs_fly_by starport_m1_pelican/exit0)
	(cs_fly_by starport_m1_pelican/exit1)
	(cs_fly_by starport_m1_pelican/erase)
	
	;scale down
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 (* 30 10))
	(ai_erase ai_current_squad)
)

; -------------------------------------------------------------------------------------------------

(script dormant starport_turret0_control
	;(f_blip_object turret0_switch blip_interface)
	(sleep_until (> (device_get_position turret0_switch) 0))
	(f_unblip_object turret0_switch)
	
	;(if (not b_starport_turret1_ready)
	;	(wake md_starport_south_armed))
		
	(game_save_no_timeout)
	(set b_starport_turret0_ready true)
)

(script command_script cs_remove_duvall
 (ai_disposable ai_current_actor true)
)

; -------------------------------------------------------------------------------------------------

(script dormant starport_turret1_control
	;(f_blip_object turret1_switch blip_interface)
	(sleep_until (> (device_get_position turret1_switch) 0))
	(f_unblip_object turret1_switch)
	
	;(if (not b_starport_turret1_ready)
	;	(wake md_starport_north_armed))
		
	(game_save_no_timeout)
	(set b_starport_turret1_ready true)
)

(script dormant starport_firing_control
	(sleep_until (and b_starport_turret0_ready b_starport_turret1_ready))
	(device_set_power firing_control_switch 1.0)
	
	(sleep_until (> (device_get_position firing_control_switch) 0))
	(f_unblip_object firing_control_switch)
	(set b_starport_defenses_fired true)	
)

(script dormant f_player_on_foot
	(sleep_until
		(begin
			(if
				(or
					(and
						(= (game_coop_player_count) 1)
						(= (unit_in_vehicle (player0)) true)
					)
					(and
						(= (game_coop_player_count) 2)
						(and
							(= (unit_in_vehicle (player0)) true)
							(= (unit_in_vehicle (player1)) true)
						)
					)
					(and
						(= (game_coop_player_count) 3)
						(and
							(= (unit_in_vehicle (player0)) true)
							(= (unit_in_vehicle (player1)) true)
							(= (unit_in_vehicle (player2)) true)
						)
					)
					(and
						(= (game_coop_player_count) 4)
						(and
							(= (unit_in_vehicle (player0)) true)
							(= (unit_in_vehicle (player1)) true)
							(= (unit_in_vehicle (player2)) true)
							(= (unit_in_vehicle (player3)) true)
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


;*
(script dormant f_player_driving
	(sleep_until
		(begin
			(if
				(or
					(vehicle_test_seat_unit starport_unsc_hog0 warthog_d (player0))
					(vehicle_test_seat_unit starport_unsc_hog1 warthog_d (player0))
					(vehicle_test_seat_unit starport_unsc_mong0 mongoose_d (player0))
					(vehicle_test_seat_unit starport_unsc_mong1 mongoose_d (player0))
				)
				
				(begin
					(set b_players_driving true)
				)
				(begin
					(set b_players_driving false)
				)
			)
		false)
	)
)
*;

(script dormant starport_waypoint
	(sleep_until b_starport_monologue)
	(sleep g_waypoint_timeout)

		(if (!= b_starport_turret0_ready true)
		(f_blip_object turret0_switch blip_interface))

		(if (!= b_starport_turret1_ready true)
		(f_blip_object turret1_switch blip_interface))
	
	(sleep_until 
		(and b_starport_turret0_ready b_starport_turret1_ready) 5)
	
	;(sleep g_waypoint_timeout)
	(sleep (* 30 10))
	(f_blip_object firing_control_switch blip_interface)
)




; =================================================================================================
; helper
; =================================================================================================
(script command_script cs_renew
	(cs_enable_moving ai_current_actor true)
	(cs_enable_targeting ai_current_actor true)
	(cs_enable_looking ai_current_actor true)
		
	(sleep_until
		(begin
			(ai_renew ai_current_squad)
		false)
	15)
)

(script static void (teleport_players_in_volume
                                         (trigger_volume v)
                                         (cutscene_flag teleport0)
                                         (cutscene_flag teleport1)
                                         (cutscene_flag teleport2)
                                         (cutscene_flag teleport3))
                                         
       (if debug (print "teleporting players in a volume forward..."))
       
       (if (volume_test_object v (player0))
              (object_teleport (player0) teleport0))
              
       (if (volume_test_object v (player1))
              (object_teleport (player1) teleport1))
              
       (if (volume_test_object v (player2))
              (object_teleport (player2) teleport2))
              
       (if (volume_test_object v (player3))
              (object_teleport (player3) teleport3))
)

(script static void (teleport_players_not_in_volume
                                         (trigger_volume v)
                                         (cutscene_flag teleport0)
                                         (cutscene_flag teleport1)
                                         (cutscene_flag teleport2)
                                         (cutscene_flag teleport3))
                                         
       (if debug (print "teleporting players not in a volume forward..."))
       
       (if (not (volume_test_object v (player0)))
              (object_teleport (player0) teleport0))
              
       (if (not (volume_test_object v (player1)))
              (object_teleport (player1) teleport1))
              
       (if (not (volume_test_object v (player2)))
              (object_teleport (player2) teleport2))
              
       (if (not (volume_test_object v (player3)))
              (object_teleport (player3) teleport3))
)



(script static boolean (is_down (ai group))
	(<= (ai_living_count group) 0))



; player_effect_set_max_rotation <yaw> <pitch> <roll>
; player_effect_start <max_intensity> <attack time>
; player_effect_stop  <decay>
(script static void cam_shake_old
	(player_effect_set_max_rotation 2 2 2)
	(player_effect_start 0.5 1.0)
	(player_effect_stop 3.0)
)

(script static void sleep_longswords
	(sleep_forever panoptical_longsword_cycle)
	(sleep_forever towers_longsword_cycle)
	(sleep_forever canyonview_longsword_cycle)
)

(script command_script cs_exit
	(if debug (print "exiting command script...")))

(script static void attempt_save
	(game_save))
	
(script static void nuke_all_covenant
	(ai_erase gr_cov)
	(kill_ambient_dropships)
)

(script static void nuke_all_longswords
	(sleep_forever panoptical_longsword_cycle)
	(sleep_forever towers_longsword_cycle)
	(sleep_forever canyonview_longsword_cycle)
	(sleep_forever jetpack_longsword_cycle)
)

(script static void nuke_all_unsc
	(ai_erase gr_unsc_jl)
	(ai_erase atrium_unsc_elevator)
	(ai_erase atrium_unsc_troopers)
	(ai_erase jh_unsc_mars_balcony_inf0)
	(ai_erase jh_unsc_mars_tree_inf0)
	(ai_erase jh_unsc_odst_balcony_inf0)
	(ai_erase jh_unsc_odst_tree_inf0)
)



;==================================================================================================================
; object control =========================================================================
(global boolean editor_object_management 0)
;==================================================================================================================
;thespian_folder_activate and thespian_folder_deactivate
(script dormant object_control
	;if in editor, create all objects
	;*
	(if (and (editor_mode) (not editor_object_management))
		(begin
			(print "(sleep_forever object_control)")
			(sleep_forever)
		)
	)
	*;
	(print "object_control")
	;(objects_destroy_all)

;*
	(print "destroy portal doors")
	(object_destroy dm_ready_door0)
	(object_destroy dm_jh_lobby0)
	(object_destroy dm_traxus_lobby_door1)
	(object_destroy dm_door_urban_gen_small_b_0)
	(object_destroy dm_door_urban_gen_small_b_1)
	(object_destroy dm_trophy_door0)
	(object_destroy dm_trophy_door8)
	(object_destroy dm_trophy_door9)
	(object_destroy dm_trophy_door7)
	(object_destroy dm_trophy_door6)
	(object_destroy dm_trophy_door1)
*;
			
	;(if (= (current_zone_set_fully_active) 0) (objects_manage_0))
	(sleep_until (>= (current_zone_set) 0) 1)
	(sleep 1)              
	(if (= (current_zone_set) 0) (objects_manage_0))
                                
	;(sleep_until (>= (current_zone_set_fully_active) 1) 1)
	;(objects_manage_1)
	(sleep_until (>= (current_zone_set) 1) 1)
	(sleep 1)              
	(if (= (current_zone_set) 1) (objects_manage_1))
	
	;(sleep_until (>= (current_zone_set_fully_active) 2) 1)
	;(objects_manage_2)
	(sleep_until (>= (current_zone_set) 2) 1)
	(sleep 1)              
	(if (= (current_zone_set) 2) (objects_manage_2))
	
	;(sleep_until (>= (current_zone_set_fully_active) 3) 1)
	;(objects_manage_3)
	(sleep_until (>= (current_zone_set) 3) 1)
	(sleep 1)              
	(if (= (current_zone_set) 3) (objects_manage_3))
		
	;(sleep_until (>= (current_zone_set_fully_active) 4) 1)
	;(objects_manage_4)
	(sleep_until (>= (current_zone_set) 4) 1)
	(sleep 1)              
	(if (= (current_zone_set) 4) (objects_manage_4a))
		
	;(sleep_until (>= (current_zone_set_fully_active) 5) 1)
	;(objects_manage_5)
	(sleep_until (>= (current_zone_set) 5) 1)
	(sleep 1)              
	(if (= (current_zone_set) 5) (objects_manage_5))
)

;set_panoptical_010_020
(script static void objects_manage_0
	(print "no objects to destroy")
		
	(object_create_folder dm_010)
	(object_create_folder dc_010)
	(object_create_folder eq_010)
	(object_create_folder wp_010)
	(object_create_folder bp_010)
	(object_create_folder sc_010)
	(object_create_folder cr_010)

	(object_create_folder dm_020)
	(object_create_folder dc_020)
	(object_create_folder eq_020)
	(object_create_folder wp_020)
	(object_create_folder bp_020)
	(object_create_folder sc_020)
	(object_create_folder cr_020)
	(sleep 1)
	(setup_010_bodies)
	(setup_020_bodies)
)

;set_interior_010_020_030
(script static void objects_manage_1
	(print "no objects to destroy")
	
	(sleep_until (= (current_zone_set_fully_active) 1) 1)
	(object_create_folder dm_030)
	(object_create_folder dc_030)
	(object_create_folder eq_030)
	(object_create_folder wp_030)
	(object_create_folder bp_030)
	(object_create_folder sc_030)
	(object_create_folder cr_030)
	(sleep 1)
	(setup_030_bodies)
)

;set_canyonview_030_040
(script static void objects_manage_2
	(object_destroy_folder dm_010)
	(object_destroy_folder dc_010)
	(object_destroy_folder eq_010)
	(object_destroy_folder wp_010)
	(object_destroy_folder bp_010)
	(object_destroy_folder sc_010)
	(object_destroy_folder cr_010)
	
	(object_destroy_folder dm_020)
	(object_destroy_folder dc_020)
	(object_destroy_folder eq_020)
	(object_destroy_folder wp_020)
	(object_destroy_folder bp_020)
	(object_destroy_folder sc_020)
	(object_destroy_folder cr_020)

	(sleep_until (= (current_zone_set_fully_active) 2) 1)
	(object_create_folder dm_040)
	(object_create_folder dc_040)
	(object_create_folder eq_040)
	(object_create_folder wp_040)
	(object_create_folder bp_040)
	(object_create_folder sc_040)
	(object_create_folder cr_040)
	(sleep 1)
	(setup_030_bodies)
	(setup_040_bodies)
)

;set_atrium_040_050_060
(script static void objects_manage_3
	(object_destroy_folder dm_030)
	(object_destroy_folder dc_030)
	(object_destroy_folder eq_030)
	(object_destroy_folder wp_030)
	(object_destroy_folder bp_030)
	(object_destroy_folder sc_030)
	(object_destroy_folder cr_030)
	
	(sleep_until (= (current_zone_set_fully_active) 3) 1)
	(object_create_folder atrium_elevator)
	
	(object_create_folder dm_050)
	(object_create_folder dc_050)
	(object_create_folder eq_050)
	(object_create_folder wp_050)
	(object_create_folder bp_050)
	(object_create_folder sc_050)
	(object_create_folder cr_050)
	(object_create_folder ve_050)
;*	
	(object_create_folder dm_060)
	(object_create_folder dc_060)
	(object_create_folder eq_060)
	(object_create_folder wp_060)
	(object_create_folder bp_060)
	(object_create_folder sc_060)
	(object_create_folder cr_060)	
*;
	(sleep 1)
	(setup_050_bodies)
)

;set_jetpack_060_070
(script static void objects_manage_4a
	(object_destroy_folder dm_040)
	(object_destroy_folder dc_040)
	(object_destroy_folder eq_040)
	(object_destroy_folder wp_040)
	(object_destroy_folder bp_040)
	(object_destroy_folder sc_040)
	(object_destroy_folder cr_040)
	
	(object_destroy_folder dm_050)
	(object_destroy_folder dc_050)
	(object_destroy_folder eq_050)
	(object_destroy_folder wp_050)
	(object_destroy_folder bp_050)
	(object_destroy_folder sc_050)
	(object_destroy_folder cr_050)
	(object_destroy_folder ve_050)

	(sleep_until (= (current_zone_set_fully_active) 4) 1)
;*
	(object_create_folder dm_060)
	(object_create_folder dc_060)
	(object_create_folder eq_060)
	(object_create_folder wp_060)
	(object_create_folder bp_060)
	(object_create_folder sc_060)
	(object_create_folder cr_060)
*;
	(object_create_folder atrium_elevator)

	(object_create_folder dm_070)
	(object_create_folder dm_070_lobby)
	(object_create_folder dc_070)
	(object_create_folder eq_070)
	(object_create_folder wp_070)
	;(object_create_folder bp_070)
	(object_create_folder sc_070)
	(object_create_folder sc_070_lobby)
	(object_create_folder cr_070)
	;(object_create_folder ve_070)

	(sleep 1)
	(setup_070_bodies)
)

;set_jetpack_080
(script static void objects_manage_4b
	(object_destroy_folder dm_070)
	(object_destroy_folder dc_070)
	(object_destroy_folder eq_070)
	(object_destroy_folder wp_070)
	;(object_destroy_folder bp_070)
	(object_destroy_folder sc_070)
	(object_destroy_folder cr_070)
	;(object_destroy_folder ve_070)

	(sleep_until (= (current_zone_set_fully_active) 4) 1)

	;(object_create_folder atrium_elevator)

	(object_create_folder dm_080)
	(object_create_folder dc_080)
	(object_create_folder eq_080)
	(object_create_folder wp_080)
	(object_create_folder bp_080)
	(object_create_folder sc_080)
	(object_create_folder cr_080)
	(sleep 1)
	(setup_080_bodies)
)

;set_starport_090
(script static void objects_manage_5
;*			
	(object_destroy_folder dm_060)
	(object_destroy_folder dc_060)
	(object_destroy_folder eq_060)
	(object_destroy_folder wp_060)
	(object_destroy_folder bp_060)
	(object_destroy_folder sc_060)
	(object_destroy_folder cr_060)
*;	
	(object_destroy_folder dm_070)
	(object_destroy_folder dc_070)
	(object_destroy_folder eq_070)
	(object_destroy_folder wp_070)
	;(object_destroy_folder bp_070)
	(object_destroy_folder sc_070)
	(object_destroy_folder cr_070)
	;(object_destroy_folder ve_070)

	(object_destroy_folder dm_080)
	(object_destroy_folder dc_080)
	(object_destroy_folder eq_080)
	(object_destroy_folder wp_080)
	(object_destroy_folder bp_080)
	(object_destroy_folder sc_080)
	(object_destroy_folder cr_080)
	
	(sleep_until (= (current_zone_set_fully_active) 5) 1)
	(object_create_folder dm_090)
	(object_create_folder dc_090)
	(object_create_folder eq_090)
	(object_create_folder wp_090)
	(object_create_folder bp_090)
	(object_create_folder sc_090)
	(object_create_folder cr_090)
	(sleep 1)
	(setup_090_bodies)
)


(script static void objects_destroy_all
	(print "destroying all objects")
	(object_destroy_folder dm_010)
	(object_destroy_folder dc_010)
	(object_destroy_folder eq_010)
	(object_destroy_folder wp_010)
	(object_destroy_folder bp_010)
	(object_destroy_folder sc_010)
	(object_destroy_folder cr_010)
	
	(object_destroy_folder dm_020)
	(object_destroy_folder dc_020)
	(object_destroy_folder eq_020)
	(object_destroy_folder wp_020)
	(object_destroy_folder bp_020)
	(object_destroy_folder sc_020)
	(object_destroy_folder cr_020)

	(object_destroy_folder dm_030)
	(object_destroy_folder dc_030)
	(object_destroy_folder eq_030)
	(object_destroy_folder wp_030)
	(object_destroy_folder bp_030)
	(object_destroy_folder sc_030)
	(object_destroy_folder cr_030)

	(object_destroy_folder dm_040)
	(object_destroy_folder dc_040)
	(object_destroy_folder eq_040)
	(object_destroy_folder wp_040)
	(object_destroy_folder bp_040)
	(object_destroy_folder sc_040)
	(object_destroy_folder cr_040)
	
	(object_destroy_folder dm_050)
	(object_destroy_folder dc_050)
	(object_destroy_folder eq_050)
	(object_destroy_folder wp_050)
	(object_destroy_folder bp_050)
	(object_destroy_folder sc_050)
	(object_destroy_folder cr_050)
;*	
	(object_destroy_folder dm_060)
	(object_destroy_folder dc_060)
	(object_destroy_folder eq_060)
	(object_destroy_folder wp_060)
	(object_destroy_folder bp_060)
	(object_destroy_folder sc_060)
	(object_destroy_folder cr_060)
*;	
	(object_destroy_folder dm_070)
	(object_destroy_folder dc_070)
	(object_destroy_folder eq_070)
	(object_destroy_folder wp_070)
	;(object_destroy_folder bp_070)
	(object_destroy_folder sc_070)
	(object_destroy_folder cr_070)
	
	(object_destroy_folder dm_080)
	(object_destroy_folder dc_080)
	(object_destroy_folder eq_080)
	(object_destroy_folder wp_080)
	(object_destroy_folder bp_080)
	(object_destroy_folder sc_080)
	(object_destroy_folder cr_080)
	
	(object_destroy_folder dm_090)
	(object_destroy_folder dc_090)
	(object_destroy_folder eq_090)
	(object_destroy_folder wp_090)
	(object_destroy_folder bp_090)
	(object_destroy_folder sc_090)
	(object_destroy_folder cr_090)
)

;==================================================================================================================
; scenery_animation_start <scenery> <animation_graph> <string_id>
; female: 01-20
; male: 01-15
;==================================================================================================================

(script static void setup_010_bodies
	(print "setup_010_bodies")
	(scenery_animation_start sc_panoptical_civilian_fm1 objects\characters\civilian_female\civilian_female deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_fm2 objects\characters\civilian_female\civilian_female deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_fm3 objects\characters\civilian_female\civilian_female deadbody_03)
	(scenery_animation_start sc_panoptical_civilian_fm4 objects\characters\civilian_female\civilian_female deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_fm5 objects\characters\civilian_female\civilian_female deadbody_09)
	(scenery_animation_start sc_panoptical_civilian_fm6 objects\characters\civilian_female\civilian_female deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_fm7 objects\characters\civilian_female\civilian_female deadbody_03)
	(scenery_animation_start sc_panoptical_civilian_fm8 objects\characters\civilian_female\civilian_female deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_fm9 objects\characters\civilian_female\civilian_female deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_fm10 objects\characters\civilian_female\civilian_female deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_fm11 objects\characters\civilian_female\civilian_female deadbody_03)
	(scenery_animation_start sc_panoptical_civilian_fm12 objects\characters\civilian_female\civilian_female deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_fm13 objects\characters\civilian_female\civilian_female deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_fm14 objects\characters\civilian_female\civilian_female deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_fm15 objects\characters\civilian_female\civilian_female deadbody_03)
	(scenery_animation_start sc_panoptical_civilian_fm16 objects\characters\civilian_female\civilian_female deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_fm17 objects\characters\civilian_female\civilian_female deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_fm18 objects\characters\civilian_female\civilian_female deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_fm19 objects\characters\civilian_female\civilian_female deadbody_03)
	(scenery_animation_start sc_panoptical_civilian_fm20 objects\characters\civilian_female\civilian_female deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_fm21 objects\characters\civilian_female\civilian_female deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_fm22 objects\characters\civilian_female\civilian_female deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_fm23 objects\characters\civilian_female\civilian_female deadbody_10)
	(scenery_animation_start sc_panoptical_civilian_fm24 objects\characters\civilian_female\civilian_female deadbody_06)
	(scenery_animation_start sc_panoptical_civilian_fm25 objects\characters\civilian_female\civilian_female deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_fm26 objects\characters\civilian_female\civilian_female deadbody_02)
			
	(scenery_animation_start sc_panoptical_civilian_m1 objects\characters\marine\marine deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_m2 objects\characters\marine\marine deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_m3 objects\characters\marine\marine deadbody_03)
	(scenery_animation_start sc_panoptical_civilian_m4 objects\characters\marine\marine deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_m5 objects\characters\marine\marine deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_m6 objects\characters\marine\marine deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_m7 objects\characters\marine\marine deadbody_12)
	(scenery_animation_start sc_panoptical_civilian_m8 objects\characters\marine\marine deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_m9 objects\characters\marine\marine deadbody_10)
	(scenery_animation_start sc_panoptical_civilian_m10 objects\characters\marine\marine deadbody_02)
	(scenery_animation_start sc_panoptical_civilian_m11 objects\characters\marine\marine deadbody_03)
	(scenery_animation_start sc_panoptical_civilian_m12 objects\characters\marine\marine deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_m13 objects\characters\marine\marine deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_m14 objects\characters\marine\marine deadbody_02)
	;(scenery_animation_start sc_panoptical_civilian_m15	objects\characters\marine\marine deadbody_05)
	(scenery_animation_start sc_panoptical_civilian_m16 objects\characters\marine\marine deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_m17 objects\characters\marine\marine deadbody_09)
	(scenery_animation_start sc_panoptical_civilian_m18 objects\characters\marine\marine deadbody_14)
	(scenery_animation_start sc_panoptical_civilian_m19 objects\characters\marine\marine deadbody_03)
	(scenery_animation_start sc_panoptical_civilian_m20 objects\characters\marine\marine deadbody_05)
	(scenery_animation_start sc_panoptical_civilian_m21 objects\characters\marine\marine deadbody_01)
	(scenery_animation_start sc_panoptical_civilian_m22 objects\characters\marine\marine deadbody_13)
	(scenery_animation_start sc_panoptical_civilian_m23 objects\characters\marine\marine deadbody_08)
	(scenery_animation_start sc_panoptical_civilian_m24 objects\characters\marine\marine deadbody_04)
	(scenery_animation_start sc_panoptical_civilian_m25 objects\characters\marine\marine deadbody_15)
	
	;(scenery_animation_start sc_panoptical_marine0 objects\characters\marine\marine e3_deadbody_02)
)

(script static void setup_020_bodies
	(print "setup_020_bodies")
	(scenery_animation_start sc_towers_civilian_fm1 objects\characters\civilian_female\civilian_female deadbody_09)
	(scenery_animation_start sc_towers_civilian_m0 objects\characters\marine\marine e3_deadbody_02)
)

(script static void setup_030_bodies
	(print "setup_030_bodies")
)

(script static void setup_040_bodies
	(print "setup_040_bodies")
)

(script static void setup_050_bodies
	(print "setup_050_bodies")
)

(script static void setup_070_bodies
	(print "setup_070_bodies")
	(scenery_animation_start sc_ready_civilian_fm1 objects\characters\civilian_female\civilian_female deadbody_01)
	(scenery_animation_start sc_ready_civilian_fm2 objects\characters\civilian_female\civilian_female deadbody_02)
	(scenery_animation_start sc_ready_civilian_fm3 objects\characters\civilian_female\civilian_female deadbody_03)
	
	(scenery_animation_start sc_ready_civilian_m1 objects\characters\marine\marine deadbody_01)
	(scenery_animation_start sc_ready_civilian_m2 objects\characters\marine\marine deadbody_02)
	(scenery_animation_start sc_ready_civilian_m3 objects\characters\marine\marine deadbody_03)
	(scenery_animation_start sc_ready_civilian_m4 objects\characters\marine\marine deadbody_04)
)

(script static void setup_080_bodies
	(print "setup_080_bodies")
)

(script static void setup_090_bodies
	(print "setup_090_bodies")
)


(script static void create_all
	(object_create_folder dm_010)
	(object_create_folder dc_010)
	(object_create_folder eq_010)
	(object_create_folder wp_010)
	(object_create_folder bp_010)
	(object_create_folder sc_010)
	(object_create_folder cr_010)

	(object_create_folder dm_020)
	(object_create_folder dc_020)
	(object_create_folder eq_020)
	(object_create_folder wp_020)
	(object_create_folder bp_020)
	(object_create_folder sc_020)
	(object_create_folder cr_020)
	
	(object_create_folder dm_030)
	(object_create_folder dc_030)
	(object_create_folder eq_030)
	(object_create_folder wp_030)
	(object_create_folder bp_030)
	(object_create_folder sc_030)
	(object_create_folder cr_030)
	
	(object_create_folder dm_040)
	(object_create_folder dc_040)
	(object_create_folder eq_040)
	(object_create_folder wp_040)
	(object_create_folder bp_040)
	(object_create_folder sc_040)
	(object_create_folder cr_040)
	
	(object_create_folder dm_070)
	(object_create_folder dc_070)
	(object_create_folder eq_070)
	(object_create_folder wp_070)
	;(object_create_folder bp_070)
	(object_create_folder sc_070)
	(object_create_folder cr_070)
	;(object_create_folder ve_070)

	(object_create_folder dm_080)
	(object_create_folder dc_080)
	(object_create_folder eq_080)
	(object_create_folder wp_080)
	(object_create_folder bp_080)
	(object_create_folder sc_080)
	(object_create_folder cr_080)
	
	(object_create_folder dm_090)
	(object_create_folder dc_090)
	(object_create_folder eq_090)
	(object_create_folder wp_090)
	(object_create_folder bp_090)
	(object_create_folder sc_090)
	(object_create_folder cr_090)
	
	(setup_010_bodies)
	(setup_020_bodies)
	(setup_030_bodies)
	(setup_040_bodies)
	(setup_050_bodies)
	(setup_070_bodies)
	(setup_080_bodies)
	(setup_090_bodies)
	(setup_090_bodies)
)

; -------------------------------------------------------------------------------------------------
;	difficulty
; -------------------------------------------------------------------------------------------------

(script static boolean difficulty_is_heroic_or_higher
                (or
                                (= (game_difficulty_get) heroic)
                                (= (game_difficulty_get) legendary)
                )
)

(script static boolean difficulty_is_easy
                (=  (game_difficulty_get) easy)
)

(script static boolean difficulty_is_normal
                (= (game_difficulty_get) normal)
)

(script static boolean difficulty_is_heroic
                (= (game_difficulty_get) heroic)
)

(script static boolean difficulty_is_legendary
                (= (game_difficulty_get) legendary)
)

(script static boolean difficulty_is_easy_or_normal
                (or
                                (= (game_difficulty_get) easy)
                                (= (game_difficulty_get) normal)
                )
)


; -------------------------------------------------------------------------------------------------
;	debug shortcuts
; -------------------------------------------------------------------------------------------------

(script static void 1
                (if ai_render_sector_bsps
                                (set ai_render_sector_bsps 0)
                                (set ai_render_sector_bsps 1)
                )
)

(script static void 2
                (if ai_render_objectives
                                (set ai_render_objectives 0)
                                (set ai_render_objectives 1)
                )
)

(script static void 3
                (if ai_render_decisions
                                (set ai_render_decisions 0)
                                (set ai_render_decisions 1)
                )
)

(script static void 4
                (if ai_render_command_scripts
                                (set ai_render_command_scripts 0)
                                (set ai_render_command_scripts 1)
                )
)

(script static void 5
                (if debug_performances
                                (set debug_performances 0)
                                (set debug_performances 1)
                )
)

(script static void 6
                (if debug_instanced_geometry_cookie_cutters
                                (set debug_instanced_geometry_cookie_cutters 0)
                                (set debug_instanced_geometry_cookie_cutters 1)
                )
)


;*
(script static void effect_test
  (print "fx test")
	(effect_new "fx\fx_library\_placeholder\placeholder_explosion.effect" cf_test)
	(effect_new_random "fx\fx_library\designer_fx\rocket.effect" falcon_enter/land 0 0)
	(effect_new_random "fx\fx_library\designer_fx\wraith_mortar.effect" falcon_enter/land 5 5)
)
*;
