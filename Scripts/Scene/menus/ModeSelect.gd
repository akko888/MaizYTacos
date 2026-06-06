extends Control

signal onModePressed

func _on_back_button_pressed() -> void:
	onModePressed.emit("title")

func _on_vs_button_pressed() -> void:
	onModePressed.emit("char")
