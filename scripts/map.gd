tool
extends Node2D

export(int) var grid_size = 0

onready var tilemap = $TileMap

var matrix := []
var proportion = [2,8]

func _ready():
	randomize()
	render_world()

func render_world():
	tilemap.clear()
	var prop = proportion.duplicate()
	for i in range(2):
		var s = grid_size * grid_size * prop[i]
		prop[i] = round(s / 10.0)
	for i in range(grid_size):
		matrix.append([])
		for j in range(grid_size):
			var tile = randi() % 2
			if prop[tile] == 0:
				while prop[tile] == 0:
					tile = randi() % 2
			matrix[i].append(tile)
			tilemap.set_cell(i, j, tile)
			prop[tile] -= 1
