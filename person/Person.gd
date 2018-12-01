extends KinematicBody2D

var speed = 30
var dir = 1
var vel = Vector2()

func _ready():
	pass

func _process(delta):
	if position.x > 1024 - 32:
		dir = -1
	if position.x < 32:
		dir = 1
	
	if randf() < .01:
		dir = randi()%3 -1
	

func _physics_process(delta):	
	if is_on_floor():
		vel.x = speed * dir
		vel.y = 0
	else:
		vel.y += 10
	move_and_slide(vel, Vector2(0, -1))