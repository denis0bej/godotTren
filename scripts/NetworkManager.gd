extends Node

# Aici ținem referința la jucător și port
const PORT = 9999
const DEFAULT_IP = "127.0.0.1" # Sau IP-ul local
var peer = ENetMultiplayerPeer.new()
var player_scene = preload("res://scenes/player_1.tscn") # Preîncărcăm jucătorul

func _ready():
	# Conectăm semnalele AICI, în scriptul nemuritor
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connection_success)
	multiplayer.connection_failed.connect(_on_connection_failed)

func host_game():
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	print("Server creat!")
	change_level("res://main.tscn") # Schimbăm scena după ce creăm serverul

func join_game(ip):
	peer.create_client(ip, PORT)
	multiplayer.multiplayer_peer = peer
	print("Mă conectez...")
	# NOTĂ: Clientul NU schimbă scena încă! Așteaptă să se conecteze.

func _on_connection_success():
	print("M-am conectat la Host!")
	# Abia acum Clientul intră în joc
	change_level("res://main.tscn")

func _on_player_connected(id):
	print("Jucător nou: " + str(id))
	# AICI faci spawn-ul! Pentru că scriptul ăsta există mereu.
	spawn_player(id)

func _on_player_disconnected(id):
	print("Player Disconnected: " + str(id))

# Runs ONLY on Client if they can't find the host after a few seconds
func _on_connection_failed():
	print("FAILED! Could not connect. Check IP/Firewall.")


func spawn_player(id):
	# Verificăm dacă suntem în scena de joc (Main), nu în meniu
	# Altfel încercăm să spawnăm jucători peste butoanele de meniu
	var main = get_tree().current_scene
	if main.name == "Main": # Asigură-te că nodul rădăcină din main.tscn se numește "Main"
		var p = player_scene.instantiate()
		p.name = str(id)
		main.add_child(p) # Sau main.get_node("Players").add_child(p)

func change_level(scene_path):
	get_tree().change_scene_to_file(scene_path)
