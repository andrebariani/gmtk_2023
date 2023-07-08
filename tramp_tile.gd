extends BasicTile

@onready var player_detect = $player_detect

func _physics_process(_delta):
	player_detect.force_raycast_update()
	
	if player_detect.is_colliding():
		var player = player_detect.get_collider()
		if player.curr_state == player.state.MOVE:
			player.apply_jump(player.JUMP_VELOCITY * 1.4)
