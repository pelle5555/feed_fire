extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory: MarginContainer = $"../Inventory"


@export var fire_starting_size: float = 1
@export var fire_increase: float = 0.1
var fire_size: float

func _ready() -> void:
	fire_size = fire_starting_size


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if inventory.wood_amount > 0:
				add_to_fire()
			else:
				print("not enough wood")
		
func add_to_fire() -> void:
	print("added wood to fire")
	fire_size += fire_increase
	scale = Vector2(fire_size, fire_size)
	inventory.subtract_wood()
