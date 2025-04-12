extends CharacterBody2D



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, 200, 5)
	if is_on_floor():
		velocity.y = 0
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y -= 150

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_released("up"):
		if velocity.y < 0:
			velocity.y *= 0.3
	if Input.is_action_pressed("down") and is_on_floor():
		# anim.play(down)
		$Down.set_deferred("disabled", false)
		$Standing.set_deferred("disabled", true)
		print("down")
	elif Input.is_action_just_released("down") and is_on_floor():
		# anim.stop(down)
		$Down.set_deferred("disabled", true)
		$Standing.set_deferred("disabled", false)
		print("down-release")
