extends CharacterBody2D

const SPEED = 300.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, 200, 5)
	if is_on_floor():
		velocity.y = 0
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y -= 150
	velocity.x = 200
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_released("up"):
		if velocity.y < 0:
			velocity.y *= 0.3
