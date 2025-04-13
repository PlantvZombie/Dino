extends Area2D

var i:int = 0

func _on_dino_ending_sequence() -> void:
	while i < 40:
		global_position.y += 1
		global_position.x -= 5
		await get_tree().create_timer(0.05).timeout
		i += 1
