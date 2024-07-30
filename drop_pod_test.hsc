(global vehicle v_sur_drop_01 NONE)
(global vehicle v_sur_drop_02 NONE)

(script startup lighting_reference_mark
                (print "drop pod test")
)

(script static void test_squad_drop
                
                (print "cleaning up drop pods...")
                (sleep 30)
                (drop_pod_squad)
)

(script static void drop_pod_squad
                (sleep (random_range 5 15))
                (print "squad pod 01...")
                (object_create dm_cov_squad_drop_pod)
                (object_create v_squad_drop)
                (sleep 1)
                (objects_attach dm_cov_squad_drop_pod "" v_squad_drop "")
                (sleep 1)
                (device_set_position dm_cov_squad_drop_pod 1)
                (sleep 30)
                (sleep_until (>= (device_get_position dm_cov_squad_drop_pod) 1) 1)
                (sleep 1)
                (objects_detach dm_cov_squad_drop_pod v_squad_drop)
                (object_destroy dm_cov_squad_drop_pod)
                (sleep 1)
                (f_callout_object v_squad_drop 14)
                (unit_open v_squad_drop)
)

(script static void test_elite_drop
                
                (print "cleaning up drop pods...")
                (object_destroy v_drop_elite)
                (sleep 30)
                (drop_pod_elite01)
)



;(script static void test_elite01
;		(print "test")
;		(device_set_position_track drop_pod_elite01 "pod_drop_100wu" 0)
;		(device_animate_position drop_pod_elite01 1.0 1.00 0.1 0.1 false)
;		(sleep 180)
;		(object_destroy drop_pod_elite01)
;)


(script static void drop_pod_elite01
                (sleep (random_range 5 15))
                (print "squad pod 01...")
                (object_create dm_elite_drop_pod)
                (object_create v_drop_elite)
                (sleep 1)
                (objects_attach dm_elite_drop_pod "" v_drop_elite "")
                (sleep 1)
                (device_set_position dm_elite_drop_pod 1)
                (sleep 30)
                (sleep_until (>= (device_get_position dm_elite_drop_pod) 1) 1)
                (sleep 1)
                (objects_detach dm_elite_drop_pod v_drop_elite)
                (object_destroy dm_elite_drop_pod)
                (sleep 1)
                (unit_open v_drop_elite)
)

(script static void (drop_pod (device_name pod_marker) (ai pod_pilot))
	(print "pod drop started...")
	(object_create_anew pod_marker)
	(ai_place pod_pilot)
	(sleep 1)
	(objects_attach pod_marker "" (ai_vehicle_get_from_spawn_point pod_pilot) "")
	(device_set_position pod_marker 0)
	(device_set_position_track pod_marker "pod_drop_100wu" 0)
	(device_animate_position pod_marker 1.0 3.5 0.1 0 false)
	(sleep_until (>= (device_get_position pod_marker) 1) 1)
	
	(objects_detach pod_marker (ai_vehicle_get_from_spawn_point pod_pilot))
	(effect_new_on_object_marker objects\gear\human\military\resupply_capsule\fx\capsule_impact.effect (ai_vehicle_get_from_spawn_point pod_pilot) "fx_impact")
	(object_destroy pod_marker)
	(object_damage_damage_section  (ai_vehicle_get_from_spawn_point pod_pilot) "body" 100)
	(sleep 45)
	(vehicle_unload (ai_vehicle_get_from_spawn_point pod_pilot) "")
)
;*
(script static void drop_pod_elite_pistol
	(print "dropping an elite pod with pistol-class weapon...")
	(drop_pod dm_elite_drop_pod sq_pod_pilots/pistol_class)
)

(script static void pod_loop_pistol
	(sleep_until
		(begin
			(drop_pod_elite_pistol)
			(sleep 100)
			(garbage_collect_unsafe)
			(ai_erase_all)
		0)
	1)
)

(script static void drop_pod_elite_rifle
	(print "dropping an elite pod with rifle-class weapon...")
	(drop_pod dm_elite_drop_pod sq_pod_pilots/rifle_class)
)

(script static void pod_loop_rifle
	(sleep_until
		(begin
			(drop_pod_elite_rifle)
			(sleep 100)
			(garbage_collect_unsafe)
			(ai_erase_all)
		0)
	1)
)

(script static void drop_pod_elite_support
	(print "dropping an elite pod with support-class weapon...")
	(drop_pod dm_elite_drop_pod sq_pod_pilots/support_class)
)

(script static void pod_loop_support
	(sleep_until
		(begin
			(drop_pod_elite_support)
			(sleep 100)
			(garbage_collect_unsafe)
			(ai_erase_all)
		0)
	1)
)

(script static void drop_pod_elite_sword
	(print "dropping an elite pod with sword-class weapon...")
	(drop_pod dm_elite_drop_pod sq_pod_pilots/sword_class)
)

(script static void pod_loop_sword
	(sleep_until
		(begin
			(drop_pod_elite_sword)
			(sleep 100)
			(garbage_collect_unsafe)
			(ai_erase_all)
		0)
	1)
)
*;
(script static void pod_loop_cov_supply
	(sleep_until
		(begin
			(resupply_pod_01)
			(sleep 100)
			(resupply_cov_open)
			(sleep 30)
			(garbage_collect_unsafe)
			(ai_erase_all)
		0)
	1)
)

(script static void pod_loop_unsc_supply
	(sleep_until
		(begin
			(resupply_pod_02)
			(sleep 100)
			(resupply_open_02)
			(sleep 30)
			(garbage_collect_unsafe)
			(ai_erase_all)
		0)
	1)
)


(script static void resupply_pod_01
                (object_destroy sc_cov_resupply_01)
                (sleep (random_range 5 15))
                (print "resupply pod 01...")
                (object_create dm_cov_resupply)
                (object_create_variant sc_cov_resupply_01 "fr")
                (sleep 1)
                (objects_attach dm_cov_resupply "" sc_cov_resupply_01 "")
                (sleep 1)
                (device_set_position dm_cov_resupply 1)
                (sleep_until (>= (device_get_position dm_cov_resupply) 0.98) 1)
                (sleep_until (>= (device_get_position dm_cov_resupply) 1) 1)
                (sleep 1)
                (objects_detach dm_cov_resupply sc_cov_resupply_01)
                (object_destroy dm_cov_resupply)
                (sleep (random_range 8 17))
                (sleep 60)
)

(script static void resupply_cov_open
                (object_damage_damage_section sc_cov_resupply_01 "body" 100)
)

(script static void resupply_pod_02
                ;(object_destroy sc_resupply_02)
                (print "resupply pod 02...")
                (object_create dm_resupply_02)
                (object_create_variant sc_resupply_02 "ar")
                (print "created sc_resupply02")
                (sleep 1)
                (objects_attach dm_resupply_02 "" sc_resupply_02 "")
                (sleep 1)
                (device_set_position dm_resupply_02 1)
                (sleep_until (>= (device_get_position dm_resupply_02) 0.98) 1)
                (sleep_until (>= (device_get_position dm_resupply_02) 1) 1)
                (sleep 1)
                (objects_detach dm_resupply_02 sc_resupply_02)
                (object_destroy dm_resupply_02)
                (sleep (random_range 8 17))
                (sleep 60)
)

(script static void resupply_open_02
                (object_damage_damage_section sc_resupply_02 "panel" 100)
)
