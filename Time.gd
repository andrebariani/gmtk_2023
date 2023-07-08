extends Label

@onready main = get_parent().main
var time = 0.0

func _ready():
	time = main.time_elapsed
	set_text("%02d:%02d:%02d" % [time / 60, fmod(time, 60), fmod(time, 1) * 100])
	
