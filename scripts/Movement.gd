extends Area2D

@onready var joystickBG = $JoystickBackground
@onready var joystick = $JoystickBackground/Joystick

@onready var max_range = $CollisionShape2D.shape.radius

signal move_dir

var dir: Vector3
var touch := false

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			#When someone touches the Joystock background we want to get the distance between the
			#touch and the background's center so that we can update the position of the joystick
			var distance = event.position.distance_to(joystickBG.global_position)
			if not touch:
				if distance < max_range:
					touch = true
				#want to make sure we are dynamically updating the "touch" boolean so we aren't
				#constantly in the "touch" state and keep our character moving in one direction
				else:
					touch = false
		else:
			touch = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Vector3.Zero = (0, 0, 0) so we're constantly reseting the direction of the joystick
	dir = Vector3.ZERO
	if touch:
		joystick.global_position = get_global_mouse_position()
		joystick.position = joystickBG.position + (joystick.position - joystickBG.position).limit_length(max_range)
	else:
		joystick.position = Vector2.ZERO
		
	dir = Vector3(joystick.position.x/max_range, 0, joystick.position.y/max_range)
	
	#so we're constantly sending move direction to the player
	move_dir.emit(dir)
