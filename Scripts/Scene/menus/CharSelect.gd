extends Control

signal characterConfirmed(p1Path: String, p2Path: String)

@onready var containter1 = $Player1Chars
@onready var container2 = $Playe2Chars
@onready var confirmButton = $ConfirmButton

var p1selection: String = ""
var p2selection: String = ""

const CardUI = preload("res://Scenes/GUI/CardUI.tscn")

func _ready() -> void:
	confirmButton.disabled = true
	confirmButton.pressed.connect(_on_confirm_button_pressed)
	for character in GameData.CHARACTERS:
		_add_card(character, containter1, 1)
		_add_card(character, container2, 2)

func _add_card(character: Dictionary, container: Node, player: int) -> void:
	var card = CardUI.instantiate()
	container.add_child(card)
	card.setup(character)
	card.cardSelected.connect(_on_card_selected.bind(player))

func _on_card_selected(statsPath: String, player: int) -> void:
	if player == 1:
		p1selection = statsPath
	else:
		p2selection = statsPath
	
	confirmButton.disabled = p1selection.is_empty() or p2selection.is_empty()

func _on_confirm_button_pressed() -> void:
	characterConfirmed.emit(p1selection, p2selection)
