extends Property 

@export var maximum : int = 100
@export var current : int

# Called when the node enters the scene tree for the first time.
func _ready():
	current = maximum
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func damage_health(amount : int):
	var a = (current - amount)
	a = clampi(current, 0, maximum)
	current = a
	
func heal_health(amount : int):
	var a = (current + amount)
	a = clampi(current, 0, maximum)
	current = a
	
