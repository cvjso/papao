tool
extends Node2D

export(int) var grid_size = 0

onready var tilemap = $TileMap

func _ready():
	render_world()

func render_world():
	for i in range(grid_size):
		for j in range(grid_size):
			tilemap.set_cell(i, j, 0)
