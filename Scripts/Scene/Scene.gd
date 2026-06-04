extends Node2D

func _ready() -> void:
	$GUI/Progress_Bars/Bar1/TextureProgressBar.setup($Player1)
	$GUI/Progress_Bars/Bar2/TextureProgressBar2.setup($Player2)
	
	$Player1.died.connect(_on_player_died.bind("Player 1 wins!!"))
	$Player2.died.connect(_on_player_died.bind("Player 2 wins !!"))


func _on_player_died(winnerText: String):
	print(winnerText)
