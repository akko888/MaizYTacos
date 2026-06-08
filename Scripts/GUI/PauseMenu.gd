extends Control

signal resumePressed
signal exitPressed

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	hide()

func _on_resume_pressed() -> void:
	resumePressed.emit()

func _on_exit_pressed() -> void:
	exitPressed.emit()
