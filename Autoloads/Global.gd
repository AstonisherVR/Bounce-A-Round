extends Node

signal toggle_game_paused(is_paused: bool)

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
var paused: bool = false
var camera: Camera2D
var pause_menu: Control
var settings_menu: CanvasLayer

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

func _ready():
	pass

func pause_play():
	paused = !paused
	pause_menu.visible = paused

func resume():
	get_tree().paused = false
	pause_play()

func restart():
	get_tree().paused = false
	pause_play()
	get_tree().reload_current_scene()

func show_settings():
	settings_menu.show()
	pause_menu.hide()

func hide_settings():
	settings_menu.hide()
	pause_menu.show()

func back_to_main_menu():
	get_tree().paused = false
	pause_play()
	get_tree().change_scene_to_file("res://UI/Menus/main_menu.tscn")

# temp - maybe the settings menu doesn't need to live in a global spot? (will decide in future version)
