extends Node2D

@export var player_scene: PackedScene

func _ready():
	# HOOK UP THE SIGNALS
	# These fire when the connection actually happens
	multiplayer.peer_connected.connect(_on_player_connected)
	spawn_player(1)

func _on_player_connected(id):
	spawn_player(id)
	
func spawn_player(id):
	var player = player_scene.instantiate()
	
	player.name = str(id)
	
	$Players.add_child(player)
	
	print("Player Connected! ID: " + str(id))
