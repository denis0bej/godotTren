extends Control

const PORT = 9999
const DEFAULT_IP = "100.83.73.83"

var peer = ENetMultiplayerPeer.new()

func _ready():
	peer.set_bind_ip("0.0.0.0")
	# HOOK UP THE SIGNALS
	# These fire when the connection actually happens
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connection_success)
	multiplayer.connection_failed.connect(_on_connection_failed)

# --- SIGNALS ---

# Runs on BOTH Host and Client when someone else connects
func _on_player_connected(id):
	print("Player Connected! ID: " + str(id))

# Runs on BOTH Host and Client when someone disconnects
func _on_player_disconnected(id):
	print("Player Disconnected: " + str(id))

# Runs ONLY on Client when they successfully join
func _on_connection_success():
	print("SUCCESS! I have officially joined the Host!")

# Runs ONLY on Client if they can't find the host after a few seconds
func _on_connection_failed():
	print("FAILED! Could not connect. Check IP/Firewall.")

func _on_host_pressed() -> void:
	var error = peer.create_server(PORT)
	if error != OK:
		print("Cannot host: " + str(error))
		return
	else:
		print("worked")

	multiplayer.multiplayer_peer = peer

	load_game_lvl()
	print("AM hostat!")

func _on_join_pressed() -> void:
	peer.create_client(DEFAULT_IP, PORT)
	multiplayer.multiplayer_peer = peer

	load_game_lvl()
	print("connecting!")


func load_game_lvl():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
