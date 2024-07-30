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
	(cinematic_enter "snap_to_white" false)
	(sleep 30)
	(cinematic_exit "fade_from_white" true)
)

(script static void (cinematic_enter (string fade_type) (boolean lower_weapon))
	; ai ignores players
	(ai_disregard (players) true)

	; players cannot take damage 
	(object_cannot_take_damage (players))

	; scale player input to zero 
	(cond
		((= fade_type "fade_to_black") 	(player_control_fade_out_all_input 1))
		((= fade_type "fade_to_white") 	(player_control_fade_out_all_input 1))
		((= fade_type "snap_to_black") 	(player_control_fade_out_all_input 0))
		((= fade_type "snap_to_white") 	(player_control_fade_out_all_input 0))
		((= fade_type "no_fade") 		(player_control_fade_out_all_input 0))
	)
	
	; lower the player's weapon
	(if (= lower_weapon true)
		(begin 
			(if (or (= fade_type "fade_to_black") (= fade_type "fade_to_white") (= fade_type "no_fade"))
				(begin
					(if b_debug_cinematic_scripts (print "lowering weapon slowly..."))
					(unit_lower_weapon (player0) 30)
					(unit_lower_weapon (player1) 30)
					(unit_lower_weapon (player2) 30)
					(unit_lower_weapon (player3) 30)
				)
			)
		)
	)			
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause true)

	; fade out the chud 
	(cond
		((= fade_type "fade_to_black") 	(chud_cinematic_fade 0 0.5))
		((= fade_type "fade_to_white") 	(chud_cinematic_fade 0 0.5))
		((= fade_type "snap_to_black") 	(chud_cinematic_fade 0 0))
		((= fade_type "snap_to_white") 	(chud_cinematic_fade 0 0))
		((= fade_type "no_fade") 		(chud_cinematic_fade 0 0.5))
	)
	
	; fade or snap screen out
	(cond
		((= fade_type "fade_to_black") 
			
			(begin 
				(fade_out 0 0 0 30)
				(sleep 30)
			)
		)
		((= fade_type "fade_to_white") 
			(begin
				(fade_out 1 1 1 30)
				(sleep 30)
			)
		)
		((= fade_type "snap_to_black") (fade_out 0 0 0 0))
		((= fade_type "snap_to_white") (fade_out 1 1 1 0))
	)

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

(script static void (cinematic_exit (string fade_type) (boolean weapon_starts_lowered))
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
	(cinematic_enter "fade_to_black" false)
	;*
	; fade screen to black 
	(fade_out 0 0 0 0)
	
	; get ready to play the cinematic 
	(cinematic_preparation)
	*;
)
(script static void cinematic_snap_to_white
	(cinematic_enter "fade_to_white" false)

	;*
	; fade screen to white 
	(fade_out 1 1 1 0)
	
	; get ready to play the cinematic 
	(cinematic_preparation)
	*;
)
	
(script static void cinematic_preparation
	; the ai will disregard all players 
	(ai_disregard (players) true)

	; players cannot take damage 
	(object_cannot_take_damage (players))

	; scale player input to zero 
	(player_control_fade_out_all_input 0)

	; hide players 
	(object_hide (player0) true)
	(object_hide (player1) true)
	(object_hide (player2) true)
	(object_hide (player3) true)
		
	; replenish player health 
	(replenish_players)

	; fade out the chud 
	(chud_cinematic_fade 0 0)
	(chud_show_messages false)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause true)

	; disable player input 
	(player_enable_input false)

	; player can now move 
	(player_disable_movement false)
		(sleep 1)

	; cinematic start after fading out because of camera pop 
	(if (not (campaign_survival_enabled)) 
		(cinematic_start)
	)
	(camera_control on)
)

; ======================================================================================
(script static void cinematic_snap_from_black
	(cinematic_exit "snap_from_black" false)
	;*
	(cinematic_snap_from_pre)

	; fade screen from white 
		(sleep 5)
	(fade_in 0 0 0 5)
	(cinematic_snap_from_post)
	*;
)

(script static void cinematic_snap_from_white
	(cinematic_exit "snap_from_white" false)
	;*
	(cinematic_snap_from_pre)

	; fade screen from white 
		(sleep 5)
	(fade_in 1 1 1 5)
	(cinematic_snap_from_post)
	*;
)

