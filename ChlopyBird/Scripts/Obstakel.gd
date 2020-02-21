extends Node2D


export var speed: float
export var spawn_x: float
export var min_spawn_y: float
export var max_spawn_y: float


func _ready():
	position.x = spawn_x
	position.y = rand_range(min_spawn_y, max_spawn_y)


func _process(delta):
	position.x = position.x - speed * delta
	
	if position.x < -10:
		queue_free()
