extends PanelContainer

var Element = preload("res://GUI/balance_bar/element/Element.tscn") 
var locked = false setget lock

enum {
	GOOD,
	BAD
}

var data = {
	value = int(rand_range(16,128)),
	type = GOOD if randf() < .5 else BAD
} setget update_data

func _ready():
	update_data()

func get_drag_data(pos):
	if locked:
		return false
	
	var e = Element.instance()
	e.data = data
	e.data.ref = self
	set_drag_preview(e)
	return data

func update_data(new = data):
	data = new
	rect_min_size.y = data.value
	$Label.text = str(data.value)
	rect_min_size.x = 256
	
	match data.type:
		GOOD:
			modulate = Color(0,1,0)
		BAD:
			modulate = Color(1,0,0)
	

func lock(val : bool):
	locked = val
	mouse_filter = MOUSE_FILTER_PASS