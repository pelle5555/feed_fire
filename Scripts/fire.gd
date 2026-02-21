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
@export var segments: int = 18
@export var jitter: float = 5.0

var _t := 0.0
var fire_size: float

func _ready() -> void:
	fire_size = fire_starting_size
	
func _process(delta: float) -> void:
	create_fire_arm(delta)

func create_fire_arm(delta) -> void:
	var distance = Vector2.ZERO.distance_to(get_local_mouse_position())

	_t += delta
	var start := Vector2.ZERO
	var end := get_local_mouse_position().limit_length(influence_circle.radius)

	var pts: PackedVector2Array = []
	pts.resize(segments + 1)

	for i in range(segments + 1):
		var progress := float(i) / float(segments)
		var point := start.lerp(end, progress)

		var dir := (end - start)
		var perpendicular := dir.orthogonal().normalized() if dir.length() > 0.001 else Vector2.UP
		var wave := sin(_t * 10.0 + progress * 12.0)
		point += perpendicular * wave * jitter * progress

		pts[i] = point

	fire_line.points = pts


func add_to_fire() -> void:
	print("added wood to fire")
	fire_size += fire_increase
	influence_circle.radius += influence_increase
	mouse_click_component.scale = Vector2(fire_size, fire_size)
	inventory.subtract_wood()


func mouse_click() -> void:
	if inventory.wood_amount > 0:
		add_to_fire()
	else:
		print("not enough wood")
