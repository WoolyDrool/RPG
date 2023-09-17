extends Node

class_name CombatCharacter

@export var character_name : String = "Default Combat Character"
@export var deck : Deck

signal on_health_change(new_value)
signal on_ap_change(new_value)

# Combat Variables
var character_max_health : int = 20
@export var character_health : int = 1:
	set(change):
		character_health = clamp(change, 0, character_max_health)
		emit_signal("on_health_change", character_health)
	get:
		return character_health

var character_max_ap : int = 20
@export var character_ap : int = 1:
	set(change):
		character_ap = clamp(change, 0, character_max_ap)
		emit_signal("on_ap_change", character_ap)
	get:
		return character_health

@export var is_player : bool = false
var can_act : bool = true

var next_turn_dodges = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# State Changes
func disable_actions():
	can_act = false

func enable_actions():
	can_act = true
