extends CharacterBody2D

signal dodge

var jump_force = -400
var gravity = 1000
var death = false
var cooldown 

func _ready() -> void:
	get_tree().paused = false

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
		velocity.y += 210
		if is_on_floor() and !cooldown:
			dodge.emit()
			cooldown = true


func _on_hitbox_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Obstacles"):
		death = true
		$"Dino Sprite".set_speed(1)
		$"Dino Sprite".play("die")
		get_tree().paused = true
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
		death = false
