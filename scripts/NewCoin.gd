extends Area3D

#Colon + Equals makes sure that the declared variable keeps its type
#in this case it's a boolean
var grabbed:= false 

func _on_body_entered(body):
	#has_method is slef-explanatory, checks if the body colliding with this has the method
	#collect coin
	#this is an interesting approach but I think I like checking to see if the body is in the
	#player group instead
	if body.has_method("collect_coins") and !grabbed:
		body.collect_coins()
		$mesh.queue_free()
		grabbed = true
