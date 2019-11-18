extends Control



func _ready() -> void:
	$ColorRect/VBoxContainer/CenterContainer/VBoxContainer/GridContainer/NameLineEdit.text = SaveGame.save_data["Player_name"]


func _on_HostButton_pressed() -> void:
	Network.create_server()


func _on_JoinButton_pressed() -> void:
	Network.connect_to_server()
