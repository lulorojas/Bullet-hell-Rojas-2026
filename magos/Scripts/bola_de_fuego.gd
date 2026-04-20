extends Area2D

var velocidad = 500.0
var direccion = Vector2.ZERO

func _ready():
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _physics_process(delta):
	position += direccion * velocidad * delta

func _on_body_entered(cuerpo):
	if cuerpo.is_in_group("enemigos"):
		cuerpo.recibir_danio(1)
	
	if cuerpo.is_in_group("enemigos") or cuerpo.is_in_group("obstaculos"):
		queue_free()
