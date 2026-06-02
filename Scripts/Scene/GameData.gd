extends Node

var player1_stats: CharacterStats = null
var player2_stats: CharacterStats = null
var selected_Stage: String = ""

func reset() -> void:
	player1_stats = null
	player2_stats = null
	selected_Stage = ""
