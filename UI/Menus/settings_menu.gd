extends CanvasLayer

@export var music_check_box: CheckBox
@export var sfx_check_box: CheckBox
@onready var close_button:Button = %CloseButton as Button

func _ready():
	music_check_box.button_pressed = true
	sfx_check_box.button_pressed = true

func _process(_delta):
	check_settings()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		Global.hide_settings()

func check_settings():
	if music_check_box.button_pressed == true:
		Global.music_audio_active = true
	else:
		Global.music_audio_active = false
	if sfx_check_box.button_pressed == true:
		Global.sfx_audio_active = true
	else:
		Global.sfx_audio_active = false
