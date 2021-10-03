extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset_map():
	#Reset all falling tiles to their standard position
	for i in $active_tiles.get_children():
		i.block_enable()
		pass
	pass
