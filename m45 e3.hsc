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
�tgbl���������������tgst��'4��'4tgda������'; =================================================================================================
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
	(sleep 30)
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
							(if b_debug_phantom (print "load phantom left..."))
							;(ai_vehicle_enter_immediate load_squad_01 pelican "pelican_p_l")
							;(ai_vehicle_enter_immediate load_squad_02 pelican "phantom_p_lf")
							;(ai_vehicle_enter_immediate load_squad_03 pelican "phantom_p_ml_f")
							;(ai_vehicle_enter_immediate load_squad_04 pelican "phantom_p_ml_b")
						)
		)
		; right 
		((= load_side "right")
						(begin
							(if b_debug_phantom (print "load phantom right..."))
							;(ai_vehicle_enter_immediate load_squad_01 pelican "pelican_p_r")
							;(ai_vehicle_enter_immediate load_squad_02 pelican "phantom_p_rf")
							;(ai_vehicle_enter_immediate load_squad_03 pelican "phantom_p_mr_f")
							;(ai_vehicle_enter_immediate load_squad_04 pelican "phantom_p_mr_b")
							
						)
		)
		; dual 
		((= load_side "dual")
						(begin
							(if b_debug_phantom (print "load phantom dual..."))
							;(ai_vehicle_enter_immediate load_squad_01 pelican "pelican_p_l")
							;(ai_vehicle_enter_immediate load_squad_02 pelican "pelican_p_r")
							;(ai_vehicle_enter_immediate load_squad_02 phantom "phantom_p_rf")
							;(ai_vehicle_enter_immediate load_squad_03 phantom "phantom_p_lb")
							;(ai_vehicle_enter_immediate load_squad_04 phantom "phantom_p_rb")
						)
		)
	)			
				
)

;*
(script static void f_load_pelican_test
	(ai_place test_pelican)
	(f_load_pelican (ai_vehicle_get_from_starting_location test_pelican/pilot) "dual" evac_marines none)
)
*;�tgbl���������������tgst��tgda�����ý; ===============================================================================================================================================
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
	(unit_set_current_vitality (player0) 80 80)
	(unit_set_current_vitality (player1) 80 80)
	(unit_set_current_vitality (player2) 80 80)
	(unit_set_current_vitality (player3) 80 80)
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
	     (unit_in_vehicle (unit (player0)))
	     (unit_in_vehicle (unit (player1)))
	     (unit_in_vehicle (unit (player2)))
	     (unit_in_vehicle (unit (player3)))
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


(script static void cinematic_skip_stop
	(cinematic_skip_stop_internal)		; stop listening for the button 
	(if (not (game_reverted)) (game_revert))	; if the player did not revert, do it for him 
)

(script static void (cinematic_skip_stop_load_zone (zone_set z))
	(cinematic_skip_stop_internal)		; stop listening for the button 
	(fade_out 0 0 0 30)
	(sleep 31)
	(switch_zone_set z)
	(sleep 2)
)

(script static void cinematic_skip_stop_terminal
 	(cinematic_skip_stop_internal)		; stop listening for the button
	(if (not (game_reverted))
	 	(begin
		 	(game_revert)					; if the player did not revert, do it for him
			(if b_debug_globals (print "sleeping forever..."))
			(sleep_forever)						; sleep forever so game_level_advance is not called twice
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
; -------------------------------------------------------------------------------------------------
(script static void test_cinematic_enter_exit
	;(cinematic_enter default_fade_to_black_transitions true)
	(sleep 30)
	;(cinematic_exit default_fade_to_black_transitions true)
)

(script static void (cinematic_enter (string_id cinematic_name) (boolean lower_weapon))
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
			(unit_lower_weapon (player0) 30)
			(unit_lower_weapon (player1) 30)
			(unit_lower_weapon (player2) 30)
			(unit_lower_weapon (player3) 30)
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
	(object_hide (player0) true)
	(object_hide (player1) true)
	(object_hide (player2) true)
	(object_hide (player3) true)

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

(script static void (cinematic_exit_pre (boolean weapon_starts_lowered))
	(cinematic_stop)
	(camera_control off)

	; unhide players 
	(object_hide (player0) false)
	(object_hide (player1) false)
	(object_hide (player2) false)
	(object_hide (player3) false)
	
	; raise weapon 
	(if (= weapon_starts_lowered true)
		(begin
			(if b_debug_cinematic_scripts (print "snapping weapon to lowered state..."))
			(unit_lower_weapon (player0) 1)
			(unit_lower_weapon (player1) 1)
			(unit_lower_weapon (player2) 1)
			(unit_lower_weapon (player3) 1)
			(sleep 1)
		)
		
		(begin
			(unit_raise_weapon (player0) 1)
			(unit_raise_weapon (player1) 1)
			(unit_raise_weapon (player2) 1)
			(unit_raise_weapon (player3) 1)
			(sleep 1)
		)
	)
	
	; unlock the players gaze 
	(player_control_unlock_gaze (player0))
	(player_control_unlock_gaze (player1))
	(player_control_unlock_gaze (player2))
	(player_control_unlock_gaze (player3))
	(sleep 1)
)

(script static void (cinematic_exit_post (boolean weapon_starts_lowered))
	(cinematic_show_letterbox 0)
	
	; raise weapon 
	(if (= weapon_starts_lowered true)
		(begin
			(if b_debug_cinematic_scripts (print "raising player weapons slowly..."))
			(unit_raise_weapon (player0) 30)
			(unit_raise_weapon (player1) 30)
			(unit_raise_weapon (player2) 30)
			(unit_raise_weapon (player3) 30)
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
	(unit_lower_weapon (player0) 0)
	(unit_lower_weapon (player1) 0)
	(unit_lower_weapon (player2) 0)
	(unit_lower_weapon (player3) 0)

	; pause the meta-game timer 
	(campaign_metagame_time_pause true)

	; fade out the chud 
	; cgirons todo: this was (chud_cinematic_fade 0 0) for snaps check if it is a problem
	(chud_cinematic_fade 0 0)
	
	; hide players 
	(if b_debug_cinematic_scripts (print "hiding players..."))
	(object_hide (player0) true)
	(object_hide (player1) true)
	(object_hide (player2) true)
	(object_hide (player3) true)

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
	(object_hide (player0) false)
	(object_hide (player1) false)
	(object_hide (player2) false)
	(object_hide (player3) false)
	
	; raise weapon 
	(if (= weapon_starts_lowered true)
		(begin
			(if b_debug_cinematic_scripts (print "snapping weapon to lowered state..."))
			(unit_lower_weapon (player0) 1)
			(unit_lower_weapon (player1) 1)
			(unit_lower_weapon (player2) 1)
			(unit_lower_weapon (player3) 1)
			(sleep 1)
		)
	)
	
	; unlock the players gaze 
	(player_control_unlock_gaze (player0))
	(player_control_unlock_gaze (player1))
	(player_control_unlock_gaze (player2))
	(player_control_unlock_gaze (player3))
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
			(unit_raise_weapon (player0) 30)
			(unit_raise_weapon (player1) 30)
			(unit_raise_weapon (player2) 30)
			(unit_raise_weapon (player3) 30)
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
			(player_add_footprint (player0) g_pda_breadcrumb_fade)
			(player_add_footprint (player1) g_pda_breadcrumb_fade)
			(player_add_footprint (player2) g_pda_breadcrumb_fade)
			(player_add_footprint (player3) g_pda_breadcrumb_fade)
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
	
	(cinematic_enter cinematic_name false)
	(sleep 1)
	
	(if (cinematic_skip_start)
		(begin
			(if b_debug_cinematic_scripts (print "f_start_mission: cinematic_skip_start is true... starting cinematic..."))
			(cinematic_show_letterbox_immediate true)
			(cinematic_run_script_by_name cinematic_name)
		)
		(cinematic_skip_stop)
	)	
)


; used for mid-mission cinematics
(script static void (f_play_cinematic_advanced
						(string_id cinematic_name)
						(zone_set cinematic_zone_set)
						(zone_set zone_to_load_when_done)
					)
	
	(if b_debug_cinematic_scripts (print "f_play_cinematic: calling cinematic_enter"))

	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sleep 1)
		
	(if (cinematic_skip_start)
		(begin
			(if b_debug_globals (print "f_play_cinematic: playing cinematic..."))
			(cinematic_show_letterbox_immediate true)
			(cinematic_run_script_by_name cinematic_name)
		)
		(cinematic_skip_stop_load_zone zone_to_load_when_done)
	)
	(cinematic_skip_stop_internal)
	(switch_zone_set zone_to_load_when_done)
		
	(if b_debug_cinematic_scripts (print "f_play_cinematic: done with cinematic. resetting audio levels..."))
)

; used for mid-mission cinematics
(script static void (f_play_cinematic
						(string_id cinematic_name)
						(zone_set cinematic_zone_set)
					)
	
	(if b_debug_cinematic_scripts (print "f_play_cinematic: calling cinematic_enter"))
	(cinematic_enter cinematic_name true)
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
	;(cinematic_skip_stop)		
)

(script static void (f_end_mission
						(string_id cinematic_name)
						(zone_set cinematic_zone_set)
					)
		
	(cinematic_enter cinematic_name true)	
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

(script static void f_hud_obj_complete
	(objectives_clear)
	(chud_show_screen_objective campaign_hud_objcomplete)
	(sleep 160)
	(chud_show_screen_objective "")
)


; =================================================================================================
; chapter tittes
; =================================================================================================
(script static void (f_hud_chapter (string_id string_hud))
	(chud_show_screen_chapter_title string_hud)
	(sleep 160)
	(chud_show_screen_chapter_title "")
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
(script static void (f_md_ai_play (short delay) (ai character) (ai_line line))
	(set b_is_dialogue_playing true)
	(set s_md_play_time (ai_play_line character line))
	(sleep s_md_play_time)
	(sleep delay)
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
; =================================================================================================
; globals
; =================================================================================================
(global boolean debug				true)
(global boolean editor_cinematics 	false)
(global boolean game_cinematics		true)

; objective control
(global short s_objcon_bch 0)
(global short s_objcon_fac 0)
(global short s_objcon_slo 0)

; encounter indices
(global short s_encounter_index_current 	-1)
(global short s_encounter_index_bch 		0)
(global short s_encounter_index_fac 		1)
(global short s_encounter_index_slo			2)
(global short s_encounter_index_waf 		3)
(global short s_encounter_index_wrp 		4)

; encounter
(global boolean b_bch_started 		false)
(global boolean b_fac_started 		false)
(global boolean b_slo_started		false)
(global boolean b_waf_started 		false)
(global boolean b_wrp_started		false)

(global boolean b_bch_completed 	false)
(global boolean b_fac_completed 	false)
(global boolean b_slo_completed		false)
(global boolean b_waf_completed 	false)
(global boolean b_wrp_completed		false)

; ai
(global ai ai_carter 	none)
(global ai ai_jorge 	none)
(global ai ai_kat 		none)

; clumps
(global short clump_corvette_aa		19)
(global short clump_seraphs			18)
(global short clump_sabres			17)
(global short clump_savannah_aa		16)
(global short clump_banshees		15)

; =================================================================================================
; master e3 script
; =================================================================================================
(script startup reach
	(if debug (print "::: e3 :::"))

	(if
		(or
			(editor_mode)
			(<= (player_count) 0)
		)
	
	; if game is allowed to start 
	
		(begin 
			(fade_out 0 0 0 0)
			(fade_in 0 0 0 0)
		)	
		(start)
	)
	
	; turn off training
	(hud_enable_training false)
	(object_cannot_die (player0) true)
	
	; fade out 
	(fade_in 0 0 0 0)
	
	; turns off player disable
	(player_disable_movement 0)

	;setup allegiance
	(ai_allegiance human player)
	(ai_allegiance player human)
	
	; combat dialogue
	(enable_spartan_combat_dialogue false)
	

	; objective control
	; -------------------------------------------------------------------------------------------------

			; beach
			; -------------------------------------------------------------------------------------------------
			(sleep_until (>= s_insertion_index s_encounter_index_bch) 1)
			(if (<= s_insertion_index s_encounter_index_bch) (wake bch_encounter))
			
			; command
			; -------------------------------------------------------------------------------------------------
			(sleep_until	(or
							(volume_test_players tv_fac_start)
							(= b_bch_completed true)
							(>= s_insertion_index s_encounter_index_fac)) 1)

			(if (<= s_insertion_index s_encounter_index_fac) (wake fac_encounter))	
			
			; silo
			; -------------------------------------------------------------------------------------------------
			(sleep_until	(or
							(volume_test_players tv_slo_start)
							(>= s_insertion_index s_encounter_index_slo)) 1)
			
			(if (<= s_insertion_index s_encounter_index_slo) (wake slo_encounter))

			; wafer
			; -------------------------------------------------------------------------------------------------
			(sleep_until	(or
							(= b_slo_completed true)
							(>= s_insertion_index s_encounter_index_waf)) 1)
			
			(if (<= s_insertion_index s_encounter_index_waf) (wake waf_encounter))
			
			; warp
			; -------------------------------------------------------------------------------------------------
			(sleep_until	(or
							(= b_waf_completed true)
							(>= s_insertion_index s_encounter_index_wrp)) 1)
			
			(if (<= s_insertion_index s_encounter_index_wrp) (wake wrp_encounter))
)

(script static void start
	(if debug (print "game mode. choosing insertion point..."))
	
	(cond
		((= (game_insertion_point_get) 0) (ins_beach))
		((= (game_insertion_point_get) 5) (print "::: loading in debug mode :::"))			
	)
)


; =================================================================================================
; beach
; =================================================================================================
(script dormant bch_encounter
	(if debug (print "::: starting beach encounter :::"))
	(set s_encounter_index_current s_encounter_index_bch)
	(data_mine_set_mission_segment "beach")
	
	; intro cinematic
	(if (or (not (editor_mode)) editor_cinematics)
		(if game_cinematics
			(cinematic_play_intro)))
		
	(prepare_to_switch_to_zone_set set_facility_001_005_010)

	; spartans
	
	
	; ai
	;(ai_place sq_cov_bch_cove_grunts0)
	;(ai_place sq_cov_bch_cove_elites0)

	; ambient events
	(wake bch_podfight_control)
	(wake bch_bombingrun_control)
	(wake bch_ghostcharge_control)
	(wake bch_trooper_control)
	(wake bch_fork_control)
	(wake bch_entrance_fight_control)
	
	; movement properties
	;(carter_run)
	;(jorge_run)
	;(kat_run)
	
	
	
	
	;objective control
	; -------------------------------------------------------------------------------------------------
	(set b_bch_started true)
	; -------------------------------------------------------------------------------------------------
	
			; -------------------------------------------------
			(bch_spartan_spawn)
			(bch_spartan_setup)
			(if (or (not (editor_mode)) editor_cinematics)
				(if game_cinematics
					(cinematic_exit 045la_katsplan_v2 false)))
					
			(if (<= s_objcon_bch 0)
				(begin
					;(ai_place sq_unsc_bch_falcon0)
					;(thespian_beach_start)
					(print "bah")
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_010)
		(>= s_objcon_bch 10)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 10)
				(begin
					(if debug (print "beach: objective control 010"))
					(set s_objcon_bch 10)
					
					(wake md_bch_jor_intro)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_020)
		(>= s_objcon_bch 20)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 20)
				(begin
					(if debug (print "beach: objective control 020"))
					(set s_objcon_bch 20)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_030)
		(>= s_objcon_bch 30)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 30)
				(begin
					(if debug (print "beach: objective control 030"))
					(set s_objcon_bch 30)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_040)
		(>= s_objcon_bch 40)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 40)
				(begin
					(if debug (print "beach: objective control 040"))
					(set s_objcon_bch 40)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_050)
		(>= s_objcon_bch 50)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 50)
				(begin
					(if debug (print "beach: objective control 050"))
					(set s_objcon_bch 50)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_060)
		(>= s_objcon_bch 60)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 60)
				(begin
					(if debug (print "beach: objective control 060"))
					(set s_objcon_bch 60)
					
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_070)
		(>= s_objcon_bch 70)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 70)
				(begin
					(if debug (print "beach: objective control 070"))
					(set s_objcon_bch 70)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_074)
		(>= s_objcon_bch 74)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 74)
				(begin
					(if debug (print "beach: objective control 074"))
					(set s_objcon_bch 74)
					
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_077)
		(>= s_objcon_bch 77)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 77)
				(begin
					(if debug (print "beach: objective control 077"))
					(set s_objcon_bch 77)
					
				)
			)
			; -------------------------------------------------
; *********************************
; tipul's work begins again
; renumbered a bunch of triggers
; *********************************

	(sleep_until (or
		(volume_test_players tv_objcon_bch_080)
		(>= s_objcon_bch 80)) 1)
			
			; -------------------------------------------------
			(if (<= s_objcon_bch 80)
				(begin
					(if debug (print "beach: objective control 080"))
					(set s_objcon_bch 80)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or
		(volume_test_players tv_objcon_bch_085)
		(>= s_objcon_bch 85)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 85)
				(begin
					(if debug (print "beach: objective control 085"))
					(set s_objcon_bch 85)
					
					;(ai_place gr_cov_bch_entrance)
					(bring_spartans_forward 7)
					(ai_place sq_unsc_bch_troopers0)
				)
			)
			
			
			; -------------------------------------------------
		
	(sleep_until (or
		(volume_test_players tv_objcon_bch_090)
		(>= s_objcon_bch 90)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 90)
				(begin
					(if debug (print "beach: objective control 090"))
					(set s_objcon_bch 90)
				)
			)
			
			
			; -------------------------------------------------
		
	(sleep_until (or
		(volume_test_players tv_objcon_bch_100)
		(>= s_objcon_bch 100)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 100)
				(begin
					(if debug (print "beach: objective control 100"))
					(set s_objcon_bch 100)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_110)
		(>= s_objcon_bch 110)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 110)
				(begin
					(if debug (print "beach: objective control 110"))
					(set s_objcon_bch 110)
				)
			)
			; -------------------------------------------------

	(sleep_until (or
		(volume_test_players tv_objcon_bch_120)
		(>= s_objcon_bch 120)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 120)
				(begin
					(if debug (print "beach: objective control 120"))
					(set s_objcon_bch 120)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_130)
		(>= s_objcon_bch 130)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 130)
				(begin
					(if debug (print "beach: objective control 130"))
					(set s_objcon_bch 130)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_140)
		(>= s_objcon_bch 140)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 140)
				(begin
					(if debug (print "beach: objective control 140"))
					(set s_objcon_bch 140)	
				)
			)
			; -------------------------------------------------			
	
	(set b_bch_completed true)
)


; allies
; -------------------------------------------------------------------------------------------------
(script static void bch_spartan_spawn
	(if debug (print "::: spawning beach spartans"))
	(ai_erase gr_unsc_spartans)
	(ai_place sq_carter/bch)
	(ai_place sq_jorge/bch)
	(ai_place sq_kat/bch)
	(sleep 1)
	
	(set ai_carter sq_carter)
	(set ai_jorge sq_jorge)
	(set ai_kat sq_kat)
	
	(ai_cannot_die ai_carter true)
	(ai_cannot_die ai_jorge true)
	(ai_cannot_die ai_kat true)
)


(script static void bch_spartan_setup
	(if debug (print "::: spartans now in obj_unsc_bch"))
	(ai_set_objective gr_unsc_spartans obj_unsc_bch)
)


; encounter logic
; -------------------------------------------------------------------------------------------------
(script dormant bch_trooper_control
	(sleep_until (>= s_objcon_bch 50))
	(ai_place sq_unsc_fac_troopers0)
	;(ai_place sq_unsc_bch_troopers1)
	(sleep 5)
	(ai_cannot_die sq_unsc_fac_troopers0 true)
	
	;*
	(sleep_until
		(begin
			(ai_renew gr_unsc)
			(sleep 90)
		0)
	1)
	*;
)

(script command_script cs_bch_aa_idle
	(sleep_until
		(begin
			(begin_random_count 1
				(cs_shoot_point true ps_bch_aa/idle_target0)
				(cs_shoot_point true ps_bch_aa/idle_target1)
				(cs_shoot_point true ps_bch_aa/idle_target2)
			)
			(sleep (random_range 90 150))
		0)
	1)
)

(script command_script cs_bch_falcon0_exit
	(vehicle_hover (ai_vehicle_get ai_current_actor) true)
	
	(sleep 90)
	(vehicle_hover (ai_vehicle_get ai_current_actor) false)
	(cs_fly_to_and_face ps_bch_falcon0/hover ps_bch_falcon0/exit0)
	
	(cs_fly_by ps_bch_falcon0/exit0)
	(cs_fly_by ps_bch_falcon0/exit1)
	(cs_fly_by ps_bch_falcon0/exit2)
	
	(ai_erase ai_current_squad)
)

;*
(script command_script cs_bch_fork0
	(cs_vehicle_speed 1.0)
		;(cs_vehicle_boost true)
	; load
	(f_load_fork_cargo (ai_vehicle_get ai_current_actor) "small" sq_cov_bch_ghost0 none none)
	(f_load_fork (ai_vehicle_get ai_current_actor) "left" sq_cov_bch_entrance_elites0 none sq_cov_bch_entrance_grunts0 none)

	(cs_fly_by ps_bch_fork0/entry2)
		(cs_vehicle_boost false)
	(cs_fly_by ps_bch_fork0/entry1)
		(cs_vehicle_speed 0.7)
	(cs_fly_by ps_bch_fork0/entry0)
		(cs_vehicle_speed 0.5)
	(cs_fly_to ps_bch_fork0/hover 0.25)
		(sleep 45)
	
	(cs_fly_to_and_face ps_bch_fork0/land ps_bch_fork0/land_facing 0.3)
		(sleep 30)
	
	; unload
	(f_unload_fork_cargo (ai_vehicle_get ai_current_actor) "small")
	(f_unload_fork (ai_vehicle_get ai_current_actor) "left")
		(sleep 30)

	(cs_fly_to_and_face ps_bch_fork0/hover ps_bch_fork0/land_facing 0.25)
		(sleep 30)
		
	(cs_vehicle_speed 0.7)
	(cs_fly_by ps_bch_fork0/exit0)
	
	(cs_vehicle_speed 1.0)
	;(cs_vehicle_boost true)
	(cs_fly_by ps_bch_fork0/exit1)
	(cs_fly_by ps_bch_fork0/exit2)

	(ai_erase ai_current_squad)
)
*;
(script command_script cs_bch_troopers_retreat
	(cs_enable_targeting 1)
	(cs_shoot 1)
	(cs_go_to ps_bch_troopers/fallback0)
	
	(ai_erase ai_current_actor)
)



; =================================================================================================
; facility
; =================================================================================================
(script dormant fac_encounter
	(if debug (print "::: starting launch facility encounter :::"))
	
	; objects
	(object_destroy sc_wall_panel)
	
	;(spartans_run)
	(fac_spartan_setup)
	
	; scripts
	(wake fac_deadman_control)
	(wake fac_entrance_control)
	(wake fac_airstrike_control)
	
	; objective control
	; -------------------------------------------------------------------------------------------------
	(set b_fac_started true)
	; -------------------------------------------------------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_010)
		(>= s_objcon_fac 10)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 10)
				(begin
					(if debug (print "facility: objective control 010"))
					(set s_objcon_fac 10)
					
					(wake md_bch_trf_spartans_coming)
					(thespian_performance_setup_and_begin thespian_facility_entrance_left "" 0)
					(thespian_performance_setup_and_begin thespian_facility_entrance_right "" 0)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or
		(volume_test_players tv_objcon_fac_020)
		(>= s_objcon_fac 20)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 20)
				(begin
					(if debug (print "facility: objective control 020"))
					(set s_objcon_fac 20)
					;(ai_place sq_cov_fac_beach_chasers)
					;(ai_set_targeting_group sq_cov_fac_beach_chasers 6)
					;(ai_set_targeting_group sq_unsc_fac_troopers0 6)
					
					
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_030)
		(>= s_objcon_fac 30)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 30)
				(begin
					(if debug (print "facility: objective control 030"))
					(set s_objcon_fac 30)
					
					(wake md_fac_jor_holland_said)
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_040)
		(>= s_objcon_fac 40)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 40)
				(begin
					(if debug (print "facility: objective control 040"))
					(set s_objcon_fac 40)
					
					(ai_place sq_unsc_fac_hall_trooper0)
					
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_050)
		(>= s_objcon_fac 50)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 50)
				(begin
					(if debug (print "facility: objective control 050"))
					(set s_objcon_fac 50)
					
					
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_060)
		(>= s_objcon_fac 60)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 60)
				(begin
					(if debug (print "facility: objective control 060"))
					(set s_objcon_fac 60)
					
					(bring_spartans_forward 5)
				)
			)
			
			(ai_erase sq_cov_fac_beach_chasers)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_070)
		(>= s_objcon_fac 70)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 70)
				(begin
					(if debug (print "facility: objective control 070"))
					(set s_objcon_fac 70)
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_080)
		(>= s_objcon_fac 80)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 80)
				(begin
					(if debug (print "facility: objective control 080"))
					(set s_objcon_fac 80)
				)
			)
			
			(slo_setup_bodies)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_090)
		(>= s_objcon_fac 90)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 90)
				(begin
					(if debug (print "facility: objective control 090"))
					(set s_objcon_fac 90)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_100)
		(>= s_objcon_fac 100)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 100)
				(begin
					(if debug (print "facility: objective control 100"))
					(set s_objcon_fac 100)
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_110)
		(>= s_objcon_fac 110)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 110)
				(begin
					(if debug (print "facility: objective control 110"))
					(set s_objcon_fac 110)
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_115)
		(>= s_objcon_fac 115)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 115)
				(begin
					(if debug (print "facility: objective control 115"))
					(set s_objcon_fac 115)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_120)
		(>= s_objcon_fac 120)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 120)
				(begin
					(if debug (print "facility: objective control 120"))
					(set s_objcon_fac 120)
					
					(ai_place sq_cov_fac_hall_grunts0)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_130)
		(>= s_objcon_fac 130)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 130)
				(begin
					(if debug (print "facility: objective control 130"))
					(set s_objcon_fac 130)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_140)
		(>= s_objcon_fac 140)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 140)
				(begin
					(if debug (print "facility: objective control 140"))
					(set s_objcon_fac 140)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_150)
		(>= s_objcon_fac 150)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 150)
				(begin
					(if debug (print "facility: objective control 150"))
					(set s_objcon_fac 150)
				)
			)
			; -------------------------------------------------
	
	(set b_fac_completed true)
)

