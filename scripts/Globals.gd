extends Node

var camera := Camera2D.new()
export var zoom_value = 1.0
export var speed = 10
export var offset = Vector2(0,100)

func _ready():
	get_tree().current_scene.add_child(camera)
	camera.current = true
	camera.offset = offset

func zoom_in():
	zoom_value += 0.1
	camera.zoom.x = zoom_value
	camera.zoom.y = zoom_value

func zoom_out():
	zoom_value -= 0.1
	camera.zoom.x = zoom_value
	camera.zoom.y = zoom_value

func move_cam(x_val, y_val):
	var old_offset = camera.offset
	camera.offset = Vector2(old_offset.x + x_val, old_offset.y + y_val)

func handle_move(event):
	if event.is_action_pressed("back"):
		move_cam(0, speed)
	if event.is_action_pressed("front"):
		move_cam(0, -speed)
	if event.is_action_pressed("left"):
		move_cam(-speed, 0)
	if event.is_action_pressed("right"):
		move_cam(speed, 0)

func handle_zoom(event):
	if event.is_action_pressed("down"):
		zoom_in()
	if event.is_action_pressed("up"):
		zoom_out()

func _input(event):
	handle_move(event)
	handle_zoom(event)
	
	
