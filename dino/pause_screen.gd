extends Control


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_resume_pressed() -> void:
	self.hide()
	Engine.time_scale = 1