; allies
; -------------------------------------------------------------------------------------------------
(script static void fac_spartan_spawn
	(ai_erase gr_unsc_spartans)
	
	(ai_place sq_carter/fac)
	(ai_place sq_jorge/fac)
	(ai_place sq_kat/fac)
	(sleep 1)
	
	(set ai_carter sq_carter)
	(set ai_jorge sq_jorge)
	(set ai_kat sq_kat)
	
	(ai_cannot_die ai_carter true)
	(ai_cannot_die ai_jorge true)
	(ai_cannot_die ai_kat true)
)

(script static void fac_spartan_setup
	(if debug (print "::: starting silo encounter :::"))
	(ai_set_objective gr_unsc_spartans obj_unsc_fac)
)

; encounter logic
; -------------------------------------------------------------------------------------------------
(script command_script cs_fac_fork0
	(f_load_phantom (ai_vehicle_get ai_current_actor) "left" sq_cov_fac_dock0 none none none)
	(f_load_phantom_cargo (ai_vehicle_get ai_current_actor) "single" sq_cov_fac_wraith0 none)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_fac_fork0/entry0)
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face ps_fac_fork0/hover ps_fac_fork0/land_facing 0.25)

	(sleep 30)
	
	(cs_fly_to_and_face ps_fac_fork0/land ps_fac_fork0/land_facing 0.25)
	
		(wake fac_unload_phantom_infantry)
		(sleep 90)
		(wake fac_unload_phantom_cargo)
	
	(sleep 30)
	(cs_vehicle_speed 0.25)
	(cs_fly_to_and_face ps_fac_fork0/hover ps_fac_fork0/land_facing 0.25)
	;(ai_erase ai_current_squad)
	(object_damage_damage_section (ai_vehicle_get ai_current_actor) "body" 5000)
)

(script dormant fac_unload_phantom_infantry
	(f_unload_phantom (ai_vehicle_get_from_starting_location sq_cov_fac_phantom0/pilot) "left")
)

(script dormant fac_unload_phantom_cargo
	(f_unload_phantom_cargo (ai_vehicle_get_from_starting_location sq_cov_fac_phantom0/pilot) "single")
)

(script command_script cs_fac_hall_trooper0
	(cs_go_by ps_fac_hall_trooper/p0 ps_fac_hall_trooper/p0)
	(cs_go_by ps_fac_hall_trooper/p1 ps_fac_hall_trooper/p1)
	(cs_go_by ps_fac_hall_trooper/p2 ps_fac_hall_trooper/p2)
	(cs_go_by ps_fac_hall_trooper/p3 ps_fac_hall_trooper/p3)
	(ai_erase ai_current_squad)
)


; =================================================================================================
; launch
; =================================================================================================
(global boolean b_slo_kat_hack_completed false)
(global boolean b_slo_shutter_override false)
; -------------------------------------------------------------------------------------------------

(script dormant slo_encounter
	(if debug (print "::: starting launch silo encounter :::"))

	(slo_spartan_setup)

	; scripts
	(wake slo_fight_control)
	;(wake slo_shutter_control)
	(wake slo_light_control)
	
	
	; objective control
	; -------------------------------------------------------------------------------------------------
	(set b_slo_started true)
	; -------------------------------------------------------------------------------------------------

	(sleep_until (or
		(volume_test_players tv_objcon_slo_010)
		(>= s_objcon_slo 10)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 10)
				(begin
					(if debug (print "silo: objective control 010"))
					(set s_objcon_slo 10)
					
					(wake md_slo_control_room)
					
				)
			)
			
			(device_set_position dm_slo_shutter 1)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_020)
		(>= s_objcon_slo 20)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 20)
				(begin
					(if debug (print "silo: objective control 020"))
					(set s_objcon_slo 20)
					
					(bring_spartans_forward 5)
					
					;(wake slo_shutter_override)
					
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_030)
		(>= s_objcon_slo 30)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 30)
				(begin
					(if debug (print "silo: objective control 030"))
					(set s_objcon_slo 30)
					
					(wake slo_bombingrun_start)
				)
			)
			
			
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_040)
		(>= s_objcon_slo 40)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 40)
				(begin
					(if debug (print "silo: objective control 040"))
					(set s_objcon_slo 40)
				)
			)
			; -------------------------------------------------

	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_050)
		(>= s_objcon_slo 50)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 50)
				(begin
					(if debug (print "silo: objective control 050"))
					(set s_objcon_slo 50)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_060)
		(>= s_objcon_slo 60)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 60)
				(begin
					(if debug (print "silo: objective control 060"))
					(set s_objcon_slo 60)
					
					(bring_spartans_forward 5)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_070)
		(>= s_objcon_slo 70)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 70)
				(begin
					(if debug (print "silo: objective control 070"))
					(set s_objcon_slo 70)
					
					(thespian_performance_setup_and_begin thespian_silo_salute0 "" 0)
					(thespian_performance_setup_and_begin thespian_silo_salute1 "" 0)
				)
			)
			
			(ai_kill sq_cov_slo_top_elite0)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_080)
		(>= s_objcon_slo 80)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 80)
				(begin
					(if debug (print "silo: objective control 090"))
					(set s_objcon_slo 80)
					
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_090)
		(>= s_objcon_slo 90)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 90)
				(begin
					(if debug (print "silo: objective control 090"))
					(set s_objcon_slo 90)
				)
			)
			
			
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_100)
		(>= s_objcon_slo 100)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 100)
				(begin
					(if debug (print "silo: objective control 0100"))
					(set s_objcon_slo 100)
					
					(wake md_slo_tr_sabre_ready)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_110)
		(>= s_objcon_slo 110)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 110)
				(begin
					(if debug (print "silo: objective control 110"))
					(set s_objcon_slo 110)
					
					(bring_spartans_forward 5)
				)
			)
			; -------------------------------------------------
	
	;(sleep_until (= (device_group_get dg_launch) 1) 1)
	(sleep_until (volume_test_players tv_slo_launch) 1)
	(if debug (print "launch: player has entered sabre"))
			
			; -------------------------------------------------
			(device_set_power c_launch 0)
	
			(cinematic_enter 045la_blastoff true)
			(sleep 30)
			
			;(object_destroy dm_sabre)
			(object_destroy sc_slo_sabre)
			(object_destroy_folder dm_bch_elite_pods)
			(object_destroy_folder dm_bch_skybox_pods)
			(object_destroy_folder v_bch)
			(object_destroy_folder sc_bch)
			(object_destroy_folder cr_bch)
			(slo_bombingrun_kill)
						
			(if debug (print "launch: starting cinematic!"))
			(f_play_cinematic_advanced 045la_blastoff set_launch_010_015_019 set_wafercombat_030)
			
			(if debug (print "launch: done with cinematic!"))
			(garbage_collect_unsafe)	
			
			; -------------------------------------------------
	
	(set b_slo_completed true)
)

(script static void slo_spartan_spawn
	(ai_erase gr_unsc_spartans)
	
	(ai_place sq_carter/slo)
	(ai_place sq_jorge/slo)
	(ai_place sq_kat/slo)
	(sleep 1)
	
	(set ai_carter sq_carter)
	(set ai_jorge sq_jorge)
	(set ai_kat sq_kat)
	
	(ai_cannot_die ai_carter true)
	(ai_cannot_die ai_jorge true)
	(ai_cannot_die ai_kat true)
)

(script static void slo_spartan_setup
	(if debug (print "::: spartans now in obj_unsc_slo"))
	(ai_set_objective gr_unsc_spartans obj_unsc_slo)
)

(script dormant slo_shutter_control
	(sleep_until 
		(or 
			b_slo_kat_hack_completed
			b_slo_shutter_override
		)
	)
	
	(if debug (print "opening door!"))
	(device_set_position dm_slo_shutter 1)
	
)

(script dormant slo_shutter_override
	(sleep (* 30 15))
	(if (not (= b_slo_kat_hack_completed true))	
		(set b_slo_shutter_override 1))
)


; =================================================================================================
; wafer encounter
; =================================================================================================
(global boolean b_waf_aa_online false)
; -------------------------------------------------------------------------------------------------
(script dormant waf_encounter
	(if debug (print "encounter: wafer"))
	;(set s_current_encounter s_waf_encounter_index)
	(data_mine_set_mission_segment "wafer")
	(game_insertion_point_unlock 1)
	(fade_out 1 1 1 0)
	
	(md_stop)
	
	(physics_set_gravity 0)
	(switch_zone_set set_wafercombat_030)
	(sleep 5)
	
	(disable_planetary_zonesets)
	(sleep 1)
	
	; object management
	(soft_ceiling_enable corvette false)
	(object_create_folder cr_waf)
	(object_create_folder sc_waf)
	
	; scene setup
	;(waf_savannah_dock)
	;(sfx_attach_chatter)
	; slam player into driver seat 
	(create_player_sabres
		v_wafer_sabre_player0 
		v_wafer_sabre_player1 
		v_wafer_sabre_player2 
		v_wafer_sabre_player3)	
	(load_player_sabres
		v_wafer_sabre_player0 
		v_wafer_sabre_player1 
		v_wafer_sabre_player2 
		v_wafer_sabre_player3)	
		
	; scripts
	(wake waf_sabres_undock_control)
	(wake waf_savannah_engine_control)
		
	; objective control
	; -------------------------------------------------------------------------------------------------
	(set b_waf_started true)
	; -------------------------------------------------------------------------------------------------
			
			; -------------------------------------------------
			(ai_place sq_unsc_waf_sabres0)
			(ai_place sq_unsc_waf_aa)
			(sfx_attach_chatter)
			(waf_savannah_dock)
			(sleep 30)
			(game_save_immediate)
			(cinematic_exit 045la_blastoff true)	
			
			(md_waf_hol_intro)
			; -------------------------------------------------
	
	(sleep_until (>= (device_get_position dm_savannah_wafer) 0.7))
			
			; -------------------------------------------------
			(md_waf_jor_contacts)
			
			;(md_waf_jor_contacts)
			(wake show_objective_wafer_defense)
			(game_save)
				(sleep (* 30 2))
			
			(f_blip_flag fl_wafer_signatures blip_recon)
			;(show_warning ct_warning_fighters)
				(sleep (* 30 5))
			
			(garbage_collect_now)
			(wake waf_spawn_wave0_seraphs)
			(wake waf_spawn_wave0_banshees)
				(sleep (* 30 2))
			
			(f_unblip_flag fl_wafer_signatures)
			; -------------------------------------------------
	(sleep_until (<= (ai_living_count gr_cov_waf) 3))
	(waf_blip_living_covenant)	
	(sleep_until (<= (ai_living_count gr_cov_waf) 0))
	
			; -------------------------------------------------
			(md_waf_an9_station_defenses_online)
			
			(set b_waf_aa_online true)
			
			(wake waf_spawn_wave1_seraphs)
			(wake waf_spawn_wave1_banshees)
			; -------------------------------------------------
	
	(sleep_until (<= (ai_living_count gr_cov_waf) 3))
	(waf_blip_living_covenant)		
	(sleep_until (<= (ai_living_count gr_cov_waf) 0))
	
	
	(set b_waf_completed true)
	;(set_sabre_respawns true)
	
	; ai
	;(ai_place sq_unsc_waf_sbr_start)
	
	; scripts
	;(wake waf_garbage_collector)
)

(script command_script cs_waf_aa_control
	(cs_enable_looking 0)
	(cs_enable_targeting 0)
	(sleep_until b_waf_aa_online (random_range 10 20))
)

(script dormant waf_savannah_engine_control
	(sleep_until (>= (device_get_position dm_savannah_wafer) 0.9))
	(object_set_function_variable dm_savannah_wafer frigate_engines 0.05 5)
	; throttle fx
)

; -------------------------------------------------------------------------------------------------
(script dormant waf_spawn_wave0_seraphs
	(waf_seraph_spawn_immediate 4))
	
(script dormant waf_spawn_wave0_banshees
	(waf_banshee_spawn_immediate 8))

(script dormant waf_spawn_wave1_seraphs
	(waf_seraph_spawn_immediate 8))
	
(script dormant waf_spawn_wave1_banshees
	(waf_banshee_spawn_immediate 16))


; -------------------------------------------------------------------------------------------------
(script dormant waf_sabres_undock_control
	(sleep_until (<= (objects_distance_to_flag (player0) fl_waf_anchor_center) 300))
	(waf_replenish_sabres)
)


; seraph wave spawning
; -------------------------------------------------------------------------------------------------
(global short s_waf_seraph_spawn_remaining 0)
(global real r_phantom_approach_speed 0.75)
; -------------------------------------------------------------------------------------------------
(script static void (waf_seraph_spawn_immediate (short count))
	(ai_designer_clump_perception_range 600)
	(sleep_until (<= s_waf_seraph_spawn_remaining 0) 1)
	(set s_waf_seraph_spawn_remaining count)
	(sleep_until
		(begin
			; -------------------------------------------------
			; 3 or more seraphs are supposed to spawn
			(if (>= s_waf_seraph_spawn_remaining 3)
				(begin
					(waf_spawn_seraph_center_3)
					(set s_waf_seraph_spawn_remaining (- s_waf_seraph_spawn_remaining 3))))	
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_seraph_spawn_remaining 2)
				(begin
					(waf_spawn_seraph_center_2)
					(set s_waf_seraph_spawn_remaining (- s_waf_seraph_spawn_remaining 2))))
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_seraph_spawn_remaining 1)
				(begin
					(waf_spawn_seraph_center_1)
					(set s_waf_seraph_spawn_remaining (- s_waf_seraph_spawn_remaining 1))))
			; -------------------------------------------------
			
		(<= s_waf_seraph_spawn_remaining 0))
	1)
)

(script static void waf_spawn_seraph_center_3
	(if debug (print "waf: spawning center seraphs (count 3)..."))
	(ai_place sq_cov_waf_sph_center3/seraph0)
	(seraph_warp_stagger)
	(ai_place sq_cov_waf_sph_center3/seraph1)
	(seraph_warp_stagger)
	(ai_place sq_cov_waf_sph_center3/seraph2)
	(seraph_warp_stagger)
	
	(ai_set_clump sq_cov_waf_sph_center3 clump_seraphs)
)

(script static void waf_spawn_seraph_center_2
	(if debug (print "waf: spawning center seraphs (count 2)..."))
	(ai_place sq_cov_waf_sph_center2/seraph0)
	(seraph_warp_stagger)
	(ai_place sq_cov_waf_sph_center2/seraph1)
	(seraph_warp_stagger)
	
	(ai_set_clump sq_cov_waf_sph_center2 clump_seraphs)
)

(script static void waf_spawn_seraph_center_1
	(if debug (print "waf: spawning center seraphs (count 1)..."))
	(ai_place sq_cov_waf_sph_center1/seraph0)
	(seraph_warp_stagger)
	(ai_set_clump sq_cov_waf_sph_center1 clump_seraphs)
)


; banshee wave spawning
; -------------------------------------------------------------------------------------------------
(global short s_waf_banshee_spawn_remaining 0)
; -------------------------------------------------------------------------------------------------
(script static void (waf_banshee_spawn_immediate (short count))
	(ai_designer_clump_perception_range 600)
	(sleep_until (<= s_waf_banshee_spawn_remaining 0) 1)
	(set s_waf_banshee_spawn_remaining count)
	(sleep_until
		(begin
			; -------------------------------------------------
			; 7 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 7)
				(begin
					(waf_spawn_banshee_center_7)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 7))))
					
			; 5 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 5)
				(begin
					(waf_spawn_banshee_center_5)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 5))))		
					
			; 3 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 3)
				(begin
					(waf_spawn_banshee_center_3)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 3))))	
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 2)
				(begin
					(waf_spawn_banshee_center_2)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 2))))
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 1)
				(begin
					(waf_spawn_banshee_center_1)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 1))))
			; -------------------------------------------------
			
		(<= s_waf_banshee_spawn_remaining 0))
	1)
)
	
(script static void waf_spawn_banshee_center_7
	(if debug (print "waf: spawning center banshees (count 7)..."))
	(ai_place sq_cov_waf_bsh_center7/banshee0)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee1)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee2)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee3)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee4)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee5)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee6)
	
	(ai_set_clump sq_cov_waf_bsh_center7 clump_banshees)
)

(script static void waf_spawn_banshee_center_5
	(if debug (print "waf: spawning center banshees (count 5)..."))
	(ai_place sq_cov_waf_bsh_center5/banshee0)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center5/banshee1)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center5/banshee2)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center5/banshee3)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center5/banshee4)
	
	(ai_set_clump sq_cov_waf_bsh_center5 clump_banshees)
)

(script static void waf_spawn_banshee_center_3
	(if debug (print "waf: spawning center banshees (count 3)..."))
	(ai_place sq_cov_waf_bsh_center3/banshee0)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center3/banshee1)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center3/banshee2)
	
	(ai_set_clump sq_cov_waf_bsh_center3 clump_banshees)
)

(script static void waf_spawn_banshee_center_2
	(if debug (print "waf: spawning center banshees (count 2)..."))
	(ai_place sq_cov_waf_bsh_center2/banshee0)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center2/banshee1)
	
	(ai_set_clump sq_cov_waf_bsh_center2 clump_banshees)
)

(script static void waf_spawn_banshee_center_1
	(if debug (print "waf: spawning center banshees (count 1)..."))
	(ai_place sq_cov_waf_bsh_center1/banshee0)
	
	(ai_set_clump sq_cov_waf_bsh_center2 clump_banshees)
)



; sabre wave spawning
; -------------------------------------------------------------------------------------------------
(global short s_waf_sabre_spawn_remaining 0)
; -------------------------------------------------------------------------------------------------
(script static void (waf_sabre_spawn_immediate (short count))
	(ai_designer_clump_perception_range 600)
	(sleep_until (<= s_waf_sabre_spawn_remaining 0) 1)
	(set s_waf_sabre_spawn_remaining count)
	(sleep_until
		(begin
			; -------------------------------------------------
			; 3 or more seraphs are supposed to spawn
			(if (>= s_waf_sabre_spawn_remaining 3)
				(begin
					(waf_spawn_sabre_center_3)
					(set s_waf_sabre_spawn_remaining (- s_waf_sabre_spawn_remaining 3))))	
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_sabre_spawn_remaining 2)
				(begin
					(waf_spawn_sabre_center_2)
					(set s_waf_sabre_spawn_remaining (- s_waf_sabre_spawn_remaining 2))))
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_sabre_spawn_remaining 1)
				(begin
					(waf_spawn_sabre_center_1)
					(set s_waf_sabre_spawn_remaining (- s_waf_sabre_spawn_remaining 1))))
			; -------------------------------------------------
			
		(<= s_waf_sabre_spawn_remaining 0))
	1)
)
	
(script static void waf_spawn_sabre_center_3
	(if debug (print "waf: spawning station sabres (count 3)..."))
	(ai_place sq_unsc_waf_sbr_station3/sabre0)
	(sabre_station_stagger)
	(ai_place sq_unsc_waf_sbr_station3/sabre1)
	(sabre_station_stagger)
	(ai_place sq_unsc_waf_sbr_station3/sabre2)
	(sabre_station_stagger)
	
	(ai_set_clump sq_unsc_waf_sbr_station3 clump_sabres)
)

(script static void waf_spawn_sabre_center_2
	(if debug (print "waf: spawning station sabres (count 2)..."))
	(ai_place sq_unsc_waf_sbr_station2/sabre0)
	(sabre_station_stagger)
	(ai_place sq_unsc_waf_sbr_station2/sabre1)
	(sabre_station_stagger)
	
	(ai_set_clump sq_unsc_waf_sbr_station2 clump_sabres)
)

(script static void waf_spawn_sabre_center_1
	(if debug (print "waf: spawning station sabres (count 1)..."))
	(ai_place sq_unsc_waf_sbr_station1/sabre0)
	(sabre_station_stagger)
	
	(ai_set_clump sq_unsc_waf_sbr_station1 clump_sabres)
)

(script static void waf_replenish_sabres
	(waf_sabre_spawn_immediate (- 8 (ai_living_count gr_unsc_waf_sabres))))



; =================================================================================================
; warp
; =================================================================================================
(script dormant wrp_encounter
	(if debug (print "encounter: warp from wafer to corvette"))
	(data_mine_set_mission_segment "post-wafer")
	
	; objective control
	; -------------------------------------------------------------------------------------------------
	;(set b_wrp_started true)
	; -------------------------------------------------------------------------------------------------

			; -------------------------------------------------
			(sleep 60)
			(md_wrp_an9_ships_neutralized)
			(fade_out 1 1 1 90)
			(game_won)
			;(f_blip_flag fl_wafer_land blip_interface)
			;(new_mission_objective 7 ct_obj_wafer_dock)
			;(wake show_objective_wafer_dock)
			; -------------------------------------------------
;*
	(sleep_until (volume_test_players tv_wafer_land) 1)
	(if debug (print "warp: player is now docking with the wafer..."))
	
			; -------------------------------------------------
			(f_unblip_flag fl_wafer_land)
			
			; players can't slam into the docking bay
			(object_cannot_take_damage v_wafer_sabre_player0)
			(object_cannot_take_damage v_wafer_sabre_player1)
			(object_cannot_take_damage v_wafer_sabre_player2)
			(object_cannot_take_damage v_wafer_sabre_player3)
			
			(object_cannot_take_damage v_warp_sabre_player0)
			(object_cannot_take_damage v_warp_sabre_player1)
			(object_cannot_take_damage v_warp_sabre_player2)
			(object_cannot_take_damage v_warp_sabre_player3)
			
			(cinematic_enter 045lb_pitstop true)
			
			(sfx_detach_chatter)
			;(replenish_players)
			;(mus_kill mus_new1b_hi)
			;(mus_play mus_warp)
			
			(teleport_players
				fl_warp_teleport0
				fl_warp_teleport1
				fl_warp_teleport2
				fl_warp_teleport3)
			
			(object_destroy dm_savannah_wafer)
			(object_destroy_folder v_warp_sabres)
			(object_destroy_folder v_wafer_sabres)
			
			;(wake md_wrp_jor_my_stop)
			;(object_destroy_folder cr_waf_asteroids)
			;(cinematic_skip_stop_internal)
			(ai_erase_all)
			(f_play_cinematic_advanced 045lb_pitstop set_warp_030_040 set_corvettecombat_050_070)
	*;
			; -------------------------------------------------	

	;(game_won)
	; (set b_wrp_completed true)
	
)

; -------------------------------------------------------------------------------------------------
; warping
; -------------------------------------------------------------------------------------------------
(global effect fx_warp_flash objects\vehicles\covenant\seraph\fx\warp\warp.effect)
(global sound sfx_warp sound\vehicles\seraph\seraph_slip_space.sound)
(global looping_sound sfx_chatter sound\prototype\radio_chatter\radio_chatter_loop\radio_chatter_loop.sound_looping)
(global boolean b_play_warp_sound true)
; -------------------------------------------------------------------------------------------------

(script command_script cs_sabre_warp
	(effect_new_on_object_marker fx_warp_flash (ai_vehicle_get ai_current_actor) "ai_antenna_center")
	;(if b_play_warp_sound
		;(sound_impulse_start sfx_warp (ai_vehicle_get ai_current_actor) 1.0))
	(object_set_velocity (ai_vehicle_get ai_current_actor) 120)	
)

(script command_script cs_sabre_exit_station
	(object_set_velocity (ai_vehicle_get ai_current_actor) 20)	
)

(script command_script cs_banshee_warp
	(effect_new_on_object_marker fx_warp_flash (ai_vehicle_get ai_current_actor) "fx_warp")
	;(if b_play_warp_sound
		;(sound_impulse_start sfx_warp (ai_vehicle_get ai_current_actor) 1.0))
	(object_set_velocity (ai_vehicle_get ai_current_actor) 100)	
)

