extends CharacterBody3D

var nav : NavigationRegion3D
@onready var nav_agent = $NavigationAgent3D
var target_location : Node3D
var player 

var move_speed = 10.0
var move_vec : Vector3

# TODO: Extract these functions to a specific pathfinding script

func _ready():
	player = get_tree().root.get_nodes_in_group("Player")
	nav_agent.target_position = target_location.global_position

func _physics_process(delta):
	if nav_agent.is_target_reachable() and not nav_agent.is_target_reached():
		var next_location = nav_agent.get_next_path_position()
		var direction = global_position.direction_to(next_location)
		global_position += direction * delta

func apply_damage():
	var path = nav.get_pat
	print("ugh")

func update_target_position():
	
