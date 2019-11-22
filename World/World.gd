extends Spatial


func _enter_tree() -> void:
	get_tree().paused = true


func _ready() -> void:
	pass


func spawn_local_player():
	var new_player = preload("res://Player/Player.tscn").instance()
	new_player.name = str(Network.local_player_id)
	new_player.translation = Vector3(14, 4, 14)
	$Players.add_child(new_player)


remote func spawn_remote_player(id) -> void:
	var new_player = preload("res://Player/Player.tscn").instance()
	new_player.name = str(id)
	new_player.translation = Vector3(14, 2, 14)
	$Players.add_child(new_player)


func unpause() -> void:
	get_tree().paused = false
	spawn_local_player()
	rpc("spawn_remote_player", Network.local_player_id)
