extends CharacterBody2D

@export var speed = 100
@export var dash_speed = 300
@export var dash_duration = 0.2
@export var dash_cooldown = 1.0

@onready var animated_sprite = $AnimatedSprite2D
var is_dashing = false
var dash_timer = 0.0
var cooldown_timer = 0.0
var dash_direction = Vector2.ZERO  # New variable to store the dash direction

func _physics_process(delta):
	var velocity = Vector2.ZERO  # Local velocity variable

	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
		else:
			velocity = dash_direction * dash_speed  # Maintain dash velocity
	else:
		cooldown_timer -= delta
		var input_vector = Vector2.ZERO
		input_vector.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		input_vector.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			velocity = input_vector * speed
			if input_vector.x < 0:
				animated_sprite.play("walk_left")
			else:
				animated_sprite.play("walk_right")
		else:
			velocity = Vector2.ZERO
			animated_sprite.play("idle")
		
		if Input.is_action_just_pressed("ui_dash") and cooldown_timer <= 0 and input_vector != Vector2.ZERO:
			is_dashing = true
			dash_timer = dash_duration
			cooldown_timer = dash_cooldown
			dash_direction = input_vector  # Store the current input direction
			velocity = dash_direction * dash_speed
			animated_sprite.play("dash")
	
	self.velocity = velocity  # Assign the calculated velocity to the character's velocity
	move_and_slide()

func _ready():
	animated_sprite.play("idle")
