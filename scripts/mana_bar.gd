extends ProgressBar
class_name Mana_bar

@export var elf: Player
#@onready var ui: Control = $".."



func set_status(max_v : int, v : int):
	max_value = max_v
	value = v	
func set_new_value(v: float):
	value = v

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
