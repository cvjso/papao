extends Node2D

var snake_pos
var move = 10
var life = 3

func _ready():
	snake_pos = Globals.populate_snake()
	self.global_position = Globals.get_map_to_world_pos(snake_pos)

func move():
	snake_pos = Globals.move_snake(snake_pos)
	self.global_position = Globals.get_map_to_world_pos(snake_pos)

func _input(event):
	if event.is_action_pressed("debug"):
		move()

func take_damage(value):
	life -= value
	if life < 0:
		self.queue_free()
