extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var inventory: Inventory
@export var tree_start_hitpoints: int = 5

var tree_hitpoints = tree_start_hitpoints:
	set(value):
		tree_hitpoints = value
		animation_player.play("Chopped")
		if tree_hitpoints <= 0:
			cut_down_tree()

func chop_tree() -> void:
	tree_hitpoints -= 1
	
func cut_down_tree() -> void:
	print("cut cut")
	inventory.add_wood(2)
#	todo: play cutdown animation
	queue_free()

func mouse_click() -> void:
	chop_tree()
