extends Line2D

#@onready var fire_line: Line2D = $FireLine

@export var influence_circle: Node2D
@export var segments: int = 18
@export var jitter: float = 5.0

var _t := 0.0

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

	points = pts
