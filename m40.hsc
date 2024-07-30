;matt's global scripts

(script static unit player0
  (unit (player_get 0)))

(script static unit player1
  (unit (player_get 1)))

(script static unit player2
  (unit (player_get 2)))

(script static unit player3
  (unit (player_get 3)))
  
(script static short player_count
  (list_count (players)))

(script static void print_difficulty
	; such a horrible place to put this 
	(game_save_immediate)

	(cond
		((= (game_difficulty_get_real) easy) (print "easy"))
		((= (game_difficulty_get_real) normal) (print "normal"))
		((= (game_difficulty_get_real) heroic) (print "heroic"))
		((= (game_difficulty_get_real) legendary) (print "legendary"))
	)
)

; globals 
(global string data_mine_mission_segment "")


; difficulty level scripts 
(script static boolean difficulty_legendary
	(= (game_difficulty_get) legendary)
)

(script static boolean difficulty_heroic
	(= (game_difficulty_get) heroic)
)

(script static boolean difficulty_normal
	(= (game_difficulty_get) normal)
)

; attempts to determine if the player is in combat 
(script static boolean players_not_in_combat
	(player_action_test_reset)
		(sleep 30)
	(if	(and
			(not (player_action_test_primary_trigger))
			(not (player_action_test_grenade_trigger))

			(cond
				((= (game_coop_player_count) 4)	(begin
												(>= (object_get_shield (player0)) 1)
												(>= (object_get_shield (player1)) 1)
												(>= (object_get_shield (player2)) 1)
												(>= (object_get_shield (player3)) 1)
											)
				)
				((= (game_coop_player_count) 3)	(begin
												(>= (object_get_shield (player0)) 1)
												(>= (object_get_shield (player1)) 1)
												(>= (object_get_shield (player2)) 1)
											)
				)
				((= (game_coop_player_count) 2)	(begin
												(>= (object_get_shield (player0)) 1)
												(>= (object_get_shield (player1)) 1)
											)
				)
				(true						(begin
												(>= (object_get_shield (player0)) 1)
											)
				)
			)
		)
	true ; if the player hasn't pulled either trigger and is at full health then return true 
	false ; otherwise return false 
	)
)

; ======================================================================================
; cinematic skip scripts ===============================================================
; ======================================================================================
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

; ======================================================================================
; cinematic fade black scripts =========================================================
; ======================================================================================
(script static void cinematic_fade_to_black
		; the ai will disregard all players 
		(ai_disregard (players) true)

		; players cannot take damage 
		(object_cannot_take_damage (players))

	; scale player input to zero 
	(player_control_fade_out_all_input 1)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause true)

		; lower weapon 
		(unit_lower_weapon (player0) 30)
		(unit_lower_weapon (player1) 30)
		(unit_lower_weapon (player2) 30)
		(unit_lower_weapon (player3) 30)
			(sleep 10)
		
	; fade out the chud 
	(chud_cinematic_fade 0 0.5)
	
	; bring up letterboxes 
	(cinematic_show_letterbox true)
		(sleep 5)
	
	; fade screen to black 
	(fade_out 0 0 0 30)
		(sleep 30)

		; hide players 
		(object_hide (player0) true)
		(object_hide (player1) true)
		(object_hide (player2) true)
		(object_hide (player3) true)
	
	; cinematic start after fading out because of camera pop 
	(cinematic_start)
	(camera_control on)

	; disable player input 
	(player_enable_input false)

	; player can now move 
	(player_disable_movement false)
		(sleep 1)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate true)
)

; ======================================================================================
(script static void cinematic_snap_to_black
		; the ai will disregard all players 
		(ai_disregard (players) true)

		; players cannot take damage 
		(object_cannot_take_damage (players))

	; fade screen to black 
	(fade_out 0 0 0 0)
;		(sleep 1)

	; scale player input to zero 
	(player_control_fade_out_all_input 0)
	
		; lower weapon 
		(unit_lower_weapon (player0) 1)
		(unit_lower_weapon (player1) 1)
		(unit_lower_weapon (player2) 1)
		(unit_lower_weapon (player3) 1)
			(sleep 1)
		
			; hide players 
			(object_hide (player0) true)
			(object_hide (player1) true)
			(object_hide (player2) true)
			(object_hide (player3) true)
	
	; fade out the chud 
	(chud_cinematic_fade 0 0)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause true)
		(sleep 1)

	; cinematic start after fading out because of camera pop 
	(cinematic_start)
	(camera_control on)

	; disable player input 
	(player_enable_input false)

	; player can now move 
	(player_disable_movement false)
		(sleep 1)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate true)
		(sleep 1)
)