(script command_script cs_seraph_warp
	(effect_new_on_object_marker fx_warp_flash (ai_vehicle_get ai_current_actor) "fx_warp")
	;(if b_play_warp_sound
		;(sound_impulse_start sfx_warp (ai_vehicle_get ai_current_actor) 1.0))
	(object_set_velocity (ai_vehicle_get ai_current_actor) 100)	
)

(script command_script cs_phantom_warp
	(effect_new_on_object_marker fx_warp_flash (ai_vehicle_get ai_current_actor) "fx_warp")
	;(if b_play_warp_sound
		;(sound_impulse_start sfx_warp (ai_vehicle_get ai_current_actor) 1.0))
	(object_set_velocity (ai_vehicle_get ai_current_actor) 40)	
)

(script static void banshee_warp_stagger
	(sleep (random_range 5 15)))

(script static void seraph_warp_stagger
	(sleep (random_range 5 20)))
	
(script static void sabre_station_stagger
	(sleep (random_range 15 25)))
	
(script static void sabre_warp_stagger
	(sleep (random_range 5 20)))
	

; =================================================================================================
; helpers
; =================================================================================================
(script static void (bring_spartans_forward (real dist))
	(if debug (print "bringing spartans forward..."))
	(ai_bring_forward (ai_get_object sq_jorge) dist)
	(ai_bring_forward (ai_get_object sq_carter) dist)
	(ai_bring_forward (ai_get_object sq_kat) dist)
)

(script command_script cs_gunner_hold
	(if debug (print "chin gunner holding..."))
	(cs_enable_looking false)
	(cs_enable_targeting false)
	(sleep 9999)
	(sleep_forever)
)


(script static void waf_fly
	(if debug (print "new wafer sabre to test..."))
	(vehicle_unload v_test_waf_sabre "")
	(object_create_anew v_test_waf_sabre)
	(vehicle_load_magic v_test_waf_sabre "warthog_d" (player0))
)

(script static void disable_planetary_zonesets
	(if debug (print "disabling planetary zone sets..."))
	(zone_set_trigger_volume_enable zone_set:set_facility_001_005_010 false)
	(zone_set_trigger_volume_enable begin_zone_set:set_launch_010_015_019 false)
	(zone_set_trigger_volume_enable zone_set:set_silo_005_010_015 false)
	(zone_set_trigger_volume_enable begin_zone_set:set_silo_005_010_015 false)
)

(script static void waf_blip_living_covenant
	(if debug (print "blipping final covenant..."))
	(blip_ai_object sq_cov_waf_bsh_center7/banshee0)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee1)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee2)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee3)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee4)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee5)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee6)
	
	(blip_ai_object sq_cov_waf_bsh_center5/banshee0)
	(blip_ai_object sq_cov_waf_bsh_center5/banshee1)
	(blip_ai_object sq_cov_waf_bsh_center5/banshee2)
	(blip_ai_object sq_cov_waf_bsh_center5/banshee3)
	(blip_ai_object sq_cov_waf_bsh_center5/banshee4)
	
	(blip_ai_object sq_cov_waf_bsh_center3/banshee0)
	(blip_ai_object sq_cov_waf_bsh_center3/banshee1)
	(blip_ai_object sq_cov_waf_bsh_center3/banshee2)
	
	(blip_ai_object sq_cov_waf_bsh_center2/banshee0)
	(blip_ai_object sq_cov_waf_bsh_center2/banshee1)
	
	(blip_ai_object sq_cov_waf_bsh_center1/banshee0)
	
	; -------------------------------------------------
	
	(blip_ai_object sq_cov_waf_sph_center3/seraph0)
	(blip_ai_object sq_cov_waf_sph_center3/seraph1)
	(blip_ai_object sq_cov_waf_sph_center3/seraph2)
	
	(blip_ai_object sq_cov_waf_sph_center2/seraph0)
	(blip_ai_object sq_cov_waf_sph_center2/seraph1)
	
	(blip_ai_object sq_cov_waf_sph_center1/seraph0)
)

(script static void (blip_ai_object (ai actor))
	(f_blip_object (ai_get_object actor) 14))

; =================================================================================================
; spartan babysitting
; =================================================================================================

;*
(script static void (spartans_set_stance (string_id stance))
	(begin_random
		(begin
			(unit_set_stance (ai_get_unit ai_carter) stance)
			(sleep 3)
		)
		
		(begin
			(unit_set_stance (ai_get_unit ai_jorge) stance)
			(sleep 3)
		)
		
		(begin
			(unit_set_stance (ai_get_unit ai_kat) stance)
			(sleep 3)
		)
	)
)

(script static void spartans_lower_weapons
	(spartans_set_stance alert))
	
(script static void spartans_raise_weapons
	(spartans_set_stance ""))
	
(script static void spartans_sprint
	(kat_sprint)
	(carter_sprint)
	(jorge_sprint))

; -------------------------------------------------------------------------------------------------
(script static void carter_lower_weapon 
	(unit_set_stance (ai_get_unit ai_carter) alert))
	
(script static void carter_raise_weapon 
	(unit_set_stance (ai_get_unit ai_carter) ""))
	
(script static void carter_run
	(if debug (print "::: throttle ::: carter is running"))
	(ai_remove_cue cue_carter_walk)
	(ai_remove_cue cue_carter_jog)
	(ai_remove_cue cue_carter_sprint)
	(unit_set_stance (ai_get_unit ai_carter) ""))
	
(script static void carter_walk
	(if debug (print "::: throttle ::: carter is walking"))
	(ai_place_cue cue_carter_walk)
	(ai_remove_cue cue_carter_jog)
	(ai_remove_cue cue_carter_sprint)
	(unit_set_stance (ai_get_unit ai_carter) ""))	

(script static void carter_jog
	(if debug (print "::: throttle ::: carter is jogging"))
	(ai_remove_cue cue_carter_walk)
	(ai_place_cue cue_carter_jog)
	(ai_remove_cue cue_carter_sprint)
	(unit_set_stance (ai_get_unit ai_carter) ""))
	
(script static void carter_sprint
	(if debug (print "::: throttle ::: carter is sprinting"))
	(ai_remove_cue cue_carter_walk)
	(ai_remove_cue cue_carter_jog)
	(ai_place_cue cue_carter_sprint)
	(unit_set_stance (ai_get_unit ai_carter) sprint))


; -------------------------------------------------------------------------------------------------
(script static void kat_lower_weapon 
	(unit_set_stance (ai_get_unit ai_kat) alert))
	
(script static void kat_raise_weapon 
	(unit_set_stance (ai_get_unit ai_kat) ""))

(script static void kat_run
	(if debug (print "::: throttle ::: kat is running"))
	(ai_remove_cue cue_kat_walk)
	(ai_remove_cue cue_kat_jog)
	(ai_remove_cue cue_kat_sprint)
	(unit_set_stance (ai_get_unit ai_kat) ""))
	
(script static void kat_walk
	(if debug (print "::: throttle ::: kat is walking"))
	(ai_place_cue cue_kat_walk)
	(ai_remove_cue cue_kat_jog)
	(ai_remove_cue cue_kat_sprint)
	(unit_set_stance (ai_get_unit ai_kat) ""))	

(script static void kat_jog
	(if debug (print "::: throttle ::: kat is jogging"))
	(ai_remove_cue cue_kat_walk)
	(ai_place_cue cue_kat_jog)
	(ai_remove_cue cue_kat_sprint)
	(unit_set_stance (ai_get_unit ai_kat) ""))
	
(script static void kat_sprint
	(if debug (print "::: throttle ::: kat is sprinting"))
	(ai_remove_cue cue_kat_walk)
	(ai_remove_cue cue_kat_jog)
	(ai_place_cue cue_kat_sprint)
	(unit_set_stance (ai_get_unit ai_kat) sprint))


; -------------------------------------------------------------------------------------------------
(script static void jorge_lower_weapon 
	(unit_set_stance (ai_get_unit ai_jorge) alert))
	
(script static void jorge_raise_weapon 
	(unit_set_stance (ai_get_unit ai_jorge) ""))
	
(script static void jorge_run
	(if debug (print "::: throttle ::: jorge is running"))
	(ai_remove_cue cue_jorge_walk)
	(ai_remove_cue cue_jorge_jog)
	(ai_remove_cue cue_jorge_sprint)
	(unit_set_stance (ai_get_unit ai_jorge) ""))
	
(script static void jorge_walk
	(if debug (print "::: throttle ::: jorge is walking"))
	(ai_place_cue cue_jorge_walk)
	(ai_remove_cue cue_jorge_jog)
	(ai_remove_cue cue_jorge_sprint)
	(unit_set_stance (ai_get_unit ai_jorge) ""))	

(script static void jorge_jog
	(if debug (print "::: throttle ::: jorge is jogging"))
	(ai_remove_cue cue_jorge_walk)
	(ai_place_cue cue_jorge_jog)
	(ai_remove_cue cue_jorge_sprint)
	(unit_set_stance (ai_get_unit ai_jorge) ""))
	
(script static void jorge_sprint
	(if debug (print "::: throttle ::: jorge is sprinting"))
	(ai_remove_cue cue_jorge_walk)
	(ai_remove_cue cue_jorge_jog)
	(ai_place_cue cue_jorge_sprint)
	(unit_set_stance (ai_get_unit ai_jorge) sprint))

(script static void spartans_walk
	(jorge_walk)
	(carter_walk)
	(kat_walk))
	
(script static void spartans_jog
	(jorge_jog)
	(carter_jog)
	(kat_jog))	

(script static void spartans_run
	(jorge_run)
	(carter_run)
	(kat_run))
	
(script static void spartans_walk_and_ready
	(spartans_walk)
	(spartans_set_stance "")
)

*;

; -------------------------------------------------------------------------------------------------
(script static void (create_player_sabres
					(object_name sabre0) 
					(object_name sabre1) 
					(object_name sabre2) 
					(object_name sabre3))
	
		(if (>= (game_coop_player_count) 4)
		(begin
			(if debug (print "creating sabre3..."))
			(object_create sabre3)
		))

	(if (>= (game_coop_player_count) 3)
		(begin
			(if debug (print "creating sabre2..."))
			(object_create sabre2)
		))
		
	(if (>= (game_coop_player_count) 2)
		(begin
			(if debug (print "creating sabre1..."))
			(object_create sabre1)
		))
		
	(if (>= (game_coop_player_count) 1)
		(begin
			(if debug (print "creating sabre0..."))
			(object_create sabre0)
		))
)

(script static void (load_player_sabres 
					(vehicle sabre0) 
					(vehicle sabre1) 
					(vehicle sabre2) 
					(vehicle sabre3))
					
	(if (>= (game_coop_player_count) 4)
		(begin
			(if debug (print "loading sabre3..."))
			;(object_create sabre3)
			(vehicle_load_magic sabre3 "sabre_d" (player3))
			(vehicle_set_player_interaction sabre3 "sabre_d" false false)
		))

	(if (>= (game_coop_player_count) 3)
		(begin
			(if debug (print "loading sabre2..."))
			;(object_create sabre2)
			(vehicle_load_magic sabre2 "sabre_d" (player2))
			(vehicle_set_player_interaction sabre2 "sabre_d" false false)
		))
		
	(if (>= (game_coop_player_count) 2)
		(begin
			(if debug (print "loading sabre1..."))
			;(object_create sabre1)
			(vehicle_load_magic sabre1 "sabre_d" (player1))
			(vehicle_set_player_interaction sabre1 "sabre_d" false false)
		))
		
	(if (>= (game_coop_player_count) 1)
		(begin
			(if debug (print "loading sabre0..."))
			;(object_create sabre0)
			(vehicle_load_magic sabre0 "sabre_d" (player0))
			(vehicle_set_player_interaction sabre0 "sabre_d" false false)
		))
)
(script static void cinematic_play_intro
	(if debug (print "starting with intro cinematic..."))
	(f_start_mission 045la_katsplan_v2)
)


; =================================================================================================
; forks
; =================================================================================================
(global short s_bch_fork_scale_ticks 300)
(script dormant bch_fork_control
	(sleep_until (= s_objcon_bch 30))
	(ai_place sq_cov_bch_forks)
	(sleep 1)
	(ai_disregard (ai_actors sq_cov_bch_forks) true)
)
(script command_script cs_bch_fork0
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork0)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork1
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork1)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork2
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork2)
	(object_destroy (ai_vehicle_get ai_current_actor)))

(script command_script cs_bch_fork3
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork3)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork4
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork4)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork5
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork5)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork6
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork6)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork7
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork7)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork8
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork8)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	

; =================================================================================================
; drop pods
; =================================================================================================
(global boolean b_bch_podfight_started false)
(global boolean b_bch_podfight_complete false)
(global boolean b_bch_podfight_doors_open false)
(global boolean b_bch_podfight_pods_landed false)
(global boolean b_bch_podfight_spartans_advance false)
(global short b_bch_podfight_phase 0)
(global short s_bch_skybox_pod_delay 7)
; -------------------------------------------------------------------------------------------------
(script dormant bch_podfight_control
	(sleep_until (= s_objcon_bch 50) 1)
	
	(if debug (print "::: pod fight started"))
	(set b_bch_podfight_started true)
	
	(wake md_bch_car_reinforcements)
	
	(sleep 45)
	(bch_skybox_pod_drop dm_skybox_pod_00)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_01)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_02)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_03)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_04)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_05)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_06)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_07)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_08)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_09)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_10)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_11)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_12)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_13)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_14)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_15)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_16)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_17)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_18)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_19)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_20)
	(sleep 150)
	
		
			; -------------------------------------------------
			(wake bch_drop_pod_elite0)
			;(wake bch_drop_pod_elite1)
			;(wake bch_drop_pod_elite2)
			
			;(wake bch_podfight_brace_control)
			; -------------------------------------------------
	
	(sleep 90)
	(set b_bch_podfight_spartans_advance true)
	(sleep 45)
	(wake bch_open_pod0)
	;(wake bch_open_pod1)
	;(wake bch_open_pod2)
	(sleep 30)
	
	
	(wake md_bch_car_been_engaged)
	
	(sleep_until (<= (ai_living_count sq_cov_bch_pod_elites0/elite0) 0) 1)
		(set b_bch_podfight_phase 1)
		
	(sleep_until 
		(and
			(<= (ai_living_count sq_cov_bch_pod_elites0/elite0) 0)
			(>= s_objcon_bch 70))
	1 (* 30 10))
	
		(sleep 15)
		
		(set b_bch_podfight_phase 1)
		(drop_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
		(open_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
		(sleep 10)	
	
		;(set b_bch_podfight_phase 2)
		(drop_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2)
		(open_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2)
		(sleep 10)
		
	(sleep_until (<= (ai_living_count sq_cov_bch_pod_elites0) 0) 1)
	
	
	;(sleep_until (<= (ai_living_count sq_cov_bch_pod_elites0) 0) 1)
	(set b_bch_podfight_complete true)
)

(script static void bch_skybox_pod_delay
	(sleep (random_range 5 10))
)

(script dormant bch_podfight_brace_control
	(sleep_until (>= (device_get_position dm_bch_pod_elite1) 1) 1)
	(thespian_performance_setup_and_begin thespian_kat_brace "" 0)
)

(script static void test_pod_landings
	(drop_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0)
	(drop_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
	(drop_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2)
)

(script static void (drop_pod (device_name pod_marker) (ai pod_pilot))
	(print "pod drop started...")
	(object_create pod_marker)
	(ai_place pod_pilot)
	(sleep 1)
	(objects_attach pod_marker "" (ai_vehicle_get_from_spawn_point pod_pilot) "")
	(device_set_position_immediate pod_marker 0)
	(sleep 1)
	(device_set_power pod_marker 1)
	(device_set_position pod_marker 1)
	;(device_set_position_track pod_marker "pod_drop_100wu" 0)
	;(device_animate_position pod_marker 1.0 3.5 0.1 0 false)
	(sleep_until (>= (device_get_position pod_marker) 1) 1)
	(effect_new_on_object_marker objects\gear\human\military\resupply_capsule\fx\capsule_impact.effect (ai_vehicle_get_from_spawn_point pod_pilot) "fx_impact")
	(device_set_power pod_marker 0)
	
	
)

(script static void loop_pod_drop

	(sleep_until
		(begin
			(drop_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0)
			(sleep 30)
			(open_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0)
			(sleep 90)
			(ai_erase_all)
			(object_destroy dm_bch_pod_elite0)
			(garbage_collect_unsafe)
			(sleep 1)
		0)
	1)
	
	
)

(script static void (open_pod (device_name pod_marker) (ai pod_pilot))
	(objects_detach pod_marker (ai_vehicle_get_from_spawn_point pod_pilot))
	(object_destroy pod_marker)
	(object_damage_damage_section  (ai_vehicle_get_from_spawn_point pod_pilot) "body" 100)
	(set b_bch_podfight_doors_open true)
	(sleep 45)
	(vehicle_unload (ai_vehicle_get_from_spawn_point pod_pilot) "")
)

(script dormant bch_drop_pod_elite0
	(drop_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0))
	
(script dormant bch_drop_pod_elite1
	(drop_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
	(open_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1))
	
(script dormant bch_drop_pod_elite2
	(sleep 25)
	(drop_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2))
	
(script static void (bch_skybox_pod_drop (device_name d))
	
	(object_create d)
	(object_cinematic_visibility d true)
	(device_set_position_track d "m45_skybox_drop_600wu" 0)
	(device_animate_position d 1.0 6.0 2 0 false)
)

(script dormant bch_open_pod0
	(open_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0)
)

(script dormant bch_open_pod1
	(sleep 15)
	(open_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
)

(script dormant bch_open_pod2
	(sleep 7)
	(open_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2)
)



; =================================================================================================
; bombing run
; =================================================================================================
(global real s_seraph_bombingrun_time 6)
(global boolean b_bch_bombingrun_started false)
(global boolean b_bch_bombingrun_complete false)
(global short s_bch_bombingrun_delay_min 10)
(global short s_bch_bombingrun_delay_max 20)
; -------------------------------------------------------------------------------------------------
(script dormant bch_bombingrun_control
	
	(sleep_until (>= s_objcon_bch 80))
	
			; -------------------------------------------------
			(if debug (print "::: bombing run started"))
			(set b_bch_bombingrun_started true)
			(ai_place sq_unsc_bch_aa)
			(wake bch_bombingrun_start)
			(wake md_bch_kat_airborne)
			; -------------------------------------------------
	
	
	;(sleep_until (volume_test_players tv_bch_bombingrun_crash_start) 1)
	;(sleep_until (>= s_objcon_bch 65) 1)
	(sleep 90)
			; -------------------------------------------------
			(if debug (print "::: bombing run crash started"))
			(bch_seraph_bombingrun_crash0)
	
			(cs_run_command_script sq_unsc_bch_aa/aa0 cs_unsc_bch_aa0_target_bombers)
			(cs_run_command_script sq_unsc_bch_aa/aa1 cs_unsc_bch_aa1_target_bombers)
			(cs_run_command_script sq_unsc_bch_aa/aa2 cs_unsc_bch_aa1_target_bombers)
			; -------------------------------------------------
			
			
	(sleep_until (>= (device_get_position dm_marker_seraph_crash0) 1) 1)
	
			; -------------------------------------------------
			;(wake bch_bombingrun_temp_explosion)
			;(ai_erase sq_cov_bch_seraph_bombers0/pilot_crash0)
			(objects_detach dm_marker_seraph_crash0 (ai_vehicle_get_from_starting_location sq_cov_bch_seraph_bombers0/pilot_crash0))
			(damage_object (ai_vehicle_get_from_starting_location sq_cov_bch_seraph_bombers0/pilot_crash0) "" 1000)
			
			(effect_new_on_object_marker objects\levels\solo\m45\wall_panel\fx\wall_panel_destroyed.effect sc_wall_panel "")
			(object_set_permutation sc_wall_panel default destroyed)

			(object_destroy dm_marker_seraph_crash0)
			(damage_object sc_wall_panel "" 1000)
			
			(cam_shake 0.2 1 3)
			(set b_bch_bombingrun_complete true)
			(sleep 300)
			(object_destroy sc_wall_panel)
			
			(sleep 300)
			
			(ai_erase sq_unsc_bch_aa)
			; -------------------------------------------------
)

(script dormant bch_bombingrun_temp_explosion
	(effect_new_at_ai_point fx\fx_library\_placeholder\placeholder_explosion.effect ps_bch_bombingrun/p0)
	(sleep 7)
	(effect_new_at_ai_point fx\fx_library\_placeholder\placeholder_explosion.effect ps_bch_bombingrun/p1)
	(sleep 7)
	(effect_new_at_ai_point fx\fx_library\_placeholder\placeholder_explosion.effect ps_bch_bombingrun/p2)
	(sleep 7)
	(effect_new_at_ai_point fx\fx_library\_placeholder\placeholder_explosion.effect ps_bch_bombingrun/p3)
)


(script dormant slo_bombingrun_start
	(set b_bch_bombingrun_complete false)
	(loop_seraph_silo_bombingrun)
)

(script dormant bch_bombingrun_start
	(loop_seraph_bombingrun))

(script static void loop_seraph_bombingrun
	(wake bch_bombingrun_01)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_02)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_03)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_04)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_05)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_06)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_07)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_08)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_09)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_10)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_11)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_12)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_13)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_14)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_15)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
)


(script dormant bch_bombingrun_00
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_00 v_seraph_bomber_00))
	
(script dormant bch_bombingrun_01
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_01 v_seraph_bomber_01))
	
(script dormant bch_bombingrun_02
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_02 v_seraph_bomber_02))
	
(script dormant bch_bombingrun_03
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_03 v_seraph_bomber_03))

(script dormant bch_bombingrun_04
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_04 v_seraph_bomber_04))
	
(script dormant bch_bombingrun_05
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_05 v_seraph_bomber_05))
	
(script dormant bch_bombingrun_06
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_06 v_seraph_bomber_06))
	
(script dormant bch_bombingrun_07
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_07 v_seraph_bomber_07))
	
(script dormant bch_bombingrun_08
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_08 v_seraph_bomber_08))
	
(script dormant bch_bombingrun_09
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_09 v_seraph_bomber_09))
	
(script dormant bch_bombingrun_10
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_10 v_seraph_bomber_10))
	
(script dormant bch_bombingrun_11
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_11 v_seraph_bomber_11))
	
(script dormant bch_bombingrun_12
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_12 v_seraph_bomber_12))
	
(script dormant bch_bombingrun_13
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_13 v_seraph_bomber_13))
	
(script dormant bch_bombingrun_14
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_14 v_seraph_bomber_14))
	
(script dormant bch_bombingrun_15
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_15 v_seraph_bomber_15))
	

(script static void loop_seraph_silo_bombingrun
	(wake slo_bombingrun_01)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_02)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_03)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_04)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_05)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_06)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_07)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_08)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_09)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_10)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_11)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_12)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_13)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_14)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_15)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
)

(script static void slo_bombingrun_kill
	(sleep_forever slo_bombingrun_01)
	(sleep_forever slo_bombingrun_02)
	(sleep_forever slo_bombingrun_03)
	(sleep_forever slo_bombingrun_04)
	(sleep_forever slo_bombingrun_05)
	(sleep_forever slo_bombingrun_06)
	(sleep_forever slo_bombingrun_07)
	(sleep_forever slo_bombingrun_08)
	(sleep_forever slo_bombingrun_09)
	(sleep_forever slo_bombingrun_10)
	(sleep_forever slo_bombingrun_11)
	(sleep_forever slo_bombingrun_12)
	(sleep_forever slo_bombingrun_13)
	(sleep_forever slo_bombingrun_14)
	(sleep_forever slo_bombingrun_15)
	
	(object_destroy_folder v_bch_bombers)
	(object_destroy_folder dm_bch_bombingrun)
)

(script dormant slo_bombingrun_00
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_00 v_seraph_bomber_00))
	
(script dormant slo_bombingrun_01
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_01 v_seraph_bomber_01))
	
(script dormant slo_bombingrun_02
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_02 v_seraph_bomber_02))
	
(script dormant slo_bombingrun_03
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_03 v_seraph_bomber_03))

(script dormant slo_bombingrun_04
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_04 v_seraph_bomber_04))
	
(script dormant slo_bombingrun_05
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_05 v_seraph_bomber_05))
	
(script dormant slo_bombingrun_06
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_06 v_seraph_bomber_06))
	
(script dormant slo_bombingrun_07
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_07 v_seraph_bomber_07))
	
(script dormant slo_bombingrun_08
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_08 v_seraph_bomber_08))
	
(script dormant slo_bombingrun_09
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_09 v_seraph_bomber_09))
	
(script dormant slo_bombingrun_10
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_10 v_seraph_bomber_10))
	
(script dormant slo_bombingrun_11
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_11 v_seraph_bomber_11))
	
(script dormant slo_bombingrun_12
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_12 v_seraph_bomber_12))
	
(script dormant slo_bombingrun_13
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_13 v_seraph_bomber_13))
	
(script dormant slo_bombingrun_14
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_14 v_seraph_bomber_14))
	
(script dormant slo_bombingrun_15
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_15 v_seraph_bomber_15))