(script static void cinematic_snap_from_pre
	; cinematic stop and camera control off 
	(if (not (campaign_survival_enabled)) 
		(cinematic_stop)
	)
	(camera_control off)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate false)

	; snap in the chud 
	(cinematic_hud_off)
		(sleep 1)
	(chud_cinematic_fade 1 0)

	; unhide players 
	(object_hide (player0) false)
	(object_hide (player1) false)
	(object_hide (player2) false)
	(object_hide (player3) false)
)

(script static void cinematic_snap_from_post
	; enable player input 
	(player_enable_input true)

	; scale player input to one 
	(player_control_fade_in_all_input 1)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause false)

	; the ai will disregard all players 
	(ai_disregard (players) 	false)

	; players cannot take damage 
	(object_can_take_damage (players))

	; player can now move 
	(player_disable_movement false)
	
	; turn on hud messages 
	(chud_show_messages true)

	; game save 
	(if (not (campaign_survival_enabled)) (game_save))
)

; ======================================================================================
(script static void cinematic_fade_to_black
	(cinematic_enter "fade_to_black" true))

(script static void cinematic_fade_to_white
	(cinematic_enter "fade_to_white" true))

(script static void cinematic_fade_to_gameplay
	(cinematic_exit "fade_from_black" true)
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
						(script cinematic_intro)
						(string snap_color)
					)
								
	(cond
		((= snap_color "black")		(cinematic_enter "snap_to_black" false))
		((= snap_color "white")		(cinematic_enter "snap_to_white" false))
		((= snap_color "no_fade")	(cinematic_enter "no_fade" false))
	)	

	(sleep 1)
	
	(if (cinematic_skip_start)
		(begin
			(if b_debug_cinematic_scripts (print "cinematic_skip_start is true... starting cinematic..."))
			(sound_class_set_gain "" 0 0)
			(sound_class_set_gain "mus" 1 0)
			(evaluate cinematic_intro)
		)
		(cinematic_skip_stop)
	)
	
	(if b_debug_cinematic_scripts (print "done with cinematic. resetting audio levels..."))
	(sound_class_set_gain "" 1 0)
)

; used for mid-mission cinematics
(script static void (f_play_cinematic
						(script cinematic_outro)
						(zone_set cinematic_zone_set)
						(string fade_type)
					)
	
	(if b_debug_cinematic_scripts (print "f_play_cinematic: calling cinematic_enter"))
	(cond
		((= fade_type "fade_to_black")	(cinematic_enter "fade_to_black" true))
		((= fade_type "fade_to_white")	(cinematic_enter "fade_to_white" true))
		((= fade_type "snap_to_black")  (cinematic_enter "snap_to_black" true))
		((= fade_type "snap_to_white")  (cinematic_enter "snap_to_white" true))
	)
	(sleep 1)

	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sleep 1)
		
	(sound_suppress_ambience_update_on_revert)
	(sleep 1)

	;(if (cinematic_skip_start)
		(begin
			(if b_debug_globals (print "f_play_cinematic: playing cinematic..."))
			;(cinematic_show_letterbox true) - dmiller 8-14-2009
			(sleep 30)
			(sound_class_set_gain "" 0 0)
			(sound_class_set_gain "mus" 1 0)
			(evaluate cinematic_outro)
		)
	;)
	;(cinematic_skip_stop)

		
	(if b_debug_cinematic_scripts (print "f_play_cinematic: done with cinematic. resetting audio levels..."))
	(sound_class_set_gain "" 1 0)

	; cinematic snap so the fade back in is seamless
	(cond
		((= fade_type "fade_to_black")	(fade_out 0 0 0 0))
		((= fade_type "fade_to_white")	(fade_out 1 1 1 0))
		((= fade_type "snap_to_black")  (fade_out 0 0 0 0))
		((= fade_type "snap_to_white")  (fade_out 1 1 1 0))
	)
)

(script static void (f_end_mission
						(script cinematic_outro)
						(zone_set cinematic_zone_set)
						(string fade_type)
					)
		
	(cond
		((= fade_type "fade_to_black")	(cinematic_fade_to_black))
		((= fade_type "fade_to_white")	(cinematic_fade_to_white))
		((= fade_type "snap_to_black")  (cinematic_snap_to_black))
		((= fade_type "snap_to_white")  (cinematic_snap_to_white))
	)
	
	(sleep 1)
	
	; erase all ai 
	(ai_erase_all)
	
	; clean up garbage - dmiller 8-14-2009
	(garbage_collect_now)

	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sound_suppress_ambience_update_on_revert)
	(sleep 1)

	; the magic
	(if (cinematic_skip_start)
		(begin
			(if b_debug_globals (print "play outro cinematic..."))
			;(cinematic_show_letterbox true) - dmiller 8-14-2009
			(sleep 30)
			(evaluate cinematic_outro)
			(sound_class_set_gain "" 0 0)
			
		)
	)
	(cinematic_skip_stop_internal)
		
	; turn off all ambient sounds 
	(sound_class_set_gain "" 0 0)
	(sound_class_set_gain "ui" 1 0)

	; cinematic snap to black 
	(cinematic_snap_to_black)

)



