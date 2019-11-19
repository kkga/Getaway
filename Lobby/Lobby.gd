extends Control

onready var name_line_edit = $ColorRect/VBoxContainer/CenterContainer/VBoxContainer/GridContainer/NameLineEdit
onready var waiting_room = $WaitingRoomPopup


func _ready() -> void:
	name_line_edit.text = SaveGame.save_data["Player_name"]


func _on_HostButton_pressed() -> void:
	Network.create_server()
	show_waiting_room()


func _on_JoinButton_pressed() -> void:
	Network.connect_to_server()
	show_waiting_room()


func _on_NameLineEdit_text_changed(_new_text: String) -> void:
	SaveGame.save_data["Player_name"] = name_line_edit.text
	SaveGame.save_game()


func show_waiting_room():
	waiting_room.popup_centered()