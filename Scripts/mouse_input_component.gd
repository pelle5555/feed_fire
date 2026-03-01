extends Area2D
@export var clickable: Node2D

var _influence: Node = null
	
func _get_influences() -> Array:
	return get_tree().get_nodes_in_group("influence")

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_position_in_any_influence(clickable.global_position): 
				if clickable != null and clickable.has_method("mouse_click"):
					clickable.mouse_click()
					
func is_position_in_any_influence(pos: Vector2) -> bool:
	for influence in _get_influences():
		if influence.is_position_reachable(pos):
			return true
	return false
