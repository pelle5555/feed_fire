extends Node2D

@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $MouseClickComponent/Sprite2D

@export var ember_texture: Texture2D
@export var smoking_texture: Texture2D
@export var onfire_texture: Texture2D
@export var current_state: EmberState = EmberState.EMBER
@export var state_change_time: float = 10



enum EmberState {
	EMBER,
	SMOKING,
	ON_FIRE
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = state_change_time
	timer.start()
	update_visuals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_state(new_state: EmberState) -> void:
	current_state = new_state
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
	set_state(EmberState.SMOKING)
