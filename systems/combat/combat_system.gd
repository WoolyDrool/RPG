extends Node2D

enum TurnType {PLAYER, PARTY, ENEMY}
@export var turn : TurnType
@export var turnIndex : int = 1

var enemy_configuration

var attack_queue = []
var background_properties = []

signal combat_begin
signal combat_end_turn
signal combat_end

func decide_first():
	pass

func end_turn():
	match(turn):
		TurnType.PLAYER:
			turn = TurnType.ENEMY
		TurnType.ENEMY:
			turn = TurnType.PLAYER
	
	emit_signal("combat_end")
