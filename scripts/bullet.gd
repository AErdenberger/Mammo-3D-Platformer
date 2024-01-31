extends Node3D

@onready var RB:RigidBody3D = $RigidBody3D

var timer = Timer.new()

func _ready():
	timer.wait_time = 1
	timer.timeout.connect(destroy)
	timer.one_shot = true
	add_child(timer)
	timer.start()
	
func destroy():
	queue_free()

func hitObject():
	pass
