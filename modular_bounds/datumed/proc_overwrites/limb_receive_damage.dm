/obj/item/bodypart/proc/get_damage()
	var/limb_damage = 0
	if(!owner)
		return limb_damage
	for(var/datum/medical_condition/condition in owner.medical_conditions)
		if(owner.medical_conditions[condition] == body_zone)
			limb_damage += condition.health_offset
	return abs(limb_damage)

/// Updates brute_dam and burn_dam for limbs so they render correct damage overlays on the mob
/obj/item/bodypart/proc/update_limb_health_values_for_conditions()
	var/burn_damage_total = 0
	var/brute_damage_total = 0
	if(!owner)
		return
	for(var/datum/medical_condition/condition in owner.medical_conditions)
		if(owner.medical_conditions[condition] == body_zone)
			if(condition.damage_type == BRUTE)
				brute_damage_total += condition.health_offset
			else if(condition.damage_type == BURN)
				burn_damage_total += condition.health_offset

/obj/item/bodypart/proc/receive_damage(brute = 0, burn = 0, blocked = 0, updating_health = TRUE, forced = FALSE, required_bodytype = null, wound_bonus = 0, exposed_wound_bonus = 0, sharpness = NONE, attack_direction = null, damage_source, wound_clothing = TRUE)
	SHOULD_CALL_PARENT(TRUE)
	var/hit_percent = forced ? 1 : (100-blocked)/100
	if((!brute && !burn) || hit_percent <= 0)
		return FALSE
	if (!forced || !isnull(owner))
		if (HAS_TRAIT(owner, TRAIT_GODMODE))
			return FALSE
		if (SEND_SIGNAL(owner, COMSIG_CARBON_LIMB_DAMAGED, src, brute, burn) & COMPONENT_PREVENT_LIMB_DAMAGE)
			return FALSE
		if(required_bodytype && !(bodytype & required_bodytype))
			return FALSE
	brute = round(max(brute * hit_percent * brute_modifier, 0), DAMAGE_PRECISION)
	burn = round(max(burn * hit_percent * burn_modifier, 0), DAMAGE_PRECISION)
	if(!brute && !burn)
		return FALSE
	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	/*
	// START WOUND HANDLING
	*/
	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	//var/wounding_dmg = max(brute, burn)
	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)
	if(can_inflict <= 0)
		return FALSE
	if(brute && !(wounding_type == WOUND_BURN))
		damage_to_conditions(brute, wounding_type)
	if(burn && (wounding_type == WOUND_BURN))
		damage_to_conditions(burn, wounding_type)
	if(owner)
		if(can_be_disabled)
			update_disabled()
		if(updating_health)
			owner.updatehealth()
	update_limb_health_values_for_conditions()
	return update_bodypart_damage_state()
