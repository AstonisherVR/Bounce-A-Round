extends CharacterBody2D

@export var bounce_particles: PackedScene = preload("res://Ball/bounce_particles_ball.tscn")
@export var animation_player: AnimationPlayer
@export var sparkles: GPUParticles2D
@export var ball_bounce_sfx: AudioStreamPlayer2D
@export var ball_sprites: AnimatedSprite2D
@onready var base_scale: Vector2 = ball_sprites.scale
var new_ball_idle_animations: Array = ["Idle", "Glowing Idle"]
var new_ball_bounce_animations: Array = ["Bounce", "Glowing Bounce"]
var current_new_ball_idle_animation_number: int
var current_new_ball_bounce_animation_number: int
var direction: Vector2 = Vector2.ZERO
var speed: float = 0.0
var light_time: float = 0.0
var light_speed: float = 1.0
var knockback_amount: float = 500
var gravity: float = 1.75
var game_over: bool = false

func _ready():
	ball_sprites.play("Ball")
	current_new_ball_bounce_animation_number = 0
	current_new_ball_idle_animation_number = 0
	velocity = spawn_direction()
	special_ball_chance()
	spawn_parameters()

func _physics_process(delta):
	#If the game is over, the game stops.
	if game_over != true:
		movement(delta)
		light_time = wrapf(light_time+delta*light_speed, -PI,PI)
		sparkles.rotation = light_time
# The starting parameters for the ball
func spawn_parameters():
	position = Vector2.ZERO
	speed = Global.DEFAULT_BALL_SPEED
	animation_player.play(new_ball_idle_animations[current_new_ball_idle_animation_number])

func spawn_direction():
	var random_angle = randf_range(0, 360)   # Random angle between 0 and 360 degrees
	direction = Vector2(cos(deg_to_rad(random_angle)), sin(deg_to_rad(random_angle+0.2))).normalized()
	if abs(direction.angle()) <= 2 and abs(direction.angle()) >= 0.95:
		spawn_direction()
	return direction

#Randomizes the ball speed
func speed_increase():
	if speed *1.2 > Global.BALL_SPEED_CAP:
		speed = Global.BALL_SPEED_CAP
	else:
		speed *= 1.1
	return speed

func movement(delta):
	#print(velocity)
	#Makes the collision
	var collision = move_and_collide(velocity * speed * delta)
	if not collision: return
	if collision:
		bounced_direction(collision)
		animation_player.play(new_ball_bounce_animations[current_new_ball_bounce_animation_number])
		ball_bounce_sfx.pitch_scale = randf_range(0.65, 1.35)
		ball_bounce_sfx.play()
		#FIXME
		#HOW TO DETECT SPECIFIC COLLISIONS
		spawn_bounce_particles(collision.get_position(), collision.get_normal().angle())
	Global.camera.shake(0.25, 15.0, 10.0)
	Input.start_joy_vibration(0, 0.4, 0.2, 0.3)

func bounced_direction(colided_thing):
	velocity = velocity.bounce(colided_thing.get_normal())
	speed = speed_increase()

func spawn_bounce_particles(pos: Vector2, angle: float) -> void:
	var instance = bounce_particles.instantiate()
	get_tree().get_current_scene().add_child(instance)
	instance.global_position = pos
	instance.rotation = angle

func special_ball_chance():
	var random_special_new_ball_chance_number: int = randi_range(1, 20)
	if random_special_new_ball_chance_number > 18:
		current_new_ball_idle_animation_number = 1
		current_new_ball_bounce_animation_number = 1
	else:
		current_new_ball_idle_animation_number = 0
		current_new_ball_bounce_animation_number = 0

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
