class_name UserPrefs extends Resource

@export var use_smooth_movement:bool = true

const USER_PREFS_PATH:String = "user://user_prefs.tres"

static func load_or_create() -> UserPrefs:
	var res:UserPrefs
	res = UserPrefs.new()
	return res
