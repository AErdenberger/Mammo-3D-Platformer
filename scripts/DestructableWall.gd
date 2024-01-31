extends RigidBody3D

@onready var MI:MeshInstance3D = $Model/Node/cuboid
var material_full_health = preload("res://new_features/Mammo-3D-Platformer/models/Materials/Full_Health.tres")
var material_damaged = preload("res://new_features/Mammo-3D-Platformer/models/Materials/Damaged.tres")
var health = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.owner.has_method("hitObject"):
		if health > 1:
			MI.set_surface_override_material(0, material_damaged)
			health = health - 1
		else:
			queue_free()
		body.queue_free()
