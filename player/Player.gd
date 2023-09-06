
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
var cam_input : Vector2
var rotation_velocity : Vector2
var input_movement_vector : Vector2

var GRAVITY = -ProjectSettings.get_setting("physics/3d/default_gravity")

# Refs
@export var viewmodel : Node3D

# TODO ----
# 1 Implement a state machine of some kind

func _ready():
	if !viewmodel:	
		viewmodel = $PlayerCollision

func _process(delta):
	process_input(delta)

func _physics_process(delta):
	process_movement(delta)

func process_input(delta):
	# ----------------------------------
	# Walking
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

	# Basis vectors are already normalized.
	dir += -transform.basis.z * input_movement_vector.y
	dir += transform.basis.x * input_movement_vector.x
	# ----------------------------------

	# ----------------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("move_jump"):
			vel.y = JUMP_SPEED
	# ----------------------------------


func process_movement(delta):
	# Gravity
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	# Acceleration
	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.lerp(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	
	velocity = vel
	move_and_slide()