; ======================================================================================
(script static void cinematic_fade_to_title
		(sleep 15)
	; cinematic stop and camera control off 
	(cinematic_stop)
	(camera_control off)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate true)

		; unhide players 
		(object_hide (player0) false)
		(object_hide (player1) false)
		(object_hide (player2) false)
		(object_hide (player3) false)
		
			; unlock the players gaze 
			(player_control_unlock_gaze (player0))
			(player_control_unlock_gaze (player1))
			(player_control_unlock_gaze (player2))
			(player_control_unlock_gaze (player3))
				(sleep 1)

			; lower weapon 
			(unit_lower_weapon (player0) 1)
			(unit_lower_weapon (player1) 1)
			(unit_lower_weapon (player2) 1)
			(unit_lower_weapon (player3) 1)

	; fade screen from black 
		(sleep 1)
	(fade_in 0 0 0 15)
		(sleep 15)

	; the ai will disregard all players 
	(ai_disregard (players) 	false)

	; players cannot take damage 
	(object_can_take_damage (players))
)

; ======================================================================================
(script static void cinematic_fade_to_title_slow
	; cinematic stop and camera control off 
	(cinematic_stop)
	(camera_control off)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate true)

		; unhide players 
		(object_hide (player0) false)
		(object_hide (player1) false)
		(object_hide (player2) false)
		(object_hide (player3) false)
		
			; unlock the players gaze 
			(player_control_unlock_gaze (player0))
			(player_control_unlock_gaze (player1))
			(player_control_unlock_gaze (player2))
			(player_control_unlock_gaze (player3))
				(sleep 1)

			; lower weapon 
			(unit_lower_weapon (player0) 1)
			(unit_lower_weapon (player1) 1)
			(unit_lower_weapon (player2) 1)
			(unit_lower_weapon (player3) 1)

	; fade screen from black 
		(sleep 1)
	(fade_in 0 0 0 150)
		(sleep 15)

	; the ai will disregard all players 
	(ai_disregard (players) 	false)

	; players cannot take damage 
	(object_can_take_damage (players))
)

; ======================================================================================
(script static void cinematic_title_to_gameplay
		(sleep 30)
		
		; unlock the players gaze 
		(player_control_unlock_gaze (player0))
		(player_control_unlock_gaze (player1))
		(player_control_unlock_gaze (player2))
		(player_control_unlock_gaze (player3))
			(sleep 1)

			; lower weapon 
			(unit_lower_weapon (player0) 1)
			(unit_lower_weapon (player1) 1)
			(unit_lower_weapon (player2) 1)
			(unit_lower_weapon (player3) 1)
				(sleep 1)
				
		; raise weapons 
		(unit_raise_weapon (player0) 30)
		(unit_raise_weapon (player1) 30)
		(unit_raise_weapon (player2) 30)
		(unit_raise_weapon (player3) 30)
		(sleep 10)

	; enable player input 
	(player_enable_input true)

	; scale player input to one 
	(player_control_fade_in_all_input 1)

	; player can now move 
	(player_disable_movement false)
		(sleep 110)

	; remove letterboxes 
	(cinematic_show_letterbox false)
		(sleep 15)

	; fade in the hud 
	(chud_cinematic_fade 1 1)
		
	; pause the meta-game timer 
	(campaign_metagame_time_pause false)

	; the ai will disregard all players 
	(ai_disregard (players) 	false)

	; players cannot take damage 
	(object_can_take_damage (players))
	
	; game save 
	(game_save)
)

; ======================================================================================
(script static void cinematic_fade_to_gameplay
	; cinematic stop and camera control off 
	(cinematic_stop)
	(camera_control off)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate true)

		; unhide players 
		(object_hide (player0) false)
		(object_hide (player1) false)
		(object_hide (player2) false)
		(object_hide (player3) false)
	
			; unlock the players gaze 
			(player_control_unlock_gaze (player0))
			(player_control_unlock_gaze (player1))
			(player_control_unlock_gaze (player2))
			(player_control_unlock_gaze (player3))
				(sleep 1)

			; lower weapon 
			(unit_lower_weapon (player0) 1)
			(unit_lower_weapon (player1) 1)
			(unit_lower_weapon (player2) 1)
			(unit_lower_weapon (player3) 1)

	; fade screen from black 
		(sleep 1)
	(fade_in 0 0 0 15)
		(sleep 15)

	; remove letterboxes 
	(cinematic_show_letterbox false)
	
	; fade in the chud 
	(chud_cinematic_fade 1 1)

		; raise weapon 
		(unit_raise_weapon (player0) 30)
		(unit_raise_weapon (player1) 30)
		(unit_raise_weapon (player2) 30)
		(unit_raise_weapon (player3) 30)
		(sleep 10)
		
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
	
	; game save 
	(game_save)
)

