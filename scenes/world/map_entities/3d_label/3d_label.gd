extends Spatial

export var text = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Viewport/Control.get_node("Label").text = text
