extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory: MarginContainer = $"../Inventory"
@onready var fire_line: Line2D = $FireLine
@onready var collision_shape_2d: CollisionShape2D = $Influence/CollisionShape2D


@export var fire_starting_size: float = 1
@export var fire_increase: float = 0.1

@export var starting_influence: float = 65.0

@export var segments: int = 18
@export var jitter: float = 10.0

var _t := 0.0
var fire_size: float
var influence: float

func _ready() -> void:
	fire_size = fire_starting_size
	influence = starting_influence
	
	
func _process(delta: float) -> void:
	create_fire_arm(delta)

func create_fire_arm(delta) -> void:
	_t += delta
	var start := Vector2.ZERO
	var end := get_local_mouse_position()

	var pts: PackedVector2Array = []
	pts.resize(segments + 1)

	for i in range(segments + 1):
		var a := float(i) / float(segments)
		var p := start.lerp(end, a)

		var dir := (end - start)
		var perp := dir.orthogonal().normalized() if dir.length() > 0.001 else Vector2.UP
		var wave := sin(_t * 10.0 + a * 12.0)
		p += perp * wave * jitter * a

		pts[i] = p

	fire_line.points = pts

func add_to_fire() -> void:
	print("added wood to fire")
	fire_size += fire_increase
	scale = Vector2(fire_size, fire_size)
	inventory.subtract_wood()


func mouse_click() -> void:
	if inventory.wood_amount > 0:
		add_to_fire()
	else:
		print("not enough wood")
