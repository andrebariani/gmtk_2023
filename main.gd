extends Node2D

var levels = [
	preload("res://level.tscn"),
	preload("res://level2.tscn"),
	preload("res://level3.tscn"),
	preload("res://level_final.tscn"),
]
var level_idx = 0

signal game_started
var game_start = false
var time_elapsed = 0.0

func _ready():
	self.add_to_group("main")

func _process(delta):
	if game_start:
		time_elapsed += delta

func next_level():
	$CurrentLevel.get_child(0).queue_free()
	
	# oh noes
	level_idx += 1
	if level_idx >= levels.size():
		level_idx = 0
	
	var level = levels[level_idx].instantiate()
	$CurrentLevel.add_child(level)
