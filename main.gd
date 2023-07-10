extends Node2D

@onready var transition = $CanvasLayer/Transition

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
	$fadeout.play(0.0)
	var tween = get_tree().create_tween()
	tween.finished.connect(_on_fade_out)
	tween.tween_property(transition.material, "shader_parameter/progress", 1, 1).set_trans(Tween.TRANS_LINEAR)

func _on_fade_out():
	$CurrentLevel.get_child(0).queue_free()
	
	$CanvasLayer.rotation = deg_to_rad(180)
	$CanvasLayer.offset.x = 400
	$CanvasLayer.offset.y = 224
	
	# eew
	level_idx += 1
	if level_idx >= levels.size():
		level_idx = 0
	
	var level = levels[level_idx].instantiate()
	$CurrentLevel.add_child(level)
	
	$fadein.play(0.0)
	var tween = get_tree().create_tween()
	tween.finished.connect(_on_fade_in)
	tween.tween_property(transition.material, "shader_parameter/progress", 0, 0.7).set_trans(Tween.TRANS_LINEAR)

func _on_fade_in():
	$CanvasLayer.rotation = deg_to_rad(0)
	$CanvasLayer.offset.x = 0
	$CanvasLayer.offset.y = 0

