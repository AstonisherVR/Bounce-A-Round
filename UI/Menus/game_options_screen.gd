extends Control

@export var player_1_colors_option_dropdown_button: OptionButton
@export var player_2_colors_option_dropdown_button: OptionButton
# Called when the node enters the scene tree for the first time.
func _ready():
	color_options() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#TODO Make the color options
func color_options():
	if player_1_colors_option_dropdown_button.item_selected:
		modulate = Color(1, 1, 5, 1)

