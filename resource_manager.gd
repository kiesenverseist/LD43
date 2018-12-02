extends Node

onready var m = $"../"

var human_consumption = {
	money = -1,
	research = 1,
	materials = 0,
	energy = 0
}

var machine_consumption = {
	money = 5,
	materials = -3,
	energy = -3,
	humans = 0,
	research = 0
}

var passive_creation = {
	money = 5,
	materials = 5,
	energy = 5,
	humans = 0,
	research = 0
}

#chnage this in a few
var requirements = {
	humans = {
		humans = 0,
		money = -1,
		research = 1,
		materials = 0,
		energy = 0
	},
	money = {
		humans = 0,
		money = 0,
		research = 0,
		materials = 0,
		energy = 0
	},
	research = {
		humans = 0,
		money = 1,
		research = 0,
		materials = 0,
		energy = 0
	},
	materials = {
		humans = 0,
		money = -1,
		research = 0,
		materials = 0,
		energy = 0
	},
	energy = {
		humans = 0,
		money = -1,
		research = 0,
		materials = 1,
		energy = 0
	}
}

func _on_ResourceTrackerCountdown_timeout():
	for type in human_consumption:
		m.resources[type] += human_consumption[type] * m.resources.humans
	
	for type in machine_consumption:
		m.resources[type] += machine_consumption[type]
#for type in requirements:
#		for req in requirements[type]:
#			m.resources[req] += requirements[type][req] * m.resources[req]