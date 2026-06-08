extends TextureButton

signal pauseRequested

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pressed.connect(_on_pressed)
	
func _on_pressed() -> void:
	print("Pressed")
	pauseRequested.emit()
