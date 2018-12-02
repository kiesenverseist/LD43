extends Node

var extents = 20 setget set_extents

func _ready():
	pass

func get_people():
	var children = get_children()
	var count = 0
	
	for c in children:
		if c.alive:
			count += 1
	
	return count

func set_extents(val):
	for c in get_children():
		c.extents = val
	
	extents = val