extends CanvasLayer

const MENU_PRINCIPAL = "res://Escenas/menu_principal.tscn"

func _ready():
	$GameOverMenu.modulate.a = 0.0   
	$GameOverMenu.visible = false
 
func mostrar():
	$GameOverMenu.visible = true
	var tween = create_tween()
	tween.tween_property($GameOverMenu, "modulate:a", 1.0, 1.5) \
		 .set_trans(Tween.TRANS_SINE) \
		 .set_ease(Tween.EASE_IN_OUT)


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file(MENU_PRINCIPAL)


func _on_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()
