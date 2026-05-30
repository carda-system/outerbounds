/mob/living/carbon
	/// List of all of this mob's attributes and their values
	var/list/attributes = list(
		ATTRIBUTE_WILLPOWER = MAX_ATTRIBUTE_SCORE,
		ATTRIBUTE_SELF = DEFAULT_ATTRIBUTE_SCORE,
		ATTRIBUTE_SMARTS = DEFAULT_ATTRIBUTE_SCORE,
		ATTRIBUTE_INTUITION = DEFAULT_ATTRIBUTE_SCORE,
		ATTRIBUTE_MUSCLE = DEFAULT_ATTRIBUTE_SCORE,
		ATTRIBUTE_REFLEX = DEFAULT_ATTRIBUTE_SCORE,
		ATTRIBUTE_AWARENESS = DEFAULT_ATTRIBUTE_SCORE,
	)
	/// List of current attribute modifiers, ATTRIBUTE_WHATEVER = modifier number
	var/list/attribute_modifiers = list()
	/// List of any active attribute modifiers this mob may have, arranged as ATTRIBUTE_WHATEVER = number modifier
	var/list/attributes = list()

/// Get's a carbon's score for an attribute, optionally adjusted by modifiers
/mob/living/carbon/proc/get_attribute_score(attribute, modified = TRUE)
	if(!attribute)
		return 0
	var/score = attributes[attribute]
	if(!modified)
		return score
	if(attribute in attribute_modifiers)
		score += attribute_modifiers[attribute]
	return score

/// Returns a multiplied time for a given attribute or attributes via a list and an original time
/proc/attributes_adjusted_time(mob/living/carbon/holder, list/attributes_to_check, original_time)
	if(isnull(holder) || isnull(attributes_to_check) || isnull(original_time))
		return
	var/score_to_use = 0
	for(var/attribute in attributes_to_check)
		var/attribute_score = holder.get_attribute_score(attribute)
		score_to_use = max(score_to_use, attribute_score)
	switch(score_to_use)
		if(0 to 1)
			return original_time * 1.5
		if(2)
			return original_time * 1.25
		if(3 to 5)
			return original_time * 1
		if(6 to 7)
			return original_time * 0.9
		if(8 to 9)
			return original_time * 0.825
		if(10)
			return original_time * 0.75

/// Returns a title for a specific attribute level per attribute
/proc/get_attribute_title(attribute, score)
	switch(attribute)
		if(ATTRIBUTE_WILLPOWER)
			switch(score)
				if(0)
					return "Broken"
				if(1)
					return "Dangerously Low"
				if(2 to 3)
					return "Low"
				if(4 to 6)
					return "Suggestible"
				if(7 to 9)
					return "Strong"
				if(10)
					return "Flawless"
		if(ATTRIBUTE_SELF)
			switch(score)
				if(0)
					return "..."
				if(1)
					return "Abysmal"
				if(2)
					return "Little"
				if(3 to 4)
					return "Questionable"
				if(5 to 8)
					return "Individual"
				if(9 to 10)
					return "Strong"
		if(ATTRIBUTE_SMARTS)
			switch(score)
				if(0)
					return "Thoughtless"
				if(1 to 3)
					return "Low"
				if(4 to 6)
					return "Average"
				if(7 to 8)
					return "Sharp"
				if(9)
					return "Studied"
				if(10)
					return "Remarkable"
		if(ATTRIBUTE_INTUITION)
			switch(score)
				if(0 to 2)
					return "Clueless"
				if(3 to 4)
					return "Slow"
				if(5 to 7)
					return "Average"
				if(8 to 9)
					return "Quick"
				if(10)
					return "Engineer"
		if(ATTRIBUTE_MUSCLE)
			switch(score)
				if(0 to 1)
					return "Feeble"
				if(2 to 4)
					return "Weak"
				if(5 to 7)
					return "Average"
				if(8 to 9)
					return "Strong"
				if(10)
					return "Colossal"
		if(ATTRIBUTE_REFLEX)
			switch(score)
				if(0 to 4)
					return "Little"
				if(5 to 7)
					return "Average"
				if(8 to 9)
					return "Fast"
				if(10)
					return "Godlike"
		if(ATTRIBUTE_AWARENESS)
			switch(score)
				if(0)
					return "Practically Blind"
				if(1 to 2)
					return "Unobservant"
				if(3 to 4)
					return "Poor"
				if(5 to 6)
					return "Average"
				if(7 to 8)
					return "Keen"
				if(9 to 10)
					return "Eagle-Eyed"
	// Something bad has happened
	return "???"
