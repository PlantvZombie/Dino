extends Control


func _ready() -> void:
	$Panel.hide()

func _process(delta):
	if Input.is_action_pressed("esc"):
		get_tree().quit()


func _on_story_pressed() -> void:
	get_tree().change_scene_to_file("res://story_mode.tscn")

func _on_endless_pressed() -> void:
	get_tree().change_scene_to_file("res://dino endless mode.tscn")


func _on_settings_pressed() -> void:
	$Panel.show()


func _on_close_pressed() -> void:
	$Panel.hide()
