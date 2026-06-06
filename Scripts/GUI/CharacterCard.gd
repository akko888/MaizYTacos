extends TextureButton

signal cardSelected(statsPath: String)

@onready var label = $Label
@onready var portrait = $TextureRect

func setup(data: Dictionary) -> void:
	label.text = data["name"]
	portrait.texture = data["preview"]
	pressed.connect(_on_pressed.bind(data["stats"]))

func _on_pressed(statsPath: String) -> void:
	cardSelected.emit(statsPath)
