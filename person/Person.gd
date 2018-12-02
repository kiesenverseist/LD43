extends KinematicBody2D

var speed = 10
var dir = 1
var vel = Vector2()
var alive = true
var grav = 10
var extents = 20

func _ready():
	pass

func _process(delta):
	if randf() < .01:
		dir = randi()%3 -1
	
	if position.x > extents:
		dir = -1
	if position.x < -extents:
		dir = 1

func _physics_process(delta):	
	vel.x = speed * dir
	if is_on_floor():
		vel.y = 0
	else:
		vel.y += grav
	move_and_slide(vel, Vector2(0, -1))

func kill():
	alive = false
	queue_free()