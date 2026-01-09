extends Node

enum ExerciseType {
	RHYTHMIC_EXERCISE  = 0,
	INTENSITY_EXERCISE = 1,
	REACTION_EXERCISE  = 2,
}

var tts_is_speaking: bool = false
signal tts_finished

func _process(delta: float) -> void:
	var is_speaking: bool = DisplayServer.tts_is_speaking()
	if tts_is_speaking == true and is_speaking == false:
		tts_finished.emit()
	tts_is_speaking = is_speaking

func time_to_tts( time: int ) -> String:
	var minutes: int = int( time / 60 )
	var seconds: int = time % 60
	if minutes > 0:
		return "%d %d" % [ minutes, seconds ]
	else:
		return "%d" % seconds

func time_to_str( time: int ) -> String:
	var minutes: int = int( time / 60 )
	var seconds: int = time % 60
	return "%02d:%02d" % [ minutes, seconds ]

func disable_input( disable: bool ) -> void:
	for node: Control in get_tree().get_nodes_in_group("DisableInput"):
		if 'disabled' in node:
			node.disabled = disable
		elif 'editable' in node:
			node.editable = not disable

func tts_speak( utterance: String ):
	DisplayServer.tts_speak( 
		utterance, 
		Conf.config['tts']['voice'], 
		Conf.config['tts']['volume'],
		Conf.config['tts']['pitch'],
		Conf.config['tts']['rate'],
		0,
		true
	)

func wait( sec ) -> void:
	await get_tree().create_timer( sec ).timeout

func get_unique_id( length: int = 10 ) -> String:
	const alpha: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_"
	var unique_string: String = ""
	for i in range( length ):
		unique_string += alpha[randi_range(0, alpha.length()-1)]
	return unique_string

func get_placeholder_name() -> String:
	const adjectives = [
		"Angry",
		"Wobbly",
		"Sneaky",
		"Explosive",
		"Sleepy",
		"Confused",
		"Heroic",
		"Chaotic",
		"Overcaffeinated",
		"Suspicious",
		"Dramatic",
		"Bouncy",
		"Clumsy",
		"Grumpy",
		"Hyperactive",
		"Lazy",
		"Majestic",
		"Nervous",
		"Optimistic",
		"Reckless",
		"Sassy",
		"Shaky",
		"Slippery",
		"Smug",
		"Speedy",
		"Spicy",
		"Stubborn",
		"Surprised",
		"Twitchy",
		"Unstable",
		"Victorious",
		"Weird",
		"Wild",
		"Zany",
		"Awkward",
		"Bold",
		"Cosmic",
		"Dizzy",
		"Flailing",
		"Furious",
		"Goofy",
		"Jittery",
		"Loopy",
		"Melodramatic",
		"Panicked",
		"Quirky",
		"Rowdy",
		"Unhinged"
	];

	const actions = [
		"Squats",
		"Pushups",
		"Lunges",
		"Plank",
		"Burpees",
		"Crunches",
		"Twists",
		"Hops",
		"Jumps",
		"March",
		"Stretch",
		"Raises",
		"Kicks",
		"Shuffles",
		"Slides",
		"Crawls",
		"Holds",
		"Steps",
		"Pulses",
		"Circles",
		"Rotations",
		"Climbers",
		"Swings",
		"Thrusts",
		"Presses",
		"Pulls",
		"Reaches",
		"Scoots",
		"Balances",
		"Skips",
		"Bounds",
		"Sprints",
		"Shakes",
		"Tilts",
		"Bends",
		"Flys",
		"Rolls",
		"Twists Again",
		"Explosions",
		"Grinds",
		"Wiggles",
		"Flops",
		"Flails",
		"Taps",
		"Slams",
		"Hovers",
		"Kneels",
		"Lifts",
		"Drops",
"Squats",
		"Pushups",
		"Lunges",
		"Plank",
		"Burpees",
		"Crunches",
		"Jumps",
		"Stretch",
		"Raises",
		"Hops",
		"Jabs",
		"Crosses",
		"Hooks",
		"Uppercuts",
		"Roundhouse Kicks",
		"Front Kicks",
		"Side Kicks",
		"Back Kicks",
		"Knee Strikes",
		"Elbows",
		"Punch Combos",
		"Kick Combos",
		"Shadowboxing",
		"Footwork",
		"Shuffles",
		"Slips",
		"Rolls",
		"Weaves",
		"Counters",
		"Feints",
		"Power Strikes",
		"Speed Bursts",
		"Balance Drills",
		"Core Blasts",
		"Guard Holds",
		"Clinches",
		"Spar Bursts",
		"Pad Smashes",
		"Heavy Bag Rounds",
		"Finisher Flurries"
	];

	return adjectives[ randi_range( 0, adjectives.size()-1)] + " " + actions[randi_range(0, actions.size()-1)]
