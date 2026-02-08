extends Node

const PORT = 9999
const DEFAULT_IP = "127.0.0.1"
const MAX_PLAYERS = 2 
const SPAWN_POS_P1 = Vector2(200, 300) # Left Side
const SPAWN_POS_P2 = Vector2(0, 700) # Right Side

var peer = ENetMultiplayerPeer.new()
var player_scene = preload("res://scenes/player_1.tscn")

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connection_success)
	multiplayer.connection_failed.connect(_on_connection_failed)

func host_game():
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	print("Server Created!")
	change_level("res://scenes/main.tscn")

func join_game(ip):
	peer.create_client(ip, PORT)
	multiplayer.multiplayer_peer = peer
	print("Connecting...")

func _on_connection_success():
	print("Connected to Host!")
	change_level("res://scenes/main.tscn")

func _on_connection_failed():
	print("Error couldn't connect to host")

func _on_player_connected(id):
	print("Player Connected: " + str(id))
	# ONLY THE SERVER SHOULD SPAWN PLAYERS
	if multiplayer.is_server():
		spawn_player(id)

func _on_player_disconnected(id):
	print("Player Disconnected: " + str(id))
	# Optional: Clean up player node if needed, though Spawner might handle it.
	var main = get_tree().current_scene
	if main.name == "Main":
		var player = main.get_node("Players").get_node_or_null(str(id))
		if player: player.queue_free()

func spawn_player(id):
	var main = get_tree().current_scene
	if main.name == "Main":
		var p = player_scene.instantiate()
		p.name = str(id)
		
		if id == 1:
			p.position = SPAWN_POS_P1 # Host goes Left
		else:
			p.position = SPAWN_POS_P2 # Client goes Right
		
		# Add to the "Players" node so MultiplayerSpawner sees it!
		main.get_node("Players").add_child(p) 

func change_level(scene_path):
	get_tree().change_scene_to_file(scene_path)
	
# We need to spawn the Host's player once they enter the Main scene
func _on_scene_changed():
	# If we are the server and we just loaded Main, spawn ourselves (ID 1)
	if multiplayer.is_server() and get_tree().current_scene.name == "Main":
		spawn_player(1)
