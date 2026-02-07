extends CharacterBody2D

const SPEED = 400.0 # O viteză vizibilă

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	var direction = Input.get_vector("a", "d", "w", "s")
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO # Se oprește instant

	move_and_slide()
