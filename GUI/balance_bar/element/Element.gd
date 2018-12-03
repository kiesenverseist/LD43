extends Control

var Element = preload("res://GUI/balance_bar/element/Element.tscn") 
var locked = false setget lock
var is_preview = false
onready var panel = $Panel

enum {
	GOOD,
	BAD,
	NUETRAL,
	SPECIAL
}

var card = null

var panel_offset = Vector2(50, -100)

var data = {
	card = null,
	type = GOOD
} setget update_data

func _ready():
	if card == null:
		card = $"/root/Main/CardManager".get_card()
		self.data.card = card
	if !is_preview:
		remove_child(panel)
		$"../../../../".add_child(panel)
	update_data()

func _process(delta):
	panel.visible = !is_preview and Rect2(Vector2(), rect_size).has_point(get_local_mouse_position())
	panel.rect_global_position = get_viewport().get_mouse_position() + panel_offset
	get_viewport()
# to pick up
func get_drag_data(pos):
	if locked:
		return false
	
	var e = Element.instance()
	e.is_preview = true
	e.card = card
	e.data = data
	
	# reference to self in preview to delete when placed
	e.data.ref = self
	set_drag_preview(e)
	return data

func update_data(new = data):
	data = new
	
	
	
	$TextureRect.visible = false
	$TextureRect2.visible = false
	$TextureRect3.visible = false
	
	match card.tier:
		1:
			$TextureRect2.visible = true
		2:
			$TextureRect3.visible = true
		3:
			$TextureRect.visible = true
	
	if !is_preview:
		$name.text = str(card.name)
		panel.get_node("name").text = card.name
		panel.get_node("description").text = card.description
		
		if card.id < 0:
			data.type = SPECIAL
		
		match data.type:
			GOOD:
				panel.get_node("description2").text = str(card.benifits.description)
			BAD:
				panel.get_node("description2").text = str(card.detriments.description)
		
		match get_parent().get_parent().get_parent().type:
			NUETRAL:
				panel.get_node("benifits_c").visible = true
				panel.get_node("benifits_d").visible = true
				panel.get_node("detriments_c").visible = false
				panel.get_node("detriments_d").visible = false
			GOOD:
				panel.get_node("benifits_c").visible = true
				panel.get_node("benifits_d").visible = true
				panel.get_node("detriments_c").visible = true
				panel.get_node("detriments_d").visible = true
			BAD:
				panel.get_node("benifits_c").visible = false
				panel.get_node("benifits_d").visible = false
				panel.get_node("detriments_c").visible = true
				panel.get_node("detriments_d").visible = true
				panel_offset = Vector2(-340, -100)
		
		
		panel.get_node("benifits_c").text = "Passive generation: \n Humans: %s \n Money: %s \n Research: %s" % \
				[str(card.benifits.generation.human),str(card.benifits.generation.money),str(card.benifits.generation.research)]
		panel.get_node("benifits_d").text = "On application: \n Humans: %s \n Money: %s \n Research: %s" % \
				[str(card.benifits.instant.human),str(card.benifits.instant.money),str(card.benifits.instant.research)]
		panel.get_node("detriments_c").text = "Passive after removal: \n Humans: %s \n Money: %s \n Research: %s" % \
				[str(card.detriments.generation.human),str(card.detriments.generation.money),str(card.detriments.generation.research)]
		panel.get_node("detriments_d").text = "On removal: \n Humans: %s \n Money: %s \n Research: %s" % \
				[str(card.detriments.instant.human),str(card.detriments.instant.money),str(card.detriments.instant.research)]
		

#lock after placement, so it cannot be picked up
func lock(val : bool):
	locked = val
	mouse_filter = MOUSE_FILTER_PASS

func queue_free():
	panel.queue_free()
	.queue_free()
