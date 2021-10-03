extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	#$shoot_cast.cast_to = GameManager.player.global_transform.origin
	#$shoot_cast.force_raycast_update()
	#if $shoot_cast.is_colliding():
	#	print($shoot_cast.get_collider())
	pass
	
func hit():
	queue_free()
	
func shoot_at_player():
	var projectile = preload("res://scenes/entities/shootyboi/subscene/projectile.tscn").instance()
	var projectile_transform = self
	projectile.global_transform = projectile_transform.global_transform
	projectile.set_parent_entity(self)
	get_tree().root.add_child(projectile)
	pass
	
func _physics_process(delta):
	look_at(GameManager.player.global_transform.origin, Vector3.UP)

func _on_aiming_timer_timeout():
	var space_state = get_world().get_direct_space_state()
	#Added a bit to the dst vector to try get the bullet to go closer to my face
	var hit = space_state.intersect_ray(global_transform.origin, GameManager.player.global_transform.origin + Vector3(0, .5, 0)) #this is raycasting
	if hit:
		if hit.collider.is_in_group("player"):
			shoot_at_player()
	
