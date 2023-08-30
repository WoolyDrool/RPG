extends Node

@onready var raycaster : RayCast3D = $AttackRaycast
@onready var timer = $AttackTimer

@export var _can_attack : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_attacks()

func _handle_attacks():
	if _can_attack:
		if Input.is_action_just_pressed("attack_primary"):
			_primary()
			_can_attack = false

func _primary() -> void:
	print("primary attack")
	if raycaster.is_colliding:
		var col = raycaster.get_collider()
		print("hit ", col)
	timer.start()
	
func _on_attack_timer_timeout():
	_can_attack = true
	pass # Replace with function body.
