extends Area2D

func _on_body_entered(body):
	if body.is_in_group("jugador"):
		var enemigos = get_tree().get_nodes_in_group("enemigos2")
		if enemigos.is_empty():
			get_tree().change_scene_to_file("res://Escenas/Principal.tscn")
