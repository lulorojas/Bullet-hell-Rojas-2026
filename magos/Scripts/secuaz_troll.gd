extends CharacterBody2D


var velocidad = 200
var mago = null
var esta_muerto = false
var atacando = false

func inicializar(ref_mago):
	mago = ref_mago

func _physics_process(_delta):
	if esta_muerto or atacando or not is_instance_valid(mago):
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var dir = global_position.direction_to(mago.global_position)
	velocity = dir * velocidad
	$AnimatedSprite2D.play("moverse")
	$AnimatedSprite2D.flip_h = dir.x < 0
	move_and_slide()

func recibir_danio(_cantidad):
	if esta_muerto: return
	esta_muerto = true
	$AnimatedSprite2D.play("danio")
	await get_tree().create_timer(0.2).timeout
	morir()

func morir():
	esta_muerto = true
	$AnimatedSprite2D.play("morir")
	await get_tree().create_timer(2.0).timeout
	queue_free()

func _on_area_2d_body_entered(body):
	if esta_muerto or atacando: return
	if body.is_in_group("enemigos") or body.is_in_group("enemigos2"): return
	
	if body.is_in_group("jugador") or body.name == "Mago":
		atacando = true
		velocity = Vector2.ZERO
		
		if body.has_method("recibir_danio"):
			body.recibir_danio(25)
		
		$AnimatedSprite2D.play("atacar")
		await get_tree().create_timer(1.0).timeout
		
		morir()