(script static void (f_end_scene
							(script		cinematic_outro)		; script name defined in cinematic tag 
							(zone_set	cinematic_zone_set)		; switch to proper zone set 
							(string_id	scene_boolean)			; game progression boolean of the scene you are in 
							(string_id	scene_name)			; scene to transition to 
							(string		snap_color)
				)

	; fade to black 

	(cond
		((= snap_color "black")	(cinematic_snap_to_black))
		((= snap_color "white")	(cinematic_snap_to_white))
	)	
	(sleep 1)
	
	; award mission achievement
	;commented out - dmiller 11-06-2009	
	;(game_award_level_complete_achievements)
	
	; erase all ai 
	(ai_erase_all)
	
	; clean up garbage - dmiller 8-14-2009
	(garbage_collect_now)

	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sound_suppress_ambience_update_on_revert)
	(sleep 1)
	
		; play cinematic 
		;(if (= g_play_cinematics true)		; tipul re-enable when you change the function for omaha
			(begin
				(if (cinematic_skip_start)
					(begin
						(if b_debug_globals (print "play outro cinematic..."))
						(sleep 30)
						(evaluate cinematic_outro)
						(sound_class_set_gain "" 0 0)
						
					)
				)
				(cinematic_skip_stop_internal)
			)
		;)
	; turn off all ambient sounds 
	(sound_class_set_gain "" 0 0)
	(sound_class_set_gain "ui" 1 0)

	; cinematic snap to black 
	(cinematic_snap_to_black)

	; switch to give scene 
	(if b_debug_globals (print "switch to scene..."))
	;(game_level_advance scene_name)
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
								(short player_short)
				)			
	(sound_impulse_start sfx_tutorial_complete (player_get player_short) 1)
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
								(short 			player_short)
								(cutscene_title display_title))
								
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
)

(script static void (f_tutorial_end
								(short			player_short)
								(cutscene_title blank_title))
	
	(f_sfx_hud_tutorial_complete player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; boost
(script static void (f_tutorial_boost
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(f_tutorial_begin player_short display_title)
	(sleep_until (unit_action_test_grenade_trigger (player_get player_short)) 1)
	(f_tutorial_end player_short blank_title)
)

; shoot
(script static void (f_tutorial_rotate_weapons
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(f_tutorial_begin player_short display_title)
	(sleep_until (unit_action_test_rotate_weapons (player_get player_short)) 1)
	(f_tutorial_end player_short blank_title)
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
(global short blip_hostile 				6)
(global short blip_neutralize_alpha 	7)
(global short blip_neutralize_bravo 	8)
(global short blip_neutralize_charlie 	9)

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
	
	(set l_blip_list (ai_actors group))
	(sleep_until
		(begin
			(if (> (object_get_health (list_get l_blip_list s_blip_list_index)) 0)
				(f_blip_object (list_get l_blip_list s_blip_list_index) blip_type))
			(set s_blip_list_index (+ s_blip_list_index 1))
		(>= s_blip_list_index (list_count l_blip_list))) 1)
	
	(set s_blip_list_index 0)
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

; remove the blip
(script static void (f_unblip_ai (ai char))
	(f_unblip_object (ai_get_object char)))

; callout command for lars
(script static void (f_callout_object (object obj) (short type))
	(f_callout_atom obj type 10 2)
	(f_callout_atom obj type 10 2)
	(f_callout_atom obj type 10 2)
	(f_callout_atom obj type 100 2)
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

(script static void (f_callout_atom (object obj) (short type) (short time) (short postdelay))
	(chud_track_object_with_priority obj type)
	(sound_impulse_start sfx_blip none 1)
	(sleep time)
	(chud_track_object obj false)
	(sleep postdelay)
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

(script startup arena_joe_startup

	(print "go joe!")
	
)


(script static void crate_fight

	(ai_place crate_trooper)
	(ai_place crate_elite)

)

(script static void cue_vision

	(ai_place turret)
	(ai_place ground)

)
