extends Area2D

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	delta *= $/root/Global.speed_factor
	position += transform.x * ($/root/Global.speed / 2) * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta *= $/root/Global.speed_factor
	var viewport_size = get_viewport().get_size()
	
	# Check if the node is outside the screen
	if position.x < -500 or position.x > viewport_size.x or position.y < -500 or position.y > viewport_size.y:
		queue_free()
	if Global.speed_factor == 0.0:
		queue_free()
