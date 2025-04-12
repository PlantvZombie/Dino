extends Area2D

func _physics_process(delta: float) -> void:
	position += transform.x * ($/root/Global.speed * 1.49) * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var viewport_size = get_viewport().get_size()
	
	# Check if the node is outside the screen
	if position.x < -1000 or position.x > viewport_size.x or position.y < -1000 or position.y > viewport_size.y:
		queue_free()
