extends Node2D

var mouse_on = false
var enemy_spoted = false
var enemy_node = null


func _ready():
	pass

func _input(event):
	if event.is_action_pressed("click") and mouse_on and enemy_spoted:
		enemy_node.take_damage(3)

func _on_Area2D_mouse_entered():
	mouse_on = true

func _on_Area2D_mouse_exited():
	mouse_on = false


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		enemy_node = area.get_parent()
		enemy_spoted = true
