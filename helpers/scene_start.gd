extends Node2D

@onready var transition = $RoomChangeArea/SceneTransitionAnimation/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.get_parent().get_node("ColorRect").color.a = 255
	transition.play("fade_out") 
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
