extends Control

@export var background_animation_player: AnimationPlayer
@export var is_playing_animation: bool
@export var settings_menu: CanvasLayer

var pause_counter: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	background_animation_player.play("RESET")
	settings_menu.hide()

func _physics_process(delta: float) -> void:
	pass

func _on_resume_button_pressed():
	resume()

func _on_restart_button_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_settings_button_pressed():
	settings_menu.show()
	hide()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/Menus/main_menu.tscn")

func resume():
	settings_menu.hide()
	background_animation_player.play_backwards("Blur")
	if is_playing_animation == false:
		hide()
		get_tree().paused = false

func pause():
	get_tree().paused = true
	show()
	background_animation_player.play("Blur")

func _on_settings_menu_closed_settings() -> void:
	show()
