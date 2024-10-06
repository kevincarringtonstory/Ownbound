extends CharacterBody2D

@export var SPEED: float = 120

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

var input_vector: Vector2 = Vector2.ZERO  # Used for direction input

func _ready() -> void:
	animation_tree.active = true

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			input_vector = Vector2.ZERO
			return

	# Get input for both axes
	var x_axis: float = Input.get_axis("ui_left", "ui_right")
	var y_axis: float = Input.get_axis("ui_up", "ui_down")

	# Combine horizontal and vertical input vectors to allow diagonal movement
	input_vector = Vector2(x_axis, y_axis)

	# Normalize the input_vector to prevent diagonal movement from being faster
	if input_vector.length() > 1.0:
		input_vector = input_vector.normalized()

func _physics_process(_delta: float) -> void:
	# Update velocity based on input
	if input_vector.length() > 0:
		velocity = input_vector * SPEED
		
	else	:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)


	# Move the player using move_and_slide(), which handles collisions
	move_and_slide()
	
	# Clamp the velocity to zero in directions where the player is stuck
	if is_on_wall():
		velocity.x = 0  # Stop horizontal movement when colliding with a wall
	if is_on_floor() or is_on_ceiling():
		velocity.y = 0  # Stop vertical movement when colliding with a floor or ceiling
	

	# Update animation based on movement and collisions
	update_animation()

# Update animation based on the actual velocity and input direction
func update_animation():
	# Always update the blend position based on input direction, not velocity
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)
		

	# Play the Walk animation only if the player is moving (velocity > 0)
	if velocity.length() > 0:
		animation_tree.get("parameters/playback").travel("Walk")
	else:
		# Otherwise, play the Idle animation if not moving
		animation_tree.get("parameters/playback").travel("Idle")
