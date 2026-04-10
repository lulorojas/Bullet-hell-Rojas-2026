extends Area2D

var vel = 350
var dir = Vector2.ZERO

func _physics_process(delta):
	position += dir * vel * delta

func _on_body_entered(body):
	if body.name == "Mago":
		body.recibir_danio(25)
		
	if body.name == "Mago" or body.is_in_group("obstaculos"):
		queue_free()
