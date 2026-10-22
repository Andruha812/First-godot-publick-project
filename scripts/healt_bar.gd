extends ProgressBar

@export var elf : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#elf.healtChanged.connect(update)
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update():
	pass
	#value = elf.currentHP * 100 / elf.HP
