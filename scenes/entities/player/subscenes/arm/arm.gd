extends Spatial


onready var anim_player = $AnimationPlayer
onready var particles_shoot = $Cube/CPUParticles

var is_shooting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func shoot():
	if !is_shooting:
		anim_player.play("shoot")
		#particles_shoot.restart()
		particles_shoot.emitting = true
		is_shooting = true
		var projectile = preload("res://scenes/entities/player/subscenes/arm/projectile.tscn").instance()
		var projectile_transform = get_parent()
		projectile.global_transform = projectile_transform.global_transform
		projectile.set_parent_entity(GameManager.player)
		get_tree().root.add_child(projectile)
		$shoot.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "shoot":
		anim_player.play("idle")
		is_shooting = false
		pass
