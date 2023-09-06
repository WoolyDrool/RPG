extends Node2D

@export var chaotic : bool = false
@export var windup : float
@export var windup_min : float #chaotic
@export var windup_max : float #chaotic
var calculated_windup : float #chaotic

@export var speed : float
@export var speed_min : float #chaotic
@export var speed_max : float #chaotic
var calculated_speed : float #chaotic

@export var damage : int
@export var damage_min : int #chaotic 
@export var damage_max : int #chaotic
var calculated_damage : int #chaotic

# Internal variables
@onready var windup_timer = $WindupTimer
var rng = RandomNumberGenerator.new()
var process : bool = false

@onready var scanner = $Scanner
var scanner_start_pos : Vector2
var scanner_end_pos : Vector2

@onready var hitbox =  $Hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	#init()
	pass # Replace with function body.

func init():
	calculate_values()
	
	scanner_start_pos = $StartPos.position
	scanner_end_pos = $EndPos.position
	scanner.position = scanner_start_pos
	
	windup_timer.wait_time = calculated_windup
	windup_timer.start()

func calculate_values():
	if !chaotic:
		calculated_windup = windup
		calculated_speed = speed
		calculated_damage = damage
	else: #chaotic
		calculated_windup = rng.randf_range(windup_min, windup_max)
		calculated_speed = rng.randf_range(speed_min, speed_max)
		calculated_damage = rng.randf_range(damage_min, damage_max)
	
	print(calculated_windup, calculated_speed, calculated_damage)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if process:
		scanner.position = lerp(scanner.position, scanner_end_pos, speed * 0.1)

func _input(event):
	#if Input.is_action_just_pressed("attack_primary"):
	#	init()
	pass

func _on_hitbox_area_entered(area):
	print("got hit for ", calculated_damage," damage")

func _on_windup_timer_timeout():
	process = true
