extends Control

signal stageConfirmed(stage: String)

var selectedStage = {}

func _ready() -> void:
	for stage in GameData.Stages:
		var btn = Button.new()
		btn.text = stage["name"]
		btn.add_theme_font_size_override("font_size", 32)
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.735, 0.127, 0.16, 1.0) 
		btn.add_theme_stylebox_override("normal", style)
		btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		btn.custom_minimum_size = Vector2(300, 80)
		btn.pressed.connect(_on_stage_selected.bind(stage))
		$StageContainer.add_child(btn)

func _on_stage_selected(stage: Dictionary) -> void:
	selectedStage = stage
	$PreviewLabel.text = stage["name"]
	$PlayButton.disabled = false

func _on_play_button_pressed() -> void:
	stageConfirmed.emit(selectedStage["path"])
	
