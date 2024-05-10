class_name SettingsMenu extends CanvasLayer

@export var music_check_box: CheckBox
@export var sfx_check_box: CheckBox
@export var player_1_colors_option_button: OptionButton
@export var player_2_colors_option_button: OptionButton

@onready var close_button:Button = %CloseButton as Button
@onready var quit_button:Button = %QuitButton as Button

func _ready():
	# load (or create) file with these saved preferences
	music_check_box.button_pressed = true
	sfx_check_box.button_pressed = true
	quit_button.visible = false
	# set saved values (will be default values if first load)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		hide()
	check_settings()

func _on_close_button_pressed():
	hide()

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://UI/Menus/main_menu.tscn")

func check_settings():
	if music_check_box.button_pressed == true:
		Global.music_audio_active = true
	else:
		Global.music_audio_active = false
	if sfx_check_box.button_pressed == true:
		Global.sfx_audio_active = true
	else:
		Global.sfx_audio_active = false
