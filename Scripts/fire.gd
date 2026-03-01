extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory: MarginContainer = $"../Inventory"
@onready var fire_line: Line2D = $FireLine
@onready var collision_shape_2d: CollisionShape2D = $Influence/CollisionShape2D
@onready var mouse_click_component: Area2D = $MouseClickComponent
@onready var influence_circle: Node2D = $Influence

@export var fire_starting_size: float = 1
@export var fire_increase: float = 0.1
@export var influence_increase: float = 2

var fire_size: float

func _ready() -> void:
	fire_size = fire_starting_size
	

func add_to_fire() -> void:
	fire_size += fire_increase
	influence_circle.radius += influence_increase
	mouse_click_component.scale = Vector2(fire_size, fire_size)
	inventory.add_fire(2)
	inventory.subtract_wood()


func mouse_click() -> void:
	if inventory.wood_amount > 0:
		add_to_fire()
	else:
		print("not enough wood")
