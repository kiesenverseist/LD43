extends Node2D

onready var bar = $GUI/StabilityBar
onready var machine = $Machine

var level = 1

var record = {
	humans = [],
	money = [],
	research = [],
	materials = []
}

var resources = {
	humans = 1,
	money = 1000,
	research = 0,
	materials = 100
}

func _ready():
	pass

func _on_StabilityBar_changed():
	var new = int((bar.good_val + bar.bad_val) / 500)
	machine.level = new

func _on_ResourceTrackerCountdown_timeout():
	for r in resources:
		resources[r] += rand_range(-10,10)
		if resources[r] < 0: resources[r] = 0
	
	record.humans.push_front(resources.humans)
	record.money.push_front(resources.money)
	record.research.push_front(resources.research)
	record.materials.push_front(resources.materials)
	
	for arr in record:
		while record[arr].size() >= 100:
			record[arr].pop_back()
	
	$GUI/TabContainer/Resources/Graph.update()