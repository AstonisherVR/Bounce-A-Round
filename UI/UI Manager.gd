extends CanvasLayer

@export var pause_menu: Control
@export var pause_menu_background: AnimationPlayer
@export var settings_menu: CanvasLayer
@export var is_playing_animation: bool

var pause_counter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.pause_menu = pause_menu
	Global.settings_menu = settings_menu
	pause_menu_background.play("RESET")
	settings_menu.hide()

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		Global.pause_play()
		get_tree().paused = Global.paused
		pause_menu_background.play("Blur")

func _on_resume_button_pressed():
	Global.resume()
	pause_menu_background.play("RESET")

func _on_restart_button_pressed():
	Global.restart()
	pause_menu_background.play("RESET")

func _on_settings_button_pressed():
	Global.load_settings()

func _on_main_menu_button_pressed():
	Global.back_to_main_menu()
	pause_menu_background.play("RESET")
