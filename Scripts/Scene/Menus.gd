extends Control

var currentScene: String = "title"

@onready var screens = {
	"title" : $TitleScreen,
	"mode" : $ModeSelect,
	"char" : $CharSelect,
	"stage" : $StageSelect,
	"gallery" : $Gallery
}

func _ready() -> void:
	$TitleScreen.startPressed.connect(_on_navigation_button_pressed)
	$ModeSelect.onModePressed.connect(_on_navigation_button_pressed)
	$CharSelect.onCharPressed.connect(_on_navigation_button_pressed)
	$CharSelect.characterConfirmed.connect(_on_character_confirmed)
	$StageSelect.stageConfirmed.connect(_on_stage_confirmed)
	go_to("title")

func go_to(screen: String) -> void:
	var music_map = {
		"title" :  "main_menu",
		"mode": "main_menu",
		"char": "char_select",
		"stage": "char_select"
	}
	
	if music_map.has(screen):
		AudioManager.play_music(music_map[screen])
	var tween = create_tween()
	tween.tween_property(screens[currentScene],"modulate:a", 0.0, 0.15)
	tween.tween_callback(func():
		for s in screens.values(): s.hide()
		screens[screen].show()
	)
	tween.tween_property(screens[screen],"modulate:a", 1.0, 0.15)
	currentScene = screen

func _on_navigation_button_pressed(destination: String) -> void:
	AudioManager.play_sfx("button")
	go_to(destination)

func _on_stage_confirmed(stagePath: String) -> void:
	AudioManager.play_sfx("button")
	GameData.selected_Stage = stagePath
	get_tree().change_scene_to_file(GameData.selected_Stage)

func _on_character_confirmed(p1Path: String, p2Path: String) -> void:
	AudioManager.play_sfx("button")
	GameData.player1_stats = load(p1Path)
	GameData.player2_stats = load(p2Path)
	go_to("stage")
