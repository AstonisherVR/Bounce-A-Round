extends StaticBody2D

@export var wall_animation: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	wall_animation.play("Idle Wall")

# Called every frame. 'delta' is the elapsed time since the previous frame.
