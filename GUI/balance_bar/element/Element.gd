extends Container

var Element = preload("res://GUI/balance_bar/element/Element.tscn") 
var locked = false setget lock

enum {
	GOOD,
	BAD,
	NUETRAL
}

var data = {
	value = int(rand_range(16,128)),
	type = GOOD
} setget update_data

func _ready():
	
	update_data()

# to pick up
func get_drag_data(pos):
	if locked:
		return false
	
	var e = Element.instance()
	e.data = data
	
	# reference to self in preview to delete when placed
	e.data.ref = self
	set_drag_preview(e)
	return data

func update_data(new = data):
	data = new
	$Label.text = str(data.value)

#lock after placement, so it cannot be picked up
func lock(val : bool):
	locked = val
	mouse_filter = MOUSE_FILTER_PASS