extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var x = get_viewport_rect().size.x / 2
	var y = get_viewport_rect().size.y / 2
	$xhair.position = Vector2(x, y)