(script static void (bch_seraph_bombingrun_start (device_name marker) (object_name bomber))
	(object_create_anew marker)
	(device_set_position_track marker "e3_seraph_flyover0" 0)
	(device_set_position_immediate marker 0)
	(sleep 1)
	
	(object_create bomber)
	(sleep 1)
	
	(objects_attach marker "" bomber "")
	(device_animate_position marker 1.0 s_seraph_bombingrun_time 0 0 true)
)

(script static void (bch_seraph_bombingrun_loop (device_name marker) (object_name bomber))
	(sleep_until
		(begin
			(bch_seraph_bombingrun_start marker bomber)
			(sleep_until (>= (device_get_position marker) 1) 1)
			;(objects_detach dm_marker_seraph_bombingrun0 (ai_vehicle_get_from_spawn_point sq_cov_bch_seraph_bombers0/pilot0))
			(object_destroy bomber)
			(sleep (random_range 0 10))
		b_bch_bombingrun_complete)
	1)
)

(script static void bch_seraph_bombingrun_crash0
	(ai_place sq_cov_bch_seraph_bombers0/pilot_crash0)
	(object_create_anew dm_marker_seraph_crash0)
	(device_set_position_track dm_marker_seraph_crash0 "e3_seraph_crash0" 1)
	(sleep 1)
	
	(objects_attach dm_marker_seraph_crash0 "" (ai_vehicle_get sq_cov_bch_seraph_bombers0/pilot_crash0) "")
	(device_set_power dm_marker_seraph_crash0 1)
	(device_set_position dm_marker_seraph_crash0 1)
	(device_animate_position dm_marker_seraph_crash0 1.0 6 0 0 true)	
)


(script command_script cs_unsc_bch_aa0_target_bombers
	(cs_shoot true sq_cov_bch_seraph_bombers0/pilot2)
	(sleep_forever)
)

(script command_script cs_unsc_bch_aa1_target_bombers
	(cs_shoot true sq_cov_bch_seraph_bombers0/pilot_crash0)
	(sleep_forever)
)

(script command_script cs_unsc_bch_aa2_target_bombers
	(cs_shoot true sq_cov_bch_seraph_bombers0/pilot2)
	(sleep_forever)
)


; =================================================================================================
; ghost charge
; =================================================================================================
(global boolean b_bch_ghostcharge_started false)
(global boolean b_bch_ghostcharge_complete false)
(global boolean b_bch_ghostcharge_bullrun false)
; -------------------------------------------------------------------------------------------------
(script dormant bch_ghostcharge_control
	(sleep_until b_bch_bombingrun_complete)
	
			; -------------------------------------------------
			(if debug (print "::: ghost charge started"))
			(set b_bch_ghostcharge_started true)
			
			(ai_place sq_cov_bch_ghostcharge_fork0)
			
			(cs_run_command_script ai_carter cs_bch_ghost_charge_carter)
			(cs_run_command_script ai_kat cs_bch_ghost_charge_kat)
			(cs_run_command_script ai_jorge cs_bch_ghost_charge_jorge)
			
			;(sleep_until (volume_test_players tv_ghostcharge_start) 1)
			; -------------------------------------------------
	
	(sleep_until (= b_bch_ghostcharge_bullrun true) 1)
	(sleep_until (<= (objects_distance_to_object (ai_vehicle_get sq_cov_bch_ghost0/pilot) (ai_get_object ai_carter)) 1.5) 1)
	
			; -------------------------------------------------
			(units_set_current_vitality (ai_vehicle_get sq_cov_bch_ghost0/pilot) 0 0.3)
			(cs_run_command_script ai_carter cs_bch_ghost_charge_carter_lock)
			; -------------------------------------------------
	
	(sleep_until (<= (ai_living_count sq_cov_bch_ghostcharge0) 0) 1)
	
			; -------------------------------------------------
			(set b_bch_ghostcharge_complete true)
			(sleep 50)
			;(spartans_run)
			(wake md_bch_car_spartans_engage)
			; -------------------------------------------------
)

(script command_script cs_bch_ghost_charge_carter
	(if debug (print "carter setting up for ghost charge"))
	;(carter_run)
	(cs_go_by ps_bch_ghost_charge/rock_gap ps_bch_ghost_charge/rock_gap)
	(cs_go_to ps_bch_ghost_charge/carter_setup)
	(sleep_until (volume_test_players tv_ghostcharge_start) 1)
	;(carter_walk)
	(cs_go_to ps_bch_ghost_charge/carter_move_forward)
)

(script command_script cs_bch_ghost_charge_kat
	(if debug (print "kat setting up for ghost charge"))
	;(kat_run)
	(cs_go_to ps_bch_ghost_charge/kat_setup)
	(sleep_until (volume_test_players tv_ghostcharge_start) 1)
	;(kat_walk)
	(cs_go_to ps_bch_ghost_charge/kat_move_forward)
)

(script command_script cs_bch_ghost_charge_jorge
	(if debug (print "jorge setting up for ghost charge"))
	;(jorge_run)
	(cs_go_to ps_bch_ghost_charge/jorge_setup)
	(sleep_until (volume_test_players tv_ghostcharge_start) 1)
	;(jorge_walk)
	(cs_go_to ps_bch_ghost_charge/jorge_move_forward)
)


(script command_script cs_bch_ghost_charge_carter_lock
	(if debug (print "carter armor locking!"))
	(cs_use_equipment 3.0)
)

(script command_script cs_bch_ghost_charge_pilot
	(cs_vehicle_boost false)
	(cs_vehicle_speed 1.0)
	(object_cannot_take_damage (ai_vehicle_get ai_current_actor))
	;(cs_shoot_point true ps_bch_ghost_charge/ghost_shoot_target0)
	;(cs_enable_targeting true)
	;(sleep 45)
	;(cs_shoot_point false ps_bch_ghost_charge/ghost_shoot_target0)
	(cs_go_to ps_bch_ghost_charge/ghost_prep 1)
	(set b_bch_ghostcharge_bullrun true)
	(object_can_take_damage (ai_vehicle_get ai_current_actor))
	(cs_ignore_obstacles true)
	(cs_enable_targeting false)
	(cs_vehicle_boost true)
	(cs_vehicle_speed 1.0)
	
	(cs_go_to ps_bch_ghost_charge/ghost_dest 1)
)

(script command_script cs_bch_ghost_charge_fork
	(cs_run_command_script (ai_get_turret_ai ai_current_squad 0) cs_gunner_hold)
	(f_load_fork_cargo (ai_vehicle_get ai_current_actor) "large" sq_cov_bch_ghostcharge0 none none)
	(f_load_fork (ai_vehicle_get ai_current_actor) "dual" sq_cov_bch_entrance_elites0 sq_cov_bch_entrance_grunts0 sq_cov_bch_entrance_jackals0 sq_cov_bch_entrance_jackals1)
	(cs_vehicle_speed 0.5)
	(cs_fly_by ps_bch_ghost_charge/fork_entry0)
	
	(cs_vehicle_speed 0.3)
	(cs_fly_to_and_face ps_bch_ghost_charge/fork_hover ps_bch_ghost_charge/fork_land_facing 0.25)
		;(vehicle_hover (ai_vehicle_get ai_current_actor) true)
	(sleep_until (>= s_objcon_bch 80) 1)
		;(vehicle_hover (ai_vehicle_get ai_current_actor) false)
	;(sleep 30)
	(cs_fly_to_and_face ps_bch_ghost_charge/fork_land ps_bch_ghost_charge/fork_land_facing 0.20)
		;(vehicle_hover (ai_vehicle_get ai_current_actor) true)
	(sleep_until (volume_test_players tv_ghostcharge_start) 1)
	(sleep 30)
	(f_unload_fork_cargo (ai_vehicle_get ai_current_actor) "large")
	;(cs_fly_to_and_face ps_bch_ghost_charge/fork_land ps_bch_ghost_charge/fork_land_facing 0.25)
	(cs_run_command_script sq_cov_bch_ghostcharge0/pilot cs_bch_ghost_charge_pilot)
	(sleep 60)
	
	(cs_vehicle_speed 0.15)
	(cs_fly_to_and_face ps_bch_ghost_charge/fork_land ps_bch_ghost_charge/fork_land_facing 0.15)
	(f_unload_fork (ai_vehicle_get ai_current_actor) "dual")
	(sleep 15)
	(cs_vehicle_speed 0.25)
	(cs_fly_to_and_face ps_bch_ghost_charge/fork_hover ps_bch_ghost_charge/fork_land_facing 0.25)
	(sleep 30)
	
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_bch_ghost_charge/fork_exit0)
	(cs_fly_by ps_bch_ghost_charge/fork_erase)
	(ai_erase ai_current_squad)
)


; =================================================================================================
; facility entrance fight
; =================================================================================================
(global boolean b_bch_entrancefight_finalpush false)
; -------------------------------------------------------------------------------------------------

(script dormant bch_entrance_fight_control
	(sleep_until b_bch_ghostcharge_complete 1)
	(sleep_until (> (ai_task_count obj_cov_bch/gate_entrance) 0))
			; -------------------------------------------------
			
			
			(wake bch_entrance_jackals_renew)
			
			;(ai_set_targeting_group gr_unsc_spartans 7)
			;(ai_set_targeting_group sq_cov_bch_entrance_jackals0 7 false)
			;(ai_set_targeting_group sq_cov_bch_entrance_jackals1 7 false)
			
			(ai_magically_see gr_unsc_spartans sq_cov_bch_entrance_jackals0)
			(sleep 60)
			; -------------------------------------------------
			
	(sleep_until
		;(and
			(<= (ai_living_count sq_cov_bch_entrance_grunts0) 0)
			;(volume_test_players tv_bch_entrance_finalpush)
		;)
	1)		
	
			; -------------------------------------------------
			(if debug (print "entrance covenant falling back..."))
			;(ai_set_targeting_group gr_unsc_spartans -1)
			;(ai_set_targeting_group sq_cov_bch_entrance_jackals0 -1 true)
			;(ai_set_targeting_group sq_cov_bch_entrance_jackals1 -1 true)
			
			;(wake bch_entrancefight_car_walk)
			;(wake bch_entrancefight_jor_walk)
			;(wake bch_entrancefight_kat_walk)
			
			(sleep (random_range 30 45))
			(set b_bch_entrancefight_finalpush true)
			; -------------------------------------------------
)

(script static void bch_entrance_targeting_group_set
	(sleep 120)
	(if debug (print "spartans can now only target the jackals..."))
	
	;(ai_set_targeting_group gr_unsc_spartans 7)
	;(ai_set_targeting_group sq_cov_bch_entrance_jackals0 7 false)
	;(ai_set_targeting_group sq_cov_bch_entrance_jackals1 7 false)
			
	(ai_magically_see gr_unsc_spartans sq_cov_bch_entrance_jackals0)
)

(script dormant bch_entrance_jackals_renew
	(sleep_until
		(begin
			(ai_renew sq_cov_bch_entrance_jackals0)
			(ai_renew sq_cov_bch_entrance_jackals1)
			(sleep 90)
		(volume_test_players tv_bch_entrance_finalpush))
	1)
)

(script static void branch_abort
	(if debug (print "branch abort")))


; =================================================================================================
; facility entrance
; =================================================================================================
(script dormant fac_entrance_control
	(sleep_until
		(and 
			(> s_objcon_fac 20)
			(objects_can_see_flag (players) fl_fac_entrance 10.0)
		)
	1)
	
	(sleep 10)
	
	;(device_set_power dm_fac_entrance 1)
	(device_set_position dm_fac_entrance 0)
)


; =================================================================================================
; air strike
; =================================================================================================
(global boolean b_fac_airstrike_started false)
(global boolean b_fac_airstrike_completed false)
; -------------------------------------------------------------------------------------------------
(script dormant fac_airstrike_control
	(sleep_until (= s_objcon_fac 30) 1)
	(ai_place sq_unsc_fac_rocketguys0)
	(ai_place sq_cov_fac_wraith0)
	
	(sleep_until (= s_objcon_fac 40) 1)
	
	(sleep_until (volume_test_players tv_airstrike_mortar_hit) 1)
	(fac_fire_wraith_shot)
	(ai_place sc_cov_fac_wraith_escort0)
	(sleep 30)
	(ai_magically_see sq_unsc_fac_rocketguys0 sq_cov_fac_wraith0)
	(ai_magically_see sq_unsc_fac_rocketguys0 sc_cov_fac_wraith_escort0)
	;(wake md_fac_kat_wraith)
	
	;(sleep_until (<= (ai_living_count sq_cov_fac_wraith0) 0) 1)
	
	(if debug (print "airstrike completed"))
	(set b_fac_airstrike_completed true)
)

(script static void fac_fire_wraith_shot
	(if debug (print "boom"))
	(effect_new objects\vehicles\covenant\wraith\fx\weapon\mortar\detonation.effect fl_bch_wraith_firing_arc)
	(damage_new objects\vehicles\covenant\wraith\turrets\wraith_mortar\weapon\projectiles\damage_effects\wraith_mortar_round.damage_effect fl_bch_wraith_firing_arc)
)

(script command_script cs_fac_wraith_shelling
	;(cs_aim_object true (ai_get_object sq_unsc_fac_rocketguys0/trooper0))
	;(sleep 60)
	(sleep_until (>= s_objcon_fac 50) 1)
	;(sleep 30)
	;(cs_shoot_point true ps_fac_wraith/initial_target)
	;(sleep_until (<= (ai_living_count sq_unsc_fac_rocketguys0) 0) 30 (* 30 600))
	(sleep_until
		(begin
			(cs_go_to ps_fac_wraith/wraith_firing_pos)
			(begin_random_count 1
				(cs_shoot_point true ps_fac_wraith/target0)
				(cs_shoot_point true ps_fac_wraith/target1)
				(cs_shoot_point true ps_fac_wraith/target2))
			(sleep 240)
		0)
	1)
)



; =================================================================================================
; dead man
; =================================================================================================
(global short s_fac_deadman_sequence 0)
(global boolean b_fac_deadman_completed false)
(global boolean b_fac_deadman_car_pass_jor false)
(global boolean b_fac_deadman_kat_pass_jor false)
(global boolean b_fac_deadman_jor_hall0 false)
(global boolean b_fac_deadman_jor_hall1 false)
(global boolean b_fac_deadman_kat_bunker1 false)
; -------------------------------------------------------------------------------------------------
(script dormant fac_deadman_control
	(set b_fac_deadman_completed false)
	
		
			
	(sleep_until (>= s_objcon_fac 90) 1)
			
			; -------------------------------------------------
			(if debug (print "starting deadman moment..."))
			(fac_deadman_spawn)
			; -------------------------------------------------

	(sleep 150)

	(set b_fac_deadman_completed true)
	
	(thespian_performance_kill_by_name thespian_deadman_kat)
	(thespian_performance_kill_by_name thespian_deadman_jorge)
	(thespian_performance_kill_by_name thespian_deadman_carter)
	
)

(script static void fac_deadman_spawn
	(ai_place sq_unsc_fac_deadman0)
	(sleep 1)
	(damage_new levels\solo\m45\fx\facility_deadman_impulse.damage_effect fl_fac_damage)
	(sleep 5)
	
	; place his killer and play the vignette
	(ai_place sq_cov_fac_hall_elite0)
	(thespian_performance_setup_and_begin thespian_deadman_elite "" 0)
)

(script command_script cs_fac_deadman_elite
	(cs_enable_targeting true)

	(cs_go_to_and_face ps_fac_deadman/elite_dest ps_fac_deadman/elite_facing)
	(sleep 10)
)

(script static boolean fac_deadman_hall_look
	(objects_can_see_flag (players) fl_fac_deadman_hall 30)
)



; =================================================================================================
; helpers
; =================================================================================================
(script static void (cam_shake (real attack) (real intensity) (real decay))
	(player_effect_set_max_rotation 2 2 2)
	(player_effect_start intensity attack)
	(player_effect_stop decay))
	


(script static void slo_setup_bodies
	(object_create_folder sc_slo_bodies)
	(scenery_animation_start body2 objects\characters\marine\marine e3_deadbody_02)
	(scenery_animation_start body3 objects\characters\marine\marine e3_deadbody_03)
	(scenery_animation_start body4 objects\characters\marine\marine e3_deadbody_04)
	(scenery_animation_start body5 objects\characters\marine\marine e3_deadbody_05)
	(scenery_animation_start body6 objects\characters\marine\marine e3_deadbody_06)
	(scenery_animation_start body7 objects\characters\marine\marine e3_deadbody_07)
	(scenery_animation_start body8 objects\characters\marine\marine e3_deadbody_08)
	(scenery_animation_start body9 objects\characters\marine\marine e3_deadbody_09)
	(scenery_animation_start body10 objects\characters\marine\marine e3_deadbody_10)
	(scenery_animation_start body11 objects\characters\marine\marine e3_deadbody_11)
	(scenery_animation_start body12 objects\characters\marine\marine e3_deadbody_12)
	(scenery_animation_start body13 objects\characters\marine\marine e3_deadbody_13)
	(scenery_animation_start body14 objects\characters\marine\marine e3_deadbody_14)
	(scenery_animation_start body15 objects\characters\marine\marine e3_deadbody_15)
	(scenery_animation_start body16 objects\characters\marine\marine e3_deadbody_16)
	(scenery_animation_start body17 objects\characters\marine\marine e3_deadbody_17)
	(scenery_animation_start body18 objects\characters\marine\marine e3_deadbody_18)
	(scenery_animation_start body19 objects\characters\marine\marine e3_deadbody_19)
	(scenery_animation_start body20 objects\characters\marine\marine e3_deadbody_20)
)


; =================================================================================================
; star trek lights
; =================================================================================================
(global sound sfx_light_quad sound\levels\solo\m45\flood_light\flood_light_quad.sound)
(global sound sfx_light sound\levels\solo\m45\flood_light\flood_light.sound)
; -------------------------------------------------------------------------------------------------

(script dormant slo_light_control
	(sleep_until (> (device_get_position dm_slo_shutter) 0.5) 1)
	(slo_lights_on)
)

(script static void slo_lights_on
	(object_destroy_folder sc_slo_lights)
	(sleep 1)

	(if debug (print "::: low lights on :::"))
	(object_create sc_slo_lights_low)
	
	(sound_impulse_start sfx_light ss_flood_light_low_left 1.0)
	(sound_impulse_start sfx_light ss_flood_light_low_right 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_low_left 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_low_right 1.0)
	
		(sleep 45)
	
	(if debug (print "::: mid lights on :::"))
	(object_create sc_slo_lights_mid)
	
	(sound_impulse_start sfx_light ss_flood_light_mid_left 1.0)
	(sound_impulse_start sfx_light ss_flood_light_mid_right 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_mid_left 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_mid_right 1.0)
	
	
		(sleep 55)
	
	(if debug (print "::: high lights on :::"))
	(object_create launch_facility_light)
	
	(sound_impulse_start sfx_light ss_flood_light_top_left 1.0)
	(sound_impulse_start sfx_light ss_flood_light_top_right 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_top_left 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_top_right 1.0)
	
)


; =================================================================================================
; silo fight
; =================================================================================================
(script dormant slo_fight_control
	(sleep_until (>= (device_get_position dm_slo_shutter) 1) 1)
	(sleep 90)
	(ai_place gr_cov_slo)
	(ai_place gr_unsc_troopers_slo)
	(sleep 10)
	(ai_cannot_die sq_unsc_slo_top_troopers0 true)
)


; =================================================================================================
; thespians
; =================================================================================================
(script static void thespian_beach_start
	(thespian_performance_setup_and_begin thespian_start_carter "" 0)
	(thespian_performance_setup_and_begin thespian_start_jorge "" 0)
	(thespian_performance_setup_and_begin thespian_start_kat "" 0)
)

; =================================================================================================
; dialogue
; =================================================================================================
(global boolean b_dialogue_playing false)
(global short s_md_duration 0)
(global boolean dialogue true)
; -------------------------------------------------------------------------------------------------
(script static void (md_play (short delay) (sound line))
	(sleep delay)
	(sound_impulse_start line none 1)
	(sleep (sound_impulse_language_time line)))

(script static void (md_print (string line))
	(if dialogue (print line)))
	
(script static void md_start
	(sleep_until (not b_dialogue_playing) 1)
	(set b_dialogue_playing true))
	
(script static void md_stop
	(set b_dialogue_playing false))

(script static void (md_ai_play (short delay) (ai char) (ai_line line))
	(set s_md_duration (ai_play_line char line))
	(sleep s_md_duration)
	(sleep delay)
)

(script static void (md_object_play (short delay) (object obj) (ai_line line))
	(set s_md_duration (ai_play_line_on_object obj line))
	(sleep s_md_duration)
	(sleep delay)
)

(script static void (enable_spartan_combat_dialogue (boolean enabled))
	(if enabled
		(print "::: spartan combat dialogue enabled :::")
		(print "::: spartan combat dialogue disabled :::"))
		
	(ai_dialogue_enable enabled)
)



(script dormant md_bch_jor_intro
	(sleep 30)
	
	(md_start)
		
			(md_print "jorge: bit of a hike to the launch facility.")
			(md_ai_play 0 ai_jorge m45_0010)
			
			(md_print "carter: any closer's too hot to land.")
			(md_ai_play 0 ai_carter m45_0020)
			
			(md_print "kat: let's move, lietenant!")
			(md_ai_play 0 ai_kat m20_10c_090)
					
	(md_stop)
)

(script dormant md_bch_car_reinforcements
	(sleep (random_range 90 120))

	(md_start)
	
			(md_print "carter: enemy reinforcements inbound!")
			(md_ai_play 0 ai_carter m45_3000)
			
			(md_print "jorge: is there any place the covenant isn't?")
			(md_ai_play 0 ai_jorge m45_0910)
	
	(md_stop)
)

(script dormant md_bch_car_been_engaged
	(sleep 60)
	
	(md_start)
	
			(md_print "carter: we've been engaged!")
			(md_ai_play 0 ai_carter m10_80c_180)
			
			(md_print "carter: five and six, clear the hole.")
			(md_ai_play 0 ai_carter m10_80c_310)
	
	(md_stop)
)

(script dormant md_bch_kat_airborne
	(sleep 120)
	
	(md_start)
	
			(md_print "kat: airborne. close.")
			(md_ai_play 45 ai_kat m52_20c_320)
			
			(md_print "carter: how close?")
			(md_ai_play 0 ai_carter m52_20c_330)
			
			(sleep_until b_bch_bombingrun_complete)
			
			(md_print "kat: that close!")
			(md_ai_play 0 ai_kat m52_20c_340)
	
	(md_stop)
)

(script dormant md_bch_car_spartans_engage
	(md_start)
	
			(md_print "carter: spartans! engage hostile forces!")
			(md_ai_play 0 ai_carter m10_1130)
	
	(md_stop)
)

(script dormant md_bch_car_kill_those
	(sleep 65)
	(md_start)
	
			(md_print "carter: six! kill those split-jaw sons of bitches!")
			(md_ai_play 0 ai_carter m10_2560)
			
	(md_stop)
)


(script static void md_bch_car_inside_six
	(md_start)
	
			(md_print "carter: inside, six! let's go!")
			(md_ai_play 0 ai_carter m45_0220)
		
	(md_stop)
)

(script dormant md_fac_jor_holland_said
	(md_start)
	
			(md_print "jorge: still can't believe holland said yes to this.")
			(md_ai_play 0 ai_jorge m45_0170)
			
			(md_print "carter: let's do this before he changes his mind.")
			(md_ai_play 0 ai_carter m45_0195)
	
	(md_stop)
)

(script dormant md_bch_car_doubletime
	(sleep 90)
	
	(md_start)

			(md_print "carter: noble team, double-time it!")
			(md_ai_play 0 ai_carter m10_0660)
	
	(md_stop)
)

(script dormant md_bch_trf_spartans_coming
	(md_start)
	
		(md_print "female trooper: spartans coming in! watch your fire!")
		;(md_ai_play 0 sq_unsc_bch_tr_door0_female m45_0100)
		(md_object_play 0 none m45_0100)
		
	(md_stop)
)

(script dormant md_fac_kat_wraith
	(sleep 120)
	(md_start)

			(md_print "kat: six, use the target locator on that wraith!")
			(md_ai_play 0 ai_kat m20_0380)
	
	(md_stop)
)

(script dormant md_slo_car_rootem
	(sleep 10)
	
	(md_start)

			(md_print "carter: root'em out!")
			(md_ai_play 0 ai_carter m45_0090)
	
	(md_stop)
)

(script dormant md_slo_control_room
	(md_start)
	
			(md_print "kat: control room... go easy.")
			(md_ai_play 0 ai_kat m10_2460)
			
			(md_print "jorge: meaning?")
			(md_ai_play 0 ai_jorge m10_2470)
			
			(md_print "kat: meaning, if it looks important, don't shoot it.")
			(md_ai_play 0 ai_kat m10_2480)
	
	(md_stop)
	
	(wake md_slo_car_get_to_sabre)
)

(script dormant md_slo_car_get_to_sabre

	(sleep_until (>= (device_get_position dm_slo_shutter) 1) 1)
	
	(sleep (random_range 150 180))
	
	(md_start)

			;(thespian_performance_setup_and_begin thespian_carter_controlroom_order "" 0)
			
			(md_print "carter: six, get to the sabre before the covenant wreck it!")
			(md_ai_play 0 ai_carter m45_0530)
		
	
	(md_stop)
)

