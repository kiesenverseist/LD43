extends Container

func _ready():
	pass

var good_val = 0
var bad_val = 0

var max_value = 100.0
var value = 0

var pos = 0
var extent = 0

var half_length = 0

signal changed

func _process(delta):
	pos += (extent - pos)/10
	half_length = get_viewport_rect().size.x/2
	
	if pos > 0:
		$Bar.margin_left = 0
		$Bar.margin_right = pos * half_length
	else:
		$Bar.margin_right = 0
		$Bar.margin_left = pos * half_length
	
	var c = Color(0,1,0).linear_interpolate(Color(1,0,0), abs(pos*3))
	$Bar.color = c

func refresh():
	value = good_val - bad_val
	
	extent = value / max_value
	
	emit_signal("changed")

func _on_good_changed(val):
	good_val = val
	refresh()

func _on_bad_changed(val):
	bad_val = val
	refresh()