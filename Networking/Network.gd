extends Node

signal player_disconnected()
signal server_disconnected()

const DEFAULT_IP: String = "127.0.0.1"
const DEFAULT_PORT: int = 4444
const MAX_PLAYERS: int = 4

var local_player_id: = 0
sync var players = {}
sync var player_data = {}


func _ready() -> void:
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	get_tree().connect("network_peer_connected", self, "_on_player_connected")


func create_server() -> void:
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	add_to_player_list()


func connect_to_server() -> void:
	var peer = NetworkedMultiplayerENet.new()
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)


func add_to_player_list() -> void:
	local_player_id = get_tree().get_network_unique_id()
	player_data = SaveGame.save_data
	players[local_player_id] = player_data


func _on_connected_to_server() -> void:
	add_to_player_list()
	rpc("_send_player_info", local_player_id, player_data)


remote func _send_player_info(id, player_info) -> void:
	if local_player_id == 1:
		print(str(id) + " has connected")


func _on_player_connected(id) -> void:
	if not get_tree().is_network_server():
		print(str(id) + " has connected")
