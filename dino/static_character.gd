extends CharacterBody2D

signal dodge

var jump_force = -400
var gravity = 1000
var death = false
var cooldown 
@onready var anim = $"Dino Sprite"
func _ready() -> void:
	get_tree().paused = false
	$"../CanvasLayer/Panel2".visible = false

# Called every frame
func _process(delta):
		# Check for jump
	if get_tree().paused == false:
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = jump_force
			anim.play("jump")
		elif is_on_floor():
			anim.play("run")
			
		velocity.y += gravity * delta
		move_and_slide()

func _input(event: InputEvent) -> void:
	if get_tree().paused == false:
		if event.is_action_released("up"):
			if velocity.y < 0:
				velocity.y *= 0.6
		if Input.is_action_just_pressed("down"):
			velocity.y += 210
			if is_on_floor():
				anim.stop()
				anim.play("dodje")
				cooldown = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up") and death == true:
		get_tree().reload_current_scene()
		death = false


func _on_hitbox_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("Obstacles"):
		death = true
		$"Dino Sprite".set_speed(1)
		$"Dino Sprite".play("die")
		$"../CanvasLayer/Panel2".visible = !$"../CanvasLayer/Panel2".visible
		$"../CanvasLayer/Panel2/BigHighScore".text = "High Score: " + str(Global.save_data.high_score)
		get_tree().paused = true
		await get_tree().create_timer(0.5).timeout
