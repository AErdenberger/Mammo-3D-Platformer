extends Node3D

@export var openDoor:bool
@export var initScaleVector : Vector3
@export var dirScaleVector : Vector3
@export var objects : Array[Node3D]
@export var speed : float
@export var lockx : bool
@export var locky : bool
@export var lockz : bool

@onready var mesh = $RigidBody3D/cuboid
@onready var collision = $RigidBody3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	if speed == 0:
		speed = 1
	
	initScaleVector = objects[0].scale
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var setDir : Vector3
	
	if !lockx:
		setDir.x = dirScaleVector.x
	else:
		setDir.x = initScaleVector.x
	
	if !locky:
		setDir.y = dirScaleVector.y
	else:
		setDir.y = initScaleVector.y
	
	if !lockz:
		setDir.z = dirScaleVector.z
	else:
		setDir.z = initScaleVector.z
		
	
	if(openDoor):
		for i in objects.size():
			objects[i].scale = objects[i].scale.lerp(setDir, delta * speed)
	else:
		for i in objects.size():
			objects[i].scale = initScaleVector

func scaleControl():
	pass
