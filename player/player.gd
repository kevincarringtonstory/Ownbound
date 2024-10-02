extends CharacterBody2D

const speed = 100

@onready var animated_sprite = $AnimatedSprite2D
@onready var actionable_finder = $Direction/ActionableFinder

var input_vector = Vector2.ZERO  # Declare input_vector as a class variableaaa

func _ready():
	pass # Start with the default idle animation

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
			var actionables = actionable_finder.get_overlapping_areas()
			if actionables.size() > 0:
				actionables[0].action()
				input_vector	 = Vector2.ZERO
			return
	
	# Update input_vector based on axis input
	var x_axis: float = Input.get_axis("ui_left", "ui_right")
	var y_axis: float = Input.get_axis("ui_up", "ui_down")
	
	# Set input_vector based on axis input, allowing for both diagonal and straight movement
	input_vector = Vector2(x_axis, y_axis).normalized()  # Normalize for diagonal movement

func _physics_process(delta):
	var velocity = Vector2.ZERO  # Local velocity variable
	var animation_name: String
	
	# Update velocity based on input_vector
	if input_vector.length() > 0:
		velocity = input_vector * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	# Update animated sprite based on velocity
	#if velocity.length() > 0:
		#if input_vector.x < 0:
			#animated_sprite.play("walk_left")
		#elif input_vector.x > 0:
			#animated_sprite.play("walk_right")
		#elif input_vector.y < 0:
			#animated_sprite.play("walk_up")
		#elif input_vector.y > 0:
			#animated_sprite.play("walk_down")
			
	if input_vector.x == -1 or input_vector.x == 1:
		if input_vector.x < 0:
			animation_name = "walk_left"
		else:
			animation_name = "walk_right"
			
	if input_vector.y == -1 or input_vector.y == 1:
		if input_vector.y < 0:
			animation_name = "walk_up"
		else:
			animation_name = "walk_down"
			
	if velocity.length() > 0:
		animated_sprite.play(animation_name)
		
		
	

	self.velocity = velocity  # Assign the calculated velocity to the character's velocity
	move_and_slide()
