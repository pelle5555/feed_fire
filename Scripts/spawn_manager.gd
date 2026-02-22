extends Node2D



@export var initial_tree_count: int = 20
@export var tree_scene: PackedScene

@onready var screen_size = get_viewport().get_visible_rect().size

var tree_count: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(screen_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	initial_tree_spawn()


func initial_tree_spawn() -> void: 
	var rng = RandomNumberGenerator.new()
	while initial_tree_count > tree_count:
		var randomX = rng.randf_range(-(screen_size.x / 2) +20, screen_size.x / 2 - 20) 
		var randomY = rng.randf_range(-(screen_size.y / 2) + 100, screen_size.y / 2 - 20)
		var spawn_pos = Vector2(randomX, randomY)
		print(spawn_pos)
		spawn_tree(spawn_pos)
		tree_count += 1

func spawn_tree(global_pos: Vector2) -> void:
	var tree = tree_scene.instantiate() as Node2D
	tree.global_position = global_pos
	add_child(tree)
	print("spawn tree!")


func _on_spawn_timer_timeout() -> void:
	pass # Replace with function body.
