extends Node2D

var level = 1 setget set_level

func set_level(val):
	level = val + 1
	$Sprite.scale = Vector2(level,level)