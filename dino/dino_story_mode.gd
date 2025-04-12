extends CharacterBody2D

signal dodge
var death:bool = false
var dodging:bool = false
var cooldown:bool = false

func _ready() -> void:
	death = false
	dodging = false
	cooldown = false
	$"Dino Sprite".play("jump")

func _physics_process(_delta: float) -> void:
	if !death:
		if not is_on_floor():
			$"Dino Sprite".play("jump")
			velocity.y = move_toward(velocity.y, 250, 5)
		if is_on_floor():
			velocity.y = 0
			if !dodging:
				$"Dino Sprite".play("run")
		if Input.is_action_just_pressed("up") and is_on_floor():
			$"Dino Sprite".play("jump")
			velocity.y -= 175
		velocity.x = 200
		if Input.is_action_just_pressed("down") and is_on_floor() and !cooldown:
			dodge.emit()
			cooldown = true
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_released("up"):
		if velocity.y < 0:
			velocity.y *= 0.6

func Dodge():
	dodging = true
	$"Dino Sprite".play("dodje")
	if $"Dino Sprite".frame == 0:
		$"Hitbox Detection".position.y += 2.5
		$"Hitbox Detection".scale = Vector2(1.5, 0.75)
	await get_tree().create_timer(0.2).timeout
	if $"Dino Sprite".frame == 1:
		$"Hitbox Detection".scale = Vector2(1, 0.75)
	await get_tree().create_timer(0.2).timeout
	$"Hitbox Detection".scale = Vector2(1, 1)
	dodging = false
	$"Hitbox Detection".position.y -= 2.5
	await get_tree().create_timer(0.1).timeout
	cooldown = false

func _on_hitbox_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Obstacles"):
		death = true
		velocity = Vector2(0, 0)
		$"Dino Sprite".play("die")
		await get_tree().create_timer(0.5).timeout   
		get_tree().reload_current_scene()
