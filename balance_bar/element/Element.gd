extends Panel

var Element = preload("res://balance_bar/element/Element.tscn") 

var data = {
	value = rand_range(16,64)
} setget update_data

func _ready():
	update_data()

func get_drag_data(pos):
	var e = Element.instance()
	e.data = data
	e.data.ref = self
	set_drag_preview(e)
	return data

func update_data(new = data):
	data = new
	rect_min_size.y = data.value
	rect_min_size.x = 256