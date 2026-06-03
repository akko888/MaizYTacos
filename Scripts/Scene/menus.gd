extends Control

@onready var screens = {
	"title" : $TitleScreen,
	"mode" : $ModeSelect,
	"char" : $CharSelect,
	"stage" : $StageSelect,
	"gallery" : $Gallery
}

func _ready() -> void:
	go_to("title")

func go_to(screen: String) -> void:
	for s in screens.values():
		s.hide()
	screens[screen].show()


# Buttons functions

func _on_start_button_pressed() -> void:
	go_to("mode")

func _on_vs_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/scene.tscn")

func _on_back_button_pressed() -> void:
	go_to("title")
