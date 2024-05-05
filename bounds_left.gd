extends Area2D

@export var glowing_void_left: AnimationPlayer
@export var player_2_score_label: Label
@export var score_sfx: AudioStreamPlayer2D

func _ready() -> void:
	glowing_void_left.play("Idle")

#Checks to see if the ball is touching the void on the left
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ball"): 
		if Global.current_ball_bounce_animation_number == 0:
			Global.player_2_score_number += 1
		else:
			Global.player_2_score_number += 5
		body.special_ball_chance()
		body.spawn_parameters()
		body.velocity = body.spawn_direction()
		glowing_void_left.play("Glowing")
		score_sfx.play()
		player_2_score_label.text = str(Global.player_2_score_number)
 
	if body.is_in_group("New Ball"):
		if body.current_new_ball_idle_animation_number == 0:
			print("NEW BALL IS NOT SPECIAL ", body.current_new_ball_idle_animation_number)
			Global.player_2_score_number += 1
		else:
			print("NEW BALL IS SPECIAL ", body.current_new_ball_idle_animation_number)
			Global.player_2_score_number += 5
		glowing_void_left.play("Glowing")
		score_sfx.play()
		player_2_score_label.text = str(Global.player_2_score_number)