(global ai ai_launch_trooper none)
(script dormant md_slo_tr_sabre_ready
	(md_start)
	
			(vs_cast sq_unsc_slo_top_troopers0 true 10 m45_0530)
			(set ai_launch_trooper (vs_role 1))
	
			(md_print "trooper: sabre is prepped and ready for launch.")
			(md_ai_play 0 ai_launch_trooper m45_0530)
	
	(md_stop)
)


; wafer
; -------------------------------------------------------------------------------------------------
(script static void md_waf_hol_intro
	(md_start)
	
		(md_print "holland: noble actual to sabre b-029, over.")
		(md_object_play 0 none m45_0720)
		
		(md_print "jorge: copy, actual. colonel holland?")
		(md_object_play 0 none m45_0730)
		
		(md_print "holland: affirmative. i'll be your control from here on out. safer that way.")
		(md_object_play 0 none m45_0740)
		
		(md_print "jorge: understood, colonel.")
		(md_object_play 0 none m45_0750)
		
	(md_stop)
)

(script static void md_waf_jor_contacts
	(md_start)

		(md_print "jorge: multiple unidentified contacts!")
		(md_object_play 0 none m45_0840)
		
		(md_print "savannah: savannah actual to sabre team, be advised we have bogeys inbound.")
		(md_object_play 0 none m45_0850)
	
		(md_print "anchor 9: anchor 9 to all unsc ships, station defenses are down. requesting combat support until we can bring them back online.")
		(md_object_play 0 none m45_2200)
		
		(md_print "jorge: here we go, six. show them what you can do.")
		(md_object_play 0 none m45_0860)
		
	(md_stop)
)

(script dormant md_waf_sav_skies_clear
	(md_start)
	
		;(md_print "savannah: savannah actual to sabre team, skies are clear. you are --")
		;(md_object_play 0 none m45_0870)
	
		(md_print "anchor 9 actual: anchor niner to all craft in the vicinity. be advised, we show a large attack force inbound.")
		(md_print "anchor 9 actual: combat air patrol and sabre teams are directed to defend the station.")
		(md_object_play 0 none m45_0890)
		
		(md_print "savannah: copy anchor niner. get get'em, sabres.")
		(md_object_play 0 none m45_0900)
		
		(md_print "jorge: is there any place the covenant isn't?")
		(md_object_play 0 none m45_0910)
		
	(md_stop)
)

(script dormant md_waf_an9_warning_fighter
	(md_start)
	
		(md_print "anchor 9 actual: anchor 9 to unsc ships, impulse drive signatures detected. fighter class. heads up, sabres!")
		(md_object_play 0 none m45_0920)
	
	(md_stop)
)

(script static void md_waf_an9_warning_warning_bogeys
	(md_start)
	
		(md_print "anchor 9 actual: anchor 9 to unsc ships, inbound covenant bogeys. combat air patrol, align on intercept vector to inbound enemy craft.")
		(md_object_play 0 none m45_0930)
		
	(md_stop)
)

(script dormant md_waf_an9_warning_signatures
	(md_start)

		(md_print "anchor 9 actual: anchor 9 to unsc ships, scan's detecting multiple inbound signatures. heading 126.")
		(md_object_play 0 none m45_0940)
	
	(md_stop)
)

(script dormant md_waf_an9_warning_phantom
	(md_start)
	
		(md_print "anchor 9 actual: phantom! take it out, sabre teams.")
		(md_object_play 0 none m45_0950)
		
	(md_stop)
)

(script dormant md_waf_an9_scrambling_reserves
	(md_start)
	
		(md_print "anchor 9 actual: scrambling reserve sabre squadron. that's all we got left.")
		(md_object_play 0 none m45_0960)
		
	(md_stop)
)

(script static void md_waf_an9_defenses_down
	(md_start)

		(md_print "anchor 9: anchor 9 to all unsc ships, station defenses are down. requesting combat support until we can bring them back online.")
		(md_object_play 0 none m45_2200)
	
	(md_stop)
)

(script dormant md_waf_an9_batteries_at_56
	(md_start)

		(md_print "anchor 9: defensive batteries are at 56 percent. hang in there, sabre teams.")
		(md_object_play 0 none m45_2210)
	
	(md_stop)
)

(script dormant md_waf_an9_batteries_at_79
	(sleep (random_range (* 30 10) (* 30 20)))
	(md_start)

		(md_print "anchor 9: defensive batteries at 79 percent. buy us another minute sabre teams!")
		(md_object_play 0 none m45_2220)
	
	(md_stop)
)

(script static void md_waf_an9_station_defenses_online
	(md_start)

		(md_print "anchor 9: anchor 9 to all unsc ships, station defenses are back online. clear the lane. we'll light'em up.")
		(md_object_play 0 none m45_2230)
		
	(md_stop)
)


; -------------------------------------------------------------------------------------------------
(script static void md_waf_an9_phantoms_arrived
	(md_start)

		(md_print "anchor 9: anchor 9 to all unsc fighters: multiple inbound phantoms -- headed straight for our defensive batteries.")
		(md_object_play 0 none m45_2240)
	
		(md_print "anchor 9: sabre teams, we're marking high-value gunboat targets... now!")
		(md_object_play 0 none m45_2250)
		
	(md_stop)
)


(script static void md_waf_an9_intercept_gunboats
	(md_start)
	
		(md_print "anchor 9: all unsc ships: intercept gunboat-class phantoms. hit those markers!")
		(md_object_play 0 none m45_2260)
		
	(md_stop)
)

; -------------------------------------------------------------------------------------------------
(script static void md_waf_incoming_phantoms_inbound
	(begin_random_count 1
		(md_waf_an9_phantoms_inbound_vector)
		(md_waf_an9_phantoms_forward))
)

(script static void md_waf_an9_phantoms_inbound_vector
	(md_start)

		(md_print "anchor 9: anchor 9 to sabre teams, phantoms are inbound on vector seven mark four-niner.")
		(md_object_play 0 none m45_2270)
	
	(md_stop)
)

(script static void md_waf_an9_phantoms_forward
	(md_start)

		(md_print "anchor 9: anchor 9 to sabre teams: phantom signatures detected on a forward-facing vector.")
		(md_object_play 0 none m45_2280)
	
	(md_stop)
)

; -------------------------------------------------------------------------------------------------
(script dormant md_waf_an9_gunboats_in_position
	;(sleep_until b_waf_phantoms_in_position)
	
	(md_start)

		(md_print "anchor 9: gunboats are in position! damage control teams, at the ready!")
		(md_object_play 0 none m45_2310)
	
	(md_stop)
)

(script dormant md_waf_phantom_torpedoes_away
	;(sleep_until b_waf_phantom_torpedoes_away)
	
	(begin_random_count 1
		(md_waf_an9_torpedoes_away)
		(md_waf_an9_torpedo_launch)
		(md_waf_an9_torpedoes_incoming))
		
	(sleep (* 30 5))
	
	(md_waf_an9_collision_alarm)
)

(script static void md_waf_an9_torpedoes_away
	(md_start)

		(md_print "anchor 9: phantom torpedoes away! bracing for impact!")
		(md_object_play 0 none m45_2290)
	
	(md_stop)
)

(script static void md_waf_an9_torpedo_launch
	(md_start)

		(md_print "anchor 9: torpedo launch detected!")
		(md_object_play 0 none m45_2300)
	
	(md_stop)
)


(script static void md_waf_an9_torpedoes_incoming
	(md_start)

		(md_print "anchor 9: torpedoes incoming!")
		(md_object_play 0 none m45_2320)
	
	(md_stop)
)

(script static void md_waf_an9_collision_alarm
	(md_start)
	
		(md_print "anchor 9: collision alarm!")
		(md_object_play 0 none m45_2330)
		
	(md_stop)
)

(script static void md_waf_an9_battery_one_down
	(md_start)

		(md_print "anchor 9: battery one is down!")
		(md_object_play 0 none m45_2340)
	
	(md_stop)
)

(script static void md_waf_an9_battery_two_down
	(md_start)

		(md_print "anchor 9: we've lost battery two!")
		(md_object_play 0 none m45_2350)
	
	(md_stop)
)

(script static void md_waf_an9_battery_three_down
	(md_start)

		(md_print "anchor 9: battery three is down!")
		(md_object_play 0 none m45_2360)
	
	(md_stop)
)

(script static void md_waf_an9_battery_four_down
	(md_start)

		(md_print "anchor 9: battery four is down!")
		(md_object_play 0 none m45_2370)
	
	(md_stop)
)

(script static void md_waf_an9_battery_five_down
	(md_start)

		(md_print "anchor 9: battery five is offline!")
		(md_object_play 0 none m45_2380)
			
	(md_stop)
)

(script static void md_waf_an9_battery_six_down
	(md_start)

		(md_print "anchor 9: battery six is out of the fight!")
		(md_object_play 0 none m45_2390)
	
	(md_stop)
)

(script static void md_waf_an9_all_batteries_down
	(md_start)

		(md_print "anchor 9: anchor 9 to all unsc ships: all forward-faciong batteries are destroyed. our lives are in your hands now, sabre teams!")
		(md_object_play 0 none m45_2400)
	
	(md_stop)
)



; -------------------------------------------------------------------------------------------------
; warp
; -------------------------------------------------------------------------------------------------
(script static void md_wrp_an9_ships_neutralized
	(md_start)

		(md_print "achor 9 actual: anchor 9 to unsc ships, all targets neutralized. b-029, you are clear to dock. activating marker.")
		(md_object_play 0 none m45_0970)
			
		(md_print "holland: holland to b-029 -- noble 5, you ready to go?")
		(md_object_play 0 none m45_0980)
		
		(md_print "jorge: affirmative, colonel.")
		(md_object_play 0 none m45_0990)
		
	(md_stop)
)

; =================================================================================================
; savannah
; =================================================================================================
(script static void waf_savannah_dock
	(object_destroy dm_savannah_wafer)
	(object_create dm_savannah_wafer)
	(device_set_position_track dm_savannah_wafer "m45_dock" 0)
	(device_set_position_immediate dm_savannah_wafer 0)	
	(device_animate_position dm_savannah_wafer 1.0 60 1 0 false)
)


; =================================================================================================
; objectives
; =================================================================================================
(script static void (new_mission_objective (string_id screen) (string_id start_menu))
	;(objectives_clear)
	(sound_impulse_start sound\game_sfx\fireteam\issue_directive.sound none 1)
	(f_hud_obj_new screen start_menu)
	;(cinematic_set_chud_objective t)
	;(if debug (print "objectives: adding objective to the start menu tray..."))
	;(objectives_show objective_index))
)

(script dormant show_objective_wafer_defense
	(new_mission_objective ct_obj_wafer_defend primary_objective_6))
	
	
(script static void sfx_attach_chatter
	(sound_looping_start sfx_chatter (player0) 1.0))
	
(script static void sfx_detach_chatter
	(sound_looping_stop sfx_chatter))
    
(script static boolean obj_uspart_0_3
    (= b_bch_ghostcharge_complete true))

(script static boolean obj_ugate__0_5
(and (= b_bch_podfight_started true) (not (= b_bch_podfight_complete true))))

(script static boolean obj_ugate__0_6
(and (= b_bch_bombingrun_started true) (not (= b_bch_bombingrun_complete true))))

(script static boolean obj_uspart_0_8
(>= b_bch_podfight_phase 2))

(script static boolean obj_uspart_0_9
(>= b_bch_podfight_phase 1))

(script static boolean obj_uspart_0_10
(>= s_objcon_bch 20))

(script static boolean obj_uspart_0_11
(= b_bch_podfight_complete true))

(script static boolean obj_uspart_0_14
(>= s_objcon_bch 110))

(script static boolean obj_ugate__0_15
(and (>= s_objcon_bch 120) (<= (ai_living_count gr_cov_bch_entrance) 0)))

(script static boolean obj_ugate__0_18
(= b_bch_ghostcharge_complete true))

(script static boolean obj_uentra_0_20
(<= (ai_living_count sq_cov_bch_entrance_grunts0) 0))

(script static boolean obj_uentra_0_21
(<= (ai_living_count sq_cov_bch_entrance_grunts0) 3))

(script static boolean obj_ugate__0_22
(= b_bch_ghostcharge_started true))

(script static boolean obj_ufallb_0_25
(>= s_objcon_bch 80))

(script static boolean obj_uentra_0_26
(<= (ai_living_count sq_cov_bch_entrance_grunts0) 3))

(script static boolean obj_ugate__0_27
(= b_bch_podfight_spartans_advance true))

(script static boolean obj_uph0_f_0_28
(volume_test_players tv_bch_enc_00))

(script static boolean obj_uspart_0_29
(>= s_objcon_bch 10))

(script static boolean obj_uspart_0_30
(>= s_objcon_bch 20))

(script static boolean obj_uspart_0_31
(>= s_objcon_bch 30))

(script static boolean obj_uspart_0_32
(>= s_objcon_bch 40))

(script static boolean obj_uspart_0_33
(>= s_objcon_bch 50))

(script static boolean obj_uspart_0_34
(>= s_objcon_bch 60))

(script static boolean obj_cgate__1_14
(= b_bch_entrancefight_finalpush false))

(script static boolean obj_uspart_2_1
(>= s_objcon_fac 30))

(script static boolean obj_uspart_2_2
(>= s_objcon_fac 120))

(script static boolean obj_uspart_2_5
(and (>= s_objcon_fac 120) (<= (ai_task_count obj_cov_fac/gate_hall) 0)))

(script static boolean obj_ugate__2_6
(= b_fac_deadman_completed true))

(script static boolean obj_utasks_2_9
(>= s_objcon_fac 80))

(script static boolean obj_cwhall_3_0
(< s_objcon_fac 120))

(script static boolean obj_ucontr_4_2
(>= s_objcon_slo 30))

(script static boolean obj_ujorge_4_4
(>= s_objcon_slo 50))

; =================================================================================================
; insertion points
; =================================================================================================
(global short s_insertion_index -1)
; -------------------------------------------------------------------------------------------------

; =================================================================================================
; beach
; =================================================================================================
(script static void ins_beach
	(if debug (print "::: insertion: beach"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_bch)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_beach_001_005)
	(sleep 1)
	
	(teleport_players
		fl_bch_player0
		fl_bch_player1
		fl_bch_player2
		fl_bch_player3)
		
	
)


; =================================================================================================
; facility
; =================================================================================================
(script static void ins_facility
	(if debug (print "::: insertion: facility"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_fac)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	(teleport_players
		fl_fac_player0
		fl_fac_player1
		fl_fac_player2
		fl_fac_player3)
		
	(fac_spartan_spawn)
	(ai_place sq_unsc_fac_troopers0)
	(object_destroy sc_wall_panel)
)


; =================================================================================================
; silo
; =================================================================================================
(script static void ins_silo
	(if debug (print "::: insertion: silo"))
	
	;(spartans_run)
	; set insertion point index 
	(set s_insertion_index s_encounter_index_slo)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_silo_005_010_015)
	(sleep 1)
	
	(teleport_players
		fl_slo_player0
		fl_slo_player1
		fl_slo_player2
		fl_slo_player3)
		
	(slo_spartan_spawn)
)


; =================================================================================================
; wafer
; =================================================================================================
(script static void ins_wafer
	(if debug (print "insertion: wafer"))

	; set insertion point index 
	(set s_insertion_index s_encounter_index_waf)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_wafercombat_030)
	(sleep 1)
	
	; teleporting players 
	(print "teleporting players...")
	
	;*
	(create_player_sabres
		v_wafer_sabre_player0 
		v_wafer_sabre_player1 
		v_wafer_sabre_player2 
		v_wafer_sabre_player3)
	(load_player_sabres
		v_wafer_sabre_player0 
		v_wafer_sabre_player1 
		v_wafer_sabre_player2 
		v_wafer_sabre_player3)		
	*;
	;(nuke_planet)
)

; =================================================================================================
; test scripts
; =================================================================================================
(script static void test_bch_vignette_start
	(ai_erase gr_unsc_spartans)
	(sleep 1)
	
	(bch_spartan_spawn)
	(bch_spartan_setup)
	(sleep 10)
	
	(thespian_performance_setup_and_begin thespian_start_carter "" 0)
	(thespian_performance_setup_and_begin thespian_start_jorge "" 0)
	(thespian_performance_setup_and_begin thespian_start_kat "" 0)
)

(script static void test_bch_podfight
	(if debug (print "::: insertion: pod fight"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_bch)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	(object_teleport (player0) fl_bch_podfight_player0)
	(bch_spartan_spawn)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_podfight_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_podfight_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_podfight_spartans)
	
	(set s_objcon_bch 20)
)


(script static void test_bch_encounter
	(if debug (print "::: insertion: pod fight"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_bch)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	(object_teleport (player0) fl_bch_encounter_player0)
	(bch_spartan_spawn)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_encounter_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_encounter_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_encounter_spartans)
	
	(set s_objcon_bch 30)
	
	; set insertion point index 
	(set b_bch_podfight_started true)
	(set b_bch_podfight_spartans_advance true)
	(set s_insertion_index s_encounter_index_bch)	
)

(script static void test_bch_bombingrun
	(if debug (print "::: insertion: bombing run"))
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	
	;(ai_place gr_cov_bch_entrance)
	(object_teleport (player0) fl_bch_bombingrun_player0)
	(bch_spartan_spawn)
	;(sleep_forever bch_bombingrun_control)
	(set s_objcon_bch 60)
	
	; start scripts
	(set s_insertion_index s_encounter_index_bch)
	(sleep 1)
	(sleep_forever bch_podfight_control)
	
	(sleep 5)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_bombingrun_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_bombingrun_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_bombingrun_spartans)
)

(script static void fx_loop_crash
	(if debug (print "looping bombing run crash!"))
	
	(sleep_until
		(begin
			(garbage_collect_unsafe)
			(object_create_anew sc_wall_panel)
			(bch_seraph_bombingrun_crash0)
			
			(sleep_until (>= (device_get_position dm_marker_seraph_crash0) 1) 1)
	
				(objects_detach dm_marker_seraph_crash0 (ai_vehicle_get_from_starting_location sq_cov_bch_seraph_bombers0/pilot_crash0))
				(damage_object (ai_vehicle_get_from_starting_location sq_cov_bch_seraph_bombers0/pilot_crash0) "" 1000)
				
				(effect_new_on_object_marker objects\levels\solo\m45\wall_panel\fx\wall_panel_destroyed.effect sc_wall_panel "")
				(object_set_permutation sc_wall_panel default destroyed)
	
				(object_destroy dm_marker_seraph_crash0)

				(sleep 210)
				(object_destroy sc_wall_panel)
		0)
	1)
)

(script static void test_bch_ghostcharge
	(if debug (print "::: insertion: ghost charge"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_bch)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	
	(bch_spartan_spawn)
	(object_teleport (player0) fl_bch_ghostcharge_player0)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_ghostcharge_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_ghostcharge_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_ghostcharge_spartans)
	
	;(ai_place gr_cov_bch_entrance)
	(sleep_forever bch_podfight_control)
	(sleep_forever bch_bombingrun_control)
	
	(set b_bch_bombingrun_complete true)
	
	(set s_objcon_bch 80)
	
	(ai_erase gr_cov_bch_cove)
	
	
)

(script static void test_bch_entrance
	(if debug (print "::: insertion: entrance fight"))
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)	
	
	
	
	(set s_insertion_index s_encounter_index_bch)
	(sleep 1)
	(sleep_forever bch_podfight_control)
	(sleep_forever bch_bombingrun_control)
	(sleep_forever bch_ghostcharge_control)

	
	(set s_objcon_bch 90)
	
	
	
	
	(object_teleport (player0) fl_bch_entrance_player0)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_entrance_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_entrance_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_entrance_spartans)
	
	(ai_place gr_cov_bch_entrance)
	(set b_bch_ghostcharge_complete true)
)


(script static void test_fac_deadman
	(if debug (print "::: insertion: deadman"))
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	(object_teleport (player0) fl_fac_deadman_player0)
	
	(fac_spartan_spawn)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_fac_deadman_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_fac_deadman_spartans)
	(object_teleport (ai_get_object ai_kat) fl_fac_deadman_spartans)
	
	(sleep_forever bch_podfight_control)
	(sleep_forever bch_bombingrun_control)
	
	;(set b_bch_bombingrun_complete true)
	
	
	(set s_objcon_fac 70)
	(set b_fac_airstrike_completed true)
	;(ai_erase gr_cov_bch_cove)
	; set insertion point index 
	(set s_insertion_index s_encounter_index_fac)
)


(script static void test_slo_fight
	(if debug (print "::: insertion: silo fight"))
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_silo_005_010_015)
	(sleep 1)
	
	(object_teleport (player0) fl_slo_fight_player0)
	
	(slo_spartan_spawn)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_slo_fight_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_slo_fight_spartans)
	(object_teleport (ai_get_object ai_kat) fl_slo_fight_spartans)
	
	;(sleep_forever bch_podfight_control)
	;(sleep_forever bch_bombingrun_control)
	
	;(set b_bch_bombingrun_complete true)
	
	
	(set s_objcon_slo 40)
	
	;(ai_erase gr_cov_bch_cove)
	; set insertion point index 
	(set s_insertion_index s_encounter_index_slo)
)


; =================================================================================================
; helpers
; =================================================================================================
(script static void (teleport_players
						(cutscene_flag fl0)
						(cutscene_flag fl1)
						(cutscene_flag fl2)
						(cutscene_flag fl3))
					
	(object_teleport (player0) fl0)
	(object_teleport (player1) fl1)
	(object_teleport (player2) fl2)
	(object_teleport (player3) fl3)
)

(script static void (thespian_carter_cheer)
	(performance_play_line "carter_wave")
)

(script static void (thespian_kat_brace)
	(performance_play_line "kat_brace")
)

(script static void (thespian_start_kat)
	(performance_play_line "lines_0")
)

(script static void (thespian_start_carter)
	(performance_play_line "carter_wave")
)

(script static void (thespian_start_jorge)
	(performance_play_line "lines_0")
)

(script static void (thespian_controlroom_kat)
	(performance_play_line "goto_dest")
	(cs_stow (performance_get_actor kat))
	(performance_play_line "script_stow")
	(performance_play_line "sleep_for_stow")
	(performance_play_line "hack")
	(set b_slo_kat_hack_completed true)
	(performance_play_line "script_open_door")
)

(script static void (thespian_controlroom_carter)
	(performance_play_line "goto_dest")
	(performance_play_line "investigate")
)

(script static void (thespian_controlroom_carter_order)
	(performance_play_line "order")
)

(script static void (thespian_controlroom_jorge)
	(performance_play_line "goto")
	(performance_play_line "idle")
)

(script static void (thespian_facility_injured_gutground0)
	(performance_play_line "pain")
)

(script static void (thespian_facility_injured_gutlyingdown0)
	(performance_play_line "pain")
)

(script static void (thespian_facility_injured_legground0)
	(performance_play_line "pain")
)

(script static void (thespian_facility_injured_chestground0)
	(performance_play_line "pain")
)

(script static void (thespian_silo_salute0)
	(performance_play_line "goto_dest")
	(performance_play_line "trooper_alert")
	(sleep_until (< (objects_distance_to_object (players) (ai_get_object (performance_get_actor trooper))) 5) 1)
	(performance_play_line "sleep_until_proximity")
	(performance_play_line "trooper_anim")
	(performance_play_line "goto_exit")
)

(script static void (thespian_silo_salute1)
	(performance_play_line "teleport")
	(performance_play_line "goto_dest")
	(sleep_until (< (objects_distance_to_object (players) (ai_get_object (performance_get_actor trooper))) 3) 1)
	(performance_play_line "sleep_until_proximity")
	(performance_play_line "trooper_anim")
	(sleep_until (> (objects_distance_to_object (players) (ai_get_object (performance_get_actor trooper))) 1) 1)
	(performance_play_line "sleep_until_player_moves_past")
	(performance_play_line "goto_exit")
)

(script static void (thespian_facility_entrance_left)
	(performance_play_line "goto_dest")
	(performance_play_line "shoot_left")
	(sleep_until (>= s_objcon_fac 20))
	(performance_play_line "script_wait_for_player")
)

(script static void (thespian_facility_entrance_right)
	(performance_play_line "goto_dest")
	(performance_play_line "shoot_left")
	(sleep_until (>= s_objcon_fac 20))
	(performance_play_line "script_wait_for_player")
)

(script static void (thespian_deadman_elite)
	(performance_play_line "goto_dest")
	(performance_play_line "anim")
	(wake md_slo_car_rootem)
	(performance_play_line "md_car_rootem")
)

(script static void (thespian_deadman_carter)
	(performance_play_line "bunker0_move_to")
	(performance_play_line "bunker0_anim_open_enter")
	(performance_play_line "bunker0_anim_open_to_closed")
	(performance_play_line "bunker0_anim_closed_idle")
	(sleep_until (and (= b_fac_airstrike_completed true) (fac_deadman_hall_look)) 1)
	(performance_play_line "script_wait")
	(performance_play_line "bunker0_anim_closed_to_open")
	(performance_play_line "bunker0_anim_open_idle")
	(sleep_until (>= s_objcon_fac 80) 1)
	(performance_play_line_by_id 7)
	(performance_play_line "bunker0_anim_open_exit")
	(performance_play_line "goto_hall0")
	(sleep_until (= b_fac_deadman_completed true) 1)
	(performance_play_line_by_id 10)
)

