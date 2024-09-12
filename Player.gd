extends CharacterBody2D

var speed = 100  # Adjust this value to match Undertale's movement speed

func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = input_vector * speed
	
	if input_vector != Vector2.ZERO:
		$Sprite2D.modulate = Color(1, 0.5, 0.5)
	else:
		$Sprite2D.modulate = Color(1, 1, 1)
	
	move_and_slide()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("Player position: ", global_position)
		print("Player velocity: ", velocity)

