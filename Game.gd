extends Node2D

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("Player position: ", $Player.global_position)
		print("Player velocity: ", $Player.velocity)