; ======================================================================================
; chapter title scripts ================================================================
; ======================================================================================

(script static void chapter_start
	(chud_cinematic_fade 0 0.5)
	(cinematic_show_letterbox true)
		(sleep 30)
)
(script static void chapter_stop
	; remove letterboxes 
	(cinematic_show_letterbox false)
		(sleep 15)
	
	; fade in hud 
	(chud_cinematic_fade 1 0.5)
	
	; game save 
	(game_save)
)

; ======================================================================================
; perspective scripts ==================================================================
; ======================================================================================

;for use with perspective scripts
(global boolean perspective_running false)
(global boolean perspective_finished false)

(script static void perspective_start
	; cancel any pending game saves 
	(game_save_cancel)
	
	; allow perspective to be skipped 
	(cinematic_skip_start_internal)

		; the ai will disregard all players 
		(ai_disregard (player0) 	true)
		(ai_disregard (player1) 	true)
		(ai_disregard (player2) 	true)
		(ai_disregard (player3) 	true)

			; players cannot take damage 
			(object_cannot_take_damage (player0))
			(object_cannot_take_damage (player1))
			(object_cannot_take_damage (player2))
			(object_cannot_take_damage (player3))

	; scale player input to zero 
	(player_control_fade_out_all_input 2)
	
		; lower weapon 
		(unit_lower_weapon (player0) 30)
		(unit_lower_weapon (player1) 30)
		(unit_lower_weapon (player2) 30)
		(unit_lower_weapon (player3) 30)
		
	; fade out the chud 
	(chud_cinematic_fade 0 0.5)
		(sleep 15)

	; bring up letterboxes 
	(cinematic_show_letterbox true)
		(sleep 5)
	
	(fade_out 0 0 0 10)
		(sleep 10)
	(camera_control true)
	(cinematic_start)
		(sleep 15)
)

(script static void perspective_stop
	; cinematic stop and camera control off 
	(cinematic_stop)
	(camera_control off)
		(sleep 1)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate true)

		; unlock the players gaze 
		(player_control_unlock_gaze (player0))
		(player_control_unlock_gaze (player1))
		(player_control_unlock_gaze (player2))
		(player_control_unlock_gaze (player3))
	
	; scale player input to one 
	(player_control_fade_in_all_input 0.5)
	
	; fade screen from black 
	(fade_in 0 0 0 10)
		(sleep 5)

	; remove letterboxes 
	(cinematic_show_letterbox false)
	
		; raise weapon 
		(unit_raise_weapon (player0) 30)
		(unit_raise_weapon (player1) 30)
		(unit_raise_weapon (player2) 30)
		(unit_raise_weapon (player3) 30)
			(sleep 10)
	
	; fade in the chud 
	(chud_cinematic_fade 1 0.5)

	; pause the meta-game timer 
	; the ai will disregard all players 
	(ai_disregard (player0) 	false)
	(ai_disregard (player1) 	false)
	(ai_disregard (player2) 	false)
	(ai_disregard (player3) 	false)

		; players cannot take damage 
		(object_can_take_damage (player0))
		(object_can_take_damage (player1))
		(object_can_take_damage (player2))
		(object_can_take_damage (player3))
		
	; game save 
	(game_save)
)

(script static void perspective_skipped
	(cinematic_stop)
	(camera_control off)
	
		; the ai will disregard all players 
		(ai_disregard (player0) 	false)
		(ai_disregard (player1) 	false)
		(ai_disregard (player2) 	false)
		(ai_disregard (player3) 	false)
	
			; players cannot take damage 
			(object_can_take_damage (player0))
			(object_can_take_damage (player1))
			(object_can_take_damage (player2))
			(object_can_take_damage (player3))
	
		; unlock the players gaze 
		(player_control_unlock_gaze (player0))
		(player_control_unlock_gaze (player1))
		(player_control_unlock_gaze (player2))
		(player_control_unlock_gaze (player3))
			(sleep 5)

	; fade in player input 
	(player_control_fade_in_all_input 1)
	
	; fade in 
	(fade_in 0 0 0 15)
		(sleep 15)

		; raise weapon 
		(unit_raise_weapon (player0) 15)
		(unit_raise_weapon (player1) 15)
		(unit_raise_weapon (player2) 15)
		(unit_raise_weapon (player3) 15)

	
	; game save 
	(game_save)
)

