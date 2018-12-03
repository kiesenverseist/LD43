extends Control

var Element = preload("res://GUI/balance_bar/element/Element.tscn") 
var locked = false setget lock
var is_preview = false
onready var panel = $Panel

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
	if !is_preview:
		remove_child(panel)
		$"../../../../".add_child(panel)
	update_data()

func _process(delta):
	panel.visible = !is_preview and Rect2(Vector2(), rect_size).has_point(get_local_mouse_position())
	panel.rect_global_position = rect_global_position + Vector2(134,-42)

# to pick up
func get_drag_data(pos):
	if locked:
		return false
	
	var e = Element.instance()
	e.is_preview = true
	e.data = data
	
	# reference to self in preview to delete when placed
	e.data.ref = self
	set_drag_preview(e)
	return data

func update_data(new = data):
	data = new
	
	if !is_preview:
		$name.text = str(data.card.name)
		panel.get_node("VBoxContainer/name").text = data.card.name
		panel.get_node("VBoxContainer/description").text = data.card.description

#lock after placement, so it cannot be picked up
func lock(val : bool):
	locked = val
	mouse_filter = MOUSE_FILTER_PASS
