extends CharacterBody3D

#Signals are a way for objects to communicate with each other without relying on direct references
signal coin_collected

@export var view : Node3D
@export var coins := 0
@export var bullet : PackedScene
@export var shoot_speed : float

var move_speed = 250
var move_velocity: Vector3

var gravity:float = 0
var jump_strength = 7

var rotation_direction : float

var previously_floored = false

var jump_single = true
var jump_double = true

var move_joystick : Vector3

@onready var model = $character
@onready var bullet_spawner = $character/BulletSpawner
@onready var animation := $character/AnimationPlayer
@onready var animation_tree := $character/AnimationTree

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
	handle_effects()

	if position.y < -10:
		get_tree().reload_current_scene()
		
	model.scale = model.scale.lerp(Vector3(1,1,1), delta * 10)
	
	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25, 0.75, 1.25)
		
	previously_floored = is_on_floor()
	
	if Vector2(velocity.z, velocity.x).length() > 0:
		rotation_direction = Vector2(velocity.z, velocity.x).angle()
		
	rotation.y = lerp_angle(rotation.y, rotation_direction, delta * 10)

	pass
	
func handle_effects():
	if is_on_floor():
		#This changes negative velocity to positive so we can accurately check if the player is moving
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			animation_tree["parameters/WalkBlend/blend_amount"] = 1
			#animation.play("CustomAnimations/CustomWalk", 0.5)
		else:
			animation_tree["parameters/WalkBlend/blend_amount"] = 0
			#animation.play("CustomAnimations/CustomIdle", 0.5)
	else:
		if !animation_tree.get("parameters/OneShot/active"):
			animation_tree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		#animation.play("CustomAnimations/CustomJump", 0.5)

func handle_controls(delta):
	var input := Vector3.ZERO
	
	#Get axis input by specifying two actions, one negative and one positive.
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")
	
	if move_joystick == Vector3.ZERO:
		input = input.rotated(Vector3.UP, view.rotation.y).normalized()
	else:
		input = move_joystick.rotated(Vector3.UP, view.rotation.y).normalized()
	
	move_velocity = input * move_speed * delta
	
	if Input.is_action_just_pressed("shoot"):
		var shot = bullet.instantiate()
		owner.add_child(shot)
		shot.global_position = bullet_spawner.global_position
		var velocity_vector = (bullet_spawner.global_position - Vector3(global_position.x, bullet_spawner.global_position.y, global_position.z)).normalized()
		shot.RB.linear_velocity = velocity_vector * shoot_speed
		
	if Input.is_action_just_pressed("jump"):
		if(jump_double):
			gravity = -jump_strength
			jump_double = false
			model.scale = Vector3(0.5, 1.5, 0.5)
		if(jump_single): 
			jump()
		
	pass
	
func jump():
	
	gravity = -jump_strength
	
	model.scale = Vector3(0.5, 1.5, 0.5)
	
	jump_single = false
	jump_double = true
	
func handle_gravity(delta):
	gravity += 25 * delta
	if gravity > 0 and is_on_floor():
		gravity = 0
		jump_single = true
		
func collect_coins():
	coins += 1
	
	#This is going to make other code referencing this signal fire
	coin_collected.emit(coins)


func _on_touch_move(dir):
	move_joystick = dir
