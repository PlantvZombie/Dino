extends Node2D

var shown:bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc") and !shown:
		$"Dino/Pause Screen".show()
		Engine.time_scale = 0
