extends Area2D
@export var clickable: Node2D

var _influence: Node = null
	
func _get_influence() -> Node:
	if _influence == null:
		_influence = get_tree().get_first_node_in_group("influence")
	return _influence

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var influence := _get_influence()
			
			if influence != null and influence.is_position_reachable(clickable.global_position): 
				if clickable != null and clickable.has_method("mouse_click"):
					clickable.mouse_click()
