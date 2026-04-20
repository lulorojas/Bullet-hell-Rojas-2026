extends CharacterBody2D

const MOCO = preload("res://Escenas/moco.tscn")

@export var puntos: Array[Marker2D]
var indice = 0
var aceleracion = 120
var mago = null
var esperando = false

var vida = 7
var vida_max = 7
var esta_muerto = false
var recibiendo_danio = false

var ataques_realizados = 0

func _ready():
	vida = 7
	vida_max = 7 
	actualizar_barra_vida()

func _physics_process(_delta):
	if esta_muerto or recibiendo_danio:
		velocity = Vector2.ZERO 
		move_and_slide()
		return
		
	if mago != null:
		velocity = Vector2.ZERO
		if $AnimatedSprite2D.animation != "Atacar":
			$AnimatedSprite2D.play("Quieto")
			
	if esperando:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("Quieto")
	else:
		if puntos.size() > 0:
			var punto_objetivo = puntos[indice].global_position
			var direccion = punto_objetivo - global_position
			var distancia = direccion.length() 
			
			direccion = direccion.normalized()
			velocity = direccion * aceleracion
			
			$AnimatedSprite2D.play("Caminar")
			$AnimatedSprite2D.flip_h = velocity.x < 0
			
			if distancia < 5.0:
				indice += 1
				velocity = Vector2.ZERO
				$TimerPuntos.start()
				esperando = true	
				if indice >= puntos.size():
					indice = 0
	
	move_and_slide()

func _on_timer_puntos_timeout():
	esperando = false

func atacar():
	
	if mago == null or esta_muerto:
		return
	
	$AnimatedSprite2D.play("Atacar")
	
	if vida <= 4:
		patron_disparo(8, 150)
	else:
		if ataques_realizados < 2:
			patron_disparo(3, 40)
		else:
			patron_disparo(8, 100)
		
		ataques_realizados += 1
		if ataques_realizados >= 4:
			ataques_realizados = 0

func patron_disparo(cantidad, apertura):
	var direccion_base = global_position.direction_to(mago.global_position).angle()
	var angulo_inicial 	= direccion_base - deg_to_rad(apertura / 2.0)
	var paso_angular = deg_to_rad(apertura) / (cantidad - 1)
	
	for i in range(cantidad):
		var moco = MOCO.instantiate()
		var angulo_actual = angulo_inicial + (paso_angular * i)
		
		moco.global_position = global_position
		moco.dir = Vector2.from_angle(angulo_actual)
		moco.rotation = angulo_actual
		
		get_parent().add_child(moco)

func ataque_dificil():
	
	patron_disparo(15, 360)
	patron_disparo(5, 40) 
	patron_disparo(8, 120)


func _on_rango_body_entered(body):
	if body.name == "Mago":
		mago = body
		$TimerAtaque.start()

func _on_rango_body_exited(body):
	if body == mago:
		mago = null
		$TimerAtaque.stop()

func _on_timer_ataque_timeout():
	if mago != null:
		atacar()

func actualizar_barra_vida():
	
	%BarraVidaTrol.frame = clamp(vida, 0, 7)

func recibir_danio(cantidad):
	if esta_muerto or recibiendo_danio:
		return
	
	vida -= cantidad
	actualizar_barra_vida()
	
	if vida == 4: 
		ataque_dificil()
		
	if vida == 2: 
		ataque_dificil()
	
	if vida <= 1:
		morir()
	else:
		recibiendo_danio = true
		$AnimatedSprite2D.play("Dano")
		if not esta_muerto:
			recibiendo_danio = false

func morir():
	esta_muerto = true
	$AnimatedSprite2D.play("Morir")
	$CanvasLayer.visible = false 
	await get_tree().create_timer(2.0).timeout
	
	
	queue_free()
