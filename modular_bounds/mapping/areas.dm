/area
	/// If lighting behaves like it's outside and thus has luminosity
	var/outside_lights = FALSE

/area/outerbounds
	name = "OB Area Basetype (DONT USE)"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "mining"
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED | CAVES_ALLOWED
	sound_environment = SOUND_AREA_LAVALAND
	ambient_buzz = null
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambience_index = AMBIENCE_GENERIC
	min_ambience_cooldown = 15 SECONDS
	max_ambience_cooldown = 1 MINUTES

/area/outerbounds/add_base_lighting()
	. = ..()
	if(outside_lights)
		luminosity = 1
		for(var/turf/luminous_turf in contents)
			luminous_turf.luminosity = 1

/area/outerbounds/surface_generator
	name = "Surface"
	map_generator = /datum/map_generator/surface_generator
	area_has_base_lighting = TRUE
	base_lighting_alpha = 255
	outdoors = TRUE
	outside_lights = TRUE

/area/outerbounds/cave
	name = "Underground"
	area_flags = NONE
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	area_has_base_lighting = TRUE
	outdoors = TRUE
	base_lighting_alpha = 150
	base_lighting_color = "#336699"

/area/outerbounds/indoors
	name = "Indoors"
	area_flags = NONE
	sound_environment = SOUND_AREA_SMALL_ENCLOSED
	area_has_base_lighting = TRUE
	base_lighting_alpha = 150
	base_lighting_color = "#336699"
