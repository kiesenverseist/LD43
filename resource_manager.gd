extends Node

onready var m = $"../"

#get rid of all this
var human_consumption = {
	money = -1,
	research = 1
}

var passive_creation = {
	money = 5.0,
	humans = 0.1,
	research = 1.0
}

var research_reward = {
	money = 0,
	humans = 0,
	research = 0
}

var total_benifit = {
	money = 0.0,
	humans = 0.0,
	research = 0.0
}

var total_detriment = {
	money = 0.0,
	humans = 0.0,
	research = 0.0
}


func research_completed():
	for type in research_reward:
		m.resources[type] += research_reward[type]

func _on_ResourceTrackerCountdown_timeout():
	for type in human_consumption:
		if m.resources[type] < -human_consumption[type] * m.resources.humans:
			m.resources.humans -= 1
			m.resources.money += 100
			continue
		m.resources[type] += human_consumption[type] * m.resources.humans
	
	for type in passive_creation:
		m.resources[type] += passive_creation[type]

	
	for type in passive_creation:
		m.resources[type] += total_benifit[type] + total_detriment[type]
		
	if m.resources.money > 100 * m.level:
		m.uplevel()
		m.resources.money -= 100 * m.level

	
#for type in requirements:
#		for req in requirements[type]:
#			m.resources[req] += requirements[type][req] * m.resources[req]


func _on_GoodBar_card_changed(list):
	var temp = {
		money = 5.0,
		human = 0.0,
		research = 0.0
	}
	
	for i in list:
		for type in i.benifits.generation:
			temp[type] += i.benifits.generation[type]
	
	total_benifit.money = temp.money
	total_benifit.humans = temp.human
	total_benifit.research = temp.research
	
	print(total_benifit)


func _on_BadBar_card_changed(list):
	var temp = {
		money = 5.0,
		human = 0.0,
		research = 0.0
	}
	
	for i in list:
		for type in i.detriments.generation:
			temp[type] += i.detriments.generation[type]
	
	total_detriment.money = temp.money
	total_detriment.humans = temp.human
	total_detriment.research = temp.research
