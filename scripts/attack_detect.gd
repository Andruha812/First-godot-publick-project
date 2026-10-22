extends Area2D
@onready var is_in_area = false

func _on_body_entered(body: Node2D) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	is_in_area = true
	while is_in_area==true:
		await(1)
		print("area")
		await get_tree().create_timer(1).timeout


func _on_area_exited(area: Area2D) -> void:
	is_in_area = false 
