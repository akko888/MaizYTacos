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
