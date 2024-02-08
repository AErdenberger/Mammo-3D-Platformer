extends Area3D

@export var target:Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	for i in target.size():
		if target[i].has_method("scaleControl"):
			target[i].openDoor = true
		elif target[i].get_child(0).has_method("scaleControl"):
			target[i].get_child(0).openDoor = true
	pass # Replace with function body.


func _on_body_exited(body):
	for i in target.size():
		if target[i].has_method("scaleControl"):
			target[i].openDoor = false
		elif target[i].get_child(0).has_method("scaleControl"):
			target[i].get_child(0).openDoor = false
	pass # Replace with function body.
