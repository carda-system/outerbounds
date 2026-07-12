/datum/job/outerbounds/administrator
	title = JOB_OUTERBOUNDS_ADMINISTRATOR
	description = "The physical half of the Outer Bounds expedition, taking roles anywhere between construction and maintenance, to \
		exploration and colony defense. What they lack in the countless degrees and years of study of the researchers, they make up for \
		in experience and build."
	faction = FACTION_STATION
	total_positions = 4
	spawn_positions = 4
	supervisors = SUPERVISOR_MISSION_CONTROL
	config_tag = "OUTERBOUNDS_ADMINISTRATOR"
	outfit = /datum/outfit/job/colony_administrator
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SCI
	display_order = JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR
	departments_list = list(
		/datum/job_department/command,
		/datum/job_department/science,
	)
	job_flags = STATION_JOB_FLAGS | HEAD_OF_STAFF_JOB_FLAGS

/datum/outfit/job/colony_administrator
	name = "Station Engineer"
	jobtype = /datum/job/outerbounds/administrator

	id_trim = /datum/id_trim/job/captain
	uniform = /obj/item/clothing/under/rank/rnd/research_director
	belt = /obj/item/storage/belt/utility/full/engi
	ears = /obj/item/radio/headset/headset_sci
	head = /obj/item/clothing/head/beret/science/rd
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/modular_computer/pda/roboticist
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/science
	duffelbag = /obj/item/storage/backpack/duffelbag/science
	messenger = /obj/item/storage/backpack/messenger/science
	backpack_contents = list()
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	skillchips = list(/obj/item/skillchip/job/roboticist)
