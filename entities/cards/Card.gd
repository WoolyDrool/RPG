extends Sprite2D

class_name Card

@export var card_data : CardData

@onready var label_name : RichTextLabel = $CardName
@onready var label_desc : RichTextLabel = $CardDescription
@onready var label_cost : RichTextLabel = $CardCost
@onready var label_power : RichTextLabel = $CardPower

var properties 

var deckman
var can_play : bool = false

signal on_play_card

# Called when the node enters the scene tree for the first time.
func _ready():
	if card_data:
		label_name.text = card_data.card_name
		label_desc.text = card_data.card_description
		label_cost.text = str(card_data.card_cost) 
		label_power.text = str(card_data.card_atk_power)
		can_play = true
		deckman = get_parent()
	else:
		can_play = false
		#print(card_data.card_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_card():
	can_play = false
	emit_signal("on_play_card")
	# do card stuff
	queue_free()

func _on_area_2d_mouse_entered():
	#can_play = true
	pass # Replace with function body.

func _on_area_2d_mouse_exited():
	#can_play = false
	pass # Replace with function body.

func _on_area_2d_input_event(viewport, event, shape_idx):
	if can_play:
		if Input.is_action_just_pressed("attack_primary"):
			play_card()
