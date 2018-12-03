extends KinematicBody2D

var speed = randi()%10 + 5
var dir = 1
var vel = Vector2()
var alive = true
var grav = 2.5
var extents = 20

func _ready():
	pass

func _process(delta):
	if !alive:
		dir = 1
		speed = 15
		
		if position.x > extents:
			queue_free()
	else:	
		if randf() < .01:
			dir = randi()%3 -1
		
		if position.x > extents:
			dir = -1
		if position.x < -extents:
			dir = 1
	
	match dir:
		-1:
			$body.animation = "walking"
			$body.flip_h = false
		0:
			$body.animation = "idle"
		1:
			$body.animation = "walking"
			$body.flip_h = true
	

func _physics_process(delta):	
	vel.x = speed * dir
	if is_on_floor() or is_on_ceiling():
		vel.y = 0
	else:
		vel.y += grav
	move_and_slide(vel, Vector2(0, -1))

func kill():
	alive = false