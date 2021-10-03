extends Area

var speed : float = 10.0
var parent_entity
var x_speed
var y_speed
var dying = false

func _ready():
	$death_timer.start()
	
func _on_projectile_body_entered(body):
	if body != parent_entity:
		if body.is_in_group("shootable"):
			body.hit()
		print(body)
		destroy()
		
func set_parent_entity(entity):
	parent_entity = entity
	pass
		
func _physics_process(delta):
	translation -= global_transform.basis.z * speed * delta
	if x_speed:
		translation -= global_transform.basis.x * x_speed * delta
	if y_speed:
		translation -= global_transform.basis.y * y_speed * delta
		
func _on_life_timeout():
	destroy()
	
func destroy():
	$death_particles.emitting = true
	dying = true
	
func _process(delta):
	if $death_particles.emitting == false and dying:
		queue_free()

func _on_projectile_area_entered(area):
	print("AREAA ENTERED")
	area.queue_free()
	self.queue_free()
