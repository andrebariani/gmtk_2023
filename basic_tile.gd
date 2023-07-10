extends CharacterBody2D
class_name BasicTile


var tile_size = 8
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}


var animation_speed = 30
var moving = false
var initial_position = Vector2.ZERO

var selected = false
var stop = false

@onready var ray = $RayCast2D

func _ready():
	initial_position = position

func _unhandled_input(event):
	if not stop:
		if selected:
			if event.is_action_pressed("reset_tile"):
				$reset.play(0.0)
				position = initial_position
			if moving:
				return
			for dir in inputs.keys():
				if event.is_action_pressed(dir, true):
					move(dir)

func move(dir):
	$move.play(0.0)
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_LINEAR)
		moving = true
		await tween.finished
		moving = false
