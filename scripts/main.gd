extends Node2D

@export var player_scene: PackedScene

func _ready():
	# HOOK UP THE SIGNALS
	# These fire when the connection actually happens
	multiplayer.peer_connected.connect(_on_player_connected)

func _on_player_connected(id):
	var player = player_scene.instantiate()
	
	player.name = str(id)
	
	$Players.add_child(player)
	
	player.set_multiplayer_authority(id)
	
	print("Player Connected! ID: " + str(id))
