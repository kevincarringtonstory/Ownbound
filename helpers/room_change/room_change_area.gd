extends Area2D

@export var room_scene: String  
@onready var transition = $SceneTransitionAnimation/AnimationPlayer
var player: Player


var entered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group('player') as Player

func _on_body_entered(body: CharacterBody2D) -> void:
	entered = true
	

func _process(delta: float) -> void:
	#pass
	if entered == true:
		player.can_move = false
	
		player.set_process_input(false)
		make_transition()
		#how do I stop player movement on transition? Or continue movement on next frame
		
		
		
func make_transition():
	transition.play("fade")
	await get_tree().create_timer(.4).timeout
	get_tree().change_scene_to_file(room_scene)
