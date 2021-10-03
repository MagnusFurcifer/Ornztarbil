extends Spatial

var min_clouds = 128
onready var cloud_object = load("res://scenes/world/cloud/cloud.tscn")

var height_range = 20
var width_range = 30
var length_range = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if $cloud_spawn_timer.time_left == 0:
		if $clouds.get_child_count() < min_clouds:
			randomize()
			var new_cloud = cloud_object.instance()
			new_cloud.global_transform.origin = self.global_transform.origin + Vector3(rand_range(-width_range, width_range), rand_range(-height_range, height_range), rand_range(-length_range, length_range))
			$clouds.add_child(new_cloud)
			$cloud_spawn_timer.start()
		
