extends Area3D

#Colon + Equals makes sure that the declared variable keeps its type
#in this case it's a boolean
var grabbed:= false 

func _on_body_entered(body):
	if !grabbed:
		$mesh.queue_free()
		grabbed = true
