extends Node

@export var MAX_HEARTS : int = 3
var current_hearts : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	current_hearts = MAX_HEARTS
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
