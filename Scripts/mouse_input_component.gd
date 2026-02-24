extends Area2D

@onready var timer: Timer = $Timer

@export var ember_scene: PackedScene
@export var clickable: Node2D
	
var _influence: Array
var ember_position: Vector2

func get_influence() -> Array:
	return get_tree().get_nodes_in_group("influence")
	
func is_position_in_any_influence(pos: Vector2) -> bool:
	for influence in get_influence():
		if influence.is_position_reachable(pos):
			return true
	return false

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_position_in_any_influence(clickable.global_position): 
				if clickable != null and clickable.has_method("mouse_click"):
					clickable.mouse_click()
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			timer.start()
			ember_position = clickable.global_position
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			print("pressing")
		elif event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			print("releasing")
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			timer.stop()

func create_ember() -> void:
	var ember = ember_scene.instantiate()
	add_child(ember)
	ember.global_position = ember_position

func _on_timer_timeout() -> void:
	print("build ember")
	create_ember()
