extends CharacterBody3D

var nav : NavigationRegion3D
@onready var nav_agent = $NavigationAgent3D
var target_location : Vector3
var player : Node3D

@export var move_speed = 10.0
@export var accel = 10

# TODO: Extract these functions to a specific pathfinding script

func _ready():
	player = Global.players[0]
	print(player)
	nav_agent.max_speed = move_speed

func _physics_process(delta):
	update_target_position()
	
	if nav_agent.is_target_reachable() and not nav_agent.is_target_reached():
		var direction = nav_agent.get_next_path_position() - global_position
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * move_speed , accel * delta)
		
		move_and_slide()

func apply_damage():
	print("ugh")

func update_target_position():
	if player:
		nav_agent.target_position = player.global_position
	
