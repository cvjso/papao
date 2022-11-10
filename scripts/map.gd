tool
extends Node2D

export(int) var grid_size = 0

onready var tilemap = $TileMap

export(Array, int) var proportion = [7,2,1]
var trunk = []

func _ready():
	randomize()
	render_world()

func populate():
	for i in range(grid_size):
		for j in range(grid_size):
			var tile = trunk.pop_front()
			Globals.matrix[i].append(tile)
			tilemap.set_cell(i, j, tile)

func render_world():
	tilemap.clear()
	Globals.matrix = []
	var prop = proportion.duplicate()
	for i in range(len(proportion)):
		var s = grid_size * grid_size * prop[i]
		prop[i] = round(s / 10.0)
	for i in range(grid_size):
		Globals.matrix.append([])
		for j in range(grid_size):
			var tile = randi() % len(proportion)
			if prop[tile] == 0:
				while prop[tile] == 0:
					tile = randi() % len(proportion)
			trunk.append(tile)
			prop[tile] -= 1
	trunk.shuffle()
	populate()
