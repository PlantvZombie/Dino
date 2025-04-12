extends CharacterBody2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, 200, 5)
	if is_on_floor():
		velocity.y = 0
		$"Dino Sprite".play("run")
	if Input.is_action_just_pressed("up") and is_on_floor():
		$"Dino Sprite".play("jump")
		velocity.y -= 150
	velocity.x = 200
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_released("up"):
		if velocity.y < 0:
			velocity.y *= 0.3


func _on_hitbox_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Obstacles"):
		get_tree().reload_current_scene()
