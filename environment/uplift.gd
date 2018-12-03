extends Area2D

var active = true

func _on_uplift_body_entered(body):
	if body is KinematicBody2D and active:
		body.grav = -1

func _on_uplift_body_exited(body):
	if body is KinematicBody2D:
		body.grav = 2.5

func _on_Timer_timeout():
	active = !active
	$AnimatedSprite.visible = active
