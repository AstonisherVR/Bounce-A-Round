extends GPUParticles2D

@onready var bounce_particles_follow_up = $"Bounce Particles Follow Up"

func _ready():
	emitting = true
	bounce_particles_follow_up.emitting = true
	await get_tree().create_timer(bounce_particles_follow_up.lifetime + 1.0).timeout
	queue_free()
