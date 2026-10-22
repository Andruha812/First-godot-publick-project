extends ProgressBar

@export var elf : Player
@export var max_health: float = 5 # max health for the player
var health: float = max_health
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
