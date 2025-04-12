extends CharacterBody2D

var jump_force = -400
var gravity = 1000

# Called every frame
func _process(delta):
	# Check for jump
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_force
	velocity.y += gravity * delta
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_released("up"):
		if velocity.y < 0:
			velocity.y *= 0.6
	if Input.is_action_just_pressed("down"):
		# anim.play(down)
		velocity.y += 210
		if (is_on_floor()):
			$Down.set_deferred("disabled", false)
			$Standing.set_deferred("disabled", true)
			print("down")
	elif Input.is_action_just_released("down") and is_on_floor():
		# anim.stop(down)
		$Down.set_deferred("disabled", true)
		$Standing.set_deferred("disabled", false)
		print("down-release")


func _on_hitbox_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Obstacles"):
		velocity = Vector2.ZERO
		$"Dino Sprite".play("die")
		await get_tree().create_timer(0.5).timeout   
		get_tree().reload_current_scene()
