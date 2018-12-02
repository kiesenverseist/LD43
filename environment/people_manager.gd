extends Node

func _ready():
	pass

func get_people():
	var children = get_children()
	var count = 0
	
	for c in children:
		if c.alive:
			count += 1
	
	return count