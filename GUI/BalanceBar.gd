extends ProgressBar

var good_val = 0
var bad_val = 0

func refresh():
	max_value = good_val + bad_val
	value = good_val

func _on_good_changed(val):
	good_val = val
	refresh()

func _on_bad_changed(val):
	bad_val = val
	refresh()