extends CharacterBody2D

@export var animations: AnimatedSprite2D
@export var knock_back_timer: Timer
@export var footsteps_sfx: AudioStreamPlayer2D
@export var footsteps_animation_player: AnimationPlayer
const START_POS: Vector2 = Vector2(830, 0)
var direction = Vector2.ZERO
var rotation_direction: float
var max_speed: float = Global.PLAYERS_DEFAULT_MAX_SPEED
var rotation_speed: float = Global.PLAYERS_DEFAULT_ROTATION_SPEED
var acc_speed: float = Global.PLAYERS_DEFAULT_ACCELERATION
var friction: float = Global.PLAYERS_DEFAULT_FRICTION
var knock_back_power = 800
var can_move: bool = true
var game_over: bool = false

func _physics_process(delta):
#Checks to see if the game is over
	if game_over != true:
		movement(delta)

func _ready():
	default_parameters()

func default_parameters():
	add_to_group("Player 2", true)
	position = START_POS

#limits movement
func wall_checking():
	if position.x >= 868:
		position.x = 864
	elif position.x <= 90:
		position.x = 90
	if rotation >= 0.80:
		rotation = 0.76
	elif rotation <= -0.80:
		rotation = -0.76

func player_input():
	direction.y = Input.get_axis("Player_2_UP", "Player_2_DOWN")
	direction.x = Input.get_axis("Player_2_LEFT", "Player_2_RIGHT")
	rotation_direction = Input.get_axis("Player_2_Rotate_LEFT","Player_2_Rotate_RIGHT")
	return direction.normalized()

#Movement and rotation of the player
func movement(delta):
	wall_checking()
	#Rotational movement
	if rotation_direction:
		rotate(rotation_direction * rotation_speed) 
	#Player Movement
	direction = player_input()
	if direction == Vector2.ZERO:
		footsteps_animation_player.play("Idle")
		if velocity.length() > friction * delta:
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		footsteps_animation_player.play("Footsteps")
		footsteps_sfx.pitch_scale = randf_range(0.75, 1.35)
		velocity += direction * acc_speed * delta
		velocity = velocity.limit_length(max_speed)
	move_and_slide()

func _on_knock_back_timer_timeout():
	knock_back_timer.stop()
