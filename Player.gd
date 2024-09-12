extends CharacterBody2D

var speed = 100  # Adjust this value to match Undertale's movement speed
var trail_points = []
var max_trail_points = 20
var trail_length = 50  # Length of the tail in pixels
var trail_segments = 10  # Number of segments in the tail

func _ready():
	# Create a Line2D node for the trail
	var trail = Line2D.new()
	trail.name = "Trail"
	trail.default_color = Color(0.5, 0, 0.5, 0.5)  # Purple with some transparency
	trail.width = 5
	trail.joint_mode = Line2D.LINE_JOINT_ROUND
	trail.begin_cap_mode = Line2D.LINE_CAP_ROUND
	trail.end_cap_mode = Line2D.LINE_CAP_ROUND
	add_child(trail)
	
	# Initialize trail points
	for i in range(trail_segments):
		trail_points.append(position)

func _physics_process(delta):
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = input_vector * speed
	
	if input_vector != Vector2.ZERO:
		$Sprite2D.modulate = Color(1, 0.5, 0.5)
	else:
		$Sprite2D.modulate = Color(1, 1, 1)
	
	move_and_slide()
	
	# Update trail
	update_trail(delta)

func update_trail(delta):
	# Update the first point to the player's current position
	trail_points[0] = position
	
	# Update subsequent points
	for i in range(1, trail_points.size()):
		var target_position = trail_points[i-1]
		var current_position = trail_points[i]
		var new_position = current_position.lerp(target_position, 15 * delta)
		trail_points[i] = new_position
	
	# Update the Line2D with new points
	$Trail.clear_points()
	for point in trail_points:
		$Trail.add_point(point - position)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("Player position: ", global_position)
		print("Player velocity: ", velocity)
