
extends CharacterBody3D
class_name Player

# Controller variables
@export var MAX_SPEED = 20
@export var JUMP_SPEED = 18
@export var ACCEL = 4.5
@export var DEACCEL= 16

# Internal variables
var vel = Vector3()
var dir = Vector3()
var input_movement_vector : Vector2

var GRAVITY = -ProjectSettings.get_setting("physics/3d/default_gravity")

# Refs
@export var viewmodel : Node3D

# TODO ----
# 1 Implement a state machine of some kind

func _ready():
	if !viewmodel:	
		viewmodel = $PlayerCollision
	
	CombatSystem.add_combatant($CombatCharacter, true)

func _process(delta):
	process_input(delta)
	handle_rotation()

func _physics_process(delta):
	process_movement(delta)

func process_input(delta):
	dir = Vector3()

	input_movement_vector = Vector2()

	if Input.is_action_pressed("move_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("move_back"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("move_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()

	# Assign to direction
	dir += -transform.basis.z * input_movement_vector.y
	dir += transform.basis.x * input_movement_vector.x

func process_movement(delta):
	# Gravity
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	# Acceleration
	var hvel = vel
	var accel
	var target = dir
	
	hvel.y = 0
	target *= MAX_SPEED
	
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.lerp(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	
	velocity = vel
	move_and_slide()

func handle_rotation():
	if input_movement_vector.y > 0: # Forward
		viewmodel.rotation_degrees = Vector3(0, -180, 0)
	if input_movement_vector.y < 0: # Back
		viewmodel.rotation_degrees = Vector3(0, 0, 0)
	if input_movement_vector.x > 0: # Left
		viewmodel.rotation_degrees = Vector3(0, 90, 0)
	if input_movement_vector.x < 0: # Right
		viewmodel.rotation_degrees = Vector3(0, -90, 0)
