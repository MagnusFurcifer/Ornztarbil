extends Area



# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_on_finish_line_body_entered")


func _on_finish_line_body_entered(body):
	if body.is_in_group("player"):
		self.disconnect("body_entered", self, "_on_finish_line_body_entered")
		GameManager.world_manager.player_finished()
