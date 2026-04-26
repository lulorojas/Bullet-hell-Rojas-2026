extends Area2D

func _on_body_entered(body):
	if body.is_in_group("jugador"):
		var enemigos = get_tree().get_nodes_in_group("enemigos")
		if enemigos.is_empty():
			var victoria_layer = get_tree().get_root().find_child("MostrarVictoria", true, false)
			if victoria_layer:
				victoria_layer.mostrar()
