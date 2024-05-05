extends Node

const PLAYERS_DEFAULT_MAX_SPEED: float = 500.0
const PLAYERS_DEFAULT_SPEED: float = 360
const PLAYERS_DEFAULT_ROTATION_SPEED: float = 0.05
const PLAYERS_DEFAULT_ACCELERATION: float = 3000.0
const PLAYERS_DEFAULT_FRICTION: float = 4000.0
const PLAYERS_KNOCKBACK_FORCE: float = 60.0
const DEFAULT_BALL_SPEED: float = 400
const BALL_SPEED_CAP: float = 800
const GAME_DEFAULT_MINUTES: int = 3
const GAME_DEFAULT_SECONDS: int = 0
var active_portals: int
var player_1_score_number: int
var player_2_score_number: int
var current_ball_idle_animation_number: int
var current_ball_bounce_animation_number: int
var ball_idle_animations: Array = ["Idle", "Glowing Idle"]
var ball_bounce_animations: Array = ["Bounce", "Glowing Bounce"]
var music_audio_active: bool = true
var sfx_audio_active: bool = true
var camera: Camera2D

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

func _ready():
	pass

enum GLOBAL_STATE {
	MAIN_MENU,
	GAMEPLAY,
	CONVERSATION,
	PAUSED
}

# temp - maybe the settings menu doesn't need to live in a global spot? (will decide in future version)