(script static void (thespian_deadman_kat)
	(performance_play_line "bunker0_move_to")
	(performance_play_line "bunker0_anim_open_to_close")
	(performance_play_line "bunker0_anim_closed_idle")
	(sleep_until (and (= b_fac_airstrike_completed true) (fac_deadman_hall_look)) 1)
	(performance_play_line "script_wait")
	(sleep (random_range 15 35))
	(performance_play_line "delay")
	(performance_play_line "bunker0_anim_closed_to_open")
	(performance_play_line "bunker0_anim_open_idle")
	(sleep_until (>= s_objcon_fac 80) 1)
	(performance_play_line_by_id 7)
	(performance_play_line "bunker0_anim_open_to_exit")
	(performance_play_line "goto_hall0")
	(sleep_until (= b_fac_deadman_completed true) 1)
	(performance_play_line "script_wait_for_player")
)

(script static void (thespian_deadman_jorge)
	(performance_play_line "goto_wait")
	(sleep_until (or (and (= b_fac_airstrike_completed true) (fac_deadman_hall_look)) (>= s_objcon_fac 80)) 1)
	(performance_play_line "script_wait_for_player")
	(performance_play_line "goto_hall0")
)

(script static void (thespian_facility_rockettrooper0)
	(performance_play_line "goto_dest")
	(performance_play_line "shoot_point")
	(performance_play_line "wait")
)

;start of cinematic '045la_blastoff'

(script static void 045la_blastoff_005_sc_sh1
(begin (object_destroy dm_slo_shutter)
(object_destroy launch_facility_light)
(object_destroy sc_slo_sabre)
(object_destroy sc_lnc_gantry_steps)
(render_weather 0))
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 0 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 0)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_1" true)
	(object_hide (cinematic_scripting_get_object 0 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_1" true)
	(object_hide (cinematic_scripting_get_object 0 8) true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 15)
	(ai_play_line_on_object (cinematic_object_get player) sound\dialog\levels\m45\cinematic\m45_10c_330_car)
	(cinematic_print "custom script play")
	(sleep 83)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_005_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 1 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 1)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "jorge_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "player_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_2" true)
	(object_hide (cinematic_scripting_get_object 0 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_2" true)
	(object_hide (cinematic_scripting_get_object 0 8) true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(sleep 124)

	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_005_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 2 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 2)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "jorge_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "player_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_3" true)
	(object_hide (cinematic_scripting_get_object 0 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_light_marker02_3" true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(sleep 93)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_005_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 3 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 3)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "jorge_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "player_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_4" true)
	(object_hide (cinematic_scripting_get_object 0 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_light_marker02_4" true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(sleep 68)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_005_sc_sh5
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 4 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 4)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "jorge_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "player_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_5" true)
	(object_hide (cinematic_scripting_get_object 0 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_light_marker02_5" true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_5" true)
	(cinematic_lights_initialize_for_shot 4)
	(cinematic_clips_initialize_for_shot 4)
	(sleep 99)
	(cinematic_scripting_start_dialogue 0 4 0 "none")
	(sleep 37)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_005_sc_sh6
(object_destroy launch_pad)
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 5 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 5)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(object_hide (cinematic_scripting_get_object 0 0) true)
	(object_hide (cinematic_scripting_get_object 0 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_6" true)
	(object_hide (cinematic_scripting_get_object 0 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_light_marker02_6" true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_6" true)
	(cinematic_lights_initialize_for_shot 5)
	(cinematic_clips_initialize_for_shot 5)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 4) primary_engine_glow 0.000000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 4) ambient_steam_off 0.000000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 4) secondary_engine_glow 0.000000 0.000000)
	(sleep 8)
	(cinematic_scripting_start_effect 0 5 0 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 15)
	(cinematic_scripting_start_effect 0 5 1 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 45)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 4) primary_engine_glow 1.000000 60.000000)
	(sleep 15)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 4) secondary_engine_glow 1.000000 60.000000)
	(sleep 104)

	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_005_sc_sh7
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 6 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 6)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(object_hide (cinematic_scripting_get_object 0 0) true)
	(object_hide (cinematic_scripting_get_object 0 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_7" true)
	(object_hide (cinematic_scripting_get_object 0 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_light_marker02_7" true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_7" true)
	(cinematic_lights_initialize_for_shot 6)
	(cinematic_clips_initialize_for_shot 6)
	(cinematic_scripting_start_effect 0 6 0 (cinematic_object_get "sabre_sabre_fastpack1"))
	(cinematic_scripting_start_effect 0 6 1 (cinematic_object_get "fx_smoke_tunnel"))
	(cinematic_scripting_start_effect 0 6 2 (cinematic_object_get "fx_bro_glass"))
	(sleep 121)

	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_005_sc_sh8
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 7 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 7)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "jorge_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "player_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_8" true)
	(object_hide (cinematic_scripting_get_object 0 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_light_marker02_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "sled_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_8" true)
	(cinematic_lights_initialize_for_shot 7)
	(cinematic_clips_initialize_for_shot 7)
	(sleep 63)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_005_sc_sh9
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 8 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 8)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(object_hide (cinematic_scripting_get_object 0 0) true)
	(object_hide (cinematic_scripting_get_object 0 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "sabre_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "sabre_background_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_sabre_fastpack1_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "gantry_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "fx_light_marker_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "sabre_cockpit2_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_light_marker02_9" true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "sabre_background_fastpack1_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "fx_smoke_tunnel_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_bro_glass_9" true)
	(cinematic_lights_initialize_for_shot 8)
	(cinematic_clips_initialize_for_shot 8)
	(cinematic_scripting_start_effect 0 8 0 (cinematic_object_get "sabre_sabre_fastpack1"))
	(cinematic_scripting_start_effect 0 8 1 (cinematic_object_get "sabre_background_fastpack1"))
	(cinematic_scripting_start_effect 0 8 2 (cinematic_object_get "fx_smoke_tunnel"))
	(sleep 226)

	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_blastoff_005_sc
	(cinematic_print "beginning scene 1")
	(cinematic_scripting_create_scene 0)

	(045la_blastoff_005_sc_sh1)
	(045la_blastoff_005_sc_sh2)
	(045la_blastoff_005_sc_sh3)
	(045la_blastoff_005_sc_sh4)
	(045la_blastoff_005_sc_sh5)
	(045la_blastoff_005_sc_sh6)
	(045la_blastoff_005_sc_sh7)
	(045la_blastoff_005_sc_sh8)
	(045la_blastoff_005_sc_sh9)

	(cinematic_scripting_destroy_scene 0)
)

(script static void 045la_blastoff_010_sc_sh1

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 0 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 0)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "sabre_sabre_fastpack1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "fx_sunlight_marker_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "sabre_cockpit2_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_sunlight_rear_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "sabre_background_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "sabre_background_fastpack_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_light_jorge_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(cinematic_scripting_start_effect 1 0 0 (cinematic_object_get "sabre_background_fastpack"))
	(cinematic_scripting_start_effect 1 0 1 (cinematic_object_get "sabre"))
	(sleep 299)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_blastoff_010_sc
	(cinematic_print "beginning scene 2")
	(cinematic_scripting_create_scene 1)
(prepare_to_switch_to_zone_set set_wafer_019_030)
	(045la_blastoff_010_sc_sh1)

	(cinematic_scripting_destroy_scene 1)
)

(script static void 045la_blastoff_020_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 0 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 0)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 1 "player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "sabre_sabre_fastpack1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "fx_light_marker_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "sabre_cockpit2_1" true)
	(object_hide (cinematic_scripting_get_object 2 6) true)
	(object_hide (cinematic_scripting_get_object 2 7) true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 60)
	(cinematic_scripting_start_dialogue 2 0 0 "none")
	(sleep 38)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_020_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 1 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 1)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(object_hide (cinematic_scripting_get_object 2 0) true)
	(object_hide (cinematic_scripting_get_object 2 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "sabre_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "sabre_sabre_fastpack1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "fx_light_marker_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "sabre_cockpit2_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "sabre_background_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 7 "sabre_background_fastpack_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(cinematic_scripting_start_effect 2 1 0 (cinematic_object_get "sabre"))
	(cinematic_scripting_start_effect 2 1 1 (cinematic_object_get "sabre_background_fastpack"))
	(sleep 129)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_blastoff_020_sc
	(cinematic_print "beginning scene 3")
	(cinematic_scripting_create_scene 2)
(switch_zone_set set_wafer_019_030)
	(045la_blastoff_020_sc_sh1)
	(045la_blastoff_020_sc_sh2)

	(cinematic_scripting_destroy_scene 2)
)

(script static void 045la_blastoff_030_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 0 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 0)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "sabre_sabre_fastpack1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "fx_light_marker_sun_cockpit_1" true)
	(object_hide (cinematic_scripting_get_object 3 4) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "sabre_cockpit2_1" true)
	(object_hide (cinematic_scripting_get_object 3 6) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 7 "fx_light_main_booster_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "fx_light_top_booster_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 9 "fx_light_sabre_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 3 2) ambient_steam_off 0.000000 0.000000)
	(sleep 34)
	(cinematic_scripting_start_dialogue 3 0 0 "none")
	(sleep 41)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_030_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 1 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 1)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(object_hide (cinematic_scripting_get_object 3 0) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "sabre_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "sabre_sabre_fastpack1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "fx_light_marker_sun_cockpit_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "planet_card_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "sabre_cockpit2_2" true)
	(object_hide (cinematic_scripting_get_object 3 6) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 7 "fx_light_main_booster_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "fx_light_top_booster_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 9 "fx_light_sabre_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(cinematic_scripting_start_effect 3 1 0 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 55)
	(cinematic_scripting_start_effect 3 1 1 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 11)
	(cinematic_scripting_start_dialogue 3 1 0 "none")
	(sleep 19)
	(cinematic_scripting_start_effect 3 1 2 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 32)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_030_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 2 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 2)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(object_hide (cinematic_scripting_get_object 3 0) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "sabre_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "sabre_sabre_fastpack1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "fx_light_marker_sun_cockpit_3" true)
	(object_hide (cinematic_scripting_get_object 3 4) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "sabre_cockpit2_3" true)
	(object_hide (cinematic_scripting_get_object 3 6) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 7 "fx_light_main_booster_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "fx_light_top_booster_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 9 "fx_light_sabre_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(cinematic_scripting_start_effect 3 2 0 (cinematic_object_get "sabre_sabre_fastpack1"))
	(cinematic_scripting_start_effect 3 2 2 (cinematic_object_get "sabre_sabre_fastpack1"))
	(cinematic_scripting_start_effect 3 2 1 (cinematic_object_get "sabre_sabre_fastpack1"))
	(cinematic_scripting_start_effect 3 2 3 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 32)
	(cinematic_scripting_start_effect 3 2 4 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 34)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_030_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 3 "045la_blastoff_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 3)
	(cinematic_object_create_cinematic_anchor "045la_blastoff_anchor")
	(object_hide (cinematic_scripting_get_object 3 0) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "sabre_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "sabre_sabre_fastpack1_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "fx_light_marker_sun_cockpit_4" true)
	(object_hide (cinematic_scripting_get_object 3 4) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "sabre_cockpit2_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 6 "logo_boosters_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 7 "fx_light_main_booster_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "fx_light_top_booster_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 9 "fx_light_sabre_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(object_clear_cinematic_function_variable (cinematic_scripting_get_object 3 1) engine_rpm)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 3 1) boost 0.000000 0.000000)
	(sleep 32)
	(cinematic_scripting_start_effect 3 3 0 (cinematic_object_get "sabre_sabre_fastpack1"))
	(cinematic_scripting_start_effect 3 3 2 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 1)
	(cinematic_scripting_start_effect 3 3 1 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 6)
	(cinematic_scripting_start_effect 3 3 3 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 1)
	(cinematic_scripting_start_effect 3 3 4 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 14)
	(cinematic_scripting_start_effect 3 3 5 (cinematic_object_get "sabre_sabre_fastpack1"))
	(sleep 46)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 3 1) engine_rpm 0.150000 0.000000)
	(sleep 180)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 3 1) engine_rpm 1.000000 35.000000)
	(sleep 42)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 3 1) boost 1.000000 20.000000)
	(sleep 23)
	(cinematic_scripting_start_effect 3 3 6 (cinematic_object_get "sabre"))
	(sleep 41)
	(cinematic_scripting_start_dialogue 3 3 0 "none")
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_blastoff_030_sc
	(cinematic_print "beginning scene 4")
	(cinematic_scripting_create_scene 3)

	(045la_blastoff_030_sc_sh1)
	(045la_blastoff_030_sc_sh2)
	(045la_blastoff_030_sc_sh3)
	(045la_blastoff_030_sc_sh4)
(switch_zone_set set_wafer_019_030)
	(cinematic_scripting_destroy_scene 3)
)

