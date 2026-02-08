extends Node2D

@export var player_scene: PackedScene

func _ready():
	if multiplayer.is_server():
		NetworkManager.spawn_player(1)

func _on_player_connected(_id):
	pass
