extends Node2D

const PasueMenu = preload("res://Scenes/GUI/PauseMenu.tscn")
var pasueMenu: Control

func _ready() -> void:
	
	var scene_music_map = {
		"res://Scenes/Phase1.tscn" : "phase1",
		"res://Scenes/Phase2.tscn" : "phase2",
	}
	var current = get_tree().current_scene.scene_file_path
	if scene_music_map.has(current):
		AudioManager.play_music(scene_music_map[current])
	
	$Player1.stats = GameData.player1_stats
	$Player2.stats = GameData.player2_stats
	
	$Player1.initialize()
	$Player2.initialize()
	
	$GUI/MainGUI/P1.text = $Player1.stats.name
	$GUI/MainGUI/P2.text = $Player2.stats.name
	
	$GUI/MainGUI/Bar1/TextureProgressBar.setup($Player1)
	$GUI/MainGUI/Bar2/TextureProgressBar2.setup($Player2)
	
	$Player1.died.connect(_on_player_died.bind("Player 1 wins!!"))
	$Player2.died.connect(_on_player_died.bind("Player 2 wins !!"))
	
	pasueMenu = PasueMenu.instantiate()
	pasueMenu.resumePressed.connect(_toogle_pause.bind(false))
	pasueMenu.exitPressed.connect(_on_exit)
	add_child(pasueMenu)
	
	$GUI/PauseButton.pauseRequested.connect(_toogle_pause.bind(true))


func _on_player_died(winnerText: String):
	$GUI/WinLabel.text = winnerText
	
	await get_tree().create_timer(1.5).timeout
	GameData.reset()
	get_tree().change_scene_to_file("res://Scenes/Menus.tscn")

func _toogle_pause(isPaused: bool) -> void:
	get_tree().paused = isPaused
	if isPaused:
		pasueMenu.show()
	else:
		pasueMenu.hide()

func _on_exit() -> void:
	get_tree().paused = false
	GameData.reset()
	get_tree().change_scene_to_file("res://Scenes/Menus.tscn")
