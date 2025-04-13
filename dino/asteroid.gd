extends Area2D

var i:int = 0
var tween
var touching:bool = false

func _on_dino_ending_sequence() -> void:
	while i < 40:
		global_position.y += 1
		global_position.x -= 5
		await get_tree().create_timer(0.05).timeout
		i += 1

func _on_dino_game_end() -> void:
	await get_tree().create_timer(1).timeout
	global_position = Vector2(300, -50)
	while !touching:
		await get_tree().create_timer(0.01).timeout
		global_position.y = move_toward(global_position.y, $"/root/Global".DinoPos.y, 1.15)
		global_position.x = move_toward(global_position.x, $"/root/Global".DinoPos.x, 1)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Dino":
		touching = true
