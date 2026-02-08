extends Control

func _on_host_pressed() -> void:
	NetworkManager.host_game()

func _on_join_pressed() -> void:
	NetworkManager.join_game("127.0.0.1")