(script static boolean perspective_skip_start
	(player_action_test_reset)
	; skip perspective 
	(sleep_until
		(or 
			(not perspective_running)
			(player_action_test_cinematic_skip)
		)
	1)
	
	perspective_running
)

; ======================================================================================
; insertion scripts ====================================================================
; ======================================================================================

(script static void insertion_start
	; fade out 
	(fade_out 0 0 0 0)
	
	; turn off all object sounds 
	(sound_class_set_gain "object" 0 0)
	(sound_class_set_gain "vehicle" 0 0)

	; show letterboxes immediately 
	(cinematic_show_letterbox_immediate true)
	
	; snap out the hud 
	(chud_cinematic_fade 0 0)
	
	; disable player movement 
	(player_disable_movement true)

	; disable player input 
	(player_enable_input false)

	; pause metagame timer   
	(campaign_metagame_time_pause true)

		; lower players weapons 
		(unit_lower_weapon (player0) 1)
		(unit_lower_weapon (player1) 1)
		(unit_lower_weapon (player2) 1)
		(unit_lower_weapon (player3) 1)
		(sleep 1)
		
	; turn on all object sounds 
	(sound_class_set_gain "object" 1 30)
	(sound_class_set_gain "vehicle" 1 30)
)

(script dormant insertion_end
		(sleep 30)
	(fade_in 0 0 0 15)
		(sleep 15)

	; remove letterboxes 
	(cinematic_show_letterbox false)
	
	; scale player input to one 
	(player_control_fade_in_all_input 1)
		(sleep 15)

	; fade in the hud 
	(chud_cinematic_fade 1 1)
		
		; raise weapons 
		(unit_raise_weapon (player0) 30)
		(unit_raise_weapon (player1) 30)
		(unit_raise_weapon (player2) 30)
		(unit_raise_weapon (player3) 30)

	; pause the meta-game timer 
	(campaign_metagame_time_pause false)

	; the ai will disregard all players 
	(ai_disregard (players) 	false)

	; players cannot take damage 
	(object_can_take_damage (players))

	; enable player input 
	(player_enable_input true)

	; player can now move 
	(player_disable_movement false)
	
	; game save 
	(game_save)
)


;***** first halo 3 global script belongs to me!!! *****;

;this function will return the ai of a vehicle squad, irregardless of who may have gotten into the vehicle
(script static ai (ai_get_driver (ai vehicle_starting_location))
	(object_get_ai (vehicle_driver (ai_vehicle_get_from_starting_location vehicle_starting_location)))
)

