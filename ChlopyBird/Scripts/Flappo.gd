extends Node2D
export var gravity: float
export var flap_strength: float

var velocity: float

func _physics_process(delta):
	position.y = position.y - velocity * delta
	if velocity > gravity:
		velocity = velocity + gravity * delta
	
func _input(ev):
	if Input.is_action_just_pressed('jump'):
		velocity = flap_strength
		

func jump(strength):
	velocity = clamp(strength, 0, flap_strength)
