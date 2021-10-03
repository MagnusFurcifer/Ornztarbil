extends Node


var current_level = 0
onready var level_array = [
	load("res://scenes/world/maps/level_05/map.tscn"),
	load("res://scenes/world/maps/level_02/map.tscn"),
	load("res://scenes/world/maps/level_03/map.tscn"),
	load("res://scenes/world/maps/level_04/map.tscn"),
	load("res://scenes/world/maps/level_05/map.tscn"),
]


var world_manager = null
var player = null


func get_level():
	print("Getting level: " + str(current_level))
	return level_array[current_level]
	
	
	
func next_level():
	print("Moving to next level")
	current_level = current_level + 1
