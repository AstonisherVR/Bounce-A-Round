class_name SceneRegistry extends Node

# note I don't know if I'm going to like this structure, but we're going to field test it with this version.
# The idea is to centrailze these strings so that if/when I refactor the game I only
# have to change these in on place. (spoiler alert: I'm not a huge fan of find and replace)
# so we're going to minimize how much/often we have to use that until Godot gets proper refactoring :)

const main_scenes = {
	"StartScreen": "res://UI/Menus/main_menu.gd"
}

const levels = {
	"game_start" : "res://game.tscn"
}