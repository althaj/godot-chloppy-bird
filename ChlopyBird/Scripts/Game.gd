extends Node2D

var obstakel_scene = preload("res://Scenes/Obstakel.tscn")

export var min_timer: float
export var max_timer: float

var points: int = 0


var effect
var recording
var record_index
var label
var record
var data

func _ready():
	randomize()
	$Flappo/Area2D.connect('area_entered', self, '_on_flappo_crash')
	$ObstakelTimer.connect("timeout", self, 'spawn_obstakel')  
	spawn_obstakel()
	$UI/Label.text = str(points)
	
	record_index = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(record_index, 0)
	effect.set_recording_active(true)
	

func _on_flappo_crash(area):
	if area.is_in_group('Obstakels'):
		get_tree().reload_current_scene()


func spawn_obstakel():
	var obstakel = obstakel_scene.instance()
	add_child(obstakel)
	$ObstakelTimer.wait_time = rand_range(min_timer, max_timer)
	$ObstakelTimer.start()
	obstakel.get_node("Points").connect("area_entered", self, "add_points")
	

func add_points(area):
	points = points + 1
	$UI/Label.text = str(points)
	
	
func _process(delta):
	if effect.is_recording_active():
		var flap = AudioServer.get_bus_peak_volume_left_db(record_index, 0)
		if flap > -45:
			$Flappo.jump((flap + 45) * 28)
