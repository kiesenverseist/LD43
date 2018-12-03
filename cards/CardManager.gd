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

func get_card(id = null):
	if id == null:
		var c = null
		while c == null:
			c = cards[randi()%cards.size()]
			if c.id < 0:
				c = null
		return c
	
	for card in cards:
		if card.id == id:
			return card
	