extends Node2D

onready var bar = $GUI/StabilityBar
onready var machine = $Machine

onready var person = preload("res://person/Person.tscn")

var level = 0 setget levelup
var stable = true

var record = {
	humans = [],
	money = [],
	research = [],
	materials = [],
	energy = []
}

var resources = {
	humans = 10,
	money = 100,
	research = 0,
	materials = 100,
	energy = 100
}

var colors = {
	humans = Color(0.492188, 0.345078, 0.26532),
	money = Color(0.298995, 0.492188, 0.26532),
	research = Color(0.398712, 0.50438, 0.785156),
	materials = Color(0.335861, 0.33695, 0.339844),
	energy = Color(0.839844, 0.763159, 0.262451)
}

var limits = {
	humans = 10.0,
	money = 1000.0,
	research = 100.0,
	materials = 1000.0,
	energy = 1000.0
}

var level_config = {
	0 : {
		zoom = Vector2(0.16,0.16),
		camera_pos = Vector2(0, 0),
		extents = 70
	},
	1 : {
		zoom = Vector2(0.16,0.16),
		camera_pos = Vector2(0, 0),
		extents = 70
	},
	2 : {
		zoom = Vector2(.32,.32),
		camera_pos = Vector2(0, -48),
		extents = 160
	},
	3 : {
		zoom = Vector2(.32,.32),
		camera_pos = Vector2(0, -48),
		extents = 160
	}
}

func _ready():
	self.level = 1

func _on_StabilityBar_changed():	
	stable = abs(bar.extent) < .5
	machine.stable = stable
	
	printt(bar.pos, stable)
	
	var new = int((bar.good_val + bar.bad_val) / 200)
	if new > level:
		self.level += 1

func levelup(val):	
	machine.level = val
	level = val
	var config = level_config[min(val,3)]
	
	$Camera2D.zoom = config.zoom
	$Camera2D.position = config.camera_pos
	
	$people.extents = config.extents
	
	for c in $room.get_children():
		c.visible = false
	
	resources.humans += 2
	
	match level:
		1:
			$room/level1.visible = true
		2,3:
			$room/level2.visible = true
			

func _on_ResourceTrackerCountdown_timeout():
	for r in resources:
		resources[r] = clamp(resources[r], 0, limits[r])
	
	resource_effects()
	
	for type in record:
		record[type].push_front(resources[type])
	
	for arr in record:
		while record[arr].size() >= 100:
			record[arr].pop_back()
	
	$GUI/TabContainer/Resources/Graph.update()

func resource_effects():
	while $people.get_people() < resources.humans:
		var p = person.instance()
		p.position = Vector2(randi()%($people.extents*2)-$people.extents,-randi()%100-200)
		$people.add_child(p)
		yield(get_tree(), "idle_frame")
	
	while $people.get_people() > resources.humans:
		$people.get_child(0).kill()
		yield(get_tree(), "idle_frame")
		