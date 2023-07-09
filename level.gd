extends Node2D
class_name Level

var main = null
@onready var win_level := $Win
@onready var player := get_node_or_null("Player")
@onready var timeLabel := get_node_or_null("Time")
var player_initial_pos := Vector2.ZERO
var level_completed = false

func _ready():
	var _main = get_tree().get_nodes_in_group("main")
	if _main:
		main = _main[0]
	if player:
		player_initial_pos = player.position
	win_level.win.connect(_on_level_completed)
	
	if timeLabel:
		_set_timer_complete()

func _process(_delta):
	if not level_completed:
		if Input.is_action_just_pressed("reset"):
			player.reset()
			player.position = player_initial_pos
	else:
		if Input.is_action_just_pressed("ui_accept"):
			if main:
				main.next_level()
			else:
				get_tree().reload_current_scene()


func _on_level_completed():
	$MovableTiles.set_physics_process(false)
	for t in $MovableTiles.tiles:
		t.stop = true
	$Label.visible = true
	level_completed = true
	player.curr_state = player.state.WIN


func _set_timer_complete():
	if main:
		var time = main.time_elapsed
		timeLabel.set_text("%02d:%02d:%02d" % [time / 60, fmod(time, 60), fmod(time, 1) * 100])
