extends Spatial


func _ready() -> void:
	spawn_local_player()
	rpc("spawn_remote_player", Network.local_player_id)


func spawn_local_player():
	var new_player = preload("res://Player/Player.tscn").instance()
	new_player.name = str(Network.local_player_id)
	new_player.translation = Vector3(10, 5, 10)
	$Players.add_child(new_player)


remote func spawn_remote_player(id) -> void:
	var new_player = preload("res://Player/Player.tscn").instance()
	new_player.name = str(id)
	$Players.add_child(new_player)
