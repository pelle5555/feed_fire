extends Node2D

@export var radius: float
@export var dot_radius_relation: float = 2.0
@export var dot_radius: float = 1.5
@export var ring_thickness: float = 0.0 # not used, but handy if you expand later
@export var color: Color = Color(1.0, 0.86, 0.736, 0.9)

@export var rotate_speed: float = 0.1    # radians/sec (0 = no rotation)
@export var pulse_amount: float = 2.0    # pixels
@export var pulse_speed: float = 1.0     # speed of pulse

var dot_count: int
var _t := 0.0

func _process(delta: float) -> void:
	dot_count = radius / dot_radius_relation 
	_t += delta
	queue_redraw()

func _draw() -> void:
	var r := radius + sin(_t * pulse_speed) * pulse_amount
	if r <= 0.0 or dot_count <= 0:
		return

	var step := TAU / float(dot_count)
	var rot := _t * rotate_speed

	for i in range(dot_count):
		var a := rot + step * i
		var p := Vector2(cos(a), sin(a)) * r
		draw_circle(p, dot_radius, color)

func is_position_reachable(pos: Vector2) -> bool:
	return global_position.distance_to(pos) <= radius
