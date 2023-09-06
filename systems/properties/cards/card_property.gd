extends Node

class_name CardProperty

var property_name : String = "Default Card Property"

var card

enum ActivationType {IMMEDIATE, NEXTTURN, OTHER}
var activation : ActivationType

var turnWhenPlayed

# Called when the node enters the scene tree for the first time.
func _ready():
	card = get_parent()
	card.connect("on_play_card", activate_property())
	pass # Replace with function body.

func activate_property():
	match(activation):
		ActivationType.IMMEDIATE:
			immediate()
		ActivationType.NEXTTURN:
			defer_turn()
		ActivationType.OTHER:
			special_condition()
	
func immediate() -> void:
	print("This card did something the turn it was played")
	pass

func defer_turn() -> void:
	print("This card will do something next turn")
	turnWhenPlayed = CombatSystem.turnIndex
	await(CombatSystem.turnIndex == turnWhenPlayed+1)
	activate_delayed()

func activate_delayed() -> void:
	pass

func special_condition() -> void:
	print("This card does something unique")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

