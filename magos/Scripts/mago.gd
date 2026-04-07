extends CharacterBody2D

const BOLA_ESCENA = preload("res://bola_de_fuego.tscn")
@onready var timer_disparo = $TimerDisparo

func _input(event):
	if event.is_action_pressed("click_derecho"):
		if timer_disparo.is_stopped():
			_disparar()
			timer_disparo.start()

func _disparar():
	var bola = BOLA_ESCENA.instantiate()
	bola.global_position = global_position
	bola.direccion = (get_global_mouse_position() - global_position).normalized()
	get_tree().current_scene.add_child(bola)
