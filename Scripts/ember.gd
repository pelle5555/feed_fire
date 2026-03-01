extends Node2D

@onready var timer: Timer = $Timer
@onready var ember_sprite: Sprite2D = %EmberSprite

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
			ember_sprite.texture = ember_texture
		EmberState.SMOKING:
			ember_sprite.texture = smoking_texture
		EmberState.ON_FIRE:
			ember_sprite.texture = onfire_texture

func mouse_click() -> void:
	print("click click")


func _on_timer_timeout() -> void:
	set_next_state()
