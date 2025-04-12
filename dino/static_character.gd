extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
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

	move_and_slide()
