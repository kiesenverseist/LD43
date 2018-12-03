extends Container

var Element = preload("res://GUI/balance_bar/element/Element.tscn") 
var locked = false setget lock

enum {
	GOOD,
	BAD,
	NUETRAL
}

var data = {
	card = null,
	type = GOOD
} setget update_data

func _ready():
	data.card = $"/root/Main/CardManager".get_card()
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
	$Label.text = str(data.card.name)

#lock after placement, so it cannot be picked up
func lock(val : bool):
	locked = val
	mouse_filter = MOUSE_FILTER_PASS