extends Area2D

func _on_uplift_body_entered(body):
	if body is KinematicBody2D:
		body.grav = -5

func _on_uplift_body_exited(body):
	if body is KinematicBody2D:
		body.grav = 10
