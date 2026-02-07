extends Control

func _on_host_pressed() -> void:
	NetworkManager.host_game()

func _on_join_pressed() -> void:
	NetworkManager.join_game("10.19.120.144")
