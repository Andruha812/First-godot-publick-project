extends Area2D
@onready var is_in_area = false
@onready var player = get_tree().get_first_node_in_group("player")


func _on_area_entered(area: Area2D) -> void:
	is_in_area = true
	zone_action()

func zone_action():
	while is_in_area==true:
		player.currentHP -= 1
		print("player_HP: ", player.currentHP)
		await get_tree().create_timer(1).timeout

func _on_area_exited(area: Area2D) -> void:
	is_in_area = false
