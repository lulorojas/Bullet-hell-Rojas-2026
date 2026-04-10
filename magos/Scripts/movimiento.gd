extends Node

const VELOCIDAD = 350.0

var mago: CharacterBody2D
var _direccion: Vector2 = Vector2.ZERO
var atacando = false

func _ready():
	mago = get_parent()

func _physics_process(_delta):
	
	if mago.esta_muerto:
		mago.velocity = Vector2.ZERO
		return
	
	_direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if mago:
		mago.velocity = _direccion * VELOCIDAD
		mago.move_and_slide()
		_gestionar_animaciones()

func _gestionar_animaciones():
	
	if mago.esta_muerto or mago.recibiendo_danio:
		return
	
	if %AnimatedSprite2D.animation == "Atacar" and %AnimatedSprite2D.is_playing():
		return
		
	if _direccion != Vector2.ZERO:
		%AnimatedSprite2D.play("caminar")
		if _direccion.x != 0:			
			%AnimatedSprite2D.flip_h = _direccion.x < 0		#para darse vuelta si detecta que vas para la izquierda
	else:
		%AnimatedSprite2D.play("quieto")

func disparar_animacion():
	atacando = true
	%AnimatedSprite2D.play("atacar")

func _on_animated_sprite_2d_animation_finished():
	if %AnimatedSprite2D.animation == "atacar":
		atacando = false
