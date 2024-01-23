extends CharacterBody3D

var move_speed = 250
var move_velocity: Vector3

func _physics_process(delta):
	handle_controls(delta)
	
	#Movement
	var applied_velocity : Vector3
	#velocity is from CharacterBody
	#Lerp - Returns the result of the linear interpolation between this vector and to by amount weight. 
		#weight is on the range of 0.0 to 1.0, representing the amount of interpolation.
	applied_velocity = velocity.lerp(move_velocity, delta * 10)
	
	velocity = applied_velocity
	move_and_slide()
	pass
	
func handle_controls(delta):
	var input := Vector3.ZERO
	
	#Get axis input by specifying two actions, one negative and one positive.
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")
	
	move_velocity = input * move_speed * delta
	pass
