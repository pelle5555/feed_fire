extends Node2D

@export var initial_tree_count: int = 20
@export var tree_scene: PackedScene
@export var min_tree_distance: float = 48.0
@export var max_attempts: int = 2000
@onready var screen_size = get_viewport().get_visible_rect().size

var tree_count: int = 0
var tree_positions: Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(screen_size)
	initial_tree_spawn()

func initial_tree_spawn() -> void: 
	var rng = RandomNumberGenerator.new()
	var attempts: int = 0
	while tree_positions.size() < initial_tree_count and attempts < max_attempts:
		attempts += 1
		var random_x = rng.randf_range(-(screen_size.x / 2) +20, screen_size.x / 2 - 20) 
		var random_y = rng.randf_range(-(screen_size.y / 2) + 100, screen_size.y / 2 - 20)
		var spawn_pos = Vector2(random_x, random_y)
		if is_far_enough(spawn_pos):
			spawn_tree(spawn_pos)
			tree_positions.append(spawn_pos)
			tree_count += 1
			
			
	#if tree_positions.size() < initial_tree_count:
		#print("Only spawned %d/%d trees (ran out of space or attempts)" % [tree_positions.size(), initial_tree_count])

func spawn_tree(global_pos: Vector2) -> void:
	var tree = tree_scene.instantiate() as Node2D
	tree.global_position = global_pos
	add_child(tree)

func is_far_enough(candidate: Vector2) -> bool:
	var min_distance_square := min_tree_distance * min_tree_distance
	for p in tree_positions:
		print("hello2")
		print(p.distance_squared_to(candidate))
		if p.distance_squared_to(candidate) < min_distance_square:
			print("NO space for tree")
			return false
	return true 

func _on_spawn_timer_timeout() -> void:
	pass # Replace with function body.
