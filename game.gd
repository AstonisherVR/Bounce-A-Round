extends Node2D

@export var player_1: CharacterBody2D
@export var player_2: CharacterBody2D
@export var ball: CharacterBody2D
@export var pause_menu: Control
@export var countdown_timer_label: Label
@export var game_camera: Camera2D
@export var animated_game_background: AnimatedSprite2D
@export var random_specials_timer: Timer
@export var ball_spawner_timer: Timer
@export var aplly_gravity_to_ball_state: bool = false
@export var multiply_ball_state: bool = false
@export var portals_appear_state: bool = false
var random_multiply_number: int = 0

func _ready():
	random_specials_timer.wait_time = randi_range(5, 9)
	random_specials_timer.start()
	animated_game_background.play("Default Background")
	Global.camera = game_camera
	#pause_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	game_time_over()
	if aplly_gravity_to_ball_state == true:
		aplly_gravity_to_ball(delta)
		#TODO show Popup

func game_time_over():
	if countdown_timer_label.text == "Game Over":
		player_1.game_over = true
		player_2.game_over = true
		ball.game_over = true
		random_specials_timer.stop()
		print_rich("[color=red][b]Game Over![/b][/color]")

#TODO Random events. They will be the fun in the game:
func _on_random_specials_timer_timeout():
	var random_number_for_ball_specials: int = randi_range(1, 100)
	if random_number_for_ball_specials <= 50:
		#print("NOTHINGS!")
		aplly_gravity_to_ball_state = false
		multiply_ball_state = false
		portals_appear_state = false
	elif random_number_for_ball_specials > 50 and random_number_for_ball_specials <= 75:
		#print("GRAVITY!")
		aplly_gravity_to_ball_state = true
	elif random_number_for_ball_specials > 75 and random_number_for_ball_specials <= 97:
		#print("MULTIPLY!")
		multiply_ball_state = true
		ball_spawner_timer.start()
	elif random_number_for_ball_specials > 97:
		#print("PORTALS!")
		portals_appear_state = true
	random_specials_timer.wait_time = randi_range(3, 5)
	random_specials_timer.start()
	#print("Timer rng Stopped and num is ", random_number_for_ball_specials)

#This one adds gravity to the ball
func aplly_gravity_to_ball(delta):
	if not ball.is_on_floor():
		ball.velocity.y += ball.gravity * delta
#This one one spwans multiple balls
func multiply_ball():
	var new_ball = preload("res://Ball/new_ball.tscn").instantiate()
	new_ball.position = Vector2(randf_range(-10,10), randf_range(-10,10))
	add_child(new_ball)

func _on_ball_spawner_timer_timeout():
	#print("Multiply timer HERE")
	multiply_ball()
	if multiply_ball_state == true:
		ball_spawner_timer.start()

#func make_portals():
	#portal_1.randomize_pos()
	#portal_2.randomize_pos()
