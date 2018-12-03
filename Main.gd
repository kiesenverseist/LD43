extends Node2D

onready var machine = $Machine

onready var person = preload("res://person/Person.tscn")
onready var elm = preload("res://GUI/balance_bar/element/Element.tscn")

var level = 0 setget levelup
var stable = true
var level_given = false
var research_goal = 20

var record = {
	humans = [],
	money = [],
	research = []
}

var resources = {
	humans = 10.0,
	money = 500.0,
	research = 0.0\
}

var colors = {
	humans = Color(0.890625, 0.184387, 0.184387),
	money = Color(0.477047, 0.898438, 0.403595),
	research = Color(0.398712, 0.50438, 0.785156)
}

var limits = {
	humans = 20.0,
	money = 1000.0,
	research = 500.0,
}

var level_config = {
	0 : {
		zoom = Vector2(0.16,0.16),
		camera_pos = Vector2(0, 0),
		extents = 70,
		limits = 0
	},
	1 : {
		zoom = Vector2(0.16,0.16),
		camera_pos = Vector2(0, 0),
		extents = 70,
		limits = 0
	},
	2 : {
		zoom = Vector2(0.16,0.16),
		camera_pos = Vector2(0, 0),
		extents = 70,
		limits = 0
	},
	3 : {
		zoom = Vector2(.32,.32),
		camera_pos = Vector2(0, -48),
		extents = 160,
		limits = 3000
	},
	4 : {
		zoom = Vector2(.32,.32),
		camera_pos = Vector2(0, -48),
		extents = 160,
		limits = 3000
	}
}

func _ready():
	self.level = 0
	uplevel()
#	for i in range(1,5):
#		print(-i)
#		var c = $CardManager.get_card(-i)
#		var e = elm.instance()
#
#		$GUI/TabContainer/Balance/ElementBar.list.add_child(e)
#
#		yield(get_tree(), "idle_frame")
#
#		e.card = c
#		e.data.card = c
		

func _process(delta):
	if resources.research > research_goal:
		research_complete()

func research_complete():
	resources.research = 0
	research_goal = randi()%(50*level^2) + 20 * level
	$GUI/TabContainer/Balance/ElementBar.generate_card()
	$resource_manager.research_completed()

func levelup(val):	
	level_given = false
	machine.level = val
	level = val
	var config = level_config[min(val,4)]
	
	$Camera2D.zoom = config.zoom
	$Camera2D.position = config.camera_pos
	
	$people.extents = config.extents
	
	resources.humans += 2
	limits.money += config.limits
	
	for c in $room.get_children():
		c.visible = false
		c.get_node("StaticBody2D").set_collision_layer_bit(0,false)
	
	match level:
		0,1,2:
			$room/level1.visible = true
			$room/level1/StaticBody2D.set_collision_layer_bit(0, true)
		3,4:
			$room/level2.visible = true
			$room/level1/StaticBody2D.set_collision_layer_bit(0, true)
			

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
		
		match level:
			0,1 :
				p.position = Vector2(-100,0)
			2,3:
				p.position = Vector2(randi()%($people.extents*2)-$people.extents,-randi()%100-200)
		
		$people.add_child(p)
		
		yield(get_tree(), "idle_frame")
	
	while $people.get_people() > resources.humans:
		$people.get_child(0).kill()
		yield(get_tree(), "idle_frame")
		

func _on_SpecialBar_card_changed(list):
	self.level = list.size()

func uplevel():
	
	if level_given:
		return
	
	level_given = true
	
	var c = $CardManager.get_card(-(level + 1))
	var e = elm.instance()
	
	$GUI/TabContainer/Balance/ElementBar.list.add_child(e)
	
	yield(get_tree(), "idle_frame")
	
	e.card = c
	e.data.card = c
