extends Spatial

onready var enemy_object = load("res://scenes/entities/shootyboi/shootyboi.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_map()

func reset_map():
	#Reset all falling tiles to their standard position
	for i in $active_tiles.get_children():
		i.block_enable()
		
	#Reset all enemies
	for i in $enemy_spawns.get_children():
		for x in i.get_children():
			x.queue_free()
		var tmp = enemy_object.instance()
		i.add_child(tmp)
		tmp.global_transform.origin = i.global_transform.origin
		
	for i in $doors.get_children():
		i.reset_door()
