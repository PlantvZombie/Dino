extends CharacterBody2D

signal dodge
signal EndingSequence
var death:bool = false
var dodging:bool = false
var cooldown:bool = false
var cutscene:bool = false
var first:bool = true
var DeathCounter:int = 0
var MoveDir:int = 1
var Deathpos:Vector2 = Vector2(100, 180)

func _ready() -> void:
	death = false
	dodging = false
	cooldown = false
	cutscene = false
	$"Dino Sprite".play("jump")
	DeathCounter = 0

func _physics_process(_delta: float) -> void:
	$"Camera/Death Counter".text = "Deaths: " + str(DeathCounter)
	if global_position.x >= 15200 and first:
		cutscene = true
		EndingSequence.emit()
		first = false
	if !death and !cutscene:
		if not is_on_floor():
			$"Dino Sprite".set_speed(1)
			$"Dino Sprite".play("jump")
			velocity.y = move_toward(velocity.y, 250, 5)
		if is_on_floor():
			velocity.y = 0
			if !dodging:
				$"Dino Sprite".play("run")
				$"Dino Sprite".set_speed(2)
		if Input.is_action_pressed("up") and is_on_floor():
			$"Dino Sprite".set_speed(1)
			$"Dino Sprite".play("jump")
			velocity.y -= 175
		velocity.x = 200 * MoveDir
		if Input.is_action_pressed("down") and is_on_floor() and !cooldown:
			dodge.emit()
			cooldown = true
	move_and_slide()
func _input(event: InputEvent) -> void:
	if event.is_action_released("up"):
		if velocity.y < 0:
			velocity.y *= 0.6
func Dodge():
	dodging = true
	$"Dino Sprite".set_speed(0.5)
	$"Dino Sprite".play("dodje")
	if $"Dino Sprite".frame == 0:
		$"Hitbox Detection".position.y += 2.5
		$"Hitbox Detection".scale = Vector2(1.5, 0.75)
	await get_tree().create_timer(0.4).timeout
	$"Hitbox Detection".scale = Vector2(1, 1)
	dodging = false
	$"Hitbox Detection".position.y -= 2.5
	await get_tree().create_timer(0.1).timeout
	cooldown = false
func _on_hitbox_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Obstacles"):
		death = true
		velocity = Vector2(0, 0)
		$"Dino Sprite".set_speed(1)
		$"Dino Sprite".play("die")
		await get_tree().create_timer(0.5).timeout   
		self. global_position = Deathpos
		DeathCounter += 1
		death = false

func _on_ending_sequence() -> void:
	$"Dino Sprite".play("jump")
	velocity.y = 0
	velocity.x = 0
	MoveDir = -1
	Deathpos = Vector2 (15200, 180)
	$"Camera".zoom = Vector2(1.75, 1.75)
	await get_tree().create_timer(1).timeout
	$"Dino Sprite".play("die")
	await get_tree().create_timer(1).timeout
	$"Dino Sprite".scale.x = -0.197
	cutscene = false
	$"Camera".zoom = Vector2(2, 2)
