extends CharacterBody2D

@export var speed: int = 80.0
@onready var actionable_finder = $Direction/ActionableFinder


func _unhandled_input(_event: InputEvent) -> void:
    
    if Input.is_action_just_pressed("ui_accept"):
            var actionables = actionable_finder.get_overlapping_areas()
            if actionables.size() > 0:
                actionables[0].action()
                velocity	 = Vector2.ZERO
            return
            
    handle_movement()

func _physics_process(delta: float) -> void:
    
    handle_animation()
    
#functions
    
func handle_movement():
    velocity = Vector2.ZERO
    if Input	.is_action_pressed("ui_right"):
        velocity.x += 1.0
    if Input	.is_action_pressed("ui_left"):
        velocity.x -= 1.0
    if Input	.is_action_pressed("ui_down"):
        velocity.y += 1.0
    if Input	.is_action_pressed("ui_up"):
        velocity.y -= 1.0
    velocity = velocity.normalized()	
    self.velocity = velocity * speed		
    
func handle_animation():
    
    if velocity == Vector2.ZERO:
        $AnimationTree.get("parameters/playback").travel("Idle")
    else:
        $AnimationTree.get("parameters/playback").travel("Walk")
        $AnimationTree.set("parameters/Idle/blend_position", velocity)
        $AnimationTree.set("parameters/Walk/blend_position", velocity)
    
    move_and_slide()	
    
    
