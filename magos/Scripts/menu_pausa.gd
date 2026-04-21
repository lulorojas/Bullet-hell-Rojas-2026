extends CanvasLayer

const MENU_PRINCIPAL = "res://Escenas/menu_principal.tscn"


func _ready() -> void:
	visible = false

func _input(event):
	if event.is_action_pressed("Pausar"):
		visible = !visible
		get_tree().paused = visible



func _on_continuar_pressed() -> void:
	visible = false
	get_tree().paused = false



func _on_volver_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MENU_PRINCIPAL)

func _on_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()
