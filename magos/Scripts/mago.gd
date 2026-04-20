extends CharacterBody2D

const BOLA = preload("res://Escenas/bola_de_fuego.tscn")
@onready var timer_disparo = $TimerDisparo
@onready var game_over: CanvasLayer = get_node("/root/Principal/GameOver")

var vida_max = 100
var vida_actual = 100
var esta_muerto = false
var recibiendo_danio = false

func _ready():
	%BarraVida.max_value = vida_max
	%BarraVida.value = vida_actual


func _input(event):
	if event.is_action_pressed("click_derecho") and timer_disparo.is_stopped():
			_disparar()
			timer_disparo.start()

func _disparar():
	$AnimatedSprite2D.play("Atacar")
	var bola = BOLA.instantiate()
	
	get_parent().add_child(bola)
	bola.global_position = global_position
	bola.direccion = global_position.direction_to(get_global_mouse_position())
	bola.rotation = bola.direccion.angle()

func recibir_danio(cantidad):
	if esta_muerto or recibiendo_danio:
		return
	
	vida_actual -= cantidad
	vida_actual = clamp(vida_actual, 0, vida_max)
	%BarraVida.value = vida_actual
	
	if vida_actual <= 0:
		morir()
	else:
		recibiendo_danio = true
		$AnimatedSprite2D.play("Dano")
		
		await get_tree().create_timer(3.0).timeout
		
		if not esta_muerto:
			recibiendo_danio = false
		
func morir():
	esta_muerto = true
	$AnimatedSprite2D.play("Morir")
	
	game_over.mostrar()
	await get_tree().create_timer(5.0).timeout
	queue_free()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Dano":
		recibiendo_danio = false
