extends CharacterBody2D

# Variables for movement
var speed = 200

func _process(_delta):
	# Initialize the velocity with zero to reset it each frame
	var direction = Vector2.ZERO

	# Move based on input
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Normalize the direction and apply speed if direction is non-zero
	if direction != Vector2.ZERO:
		direction = direction.normalized() * speed

	# Set the velocity and move the character
	velocity = direction
	move_and_slide()
