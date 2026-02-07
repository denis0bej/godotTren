extends CharacterBody2D

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("w"):
		velocity.y = 1;
	if Input.is_action_pressed("s"):
		velocity.y = -1;
	if Input.is_action_pressed("d"):
		velocity.x = 1;
	if Input.is_action_pressed("a"):
		velocity.x = -1;