(script static ai (ai_get_gunner (ai vehicle_starting_location))
	(object_get_ai (vehicle_gunner (ai_vehicle_get_from_starting_location vehicle_starting_location)))
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

;global door script that will shut the given door and never allow it to open again
(script static void (shut_door_forever (device machine_door))
	(device_operates_automatically_set machine_door 0)
	(device_set_position machine_door 0)
	
	(sleep_until (<= (device_get_position machine_door) 0) 30 300)
	(if (> (device_get_position machine_door) 0)
		(device_set_position_immediate machine_door 0)
	)
	(sleep 1)
	(device_set_power machine_door 0)
)

;global door script that will shut the given door and never allow it to open again
;this version is immediate
(script static void (shut_door_forever_immediate (device machine_door))
	(device_operates_automatically_set machine_door 0)
	(device_set_position_immediate machine_door 0)
	(device_set_power machine_door 0)
)


;=========================================;
;==========   playtest scripts  ==========;
;==========  delete before ship ==========;
;=========================================;

(script dormant reset_map_reminder
	(sleep_until
		(begin
			(print "press a to play again!")
		false)
	90)
)

(script static void end_segment
	(print "end gameplay segment!  thank you for playing!")
	(sleep 15)
	(print "grab paul or rob to give feedback!")
	(sleep 15)
	(player_action_test_reset)

	(sleep_until
		(begin
			(print "press the “a” button to reset!")
			(sleep_until (player_action_test_accept) 1 90)
			(player_action_test_accept)
		)
	1)

	(print "reloading map...")
	(sleep 15)
	(chud_cinematic_fade 1 0)
	(fade_in 0 0 0 0) 
	(map_reset)
)

(script static void end_mission
; 06.11.2007 - pbertone: commented this out at the end of h3 
	(if global_playtest_mode
		(begin
			(data_mine_set_mission_segment questionaire)
			(cinematic_fade_to_gameplay)
			(sleep 1) 
		
			(print "end mission!")
			(sleep 15)
			(hud_set_training_text playtest_raisehand)
			(hud_show_training_text 1)
			(sleep 90)
		
			(player_action_test_reset)
		
			(sleep_until
				(begin
					(sleep_until (player_action_test_accept) 1 90)
					(player_action_test_accept)
				)
			1)
		
			(hud_show_training_text 0)
			(print "loading next mission...")
			(sleep 15)
		)
		(begin
			; fade out 
			(fade_out 0 0 0 0)

			; cinematic stop and camera control off 
			(cinematic_stop)
			(camera_control off)
		)
	)
	
	; call game won 
	(game_won)
)

(script dormant beginning_mission_segment
	(data_mine_set_mission_segment mission_start)
)

; ======================================================================================
; cortana / gravemind channel scripts ==================================================
; ======================================================================================
(global boolean g_cortana_header false)
(global boolean g_cortana_footer false)
(global boolean g_gravemind_header false)
(global boolean g_gravemind_footer false)

; ======================================================================================
; ======================================================================================
(script dormant gs_cortana_header
	(sleep_until g_cortana_header 1)
	(print "cortana header")
		
		; cancel any pending game saves 
		(game_save_cancel)
		
		; do not allow respawn coop players 
		(game_safe_to_respawn false)
		
		; scale player input down 
		(player_control_scale_all_input 0.15 0.5)

		; turn comabat dialogue off  
		(ai_dialogue_enable false)

		; the ai will disregard all players 
		(ai_disregard (players) true)

		; players cannot take damage 
		(object_cannot_take_damage (players))
		
		; call damage effect on all players 
		;(damage_players "cinematics\cortana_channel\cortana_effect")
		
		; flicker out the hud 
		(gs_hud_flicker_out)
		
	(set g_cortana_header false)
)

(script dormant gs_cortana_footer
	(sleep_until g_cortana_footer 1)
	(print "cortana footer")
		(sleep 1)
	
		; allow  respawn coop players 
		(game_safe_to_respawn true)
		
		; scale player input up 
		(player_control_scale_all_input 1.0 0.5)
	
		; turn comabat dialogue on 
		(ai_dialogue_enable true)

		; the ai will disregard all players 
		(ai_disregard (players) 	false)
	
		; players can take damage 
		(object_can_take_damage (players))
			(sleep 1)
		
		; game save 
		(game_save)
		
		; fade back in the hud 
		(chud_cinematic_fade 1 1.5)
		
		; cortana out sound 
		(sound_impulse_start "sound\visual_fx\cortana_hud_on" none 1)

	(set g_cortana_footer false)
)
; ======================================================================================
; ======================================================================================

(script dormant gs_gravemind_header
	(sleep_until g_gravemind_header 1)
	(print "gravemind header")

		; cancel any pending game saves 
		(game_save_cancel)
		
		; do not allow respawn coop players 
		(game_safe_to_respawn false)
		
		; scale player input down 
		(player_control_scale_all_input 0.15 2)

		; turn comabat dialogue off  
		(ai_dialogue_enable false)

		; the ai will disregard all players 
		(ai_disregard (players) true)

		; players cannot take damage 
		(object_cannot_take_damage (players))
			(sleep 1)
	
	(set g_gravemind_header false)
)

(script dormant gs_gravemind_footer
	(sleep_until g_gravemind_footer 1)
	(print "gravemind footer")

		; allow  respawn coop players 
		(game_safe_to_respawn true)
		
		; scale player input up 
		(player_control_scale_all_input 1.0 1)
	
		; turn comabat dialogue on 
		(ai_dialogue_enable true)

		; the ai will disregard all players 
		(ai_disregard (players) 	false)
	
		; players can take damage 
		(object_can_take_damage (players))
			(sleep 1)

	(set g_gravemind_footer false)
		(sleep 30)

		; game save 
		(game_save)
	
)

(script static void gs_hud_flicker_out
	(chud_cinematic_fade 0 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 1 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 0 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 1 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 0 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 1 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 0 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 1 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 0 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))
	(chud_cinematic_fade 1 (real_random_range 0 0.035))
	(sound_impulse_start "sound\visual_fx\sparks_medium" none 1)
		(sleep (random_range 2 5))

	(chud_cinematic_fade 0 (real_random_range 0 0.035))
)