(script static void 045la_blastoff_040_sc_sh1

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 4) 0 "wafer_cinematic_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 4) 0)
	(cinematic_object_create_cinematic_anchor "wafer_cinematic_anchor")
	(object_hide (cinematic_scripting_get_object 4 0) true)
	(object_hide (cinematic_scripting_get_object 4 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 2 "sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 3 "fx_light_marker_sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 4 "fx_light_marker_cockpit_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 5 "nuke_card_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 6 "sabre_cockpit1_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 125)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_040_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 4) 1 "wafer_cinematic_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 4) 1)
	(cinematic_object_create_cinematic_anchor "wafer_cinematic_anchor")
	(object_hide (cinematic_scripting_get_object 4 0) true)
	(object_hide (cinematic_scripting_get_object 4 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 2 "sabre_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 3 "fx_light_marker_sabre_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 4 "fx_light_marker_cockpit_2" true)
	(object_hide (cinematic_scripting_get_object 4 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 6 "sabre_cockpit1_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(sleep 72)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_040_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 4) 2 "wafer_cinematic_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 4) 2)
	(cinematic_object_create_cinematic_anchor "wafer_cinematic_anchor")
	(object_hide (cinematic_scripting_get_object 4 0) true)
	(object_hide (cinematic_scripting_get_object 4 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 2 "sabre_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 3 "fx_light_marker_sabre_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 4 "fx_light_marker_cockpit_3" true)
	(object_hide (cinematic_scripting_get_object 4 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 6 "sabre_cockpit1_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(sleep 339)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_blastoff_040_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 4) 3 "wafer_cinematic_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 4) 3)
	(cinematic_object_create_cinematic_anchor "wafer_cinematic_anchor")
	(object_hide (cinematic_scripting_get_object 4 0) true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 1 "player_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 2 "sabre_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 3 "fx_light_marker_sabre_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 4 "fx_light_marker_cockpit_4" true)
	(object_hide (cinematic_scripting_get_object 4 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 6 "sabre_cockpit1_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(sleep 46)
	(sleep (cinematic_tag_fade_out_from_cinematic "045la_blastoff"))
	(sleep 14)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_blastoff_040_sc
	(cinematic_print "beginning scene 5")
	(cinematic_scripting_create_scene 4)
	(045la_blastoff_040_sc_sh1)
	(045la_blastoff_040_sc_sh2)
	(045la_blastoff_040_sc_sh3)
	(045la_blastoff_040_sc_sh4)

	(cinematic_scripting_destroy_scene 4)
)

(script static void 045la_blastoff_cleanup
	(cinematic_scripting_clean_up 0)
)

(script static void begin_045la_blastoff_debug
	(cinematic_zone_activate_for_debugging 0)	(sleep 2)	(camera_control on)	(cinematic_start)	(set cinematic_letterbox_style 0)
	(cinematic_show_letterbox_immediate 1)
	(camera_set_cinematic)	(cinematic_set_debug_mode 1)	(cinematic_set (cinematic_tag_reference_get_cinematic 0)))

(script static void end_045la_blastoff_debug
	(cinematic_destroy)	(cinematic_stop)	(camera_control off)	(render_exposure_fade_out 0)	(cinematic_zone_deactivate 0)	(fade_in 0 0 0 0))

(script static void 045la_blastoff_debug
	(begin_045la_blastoff_debug)
	(sleep (cinematic_tag_fade_in_to_cinematic "045la_blastoff"))
	(!045la_blastoff_005_sc)
	(!045la_blastoff_010_sc)
	(!045la_blastoff_020_sc)
	(!045la_blastoff_030_sc)
	(!045la_blastoff_040_sc)
	(end_045la_blastoff_debug)
)

(script static void begin_045la_blastoff
	(cinematic_zone_activate 0)	(sleep 2)	(camera_set_cinematic)	(cinematic_set_debug_mode 0)	(cinematic_set (cinematic_tag_reference_get_cinematic 0)))

(script static void end_045la_blastoff
	(cinematic_destroy)	(render_exposure_fade_out 0))

(script static void 045la_blastoff
	(begin_045la_blastoff)
	(sleep (cinematic_tag_fade_in_to_cinematic "045la_blastoff"))
	(!045la_blastoff_005_sc)
	(!045la_blastoff_010_sc)
	(!045la_blastoff_020_sc)
	(!045la_blastoff_030_sc)
	(!045la_blastoff_040_sc)
	(end_045la_blastoff)
)

;end of cinematic "045la_blastoff"

;start of cinematic '045lb_pitstop'

(script static void 045lb_pitstop_010_sc_sh1

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 0 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 0)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "frigate_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "pelican_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "player_sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_01_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "sabre_02_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "slipspace_bomb_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_sabre_01_dyn_light_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "fx_sabre_02_dyn_light_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "claw_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "pelican_claw_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_light_for_landing_area_1" true)
	(object_hide (cinematic_scripting_get_object 0 13) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "player_sabre_cockpit1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 15 "sabre_01_cockpit1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 16 "sabre_02_cockpit1_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 1)
	(cinematic_scripting_start_dialogue 0 0 0 "none")
	(sleep 34)
	(cinematic_scripting_start_dialogue 0 0 1 "none")
	(sleep 139)
	(cinematic_scripting_start_dialogue 0 0 2 "none")
	(sleep 4)

	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_010_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 1 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 1)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "frigate_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "pelican_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "player_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "player_sabre_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_01_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "sabre_02_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "slipspace_bomb_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "jorge_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_sabre_01_dyn_light_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "fx_sabre_02_dyn_light_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "claw_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "pelican_claw_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_light_for_landing_area_2" true)
	(object_hide (cinematic_scripting_get_object 0 13) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "player_sabre_cockpit1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 15 "sabre_01_cockpit1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 16 "sabre_02_cockpit1_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(sleep 5)
	(cinematic_scripting_start_dialogue 0 1 0 "none")
	(sleep 52)
	(cinematic_scripting_start_dialogue 0 1 1 "none")
	(sleep 46)
	(cinematic_scripting_start_dialogue 0 1 2 "none")
	(sleep 76)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_010_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 2 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 2)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "frigate_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "pelican_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "player_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "player_sabre_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_01_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "sabre_02_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "slipspace_bomb_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "jorge_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_sabre_01_dyn_light_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "fx_sabre_02_dyn_light_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "claw_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "pelican_claw_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_light_for_landing_area_3" true)
	(object_hide (cinematic_scripting_get_object 0 13) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "player_sabre_cockpit1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 15 "sabre_01_cockpit1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 16 "sabre_02_cockpit1_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(sleep 48)
	(cinematic_scripting_start_dialogue 0 2 0 "none")
	(sleep 84)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_010_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 3 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 3)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "frigate_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "pelican_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "player_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "player_sabre_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_01_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "sabre_02_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "slipspace_bomb_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "jorge_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_sabre_01_dyn_light_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "fx_sabre_02_dyn_light_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "claw_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "pelican_claw_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_light_for_landing_area_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 13 "nuke_card_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "player_sabre_cockpit1_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 15 "sabre_01_cockpit1_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 16 "sabre_02_cockpit1_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(sleep 28)
	(cinematic_scripting_start_dialogue 0 3 0 "none")
	(sleep 205)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_010_sc_sh5

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 4 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 4)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "frigate_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "pelican_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "player_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "player_sabre_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "sabre_01_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "sabre_02_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "slipspace_bomb_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "jorge_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "fx_sabre_01_dyn_light_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "fx_sabre_02_dyn_light_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "claw_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "pelican_claw_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "fx_light_for_landing_area_5" true)
	(object_hide (cinematic_scripting_get_object 0 13) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "player_sabre_cockpit1_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 15 "sabre_01_cockpit1_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 16 "sabre_02_cockpit1_5" true)
	(cinematic_lights_initialize_for_shot 4)
	(cinematic_clips_initialize_for_shot 4)
	(sleep 134)

	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045lb_pitstop_010_sc
	(cinematic_print "beginning scene 1")
	(cinematic_scripting_create_scene 0)

	(045lb_pitstop_010_sc_sh1)
	(045lb_pitstop_010_sc_sh2)
	(045lb_pitstop_010_sc_sh3)
	(045lb_pitstop_010_sc_sh4)
	(045lb_pitstop_010_sc_sh5)

	(cinematic_scripting_destroy_scene 0)
)

(script static void 045lb_pitstop_020_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 0 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 0)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "frigate_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "pelican_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "player_sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "sabre_01_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "sabre_02_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "slipspace_bomb_1" true)
	(object_hide (cinematic_scripting_get_object 1 8) true)
	(object_hide (cinematic_scripting_get_object 1 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 10 "pelican_claw_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 11 "sabre_claw_1" true)
	(object_hide (cinematic_scripting_get_object 1 12) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 13 "player_sabre_cockpit1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 14 "sabre_01_cockpit1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 15 "sabre_02_cockpit1_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 98)
	(cinematic_scripting_start_dialogue 1 0 0 "none")
	(sleep 64)
	(cinematic_scripting_start_dialogue 1 0 1 "none")
	(sleep 76)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_020_sc_sh2

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 1 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 1)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "frigate_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "jorge_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "pelican_2" true)
	(object_hide (cinematic_scripting_get_object 1 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "player_sabre_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "sabre_01_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "sabre_02_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "slipspace_bomb_2" true)
	(object_hide (cinematic_scripting_get_object 1 8) true)
	(object_hide (cinematic_scripting_get_object 1 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 10 "pelican_claw_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 11 "sabre_claw_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 12 "nukecard_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 13 "player_sabre_cockpit1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 14 "sabre_01_cockpit1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 15 "sabre_02_cockpit1_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 1 12) nuke_1 0.000000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 1 12) nuke_2 0.000000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 1 12) nuke_3 0.000000 0.000000)
	(sleep 30)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 1 12) nuke_1 1.000000 600.000000)
	(sleep 2)
	(cinematic_scripting_start_dialogue 1 1 0 "none")
	(sleep 77)
	(cinematic_scripting_start_dialogue 1 1 1 "none")
	(sleep 91)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 1 12) nuke_2 1.000000 600.000000)
	(sleep 22)
	(cinematic_scripting_start_dialogue 1 1 2 "none")
	(sleep 100)
	(cinematic_scripting_start_dialogue 1 1 3 "none")
	(sleep 28)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 1 12) nuke_3 1.000000 600.000000)
	(sleep 244)

	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_020_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 2 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 2)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "frigate_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "jorge_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "pelican_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "player_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "player_sabre_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "sabre_01_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "sabre_02_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "slipspace_bomb_3" true)
	(object_hide (cinematic_scripting_get_object 1 8) true)
	(object_hide (cinematic_scripting_get_object 1 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 10 "pelican_claw_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 11 "sabre_claw_3" true)
	(object_hide (cinematic_scripting_get_object 1 12) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 13 "player_sabre_cockpit1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 14 "sabre_01_cockpit1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 15 "sabre_02_cockpit1_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(sleep 44)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_020_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 3 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 3)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "frigate_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "jorge_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "pelican_4" true)
	(object_hide (cinematic_scripting_get_object 1 3) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "player_sabre_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "sabre_01_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "sabre_02_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "slipspace_bomb_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "space_marine01_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "space_marine02_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 10 "pelican_claw_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 11 "sabre_claw_4" true)
	(object_hide (cinematic_scripting_get_object 1 12) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 13 "player_sabre_cockpit1_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 14 "sabre_01_cockpit1_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 15 "sabre_02_cockpit1_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(sleep 43)
	(cinematic_scripting_start_dialogue 1 3 0 "none")
	(sleep 51)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_020_sc_sh5
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 4 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 4)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(object_hide (cinematic_scripting_get_object 1 0) true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(object_hide (cinematic_scripting_get_object 1 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "player_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "player_sabre_5" true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(object_hide (cinematic_scripting_get_object 1 6) true)
	(object_hide (cinematic_scripting_get_object 1 7) true)
	(object_hide (cinematic_scripting_get_object 1 8) true)
	(object_hide (cinematic_scripting_get_object 1 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 10 "pelican_claw_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 11 "sabre_claw_5" true)
	(object_hide (cinematic_scripting_get_object 1 12) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 13 "player_sabre_cockpit1_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 14 "sabre_01_cockpit1_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 15 "sabre_02_cockpit1_5" true)
	(cinematic_lights_initialize_for_shot 4)
	(cinematic_clips_initialize_for_shot 4)
	
	(cinematic_print "custom script play")
	(sleep 8)
	(cinematic_scripting_start_dialogue 1 4 0 "none")
	(sleep 16)
	(cinematic_scripting_start_dialogue 1 4 2 "none")
	(sleep 90)
	(cinematic_scripting_start_dialogue 1 4 1 "none")
	(sleep 75)
	(cinematic_scripting_start_dialogue 1 4 3 "none")
	(sleep 38)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045lb_pitstop_020_sc
	(cinematic_print "beginning scene 2")
	(cinematic_scripting_create_scene 1)
	(045lb_pitstop_020_sc_sh1)
	(045lb_pitstop_020_sc_sh2)
	(045lb_pitstop_020_sc_sh3)
	(045lb_pitstop_020_sc_sh4)
	(045lb_pitstop_020_sc_sh5)
	(cinematic_scripting_destroy_scene 1)
)

(script static void 045lb_pitstop_030_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 0 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 0)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 1 "pelican_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "slipspace_bomb_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "space_marine01_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "space_marine02_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "cutting_torch_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "claw_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 7 "fx_light_jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 8 "fx_light_pelican_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 9 "pelican_pelican_interior1_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 3)
	(cinematic_scripting_start_dialogue 2 0 0 "none")
	(sleep 272)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045lb_pitstop_030_sc
	(cinematic_print "beginning scene 3")
	(cinematic_scripting_create_scene 2)
	(045lb_pitstop_030_sc_sh1)
	(cinematic_scripting_destroy_scene 2)
)

(script static void 045lb_pitstop_040_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 0 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 0)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "frigate_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "pelican_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "player_sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "slipspace_bomb_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "sabre_01_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 6 "sabre_02_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 7 "sabre_03_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "claw_pelican_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 9 "claw_sabre_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "player_sabre_cockpit1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 11 "sabre_01_cockpit1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 12 "sabre_02_cockpit1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 13 "sabre_03_cockpit1_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 131)
	(cinematic_scripting_start_dialogue 3 0 1 "none")
	(sleep 33)
	(cinematic_scripting_start_dialogue 3 0 0 "none")
	(sleep 42)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_040_sc_sh2

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 1 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 1)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "frigate_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "pelican_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "player_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "player_sabre_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "slipspace_bomb_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "sabre_01_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 6 "sabre_02_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 7 "sabre_03_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "claw_pelican_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 9 "claw_sabre_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "player_sabre_cockpit1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 11 "sabre_01_cockpit1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 12 "sabre_02_cockpit1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 13 "sabre_03_cockpit1_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(object_set_permutation (cinematic_object_get player) flair_left_shoulder kat)
	(cinematic_print "custom script play")
	(sleep 170)
	(cinematic_scripting_start_dialogue 3 1 0 "none")
	(sleep 116)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045lb_pitstop_040_sc_sh3

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 2 "045b_pitstop_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 2)
	(cinematic_object_create_cinematic_anchor "045b_pitstop_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "frigate_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "pelican_3" true)
	(object_hide (cinematic_scripting_get_object 3 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "player_sabre_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "slipspace_bomb_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "sabre_01_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 6 "sabre_02_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 7 "sabre_03_3" true)
	(object_hide (cinematic_scripting_get_object 3 8) true)
	(object_hide (cinematic_scripting_get_object 3 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "player_sabre_cockpit1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 11 "sabre_01_cockpit1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 12 "sabre_02_cockpit1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 13 "sabre_03_cockpit1_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(sleep 7)
	(cinematic_scripting_start_dialogue 3 2 1 "none")
	(sleep 103)
	(cinematic_scripting_start_dialogue 3 2 0 "none")
	(sleep 415)

	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045lb_pitstop_040_sc
	(cinematic_print "beginning scene 4")
	(cinematic_scripting_create_scene 3)

	(045lb_pitstop_040_sc_sh1)
	(045lb_pitstop_040_sc_sh2)
	(045lb_pitstop_040_sc_sh3)
(switch_zone_set set_corvettecombat_050_070)
	(cinematic_scripting_destroy_scene 3)
)

(script static void 045lb_pitstop_050_sc_sh1

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 4) 0 "045lf_jorge_030_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 4) 0)
	(cinematic_object_create_cinematic_anchor "045lf_jorge_030_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 4 0 "beacon_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 1 "corvette_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 2 "frigate_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 3 "sabre_01_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 4 "sabre_02_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 5 "sabre_03_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 6 "sabre_04_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 7 "sabre_05_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 8 "sabre_06_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 4 9 "fx_light_marker_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 82)
	(cinematic_scripting_start_dialogue 4 0 0 "none")
	(sleep 174)
	(cinematic_scripting_start_dialogue 4 0 1 "none")
	(sleep 103)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045lb_pitstop_050_sc
	(cinematic_print "beginning scene 5")
	(cinematic_scripting_create_scene 4)

	(045lb_pitstop_050_sc_sh1)

	(cinematic_scripting_destroy_scene 4)
)

(script static void 045lb_pitstop_cleanup
	(cinematic_scripting_clean_up 1)
)

(script static void begin_045lb_pitstop_debug
	(cinematic_zone_activate_for_debugging 1)	(sleep 2)	(camera_control on)	(cinematic_start)	(set cinematic_letterbox_style 0)
	(cinematic_show_letterbox_immediate 1)
	(camera_set_cinematic)	(cinematic_set_debug_mode 1)	(cinematic_set (cinematic_tag_reference_get_cinematic 1)))

(script static void end_045lb_pitstop_debug
	(cinematic_destroy)	(cinematic_stop)	(camera_control off)	(render_exposure_fade_out 0)	(cinematic_zone_deactivate 1)	(fade_in 0 0 0 0))

(script static void 045lb_pitstop_debug
	(begin_045lb_pitstop_debug)
	(sleep (cinematic_tag_fade_in_to_cinematic "045lb_pitstop"))
	(!045lb_pitstop_010_sc)
	(!045lb_pitstop_020_sc)
	(!045lb_pitstop_030_sc)
	(!045lb_pitstop_040_sc)
	(!045lb_pitstop_050_sc)
	(end_045lb_pitstop_debug)
)

(script static void begin_045lb_pitstop
	(cinematic_zone_activate 1)	(sleep 2)	(camera_set_cinematic)	(cinematic_set_debug_mode 0)	(cinematic_set (cinematic_tag_reference_get_cinematic 1)))

(script static void end_045lb_pitstop
	(cinematic_destroy)	(render_exposure_fade_out 0))

(script static void 045lb_pitstop
	(begin_045lb_pitstop)
	(sleep (cinematic_tag_fade_in_to_cinematic "045lb_pitstop"))
	(!045lb_pitstop_010_sc)
	(!045lb_pitstop_020_sc)
	(!045lb_pitstop_030_sc)
	(!045lb_pitstop_040_sc)
	(!045lb_pitstop_050_sc)
	(end_045lb_pitstop)
)

;end of cinematic "045lb_pitstop"

;start of cinematic '045la_katsplan'

(script static void 045la_katsplan_010_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 0 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 0)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "carter_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "carter_head_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "emile_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "jorge_1" true)
	(object_hide (cinematic_scripting_get_object 0 4) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "jun_1" true)
	(object_hide (cinematic_scripting_get_object 0 6) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "kat_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "kat_head_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "carter_ar_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "case_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "emile_ar_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 13 "handle_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "jun_dmr_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 15 "kat_magnum_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 16 "player_dmr_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 17 "scarab_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 18 "fx_dyn_light_jorgejun_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 19 "fx_dyn_light_jorge_side_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 20 "fx_dyn_light__jorge_bg_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 21 "fx_dyn_light_player_int_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 22 "fx_dyn_light_emile_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 23 "fx_dyn_light_carter_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 24 "fx_dyn_light_kat_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 25 "fx_dyn_light_enter_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(render_exposure 1.00 0)
	(sleep 278)
	(cinematic_scripting_start_dialogue 0 0 0 "none")
	(sleep 175)
	(cinematic_scripting_start_dialogue 0 0 1 "none")
	(sleep 281)
	(cinematic_scripting_start_dialogue 0 0 2 (cinematic_scripting_get_object 0 3))
	(sleep 65)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_010_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 1 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 1)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(object_hide (cinematic_scripting_get_object 0 0) true)
	(object_hide (cinematic_scripting_get_object 0 1) true)
	(object_hide (cinematic_scripting_get_object 0 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "jorge_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "jorge_head_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "jun_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "jun_head_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "kat_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "kat_head_2" true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(object_hide (cinematic_scripting_get_object 0 10) true)
	(object_hide (cinematic_scripting_get_object 0 11) true)
	(object_hide (cinematic_scripting_get_object 0 12) true)
	(object_hide (cinematic_scripting_get_object 0 13) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "jun_dmr_2" true)
	(object_hide (cinematic_scripting_get_object 0 15) true)
	(object_hide (cinematic_scripting_get_object 0 16) true)
	(object_hide (cinematic_scripting_get_object 0 17) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 18 "fx_dyn_light_jorgejun_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 19 "fx_dyn_light_jorge_side_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 20 "fx_dyn_light__jorge_bg_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 21 "fx_dyn_light_player_int_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 22 "fx_dyn_light_emile_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 23 "fx_dyn_light_carter_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 24 "fx_dyn_light_kat_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 25 "fx_dyn_light_enter_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(render_exposure 1.50 0)
	(sleep 9)
	(cinematic_scripting_start_dialogue 0 1 0 (cinematic_scripting_get_object 0 5))
	(sleep 38)
	(cinematic_scripting_start_dialogue 0 1 4 (cinematic_scripting_get_object 0 5))
	(sleep 39)
	(cinematic_scripting_start_dialogue 0 1 5 (cinematic_scripting_get_object 0 5))
	(sleep 79)
	(cinematic_scripting_start_dialogue 0 1 1 (cinematic_scripting_get_object 0 5))
	(sleep 114)
	(cinematic_scripting_start_dialogue 0 1 2 (cinematic_scripting_get_object 0 3))
	(sleep 20)
	(cinematic_scripting_start_dialogue 0 1 3 (cinematic_scripting_get_object 0 5))
	(sleep 5)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_010_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 2 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 2)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(object_hide (cinematic_scripting_get_object 0 0) true)
	(object_hide (cinematic_scripting_get_object 0 1) true)
	(object_hide (cinematic_scripting_get_object 0 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "jorge_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "jorge_head_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "jun_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "jun_head_3" true)
	(object_hide (cinematic_scripting_get_object 0 7) true)
	(object_hide (cinematic_scripting_get_object 0 8) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "player_3" true)
	(object_hide (cinematic_scripting_get_object 0 10) true)
	(object_hide (cinematic_scripting_get_object 0 11) true)
	(object_hide (cinematic_scripting_get_object 0 12) true)
	(object_hide (cinematic_scripting_get_object 0 13) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "jun_dmr_3" true)
	(object_hide (cinematic_scripting_get_object 0 15) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 16 "player_dmr_3" true)
	(object_hide (cinematic_scripting_get_object 0 17) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 18 "fx_dyn_light_jorgejun_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 19 "fx_dyn_light_jorge_side_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 20 "fx_dyn_light__jorge_bg_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 21 "fx_dyn_light_player_int_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 22 "fx_dyn_light_emile_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 23 "fx_dyn_light_carter_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 24 "fx_dyn_light_kat_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 25 "fx_dyn_light_enter_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(render_exposure 1.50 0)
	(sleep 46)
	(cinematic_scripting_start_dialogue 0 2 0 (cinematic_scripting_get_object 0 3))
	(sleep 23)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_010_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 3 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 3)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(object_hide (cinematic_scripting_get_object 0 0) true)
	(object_hide (cinematic_scripting_get_object 0 1) true)
	(object_hide (cinematic_scripting_get_object 0 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "jorge_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "jorge_head_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "jun_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "jun_head_4" true)
	(object_hide (cinematic_scripting_get_object 0 7) true)
	(object_hide (cinematic_scripting_get_object 0 8) true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(object_hide (cinematic_scripting_get_object 0 10) true)
	(object_hide (cinematic_scripting_get_object 0 11) true)
	(object_hide (cinematic_scripting_get_object 0 12) true)
	(object_hide (cinematic_scripting_get_object 0 13) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "jun_dmr_4" true)
	(object_hide (cinematic_scripting_get_object 0 15) true)
	(object_hide (cinematic_scripting_get_object 0 16) true)
	(object_hide (cinematic_scripting_get_object 0 17) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 18 "fx_dyn_light_jorgejun_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 19 "fx_dyn_light_jorge_side_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 20 "fx_dyn_light__jorge_bg_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 21 "fx_dyn_light_player_int_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 22 "fx_dyn_light_emile_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 23 "fx_dyn_light_carter_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 24 "fx_dyn_light_kat_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 25 "fx_dyn_light_enter_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(render_exposure 1.50 0)
	(sleep 24)
	(cinematic_scripting_start_dialogue 0 3 0 (cinematic_scripting_get_object 0 3))
	(sleep 24)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_010_sc_sh5
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 4 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 4)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "carter_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "carter_head_5" true)
	(object_hide (cinematic_scripting_get_object 0 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "jorge_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "jorge_head_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "jun_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "jun_head_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "kat_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "kat_head_5" true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "carter_ar_5" true)
	(object_hide (cinematic_scripting_get_object 0 11) true)
	(object_hide (cinematic_scripting_get_object 0 12) true)
	(object_hide (cinematic_scripting_get_object 0 13) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 14 "jun_dmr_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 15 "kat_magnum_5" true)
	(object_hide (cinematic_scripting_get_object 0 16) true)
	(object_hide (cinematic_scripting_get_object 0 17) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 18 "fx_dyn_light_jorgejun_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 19 "fx_dyn_light_jorge_side_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 20 "fx_dyn_light__jorge_bg_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 21 "fx_dyn_light_player_int_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 22 "fx_dyn_light_emile_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 23 "fx_dyn_light_carter_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 24 "fx_dyn_light_kat_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 25 "fx_dyn_light_enter_5" true)
	(cinematic_lights_initialize_for_shot 4)
	(cinematic_clips_initialize_for_shot 4)
	(render_exposure 1.50 0)
	(sleep 43)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_katsplan_010_sc
	(cinematic_print "beginning scene 1")
	(cinematic_scripting_create_scene 0)
	(045la_katsplan_010_sc_sh1)
	(045la_katsplan_010_sc_sh2)
	(045la_katsplan_010_sc_sh3)
	(045la_katsplan_010_sc_sh4)
	(045la_katsplan_010_sc_sh5)
	(cinematic_scripting_destroy_scene 0)
)

(script static void 045la_katsplan_020_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 0 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 0)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "carter_ar_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "kat_magnum_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(render_exposure 1.00 0)
	(sleep 13)
	(cinematic_scripting_start_dialogue 1 0 0 (cinematic_scripting_get_object 1 3))
	(sleep 105)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 1 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 1)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "carter_ar_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_2" true)
	(object_hide (cinematic_scripting_get_object 1 4) true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(render_exposure 1.00 0)
	(sleep 11)
	(cinematic_scripting_start_dialogue 1 1 0 (cinematic_scripting_get_object 1 0))
	(sleep 115)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 2 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 2)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_3" true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "kat_magnum_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(render_exposure 1.00 0)
	(sleep 63)
	(cinematic_scripting_start_dialogue 1 2 0 (cinematic_scripting_get_object 1 3))
	(sleep 9)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 3 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 3)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "carter_ar_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_4" true)
	(object_hide (cinematic_scripting_get_object 1 4) true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(render_exposure 1.00 0)
	(sleep 18)
	(cinematic_scripting_start_dialogue 1 3 0 (cinematic_scripting_get_object 1 0))
	(sleep 17)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh5
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 4 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 4)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_5" true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_5" true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_5" true)
	(cinematic_lights_initialize_for_shot 4)
	(cinematic_clips_initialize_for_shot 4)
	(render_exposure 1.00 0)
	(sleep 23)
	(cinematic_scripting_start_dialogue 1 4 0 (cinematic_scripting_get_object 1 3))
	(sleep 24)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh6
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 5 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 5)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "carter_ar_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_6" true)
	(object_hide (cinematic_scripting_get_object 1 4) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "kat_magnum_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_6" true)
	(cinematic_lights_initialize_for_shot 5)
	(cinematic_clips_initialize_for_shot 5)
	(render_exposure 1.00 0)
	(sleep 2)
	(cinematic_scripting_start_dialogue 1 5 0 (cinematic_scripting_get_object 1 0))
	(sleep 29)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh7
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 6 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 6)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_7" true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_7" true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_7" true)
	(cinematic_lights_initialize_for_shot 6)
	(cinematic_clips_initialize_for_shot 6)
	(render_exposure 1.00 0)
	(sleep 2)
	(cinematic_scripting_start_dialogue 1 6 0 (cinematic_scripting_get_object 1 3))
	(sleep 44)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh8
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 7 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 7)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_8" true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_8" true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_8" true)
	(cinematic_lights_initialize_for_shot 7)
	(cinematic_clips_initialize_for_shot 7)
	(render_exposure 1.00 0)
	(sleep 12)
	(cinematic_scripting_start_dialogue 1 7 0 (cinematic_scripting_get_object 1 0))
	(sleep 63)
	(cinematic_scripting_start_dialogue 1 7 1 (cinematic_scripting_get_object 1 3))
	(sleep 46)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh9
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 8 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 8)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(object_hide (cinematic_scripting_get_object 1 0) true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(object_hide (cinematic_scripting_get_object 1 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_9" true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_9" true)
	(cinematic_lights_initialize_for_shot 8)
	(cinematic_clips_initialize_for_shot 8)
	(render_exposure 1.00 0)
	(sleep 101)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh10
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 9 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 9)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_10" true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_10" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_10" true)
	(object_hide (cinematic_scripting_get_object 1 4) true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_10" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_10" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_10" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_10" true)
	(cinematic_lights_initialize_for_shot 9)
	(cinematic_clips_initialize_for_shot 9)
	(render_exposure 1.00 0)
	(sleep 2)
	(cinematic_scripting_start_dialogue 1 9 0 (cinematic_scripting_get_object 1 0))
	(sleep 78)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh11
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 10 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 10)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_11" true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_11" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_11" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_11" true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_11" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_11" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_11" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_11" true)
	(cinematic_lights_initialize_for_shot 10)
	(cinematic_clips_initialize_for_shot 10)
	(render_exposure 1.00 0)
	(sleep 1)
	(cinematic_scripting_start_dialogue 1 10 0 (cinematic_scripting_get_object 1 3))
	(sleep 242)
	(cinematic_scripting_start_dialogue 1 10 1 (cinematic_scripting_get_object 1 0))
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh12
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 11 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 11)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_12" true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_12" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_12" true)
	(object_hide (cinematic_scripting_get_object 1 4) true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_12" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_12" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_12" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_12" true)
	(cinematic_lights_initialize_for_shot 11)
	(cinematic_clips_initialize_for_shot 11)
	(render_exposure 1.00 0)
	(sleep 92)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh13
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 12 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 12)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_13" true)
	(object_hide (cinematic_scripting_get_object 1 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_13" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_13" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_13" true)
	(object_hide (cinematic_scripting_get_object 1 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_13" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_13" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_13" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_13" true)
	(cinematic_lights_initialize_for_shot 12)
	(cinematic_clips_initialize_for_shot 12)
	(render_exposure 1.00 0)
	(sleep 15)
	(cinematic_scripting_start_dialogue 1 12 0 (cinematic_scripting_get_object 1 3))
	(sleep 178)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh14
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 13 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 13)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "carter_ar_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "kat_magnum_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_14" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_14" true)
	(cinematic_lights_initialize_for_shot 13)
	(cinematic_clips_initialize_for_shot 13)
	(render_exposure 1.00 0)
	(sleep 1)
	(cinematic_scripting_start_dialogue 1 13 0 (cinematic_scripting_get_object 1 0))
	(sleep 60)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_020_sc_sh15
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 1) 14 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 1) 14)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 1 0 "carter_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 1 "carter_ar_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 2 "carter_head_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 3 "kat_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 4 "kat_head_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 5 "kat_magnum_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 6 "fx_dyn_light_kat_carter_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 7 "fx_dyn_light_carter_cu_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 8 "fx_dyn_light_carter_bg_15" true)
	(cinematic_scripting_create_and_animate_cinematic_object 1 9 "fx_dyn_light_kat_cu_15" true)
	(cinematic_lights_initialize_for_shot 14)
	(cinematic_clips_initialize_for_shot 14)
	(render_exposure 1.00 0)
	(sleep 2)
	(cinematic_scripting_start_dialogue 1 14 0 (cinematic_scripting_get_object 1 3))
	(sleep 18)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_katsplan_020_sc
	(cinematic_print "beginning scene 2")
	(cinematic_scripting_create_scene 1)
	(045la_katsplan_020_sc_sh1)
	(045la_katsplan_020_sc_sh2)
	(045la_katsplan_020_sc_sh3)
	(045la_katsplan_020_sc_sh4)
	(045la_katsplan_020_sc_sh5)
	(045la_katsplan_020_sc_sh6)
	(045la_katsplan_020_sc_sh7)
	(045la_katsplan_020_sc_sh8)
	(045la_katsplan_020_sc_sh9)
	(045la_katsplan_020_sc_sh10)
	(045la_katsplan_020_sc_sh11)
	(045la_katsplan_020_sc_sh12)
	(045la_katsplan_020_sc_sh13)
	(045la_katsplan_020_sc_sh14)
	(045la_katsplan_020_sc_sh15)
	(cinematic_scripting_destroy_scene 1)
)

(script static void 045la_katsplan_030_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 0 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 0)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 1 "carter_ar_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "carter_head_1" true)
	(object_hide (cinematic_scripting_get_object 2 3) true)
	(object_hide (cinematic_scripting_get_object 2 4) true)
	(object_hide (cinematic_scripting_get_object 2 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 7 "jorge_head_1" true)
	(object_hide (cinematic_scripting_get_object 2 8) true)
	(object_hide (cinematic_scripting_get_object 2 9) true)
	(object_hide (cinematic_scripting_get_object 2 10) true)
	(object_hide (cinematic_scripting_get_object 2 11) true)
	(object_hide (cinematic_scripting_get_object 2 12) true)
	(object_hide (cinematic_scripting_get_object 2 13) true)
	(object_hide (cinematic_scripting_get_object 2 14) true)
	(object_hide (cinematic_scripting_get_object 2 15) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(render_exposure 1.00 0)
	(sleep 14)
	(cinematic_scripting_start_dialogue 2 0 0 (cinematic_scripting_get_object 2 0))
	(sleep 68)
	(cinematic_scripting_start_dialogue 2 0 1 (cinematic_scripting_get_object 2 6))
	(sleep 7)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_030_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 1 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 1)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 1 "carter_ar_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "carter_head_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "emile_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "emile_ar_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "emile_knife_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "jorge_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 7 "jorge_head_2" true)
	(object_hide (cinematic_scripting_get_object 2 8) true)
	(object_hide (cinematic_scripting_get_object 2 9) true)
	(object_hide (cinematic_scripting_get_object 2 10) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 11 "kat_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 12 "kat_head_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 13 "kat_magnum_2" true)
	(object_hide (cinematic_scripting_get_object 2 14) true)
	(object_hide (cinematic_scripting_get_object 2 15) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(render_exposure 1.00 0)
	(sleep 64)
	(cinematic_scripting_start_dialogue 2 1 0 (cinematic_scripting_get_object 2 0))
	(sleep 52)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_030_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 2 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 2)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_3" true)
	(object_hide (cinematic_scripting_get_object 2 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "carter_head_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "emile_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "emile_ar_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "emile_knife_3" true)
	(object_hide (cinematic_scripting_get_object 2 6) true)
	(object_hide (cinematic_scripting_get_object 2 7) true)
	(object_hide (cinematic_scripting_get_object 2 8) true)
	(object_hide (cinematic_scripting_get_object 2 9) true)
	(object_hide (cinematic_scripting_get_object 2 10) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 11 "kat_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 12 "kat_head_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 13 "kat_magnum_3" true)
	(object_hide (cinematic_scripting_get_object 2 14) true)
	(object_hide (cinematic_scripting_get_object 2 15) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(render_exposure 1.00 0)
	(sleep 24)
	(cinematic_scripting_start_dialogue 2 2 0 (cinematic_scripting_get_object 2 11))
	(sleep 51)
	(cinematic_scripting_start_dialogue 2 2 1 (cinematic_scripting_get_object 2 3))
	(sleep 50)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_030_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 3 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 3)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 1 "carter_ar_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "carter_head_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "emile_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "emile_ar_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "emile_knife_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "jorge_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 7 "jorge_head_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 8 "jun_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 9 "jun_dmr_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 10 "jun_head_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 11 "kat_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 12 "kat_head_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 13 "kat_magnum_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 14 "player_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 15 "player_dmr_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(render_exposure 1.00 0)
	(sleep 24)
	(cinematic_scripting_start_dialogue 2 3 0 (cinematic_scripting_get_object 2 11))
	(sleep 121)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_030_sc_sh5
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 4 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 4)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 1 "carter_ar_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "carter_head_5" true)
	(object_hide (cinematic_scripting_get_object 2 3) true)
	(object_hide (cinematic_scripting_get_object 2 4) true)
	(object_hide (cinematic_scripting_get_object 2 5) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "jorge_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 7 "jorge_head_5" true)
	(object_hide (cinematic_scripting_get_object 2 8) true)
	(object_hide (cinematic_scripting_get_object 2 9) true)
	(object_hide (cinematic_scripting_get_object 2 10) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 11 "kat_5" true)
	(object_hide (cinematic_scripting_get_object 2 12) true)
	(object_hide (cinematic_scripting_get_object 2 13) true)
	(object_hide (cinematic_scripting_get_object 2 14) true)
	(object_hide (cinematic_scripting_get_object 2 15) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_5" true)
	(cinematic_lights_initialize_for_shot 4)
	(cinematic_clips_initialize_for_shot 4)
	(render_exposure 1.00 0)
	(sleep 12)
	(cinematic_scripting_start_dialogue 2 4 0 (cinematic_scripting_get_object 2 6))
	(sleep 36)
	(cinematic_scripting_start_dialogue 2 4 1 (cinematic_scripting_get_object 2 0))
	(sleep 36)
	(cinematic_scripting_start_dialogue 2 4 2 (cinematic_scripting_get_object 2 6))
	(sleep 12)
	(cinematic_scripting_start_dialogue 2 4 3 (cinematic_scripting_get_object 2 11))
	(sleep 1)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_030_sc_sh6
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 5 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 5)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_6" true)
	(object_hide (cinematic_scripting_get_object 2 1) true)
	(object_hide (cinematic_scripting_get_object 2 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "emile_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "emile_ar_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "emile_knife_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "jorge_6" true)
	(object_hide (cinematic_scripting_get_object 2 7) true)
	(object_hide (cinematic_scripting_get_object 2 8) true)
	(object_hide (cinematic_scripting_get_object 2 9) true)
	(object_hide (cinematic_scripting_get_object 2 10) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 11 "kat_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 12 "kat_head_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 13 "kat_magnum_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 14 "player_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 15 "player_dmr_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_6" true)
	(cinematic_lights_initialize_for_shot 5)
	(cinematic_clips_initialize_for_shot 5)
	(render_exposure 1.00 0)
	(sleep 123)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_030_sc_sh7
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 6 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 6)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_7" true)
	(object_hide (cinematic_scripting_get_object 2 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 2 "carter_head_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "emile_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "emile_ar_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "emile_knife_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "jorge_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 7 "jorge_head_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 8 "jun_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 9 "jun_dmr_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 10 "jun_head_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 11 "kat_7" true)
	(object_hide (cinematic_scripting_get_object 2 12) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 13 "kat_magnum_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 14 "player_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 15 "player_dmr_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_7" true)
	(cinematic_lights_initialize_for_shot 6)
	(cinematic_clips_initialize_for_shot 6)
	(render_exposure 1.50 0)
	(sleep 12)
	(cinematic_scripting_start_dialogue 2 6 0 (cinematic_scripting_get_object 2 11))
	(sleep 105)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_030_sc_sh8
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 7 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 7)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_8" true)
	(object_hide (cinematic_scripting_get_object 2 1) true)
	(object_hide (cinematic_scripting_get_object 2 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "emile_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "emile_ar_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "emile_knife_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 6 "jorge_8" true)
	(object_hide (cinematic_scripting_get_object 2 7) true)
	(object_hide (cinematic_scripting_get_object 2 8) true)
	(object_hide (cinematic_scripting_get_object 2 9) true)
	(object_hide (cinematic_scripting_get_object 2 10) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 11 "kat_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 12 "kat_head_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 13 "kat_magnum_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 14 "player_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 15 "player_dmr_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_8" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_8" true)
	(cinematic_lights_initialize_for_shot 7)
	(cinematic_clips_initialize_for_shot 7)
	(render_exposure 1.00 0)
	(sleep 78)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_030_sc_sh9
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 2) 8 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 2) 8)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 2 0 "carter_9" true)
	(object_hide (cinematic_scripting_get_object 2 1) true)
	(object_hide (cinematic_scripting_get_object 2 2) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 3 "emile_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 4 "emile_ar_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 5 "emile_knife_9" true)
	(object_hide (cinematic_scripting_get_object 2 6) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 7 "jorge_head_9" true)
	(object_hide (cinematic_scripting_get_object 2 8) true)
	(object_hide (cinematic_scripting_get_object 2 9) true)
	(object_hide (cinematic_scripting_get_object 2 10) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 11 "kat_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 12 "kat_head_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 13 "kat_magnum_9" true)
	(object_hide (cinematic_scripting_get_object 2 14) true)
	(object_hide (cinematic_scripting_get_object 2 15) true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 16 "fx_dyn_light_carter_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 17 "fx_dyn_light_kat_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 18 "fx_dyn_light_lowkat_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 19 "fx_dyn_light_wall_9" true)
	(cinematic_scripting_create_and_animate_cinematic_object 2 20 "fx_dyn_light_group_9" true)
	(cinematic_lights_initialize_for_shot 8)
	(cinematic_clips_initialize_for_shot 8)
	(render_exposure 1.00 0)
	(sleep 69)
	(cinematic_scripting_start_dialogue 2 8 0 (cinematic_scripting_get_object 2 11))
	(sleep 69)
	(cinematic_scripting_start_dialogue 2 8 1 (cinematic_scripting_get_object 2 0))
	(sleep 33)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_katsplan_030_sc
	(cinematic_print "beginning scene 3")
	(cinematic_scripting_create_scene 2)
	(045la_katsplan_030_sc_sh1)
	(045la_katsplan_030_sc_sh2)
	(045la_katsplan_030_sc_sh3)
	(045la_katsplan_030_sc_sh4)
	(045la_katsplan_030_sc_sh5)
	(045la_katsplan_030_sc_sh6)
	(045la_katsplan_030_sc_sh7)
	(045la_katsplan_030_sc_sh8)
	(045la_katsplan_030_sc_sh9)
	(cinematic_scripting_destroy_scene 2)
)

(script static void 045la_katsplan_040_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 0 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 0)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "carter_1" true)
	(object_hide (cinematic_scripting_get_object 3 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "carter_head_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "emile_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "emile_ar_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "jorge_1" true)
	(object_hide (cinematic_scripting_get_object 3 6) true)
	(object_hide (cinematic_scripting_get_object 3 7) true)
	(object_hide (cinematic_scripting_get_object 3 8) true)
	(object_hide (cinematic_scripting_get_object 3 9) true)
	(object_hide (cinematic_scripting_get_object 3 10) true)
	(object_hide (cinematic_scripting_get_object 3 11) true)
	(object_hide (cinematic_scripting_get_object 3 12) true)
	(object_hide (cinematic_scripting_get_object 3 13) true)
	(object_hide (cinematic_scripting_get_object 3 14) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 15 "fx_dyn_light_skylight_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 16 "fx_dyn_light_kat_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 17 "fx_dyn_light_jun_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 18 "fx_dyn_light_car_sit_1" true)
	(object_hide (cinematic_scripting_get_object 3 19) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 20 "fx_dyn_light_jorge_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 21 "fx_dyn_light_player_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 22 "fx_dyn_light_emile_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 23 "fx_dyn_light_wall_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 24 "fx_dyn_light_jor_emi_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(render_exposure 1.50 0)
	(sleep 96)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_040_sc_sh2
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 1 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 1)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "carter_2" true)
	(object_hide (cinematic_scripting_get_object 3 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "carter_head_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "emile_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "emile_ar_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "jorge_2" true)
	(object_hide (cinematic_scripting_get_object 3 6) true)
	(object_hide (cinematic_scripting_get_object 3 7) true)
	(object_hide (cinematic_scripting_get_object 3 8) true)
	(object_hide (cinematic_scripting_get_object 3 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "kat_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 11 "kat_head_2" true)
	(object_hide (cinematic_scripting_get_object 3 12) true)
	(object_hide (cinematic_scripting_get_object 3 13) true)
	(object_hide (cinematic_scripting_get_object 3 14) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 15 "fx_dyn_light_skylight_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 16 "fx_dyn_light_kat_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 17 "fx_dyn_light_jun_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 18 "fx_dyn_light_car_sit_2" true)
	(object_hide (cinematic_scripting_get_object 3 19) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 20 "fx_dyn_light_jorge_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 21 "fx_dyn_light_player_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 22 "fx_dyn_light_emile_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 23 "fx_dyn_light_wall_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 24 "fx_dyn_light_jor_emi_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(render_exposure 1.00 0)
	(sleep 77)
	(cinematic_scripting_start_dialogue 3 1 0 (cinematic_scripting_get_object 3 10))
	(sleep 159)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_040_sc_sh3
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 2 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 2)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "carter_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "carter_ar_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "carter_head_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "emile_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "emile_ar_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "jorge_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 6 "jorge_head_3" true)
	(object_hide (cinematic_scripting_get_object 3 7) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "jun_dmr_3" true)
	(object_hide (cinematic_scripting_get_object 3 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "kat_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 11 "kat_head_3" true)
	(object_hide (cinematic_scripting_get_object 3 12) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 13 "player_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 14 "player_dmr_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 15 "fx_dyn_light_skylight_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 16 "fx_dyn_light_kat_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 17 "fx_dyn_light_jun_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 18 "fx_dyn_light_car_sit_3" true)
	(object_hide (cinematic_scripting_get_object 3 19) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 20 "fx_dyn_light_jorge_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 21 "fx_dyn_light_player_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 22 "fx_dyn_light_emile_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 23 "fx_dyn_light_wall_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 24 "fx_dyn_light_jor_emi_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(render_exposure 1.00 0)
	(sleep 247)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_040_sc_sh4
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 3 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 3)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(object_hide (cinematic_scripting_get_object 3 0) true)
	(object_hide (cinematic_scripting_get_object 3 1) true)
	(object_hide (cinematic_scripting_get_object 3 2) true)
	(object_hide (cinematic_scripting_get_object 3 3) true)
	(object_hide (cinematic_scripting_get_object 3 4) true)
	(object_hide (cinematic_scripting_get_object 3 5) true)
	(object_hide (cinematic_scripting_get_object 3 6) true)
	(object_hide (cinematic_scripting_get_object 3 7) true)
	(object_hide (cinematic_scripting_get_object 3 8) true)
	(object_hide (cinematic_scripting_get_object 3 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "kat_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 11 "kat_head_4" true)
	(object_hide (cinematic_scripting_get_object 3 12) true)
	(object_hide (cinematic_scripting_get_object 3 13) true)
	(object_hide (cinematic_scripting_get_object 3 14) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 15 "fx_dyn_light_skylight_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 16 "fx_dyn_light_kat_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 17 "fx_dyn_light_jun_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 18 "fx_dyn_light_car_sit_4" true)
	(object_hide (cinematic_scripting_get_object 3 19) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 20 "fx_dyn_light_jorge_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 21 "fx_dyn_light_player_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 22 "fx_dyn_light_emile_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 23 "fx_dyn_light_wall_4" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 24 "fx_dyn_light_jor_emi_4" true)
	(cinematic_lights_initialize_for_shot 3)
	(cinematic_clips_initialize_for_shot 3)
	(render_exposure 1.00 0)
	(sleep 129)
	(cinematic_scripting_start_dialogue 3 3 0 (cinematic_scripting_get_object 3 10))
	(sleep 15)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_040_sc_sh5
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 4 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 4)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "carter_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "carter_ar_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "carter_head_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "emile_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "emile_ar_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "jorge_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 6 "jorge_head_5" true)
	(object_hide (cinematic_scripting_get_object 3 7) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "jun_dmr_5" true)
	(object_hide (cinematic_scripting_get_object 3 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "kat_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 11 "kat_head_5" true)
	(object_hide (cinematic_scripting_get_object 3 12) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 13 "player_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 14 "player_dmr_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 15 "fx_dyn_light_skylight_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 16 "fx_dyn_light_kat_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 17 "fx_dyn_light_jun_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 18 "fx_dyn_light_car_sit_5" true)
	(object_hide (cinematic_scripting_get_object 3 19) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 20 "fx_dyn_light_jorge_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 21 "fx_dyn_light_player_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 22 "fx_dyn_light_emile_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 23 "fx_dyn_light_wall_5" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 24 "fx_dyn_light_jor_emi_5" true)
	(cinematic_lights_initialize_for_shot 4)
	(cinematic_clips_initialize_for_shot 4)
	(render_exposure 1.00 0)
	(sleep 127)
	(cinematic_scripting_start_dialogue 3 4 0 (cinematic_scripting_get_object 3 3))
	(sleep 59)
	(cinematic_scripting_start_dialogue 3 4 1 (cinematic_scripting_get_object 3 10))
	(sleep 36)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_040_sc_sh6
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 5 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 5)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "carter_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "carter_ar_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "carter_head_6" true)
	(object_hide (cinematic_scripting_get_object 3 3) true)
	(object_hide (cinematic_scripting_get_object 3 4) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "jorge_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 6 "jorge_head_6" true)
	(object_hide (cinematic_scripting_get_object 3 7) true)
	(object_hide (cinematic_scripting_get_object 3 8) true)
	(object_hide (cinematic_scripting_get_object 3 9) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "kat_6" true)
	(object_hide (cinematic_scripting_get_object 3 11) true)
	(object_hide (cinematic_scripting_get_object 3 12) true)
	(object_hide (cinematic_scripting_get_object 3 13) true)
	(object_hide (cinematic_scripting_get_object 3 14) true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 15 "fx_dyn_light_skylight_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 16 "fx_dyn_light_kat_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 17 "fx_dyn_light_jun_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 18 "fx_dyn_light_car_sit_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 19 "tac_pad_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 20 "fx_dyn_light_jorge_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 21 "fx_dyn_light_player_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 22 "fx_dyn_light_emile_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 23 "fx_dyn_light_wall_6" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 24 "fx_dyn_light_jor_emi_6" true)
	(cinematic_lights_initialize_for_shot 5)
	(cinematic_clips_initialize_for_shot 5)
	(render_exposure 1.00 0)
	(sleep 17)
	(cinematic_scripting_start_dialogue 3 5 0 (cinematic_scripting_get_object 3 0))
	(sleep 28)
	(cinematic_scripting_start_dialogue 3 5 1 (cinematic_scripting_get_object 3 10))
	(sleep 213)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_040_sc_sh7
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 3) 6 "045la_katsplan_010_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 3) 6)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_010_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 3 0 "carter_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 1 "carter_ar_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 2 "carter_head_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 3 "emile_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 4 "emile_ar_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 5 "jorge_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 6 "jorge_head_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 7 "jun_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 8 "jun_dmr_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 9 "jun_head_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 10 "kat_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 11 "kat_head_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 12 "kat_magnum_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 13 "player_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 14 "player_dmr_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 15 "fx_dyn_light_skylight_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 16 "fx_dyn_light_kat_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 17 "fx_dyn_light_jun_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 18 "fx_dyn_light_car_sit_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 19 "tac_pad_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 20 "fx_dyn_light_jorge_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 21 "fx_dyn_light_player_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 22 "fx_dyn_light_emile_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 23 "fx_dyn_light_wall_7" true)
	(cinematic_scripting_create_and_animate_cinematic_object 3 24 "fx_dyn_light_jor_emi_7" true)
	(cinematic_lights_initialize_for_shot 6)
	(cinematic_clips_initialize_for_shot 6)
	(render_exposure 1.50 0)
	(sleep 48)
	(cinematic_scripting_start_dialogue 3 6 0 (cinematic_scripting_get_object 3 0))
	(sleep 147)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_katsplan_040_sc
	(cinematic_print "beginning scene 4")
	(cinematic_scripting_create_scene 3)
	(045la_katsplan_040_sc_sh1)
	(045la_katsplan_040_sc_sh2)
	(045la_katsplan_040_sc_sh3)
	(045la_katsplan_040_sc_sh4)
	(045la_katsplan_040_sc_sh5)
	(045la_katsplan_040_sc_sh6)
	(045la_katsplan_040_sc_sh7)
	(cinematic_scripting_destroy_scene 3)
)

(script static void 045la_katsplan_cleanup
	(cinematic_scripting_clean_up 2)
)

(script static void begin_045la_katsplan_debug
	(cinematic_zone_activate_for_debugging 2)	(sleep 2)	(camera_control on)	(cinematic_start)	(set cinematic_letterbox_style 0)
	(cinematic_show_letterbox_immediate 1)
	(camera_set_cinematic)	(cinematic_set_debug_mode 1)	(cinematic_set (cinematic_tag_reference_get_cinematic 2)))

(script static void end_045la_katsplan_debug
	(cinematic_destroy)	(cinematic_stop)	(camera_control off)	(render_exposure_fade_out 0)	(cinematic_zone_deactivate 2)	(fade_in 0 0 0 0))

(script static void 045la_katsplan_debug
	(begin_045la_katsplan_debug)
	(sleep (cinematic_tag_fade_in_to_cinematic "045la_katsplan"))
	(!045la_katsplan_010_sc)
	(!045la_katsplan_020_sc)
	(!045la_katsplan_030_sc)
	(!045la_katsplan_040_sc)
	(end_045la_katsplan_debug)
)

(script static void begin_045la_katsplan
	(cinematic_zone_activate 2)	(sleep 2)	(camera_set_cinematic)	(cinematic_set_debug_mode 0)	(cinematic_set (cinematic_tag_reference_get_cinematic 2)))

(script static void end_045la_katsplan
	(cinematic_destroy)	(render_exposure_fade_out 0))

(script static void 045la_katsplan
	(begin_045la_katsplan)
	(sleep (cinematic_tag_fade_in_to_cinematic "045la_katsplan"))
	(!045la_katsplan_010_sc)
	(!045la_katsplan_020_sc)
	(!045la_katsplan_030_sc)
	(!045la_katsplan_040_sc)
	(end_045la_katsplan)
)

;end of cinematic "045la_katsplan"

;start of cinematic '045la_katsplan_v2'

(script static void 045la_katsplan_050_sc_sh1
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 0 "045la_katsplan_050_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 0)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_050_anchor")
	(object_hide (cinematic_scripting_get_object 0 0) true)
	(object_hide (cinematic_scripting_get_object 0 1) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "falcon_1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "falcon_1_falcon_chin_gun1_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "falcon_1_falcon_side_gun_left2_1" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "falcon_1_falcon_side_gun_right3_1" true)
	(object_hide (cinematic_scripting_get_object 0 6) true)
	(object_hide (cinematic_scripting_get_object 0 7) true)
	(object_hide (cinematic_scripting_get_object 0 8) true)
	(object_hide (cinematic_scripting_get_object 0 9) true)
	(object_hide (cinematic_scripting_get_object 0 10) true)
	(object_hide (cinematic_scripting_get_object 0 11) true)
	(object_hide (cinematic_scripting_get_object 0 12) true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 13 "fx_dyn_light_sun_1" true)
	(cinematic_lights_initialize_for_shot 0)
	(cinematic_clips_initialize_for_shot 0)
	(sleep 357)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_050_sc_sh2

	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 1 "045la_katsplan_050_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 1)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_050_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "carter_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "carter_ar_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "falcon_1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "falcon_1_falcon_chin_gun1_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "falcon_1_falcon_side_gun_left2_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "falcon_1_falcon_side_gun_right3_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "jorge_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "jorge_turret_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "kat_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "kat_ar_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "kat_magnum_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "player_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "player_ar_2" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 13 "fx_dyn_light_sun_2" true)
	(cinematic_lights_initialize_for_shot 1)
	(cinematic_clips_initialize_for_shot 1)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 2) driver_seat_power 1.000000 0.000000)
	(object_set_model_state_property  (cinematic_object_get "falcon_1")  0 1)
	(cinematic_print "custom script play")
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 2) thrust 0.050000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 2) engine_exhaust 0.200000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 2) blur 1.000000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 2) jet_wash 1.000000 0.000000)
	(sleep 130)
	(cinematic_scripting_start_effect 0 1 0 (cinematic_object_get "jorge"))
	(cinematic_scripting_start_effect 0 1 1 (cinematic_object_get "jorge"))
	(sleep 40)
	(cinematic_scripting_start_effect 0 1 2 (cinematic_object_get "kat"))
	(cinematic_scripting_start_effect 0 1 3 (cinematic_object_get "kat"))
	(sleep 35)
	(cinematic_scripting_start_effect 0 1 5 (cinematic_object_get "player"))
	(cinematic_scripting_start_effect 0 1 4 (cinematic_object_get "player"))
	(sleep 112)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void 045la_katsplan_050_sc_sh3
(object_set_model_state_property  (cinematic_object_get "falcon_1")  0 1)
	(camera_set_cinematic_scene (cinematic_tag_reference_get_scene 0) 2 "045la_katsplan_050_anchor")
	(cinematic_set_shot (cinematic_tag_reference_get_scene 0) 2)
	(cinematic_object_create_cinematic_anchor "045la_katsplan_050_anchor")
	(cinematic_scripting_create_and_animate_cinematic_object 0 0 "carter_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 1 "carter_ar_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 2 "falcon_1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 3 "falcon_1_falcon_chin_gun1_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 4 "falcon_1_falcon_side_gun_left2_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 5 "falcon_1_falcon_side_gun_right3_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 6 "jorge_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 7 "jorge_turret_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 8 "kat_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 9 "kat_ar_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 10 "kat_magnum_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 11 "player_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 12 "player_ar_3" true)
	(cinematic_scripting_create_and_animate_cinematic_object 0 13 "fx_dyn_light_sun_3" true)
	(cinematic_lights_initialize_for_shot 2)
	(cinematic_clips_initialize_for_shot 2)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 12) primary_ammunition_tens 0.300000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 12) primary_ammunition_ones 0.200000 0.000000)
	(cinematic_print "custom script play")
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 2) blur 1.000000 0.000000)
	(chud_cinematic_fade 1 0)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 1) primary_ammunition_tens 0.300000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 9) primary_ammunition_tens 0.300000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 1) primary_ammunition_ones 0.200000 0.000000)
	(object_set_cinematic_function_variable (cinematic_scripting_get_object 0 9) primary_ammunition_ones 0.200000 0.000000)
	(sleep 6)
	(cinematic_scripting_start_dialogue 0 2 0 (cinematic_scripting_get_object 0 6))
	(sleep 49)
	(cinematic_scripting_start_dialogue 0 2 1 (cinematic_scripting_get_object 0 0))
	(sleep 55)
	(cinematic_scripting_start_dialogue 0 2 3 (cinematic_scripting_get_object 0 8))
	(sleep 47)
	(cinematic_scripting_start_dialogue 0 2 2 (cinematic_scripting_get_object 0 0))
	(sleep 38)
	(sleep (cinematic_tag_fade_out_from_cinematic "045la_katsplan_v2"))
	(sleep 4)
	(cinematic_lights_destroy_shot)
	(cinematic_clips_destroy)
	(render_exposure_fade_out 0)
)

