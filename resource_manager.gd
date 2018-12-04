extends Node

onready var m = $"../"

#get rid of all this
var human_consumption = {
	money = -1,
	research = 1
}

var research_reward = {
	money = 0,
	humans = 0,
	research = 0
}

var total_machine = {
	money = 0.0,
	humans = 0.0,
	research = 0.0
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

	for type in total_benifit:
		m.resources[type] += total_benifit[type] + total_detriment[type] + total_machine[type]
		
	if m.resources.money > 100 * m.level:
		m.uplevel()

	
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

func _on_SpecialBar_card_changed(list):
	var temp = {
		money = 5.0,
		human = 0.0,
		research = 0.0
	}
	
	for i in list:
		for type in i.benifits.generation:
			temp[type] += i.benifits.generation[type]
	
	total_machine.money = temp.money
	total_machine.humans = temp.human
	total_machine.research = temp.research
