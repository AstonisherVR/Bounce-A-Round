class_name MainMenu extends Control

@export var start_button: Button
@export var setting_button: Button
@export var version_num_label: Label
@export var settings_menu: CanvasLayer

const version_num: String = "0.3"

func _ready() -> void:
	settings_menu.hide()
	version_num_label.text = "v%s" % version_num

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Game/game.tscn")

func _on_settings_button_pressed() -> void:
	get_tree().paused = true
	settings_menu.show()

func _on_settings_menu_closed_settings() -> void:
	get_tree().paused = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_close_button_pressed() -> void:
	settings_menu.hide()
