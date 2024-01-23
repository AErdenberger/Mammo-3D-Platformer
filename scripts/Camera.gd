extends Node3D


@export_group("Properties")
@export var target: Node

@export_group("Rotation")
@export var rotation_speed = 120

@onready var camera = $Camera3D

var camera_rotation:Vector3
var zoom = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
