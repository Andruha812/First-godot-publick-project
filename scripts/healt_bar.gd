extends ProgressBar
class_name healt_bar

@export var elf: Player
#@onready var ui: Control = $".."



func set_status(max_v : int, v : int):
	max_value = max_v
	value = v	
func set_new_value(v: float):
	value = v
	print(v)
	print(value)

func _ready() -> void:
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update():
	pass
