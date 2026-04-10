extends CharacterBody2D

const BOLA = preload("res://Escenas/bola_de_fuego.tscn")
@onready var timer_disparo = $TimerDisparo

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
