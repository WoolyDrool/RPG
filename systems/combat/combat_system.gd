extends Node2D

enum TurnType {PLAYER, PARTY, ENEMY}
@export var turn : TurnType
@export var turnIndex : int = 1
@export var state_chart : StateChart

var friendly_combatants = []
var enemy_combatants = []

var enemy_configuration

var attack_queue = []

signal combat_begin
signal combat_end_turn
signal combat_end

func _ready():
	#state_chart = $StateChart
	print(state_chart)
	decide_first()

func decide_first():
	# TODO add logic for determing turn order based on things like hp/lvl etc
	# For now player always starts first
	state_chart.send_event("turn_player_begin")
	pass

func _on_begin_game_state_entered():
	pass # Replace with function body.


func _on_player_turn_state_entered():
	print("it is now the players turn")
	pass # Replace with function body.


func _on_enemy_turn_state_entered():
	pass # Replace with function body.
