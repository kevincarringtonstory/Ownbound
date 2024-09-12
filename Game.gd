extends Node2D

var trail = []
const TRAIL_LENGTH = 50

func _ready():
	center_camera()

func center_camera():
	var viewport_size = get_viewport().size
	$Player.position = viewport_size / 2
	$Player/Camera2D.make_current()

func _process(delta):
	update_trail()
	queue_redraw()

	if Input.is_action_just_pressed("ui_accept"):
		print("Player position: ", $Player.global_position)
		print("Player velocity: ", $Player.velocity)

func update_trail():
	trail.push_front($Player.global_position)
	if trail.size() > TRAIL_LENGTH:
		trail.pop_back()

func _draw():
	for i in range(1, trail.size()):
		draw_line(trail[i-1] - $Player.global_position, trail[i] - $Player.global_position, Color(1, 1, 0), 2)
