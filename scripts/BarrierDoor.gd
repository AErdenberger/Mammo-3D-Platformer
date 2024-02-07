extends Node3D

@export var openDoor:bool
@export var initScaleVector : Vector3
@export var dirScaleVector : Vector3
@export var objects : Array[Node3D]

@onready var mesh = $RigidBody3D/cuboid
@onready var collision = $RigidBody3D/CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	initScaleVector = objects[0].scale
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(openDoor):
		for i in objects.size():
			objects[i].scale = dirScaleVector
	else:
		for i in objects.size():
			objects[i].scale = initScaleVector

