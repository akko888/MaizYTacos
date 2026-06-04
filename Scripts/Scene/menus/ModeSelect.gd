extends Control

signal backPressed(destination: String)

func _on_back_button_pressed() -> void:
	backPressed.emit("title")

func _on_vs_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scene.tscn")
