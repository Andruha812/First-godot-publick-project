extends Resource

const save_path = "user://player_data.tres"
var player_data: PlayerData = PlayerData.new()

func save_game() -> void:
	var err:= ResourceSaver.save(player_data, "user://elf.tres")
	if err!= OK:
		printerr("Nesanaca saglabasana!!")

var load_game:= load("user://elf.tres") as PlayerData
print(load_game.hp)
