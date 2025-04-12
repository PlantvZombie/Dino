extends Node2D


func _process(delta):
	if Input.is_action_pressed("esc"):
		get_tree().quit()


func _on_story_pressed() -> void:
	get_tree().change_scene_to_file("res://story_mode.tscn")

func _on_endless_pressed() -> void:
	get_tree().change_scene_to_file("change path pls")
