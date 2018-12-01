extends Node2D

onready var bar = $GUI/BalanceBar
onready var machine = $Machine

var level = 1

func _ready():
	pass

func _on_BalanceBar_changed(temp):
	var new = int(bar.max_value / 500)
	machine.level = new