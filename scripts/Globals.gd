tool
extends Node

# camera
var camera := Camera2D.new()
var zoom_value = 1.0
var speed = 10
var offset = Vector2(0,50)

# map
var matrix := []
var player_pos = Vector2(0,0)
var map
var player

func is_tile_available(pos:Vector2):
	return !matrix[pos.x][pos.y] == 2

func is_path_available(start:Vector2, end:Vector2):
	var x_diff = end.x - start.x
	var y_diff = end.y - start.y
	
	while(x_diff != 0):
		if !is_tile_available(Vector2(start.x + x_diff, start.y)):
			return false
		if x_diff < 0:
			x_diff += 1
		if x_diff > 0:
			x_diff -= 1
	
	while(y_diff != 0):
		if !is_tile_available(Vector2(start.x, start.y + y_diff)):
			return false
		if y_diff < 0:
			y_diff += 1
		if y_diff > 0:
			y_diff -= 1
	return true

func move_player(pos:Vector2):
	map = get_tree().current_scene.find_node("map")
	var n_pos = map.get_node("TileMap").world_to_map(pos)
	var p_pos = map.get_node("TileMap").world_to_map(player.global_position)
	if n_pos.x < len(matrix) and n_pos.x >= 0 and n_pos.y >= 0 and n_pos.y < len(matrix) and is_path_available(p_pos, n_pos):
		
		#player = get_tree().current_scene.find_node("player")
		player.move_player(pos)
		return true
	return false

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

func handle_quit(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()

func _input(event):
	handle_move(event)
	handle_zoom(event)
	handle_quit(event)
	
	