(script static void !045la_katsplan_050_sc
	(cinematic_print "beginning scene 1")
	(cinematic_scripting_create_scene 0)
	(045la_katsplan_050_sc_sh1)
	(045la_katsplan_050_sc_sh2)
	(045la_katsplan_050_sc_sh3)
	(cinematic_scripting_destroy_scene 0)
)

(script static void 045la_katsplan_v2_cleanup
	(cinematic_scripting_clean_up 3)
)

(script static void begin_045la_katsplan_v2_debug
	(cinematic_zone_activate_for_debugging 3)	(sleep 2)	(camera_control on)	(cinematic_start)	(set cinematic_letterbox_style 0)
	(cinematic_show_letterbox_immediate 1)
	(camera_set_cinematic)	(cinematic_set_debug_mode 1)	(cinematic_set (cinematic_tag_reference_get_cinematic 3)))

(script static void end_045la_katsplan_v2_debug
	(cinematic_destroy)	(cinematic_stop)	(camera_control off)	(render_exposure_fade_out 0)	(cinematic_zone_deactivate 3)	(fade_in 0 0 0 0))

(script static void 045la_katsplan_v2_debug
	(begin_045la_katsplan_v2_debug)
	(sleep (cinematic_tag_fade_in_to_cinematic "045la_katsplan_v2"))
(prepare_to_switch_to_zone_set set_beach_001_005)
	(!045la_katsplan_050_sc)
	(end_045la_katsplan_v2_debug)
)

(script static void begin_045la_katsplan_v2
	(cinematic_zone_activate 3)	(sleep 2)	(camera_set_cinematic)	(cinematic_set_debug_mode 0)	(cinematic_set (cinematic_tag_reference_get_cinematic 3)))

(script static void end_045la_katsplan_v2
	(cinematic_destroy)	(render_exposure_fade_out 0))

(script static void 045la_katsplan_v2
	(begin_045la_katsplan_v2)
	(sleep (cinematic_tag_fade_in_to_cinematic "045la_katsplan_v2"))
(prepare_to_switch_to_zone_set set_beach_001_005)
	(!045la_katsplan_050_sc)
	(end_045la_katsplan_v2)
)

;end of cinematic "045la_katsplan_v2"
