extends Area2D

signal win

func _on_body_entered(_body):
	win.emit()
	$Confetti.emitting = true
	
