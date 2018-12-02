extends Area2D

var level = 1 setget set_level

func _ready():
	$ConsumptioPopup.popup()

func set_level(val):
	level = val + 1

func _on_Machine_mouse_entered():
	$ConsumptioPopup.popup()
