extends CharacterBody3D

@export var view: Node3D

var move_speed = 250
var move_velocity: Vector3

var gravity:float = 0
var jump_strength = 7

var rotation_direction : float

var previously_floored = false

var jump_single = true
var jump_double = true

@onready var model = $character

func _physics_process(delta):
	handle_controls(delta)
	handle_gravity(delta)
	
	#Movement
	var applied_velocity : Vector3
	#velocity is from CharacterBody
	#Lerp - Returns the result of the linear interpolation between this vector and to by amount weight. 
		#weight is on the range of 0.0 to 1.0, representing the amount of interpolation.
	applied_velocity = velocity.lerp(move_velocity, delta * 10)
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	move_and_slide()
	
	if position.y < -10:
		get_tree().reload_current_scene()

	pass
	
func handle_controls(delta):
	var input := Vector3.ZERO
	
	#Get axis input by specifying two actions, one negative and one positive.
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")
	
	input = input.rotated(Vector3.UP, view.rotation.y).normalized()
	
	move_velocity = input * move_speed * delta
	
	if Input.is_action_just_pressed("jump"):
		if(jump_single): 
			jump()
		
	pass
	
func jump():
	
	gravity = -jump_strength
	
	jump_single = false
	jump_double = true
	
func handle_gravity(delta):
	gravity += 25 * delta
	if gravity > 0 and is_on_floor():
		gravity = 0
		jump_single = true
