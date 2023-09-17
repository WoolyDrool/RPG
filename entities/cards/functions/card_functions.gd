extends Node

class_name CardFunction

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("on_card_play", _activate_card_function.bind())
	pass # Replace with function body.

func _activate_card_function(target): # use this method to do things
	print(target)
	pass

