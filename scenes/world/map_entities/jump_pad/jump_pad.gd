extends Area

export var bounce = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_jump_pad_body_entered(body):
	GameManager.player.jump_pad_activate(bounce)
