extends MarginContainer
class_name Inventory

@onready var wood_label: Label = $HBoxContainer/WoodLabel

@export var starting_wood: int = 10

var wood_amount: int

func _ready() -> void:
	wood_amount = starting_wood
	wood_label.text = str(starting_wood)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		add_wood(1)

func add_wood(amount) -> void:
	print("wood added")
	wood_amount += amount
	wood_label.text = str(wood_amount)
	
func subtract_wood() -> void:
	print("wood subtracted")
	wood_amount -= 1
	wood_label.text = str(wood_amount)
	
	
