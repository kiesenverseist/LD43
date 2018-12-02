extends Area2D

var level = 1 setget set_level
var stable = true setget set_stable

func _ready():
	$ConsumptioPopup.popup()

func set_level(val : int):
	level = val
	
	$level1.visible = false
	$level2.visible = false
	$level3.visible = false
	
	match level:
		3:
			$level3.visible = true
			continue
		3,2:
			$level2.visible = true
			continue
		3,2,1:
			$level1.visible = true
	

func set_stable(val : bool):
	stable = val
	
	for c in [$level1, $level2, $level3]:
		c.get_node("stable").visible = stable
		c.get_node("unstable").visible = !stable

func _on_Machine_mouse_entered():
	$ConsumptioPopup.popup()
