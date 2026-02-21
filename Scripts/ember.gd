extends Node2D

@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $MouseClickComponent/Sprite2D

@export var ember_texture: Texture2D
@export var smoking_texture: Texture2D
@export var onfire_texture: Texture2D
@export var current_state: EmberState = EmberState.EMBER
@export var state_change_time: float = 5

enum EmberState {
	EMBER,
	SMOKING,
	ON_FIRE
}

func _ready() -> void:
	timer.wait_time = state_change_time
	timer.start()
	update_visuals()

func _process(delta: float) -> void:
	pass
	
func set_next_state() -> void:
	if current_state == EmberState.EMBER:
		current_state = EmberState.SMOKING
		state_change_time = 10
		timer.start()
	elif current_state == EmberState.SMOKING:
		current_state = EmberState.ON_FIRE
		
	update_visuals()

func update_visuals():
	match current_state:
		EmberState.EMBER:
			sprite_2d.texture = ember_texture
		EmberState.SMOKING:
			sprite_2d.texture = smoking_texture
		EmberState.ON_FIRE:
			sprite_2d.texture = onfire_texture

func mouse_click() -> void:
	print("click click")


func _on_timer_timeout() -> void:
	set_next_state()
