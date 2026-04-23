extends Area2D

var danio = 1
var velocidad = 80
var mago = null
var esta_muerto = false

func _ready():
	body_entered.connect(_on_body_entered)
	mago = get_tree().get_root().find_child("Mago", true, false)

func _process(delta):
	if esta_muerto or mago == null:
		return
	
	var direccion = (mago.global_position - global_position).normalized()
	global_position += direccion * velocidad * delta
	$AnimatedSprite2D.play("moverse")
	$AnimatedSprite2D.flip_h = direccion.x < 0

func _on_body_entered(body):
	if body.name == "Mago" and not esta_muerto:
		esta_muerto = true
		$AnimatedSprite2D.play("atacar")
		body.recibir_danio(danio)
		await get_tree().create_timer(0.5).timeout
		queue_free()
