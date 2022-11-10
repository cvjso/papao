extends CanvasLayer

var mouse_on = false

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("click") and mouse_on:
		Globals.change_scene("res://scenes/Playtest.tscn")

func _on_Area2D_mouse_entered():
	mouse_on = true


func _on_Area2D_mouse_exited():
	mouse_on = false
