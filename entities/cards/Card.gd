extends Sprite2D

class_name Card

@export var card_data : CardData

@onready var label_name : RichTextLabel = $CardName
@onready var label_desc : RichTextLabel = $CardDescription
@onready var label_cost : RichTextLabel = $CardCost
@onready var label_power : RichTextLabel = $CardPower

var properties 

var can_play : bool = false
var deck_manager : DeckManager

signal on_card_play(cname, ccost, catkpwr)

# Called when the node enters the scene tree for the first time.
func _ready():
	init()

func init():
	if card_data:
		label_name.text = card_data.card_name
		label_desc.text = card_data.card_description
		label_cost.text = str(card_data.card_cost) 
		label_power.text = str(card_data.card_atk_power)
		deck_manager = get_parent()
		can_play = true
	else:
		can_play = false
		#print(card_data.card_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_card():
	can_play = false
	emit_signal("on_card_play", card_data.card_name, card_data.card_cost, card_data.card_atk_power)
	# do card stuff
	queue_free()

func _on_area_2d_mouse_entered():
	#can_play = true
	pass # Replace with function body.

func _on_area_2d_mouse_exited():
	#can_play = false
	pass # Replace with function body.

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("attack_primary"):
		if can_play:
			if !(deck_manager.current_action_points - card_data.card_cost) < 0:
				play_card()
			else:
				print("not enough ap")
