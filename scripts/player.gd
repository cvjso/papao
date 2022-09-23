extends Node2D

export var stamina = 3

# deve se ir de 4 em 4 no y
# 8 em 8 no x
# quando colocado em y negativo deve-se marcar show behind parent

var area_node = preload("res://scenes/player area.tscn")
onready var p_sprite = $"player sprite"

var mouse_on = false
var area_on = false

func _ready():
	pass

func move_player(pos:Vector2):
	position = pos
	clean_area()

func add_area(pos:Vector2, target:Node2D):
	var area_inst = area_node.instance()
	target.add_child(area_inst)
	area_inst.position = pos
	if pos.y < 0:
		area_inst.show_behind_parent = true

func clean_area():
	area_on = false
	while p_sprite.get_child_count() > 0:
		var n = p_sprite.get_child(0)
		p_sprite.remove_child(n)
		n.queue_free()

func show_area():
	area_on = true
	var distance = 1
	var area_target = Node2D.new()
	clean_area()
	p_sprite.add_child(area_target)
	for i in range(stamina):
		# downs
		add_area(Vector2(-8 * distance, 4 * distance), p_sprite)
		add_area(Vector2(8 * distance, 4 * distance), p_sprite)
		# ups
		add_area(Vector2(-8 * distance, -4 * distance), p_sprite)
		add_area(Vector2(8 * distance, -4 * distance), p_sprite)
		distance += 1

func _on_Area2D_mouse_entered():
	mouse_on = true

func _on_Area2D_mouse_exited():
	mouse_on = false

func _input(event):
	if event.is_action_pressed("click") and area_on:
		clean_area()
	elif event.is_action_pressed("click") and mouse_on and not area_on:
		show_area()
