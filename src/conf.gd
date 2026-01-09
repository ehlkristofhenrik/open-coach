extends Node

const CONF_FILE_PATH = "user://config.json"
const CONF_FILE_PASS = "xmx0-d1l9p-CouchCoach"

var selected_exercise_group: String = ""

var config = {
	"tts": {
		"volume": 100,
		"rate": 1.0,
		"pitch": 1.0,
		"voice": "",
		"announce_every": 15,
		"announce_last": 10,
	},
	"quotes": [
		"I hated every minute of training, but I said, 'Don't quit. Suffer now and live the rest of your life as a champion.' - Muhammad Ali",
		"Float like a butterfly, sting like a bee. His hands can't hit what his eyes can't see. - Muhammad Ali",
		"The man who has no imagination has no wings. - Muhammad Ali",
		"It's not bragging if you can back it up. - Muhammad Ali",
		"Impossible is just a big word thrown around by small men who find it easier to live in the world they’ve been given than to explore the power they have to change it. - Muhammad Ali",
		"Everyone has a plan 'till they get punched in the mouth. - Mike Tyson",
		"I’m a dreamer. I have to dream and reach for the stars, and if I miss a star then I seize a handful of clouds. - Mike Tyson",
		"Fear is your best friend or your worst enemy. It's like fire. If you can control it, it can cook for you; it can heat your house. If you can't control it, it will burn everything around you and destroy you. - Mike Tyson",
		"I just want to conquer people and their souls. - Mike Tyson",
		"Discipline is doing what you hate to do, but nonetheless doing it like you love it. - Mike Tyson",
		"The hero and the coward both feel the same fear. Only the hero uses his fear and projects it onto his opponent. - Cus D'Amato",
		"A boy comes to me with a spark of interest, I feed the spark and it becomes a flame. I feed the flame and it becomes a fire. I feed the fire and it becomes a roaring blaze. - Cus D'Amato",
		"To be a champion, you have to believe in yourself when nobody else will. - Sugar Ray Robinson",
		"Rhythm is everything in boxing. Every move you make starts with your heart, and that's in rhythm or you're in trouble. - Sugar Ray Robinson",
		"I've always believed that you can't think about what you want to do. You have to do it. - Sugar Ray Robinson",
		"Sure the fight was fixed. I fixed it with a right hand. - George Foreman",
		"Boxing is like the jazz. The better it is, the less people appreciate it. - George Foreman",
		"A champion is someone who gets up when he can't. - Jack Dempsey",
		"Tall men come down to my size when I hit them in the body. - Jack Dempsey",
		"The best defense in boxing is to keep your opponent on the defense. - Jack Dempsey",
		"If you want to see the sunshine, you have to weather the storm. - Frank Bruno",
		"I don't care what you say about me. Just spell my name right. - Gene Tunney",
		"A good boxer doesn't just hit hard; he hits at the right time. - Joe Louis",
		"He can run, but he can't hide. - Joe Louis",
		"Everyone has a plan until they get hit. Then, like a rat, they stop in their tracks from fear and uncertainty. - Joe Louis",
		"You're not a real champion until you defend your title. - Joe Frazier",
		"Boxing is the only sport you can get your brain shook, your money took and your name in the undertaker book. - Joe Frazier",
		"Life's tough, but it's tougher if you're stupid. - John L. Sullivan",
		"I can fight any man born of a woman. - John L. Sullivan",
		"I'm the best. I'm the greatest. I'm the fastest. - Floyd Mayweather Jr.",
		"Hard work, dedication! - Floyd Mayweather Jr.",
		"You have to believe in yourself when no one else does. That's what makes you a winner. - Venus Williams (often cited by boxers like Mayweather)",
		"I'm not the best. I'm just a hard worker. - Manny Pacquiao",
		"Boxing is not about feelings. It's about performance. - Manny Pacquiao",
		"I'm a fighter. I believe in the eye for an eye business. - Roberto Duran",
		"I am not an animal, but I am the best. - Roberto Duran",
		"Getting hit motivates me. It makes me punish the guy more. - Roberto Duran",
		"If you screw up, you have to live with it for the rest of your life. - Rocky Marciano",
		"Why should I be afraid of any man? I'm the heavyweight champion of the world. - Rocky Marciano",
		"In boxing, you create a strategy to beat each new opponent, it's just like chess. - Lennox Lewis",
		"I don't think I'm a legend. I'm just a simple man who followed his dreams. - Lennox Lewis",
		"The only way to be a champion is to work harder than everyone else. - Evander Holyfield",
		"It is not the size of a man but the size of his heart that matters. - Evander Holyfield",
		"You never know what you can do until you try. - Evander Holyfield",
		"A man who is a master of patience is master of everything else. - George Foreman",
		"The fist that strikes is the fist that wins. - Sonny Liston",
		"I don't want to be the next Muhammad Ali. I want to be the first Joe Frazier. - Joe Frazier",
		"The more I sweat in training, the less I bleed in battle. - Richard Marcinko (adopted by many boxers)",
		"Champions aren't made in gyms. Champions are made from something they have deep inside them - a desire, a dream, a vision. - Muhammad Ali"
	],
	"exercise_groups": {
		
	},
	"background": ""
}:
	set(value):
		config = value
		save_config()


func _ready() -> void:
	load_config()

func save_config() -> void:
	var json: String = JSON.stringify( config )
	var file: FileAccess = FileAccess.open_encrypted_with_pass( CONF_FILE_PATH, FileAccess.WRITE, CONF_FILE_PASS )
	file.store_string( json )
	file.close()

func load_config() -> void:
	DirAccess.remove_absolute(CONF_FILE_PATH)
	if FileAccess.file_exists(CONF_FILE_PATH):
		var file: FileAccess = FileAccess.open_encrypted_with_pass(CONF_FILE_PATH, FileAccess.READ, CONF_FILE_PASS)
		var json = file.get_as_text()
		config = JSON.parse_string( json )
		file.close()

func _notification(what: int) -> void:
	if what == NOTIFICATION_CRASH:
		DirAccess.remove_absolute(CONF_FILE_PATH)
