extends CharacterBody2D

@export var speed = 100

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input_vector.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
		# Update animation based on movement direction
		if input_vector.x < 0:
			animated_sprite.play("walk_left")
		else:
			animated_sprite.play("walk_right")
	else:
		velocity = Vector2.ZERO
		animated_sprite.play("idle")
	
	move_and_slide()
