extends Control

signal startPressed(destination: String)

func _on_start_button_pressed() -> void:
	startPressed.emit("mode")
