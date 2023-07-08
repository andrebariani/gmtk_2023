extends Level

var main_menu = true

func _ready():
	$MovableTiles.set_physics_process(false)
	for t in $MovableTiles.tiles:
		t.stop = true
		
	player.set_physics_process(false)
	
	super._ready()

func _process(_delta):
	if main_menu:
		if Input.is_action_just_pressed("ui_accept"):
			main.game_start = true
			$MovableTilesMenu.set_physics_process(false)
			
			var tween = create_tween()
			tween.finished.connect(_on_transitioned)
			tween.tween_property($Camera2D, "position",
				Vector2(200, 112), 1).set_trans(Tween.TRANS_SINE)
				
			main_menu = false
	else:
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


func _on_transitioned():
	$MovableTiles.set_physics_process(true)
	for t in $MovableTiles.tiles:
		t.stop = false
	player.set_physics_process(true)
