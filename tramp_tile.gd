extends BasicTile

@onready var player_detect = $player_detect

func _physics_process(_delta):
	player_detect.force_raycast_update()
	
	if player_detect.is_colliding():
		var player = player_detect.get_collider()
		if player.curr_state == player.state.MOVE:
			player.apply_jump(player.JUMP_VELOCITY * 1.4)
			
			# anim
			var tween = create_tween()
			tween.tween_property($Tiles, "position",
				Vector2(4, 0), 0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
			await tween.finished
			var tween_back = create_tween()
			tween_back.tween_property($Tiles, "position",
				Vector2(4, 4), 0.3).set_trans(Tween.TRANS_LINEAR)
