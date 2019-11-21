extends Control

onready var name_line_edit = $ColorRect/VBoxContainer/CenterContainer/VBoxContainer/GridContainer/NameLineEdit
onready var waiting_room = $WaitingRoomPopup
onready var ip = $ColorRect/VBoxContainer/CenterContainer/VBoxContainer/GridContainer/IPLineEdit
onready var port = $ColorRect/VBoxContainer/CenterContainer/VBoxContainer/GridContainer/PortLineEdit


func _ready() -> void:
	name_line_edit.text = SaveGame.save_data["Player_name"]
	ip.text = Network.DEFAULT_IP
	port.text = str(Network.DEFAULT_PORT)


func show_waiting_room():
	waiting_room.popup_centered()
	waiting_room.refresh_players(Network.players)


# SIGNAL CALLBACKS

func _on_HostButton_pressed() -> void:
	Network.selected_port = int(port.text)
	Network.create_server()
	get_tree().call_group("host_only", "show")
	show_waiting_room()

func _on_JoinButton_pressed() -> void:
	Network.selected_port = int(port.text)
	Network.selected_ip = ip.text
	Network.connect_to_server()
	show_waiting_room()

func _on_NameLineEdit_text_changed(_new_text: String) -> void:
	SaveGame.save_data["Player_name"] = name_line_edit.text
	SaveGame.save_game()

func _on_StartButton_pressed() -> void:
	Network.start_game()
