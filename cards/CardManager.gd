extends Node

var cards = []

func _ready():
	var d = Directory.new()
	d.open("res://cards/list")
	d.list_dir_begin()
	
	var fn = d.get_next()
	while fn != "":
		var f = load("res://cards/list/" + fn)
		
		if f:
			cards.append(f)
		
		fn = d.get_next()

func get_card(id = -1):
	if id == -1:
		return cards[randi()%1]