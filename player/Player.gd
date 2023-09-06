# Code from Godot docs FPS tutorial

extends CharacterBody3D
class_name Player

# Controller variables
@export var MAX_SPEED = 20
@export var JUMP_SPEED = 18
@export var ACCEL = 4.5
@export var DEACCEL= 16
@export var MAX_SLOPE_ANGLE = 40

# Camera variables
@export var MOUSE_SENSITIVITY = 0.05
@export var MOUSE_SMOOTHING = 10

# Internal variables
var GRAVITY = -ProjectSettings.get_setting("physics/3d/default_gravity")
var vel = Vector3()
var dir = Vector3()
var cam_input : Vector2
var rotation_velocity : Vector2

# Refs
@export var camera : Node3D
@export var rotation_helper : Node3D

# TODO ----
# 1 Make angles/sliding feel better. Its very snappy and locky and Skyrim-y, for lack of a better word
# 2 Implement a state machine of some kind
# 3 Procedural headbob/crouch animations

func _ready():
	#if !camera:
	#	camera = $CamHolder/Camera3D
	if !rotation_helper:	
		rotation_helper = $CamHolder

	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):
	# ----------------------------------
	# Walking
	dir = Vector3()

	var input_movement_vector = Vector2()

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

	# ----------------------------------
	# Capturing/Freeing the cursor
	#if Input.is_action_just_pressed("ui_cancel"):
	#	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
	#		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#	else:
	#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
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

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		cam_input = event.relative
		
func _process(delta):
	#rotation_velocity = rotation_velocity.lerp(cam_input * MOUSE_SENSITIVITY, delta * MOUSE_SMOOTHING)
	#rotation_helper.rotate_y(-deg_to_rad(rotation_velocity.x))

	cam_input = Vector2.ZERO
