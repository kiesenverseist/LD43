extends ColorRect

var Element = preload("res://GUI/balance_bar/element/Element.tscn")

export var starting_elements = 0

var sum = 0 setget set_sum

onready var list = $ScrollContainer/List

enum TYPE {
	GOOD,
	BAD,
	NUETRAL
}

export(TYPE) var type

signal sum_changed(val)

func _ready():
	for i in range(starting_elements):
		var e = Element.instance()
		list.add_child(e)

#can what is being held be dropped
func can_drop_data(pos, data):
	return typeof(data) == TYPE_DICTIONARY \
			and data.has("ref") \
			and data.type == NUETRAL

#code to prcoess what happens to what is dropped
func drop_data(pos, data):
	var e = Element.instance()
	list.add_child(e)
	e.data = data
	e.data.type = type
	data.ref.queue_free()
	e.locked = true
	
	self.sum += data.value

func set_sum(val):
	sum = val
	$Sum.text = str(sum)
	emit_signal("sum_changed", sum)