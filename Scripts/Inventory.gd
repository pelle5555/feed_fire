extends MarginContainer
class_name Inventory

@onready var wood_label: Label = $HBoxContainer/WoodLabel
@onready var fire_power_label: Label = $HBoxContainer/FirePowerLabel


@export var starting_wood: int = 10
@export var starting_fire: int = 10

var wood_amount: int
var fire_amount: int

func _ready() -> void:
	wood_amount = starting_wood
	fire_amount = starting_fire
	wood_label.text = str(starting_wood)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		add_fire(1)

func add_fire(amount) -> void:
	fire_amount += amount
	fire_power_label.text = str(fire_amount)
	
func subtract_fire(amount) -> void:
	fire_amount -= amount
	fire_power_label.text = str(fire_amount)
	
func add_wood(amount) -> void:
	wood_amount += amount
	wood_label.text = str(wood_amount)
	
func subtract_wood() -> void:
	wood_amount -= 1
	wood_label.text = str(wood_amount)
	
	
