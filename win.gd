extends Area2D

signal win

func _on_body_entered(_body):
	$AudioStreamPlayer.play(0.0)
	win.emit()
	$Confetti.emitting = true
	
