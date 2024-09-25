extends Area2D

@export var room_scene: String  

var entered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: CharacterBody2D) -> void:
	entered = true

func _process(delta: float) -> void:
	if entered == true:
		get_tree().change_scene_to_file(room_scene)
