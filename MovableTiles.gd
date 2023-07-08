extends Node2D
class_name MovableTiles

@onready var tiles = get_children()
var tiles_idx = 0
var particles

func _ready():
	tiles[tiles_idx].selected = true
	particles = preload("res://selected_particles.tscn").instantiate()
	particles.position = tiles[tiles_idx].position
	add_child(particles)


func _physics_process(_delta):
	particles.position = particles.position.lerp((tiles[tiles_idx].position) + Vector2(4,4), 40 * _delta)
	
	if Input.is_action_just_pressed("next_tile"):
		tiles[tiles_idx].selected = false
		
		# ugh
		tiles_idx += 1
		if tiles_idx >= tiles.size():
			tiles_idx = 0
		
		tiles[tiles_idx].selected = true
