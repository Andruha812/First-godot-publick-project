extends Control
@export var label: Label
@export var mana_bar: ProgressBar


@export var elf: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mana_bar_value_changed(value: float) -> void:
	label.text = str("%0.0f" % value)
	pass # Replace with function body.


func _on_label_ready() -> void:
	await get_tree().create_timer(0.1).timeout
	label.text = str("%0.0f" % mana_bar.value)
