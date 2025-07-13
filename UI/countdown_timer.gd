extends Control

@export var game_timer: Timer
@export var flash_text_timer: Timer
@export var countdown_timer_text: Label

var minutes: int = 0
var seconds: int = 0
var countdown_timer_flash_number = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_timer()
	game_timer.start()
	display_timer_text()

#Checks time every second.
func _on_game_timer_timeout():
	if seconds == 0 and minutes > 0:
		minutes -= 1
		seconds = 60
	seconds -= 1
	display_timer_text()
	display_timer_run_out_text()


func display_timer_text():
	if seconds < 10:
		#Displays the counntdown with a zero
		countdown_timer_text.text = str(minutes)+":"+"0"+str(seconds)
	else:
		#Displays the counntdown
		countdown_timer_text.text = str(minutes)+":"+str(seconds)

func display_timer_run_out_text():
	if seconds == -1 and minutes == 0:
		game_timer.stop()
		countdown_timer_text.text = "Game Over"
		flash_text_timer.start()

func reset_timer():
	seconds = Global.GAME_DEFAULT_SECONDS
	minutes = Global.GAME_DEFAULT_MINUTES

func _on_flash_text_timer_timeout():
	countdown_timer_flash_number += 1
	if countdown_timer_flash_number % 2 == 0:
		countdown_timer_text.show()
	else:
		countdown_timer_text.hide()
