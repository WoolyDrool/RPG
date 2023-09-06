extends Node

class_name DeckManager

@export var user : CombatCharacter

var current_action_points = 12

func _ready():
	for i in self.get_children():
		if i.is_in_group("Cards"):
			var card : Card = i
			card.on_card_play.connect(draw_card)
			card.deck_manager = self
			print("registered ", card)
			card = null
		else:
			return
		
		
func draw_card(played_card_name : String, played_card_cost : int, played_card_atkpwr : int):
	print("played ", played_card_name, " for ", played_card_cost, " and did ", played_card_atkpwr)
	current_action_points -= played_card_cost
	$ActionPoints.text = str(current_action_points)
	pass
	
	
