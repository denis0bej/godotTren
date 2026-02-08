extends CharacterBody2D

const SPEED = 400.0

func _enter_tree():
	# Set authority based on the name (e.g. name "1" -> Authority 1)
	set_multiplayer_authority(name.to_int())

func _physics_process(_delta: float) -> void:
	# 1. BYPASS THE AUTHORITY CHECK FOR DEBUGGING
	# normally we would return here, but we want to see why it fails
	var i_am_authority = is_multiplayer_authority()
	
	if i_am_authority:
		var direction = Input.get_vector("a", "d", "w", "s")
		if direction:
			velocity = direction * SPEED
		else:
			velocity = Vector2.ZERO
		move_and_slide()