; ======================================================================================
; test to award skulls =================================================================
; ======================================================================================
(script static boolean award_skull
	(if	
		(and
			(>= (game_difficulty_get_real) normal)
			(= (game_insertion_point_get) 0)
;*
			(or
				(= (campaign_is_finished_normal) true)
				(= (campaign_is_finished_heroic) true)
				(= (campaign_is_finished_legendary) true)
			)
*;
		)
	true
	false
	)
)

; ======================================================================================
; bfg scripts =========================================================================
; ======================================================================================
(script static void (bfg_setup (device turret) (device base))
	(device_set_position_track base position 0)
	(device_set_overlay_track base power)
	(device_set_position_track turret position 0)
	(device_set_overlay_track turret power)
	(device_animate_overlay base .4 0 0 0)
	(device_animate_overlay turret 0 0 0 0)
)

(script static void (bfg_fire (device turret) (device base))
	(print "bfg fire")
	(effect_new_on_object_marker "objects\levels\shared\bfg\fx\firing_fx\bfg_foot_dust.effect" base "fx_foot")
	
	(device_animate_overlay turret 1 3 0 0)
	(sleep 60)
	
	(device_animate_position base 1 .35 0.2 .5 true)
	(sleep (random_range 20 40))
	;look around to keep it moving:
	(device_animate_overlay base (real_random_range .4 .43) (random_range 2 5) .5 .5)
	;call effects
	(sleep 140)
	(if (> (object_get_health base) 0)
		(device_animate_position base 0 1.2 0.25 1 true)
	)
	
	(print "vent done")
	(device_animate_overlay turret 0 0 0 0)
)

(script static void (bfg_fire_loop (device turret) (device base))
	(sleep_until
		(begin
			(begin
				(sleep (random_range 50 110))
				(bfg_fire turret base)
				;(bfg01_fire)
			)
			false
		)
	)
)
;*********************************************************************;
;general
;*********************************************************************;
(global short objective_control 0)

(script command_script abort_cs
	(sleep 1)
)

(script static void (fade_to_destroy (vehicle vehicle_variable))
	(object_set_scale (ai_vehicle_get ai_current_actor) .01 (* 30 5))
	(sleep (* 30 5))
	(object_destroy vehicle_variable)
)

(script static void test
	(start)
	;(test_faragate_defend)
)

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

(script static void fortress
	(ai_place fortress_ghosts)
	(ai_place fortress_ridge)
	(ai_place fortress_jetty)
	(ai_place fortress_arch)
	(ai_place fortress_banshees)
	(game_save_immediate)
)

(script static void river
	(ai_place river_ghosts)
	(ai_place river_bridge)
	(ai_place river_banshees)
	(ai_place river_banshee_pilots)
	(game_save_immediate)
	
	(sleep_until (>= (ai_combat_status river_banshee_pilots) 2))
		(ai_enter_squad_vehicles gr_cov_river_banshees)
		(print "putting elites into banshees!")

	
)

(script static void shore
	(ai_place shore_left)
	(ai_place shore_right)
	(ai_place shore_crew)
	(ai_place shore_ghost)
	
	(sleep 30)
	(game_save_immediate)
)


;*********************************************************************;
;main script
;*********************************************************************;
(script startup m40
	(print "m40 go!")
	(ai_allegiance human player)
	(ai_allegiance player human)
	;(wake dead_objects)
	
	(if (> (player_count) 0)
		; if game is allowed to start 
		(start)
			
		; if the game is not allowed to start do this 
		(begin 
			(fade_in 0 0 0 0)
			;(wake temp_camera_bounds_off)
		)
	)
)


(script static void start
	(print "start")
	;(wake music_script)
	;(wake overpass_start)
	
	;*
	(sleep_until (volume_test_players vol_courtyard_start) 5)
	(wake courtyard_start)

	(sleep_until (volume_test_players vol_airview_start) 5)
	(wake airview_start)
	
	(sleep_until (volume_test_players vol_faragate_start) 5)
	(wake faragate_start)
	
	(sleep_until (volume_test_players vol_courtyard_start) 5)
	(wake courtyard02_start)
	
	(sleep_until (volume_test_players vol_interior_start) 5)
	(wake interior_start)
	*;
)

;*********************************************************************;
;x scripts
;*
