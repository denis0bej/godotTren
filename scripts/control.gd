extends Control

const PORT = 9999
const DEFAULT_IP = "127.0.0.1"

var peer = ENetMultiplayerPeer.new()

func _on_host_pressed() -> void:
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer

	load_game_lvl()
	print("AM hostat!")

func _on_join_pressed() -> void:
	peer.create_client(DEFAULT_IP, PORT)
	multiplayer.multiplayer_peer = peer

	print("connecting!")


func load_game_lvl():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
