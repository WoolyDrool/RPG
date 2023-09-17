extends Node2D

enum TurnType {PLAYER, PARTY, ENEMY}
@export var turn : TurnType
@export var turnIndex : int = 1
@onready var state_chart : StateChart

var friendly_combatants = []
var enemy_combatants = []

signal combat_begin
signal combat_end_turn
signal combat_end

func _ready():
	state_chart = $StateChart
	decide_first()

func decide_first():
	# TODO add logic for determing turn order based on things like hp/lvl etc
	# For now player always starts first
	pass

func add_combatant(combatant : CombatCharacter, friendly : bool) -> void:
	if friendly:
		print("added ", combatant.character_name, " as an friendly combatant")
		friendly_combatants.append(combatant)
	else:
		print("added ", combatant.character_name, " as an enemy combatant")
		enemy_combatants.append(combatant)



func _on_begin_game_state_entered():
	decide_first()
	print("the game has started")
	state_chart.send_event("turn_player_begin")
	pass # Replace with function body.

func _on_player_turn_state_entered():
	print("it is now the players turn")
	pass # Replace with function body.

func _on_enemy_turn_state_entered():
	pass # Replace with function body.

func _on_background_turns_state_processing(delta):
	pass # Replace with function body.

func end_combat():
	turnIndex = 0
