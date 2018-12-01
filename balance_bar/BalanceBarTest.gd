extends ColorRect

var Element = preload("res://balance_bar/element/Element.tscn")

export var starting_elements = 0

func _ready():
	for i in range(starting_elements):
		var e = Element.instance()
		$List.add_child(e)

func can_drop_data(pos, data):
	return typeof(data) == TYPE_DICTIONARY and data.has("ref")

func drop_data(pos, data):
	var e = Element.instance()
	$List.add_child(e)
	e.data = data
	data.ref.queue_free()
#	rect_size.y = $List.rect_size.y + 32