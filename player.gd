extends CharacterBody2D
class_name Player

@export var SPEED = 40.0
@export var JUMP_VELOCITY = -96.0

var gravity = 256

enum state {
	IDLE,
	MOVE,
	DEAD,
	WIN
}

var curr_state = state.IDLE
var ori = 1

@onready var anim = $AnimationPlayer
@onready var pit_detect = $pit_detect
@onready var pit_warning = $pit_warning
@onready var short_jump_detect = $short_jump
@onready var high_jump_detect = $hi_jump

@onready var dead_explode = preload("res://dead_explode_effect.tscn")

func _physics_process(delta):
	pit_detect.force_raycast_update()
	pit_warning.force_raycast_update()
	short_jump_detect.force_raycast_update()
	
	match curr_state:
		state.IDLE:
			if not is_on_floor():
				velocity.y += gravity * delta
				anim.play("air")
			else:
				anim.play("idle")
			
			if Input.is_action_just_pressed("ui_accept"):
				curr_state = state.MOVE
		state.MOVE:
			if not is_on_floor():
				velocity.y += gravity * delta
				anim.play("air")
			else:
				anim.play("move")

			if not (pit_detect.is_colliding() or pit_warning.is_colliding()) and is_on_floor():
				apply_jump(JUMP_VELOCITY)
			elif is_on_wall():
				if not short_jump_detect.is_colliding() and is_on_floor():
					apply_jump(JUMP_VELOCITY * 0.7)
				elif not high_jump_detect.is_colliding() and is_on_floor():
					apply_jump(JUMP_VELOCITY)
			

			velocity.x = ori * SPEED
		state.DEAD:
			$Sprite2D.visible = false
			anim.play("air")
			velocity = Vector2.ZERO
		state.WIN:
			anim.play("idle")
			velocity = Vector2.ZERO
			
	move_and_slide()

func apply_jump(_velocity):
	velocity.y = _velocity
	
	
func reset():
	anim.play("RESET")
	$Sprite2D.visible = true
	curr_state = state.IDLE
	velocity = Vector2.ZERO

func _on_hurtbox_body_entered(_body):
	if curr_state != state.DEAD:
		var particles = dead_explode.instantiate()
		particles.position = self.position + Vector2(4, 4)
		get_parent().add_child(particles)
		curr_state = state.DEAD

