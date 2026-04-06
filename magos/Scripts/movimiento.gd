extends Node

const VELOCIDAD = 350.0

var mago: CharacterBody2D
var _direccion: Vector2 = Vector2.ZERO

func _ready():
	mago = get_parent()

func _physics_process(_delta):
	_direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if mago:
		mago.velocity = _direccion * VELOCIDAD
		mago.move_and_slide()
		_gestionar_animaciones()

func _gestionar_animaciones():
	if _direccion != Vector2.ZERO:
		%AnimatedSprite2D.play("caminar")
		if _direccion.x != 0:			
			%AnimatedSprite2D.flip_h = _direccion.x < 0		#para darse vuelta si detecta que vas para la izquierda
	else:
		%AnimatedSprite2D.play("quieto")
