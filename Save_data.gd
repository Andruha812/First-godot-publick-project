extends Node

const save_path = "user://player_data.tres"
var player_data: PlayerData = PlayerData.new()

func save_game() -> void:
	var err:= ResourceSaver.save(player_data, save_path)
	if err!= OK:
		printerr("Nesanaca saglabasana!!")

#var load_game:= load("user://elf.tres") as PlayerData
func load_game() -> void:
	if ResourceLoader.exists(save_path):
		player_data = ResourceLoader.load(save_path)
		print("ieladeta spele un test text:", player_data.maxMP)
	else:
		print("saglabata faila nav!")
