extends Node2D

export var stamina = 3
export var vision = 3
export var damage = 2
export var range_weapon = 4

var area_node = preload("res://scenes/player area.tscn")
var damage_area = preload("res://scenes/damage area.tscn")
onready var p_sprite = $"area spawn"
onready var light = $Light2D
onready var anim = $AnimationPlayer

var mouse_on = false
var area_on = false

var base_dist = 16
var padding_y := 0
var padding_x := 0

func _ready():
	light.texture_scale = vision + 1

func move_player(pos:Vector2):
	var TW = create_tween()
	anim.play("walk")
	TW.tween_property(self, "global_position", pos, 0.6)
	yield(anim, "animation_finished")
	anim.play("idle")
	clean_area()

func add_area(pos:Vector2, target:Node2D, area_n):
	var area_inst = area_n.instance()
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
	clean_area()
	area_on = true
	var distance = 1
	var area_target = Node2D.new()
	p_sprite.add_child(area_target)
	for i in range(stamina):
		# downs
		add_area(Vector2(-base_dist * distance + padding_x, base_dist/2 * distance + padding_y), p_sprite, area_node)
		add_area(Vector2(base_dist * distance + padding_x, base_dist/2 * distance + padding_y), p_sprite, area_node)
		# ups
		add_area(Vector2(-base_dist * distance, -base_dist/2 * distance), p_sprite, area_node)
		add_area(Vector2(base_dist * distance, -base_dist/2 * distance), p_sprite, area_node)
		distance += 1

func show_damage_area():
	area_on = true
	var distance = 1
	var area_target = Node2D.new()
	p_sprite.add_child(area_target)
	for i in range(stamina):
		# downs
		add_area(Vector2(-base_dist * distance + padding_x, base_dist/2 * distance + padding_y), p_sprite, damage_area)
		add_area(Vector2(base_dist * distance + padding_x, base_dist/2 * distance + padding_y), p_sprite, damage_area)
		# ups
		add_area(Vector2(-base_dist * distance, -base_dist/2 * distance), p_sprite, damage_area)
		add_area(Vector2(base_dist * distance, -base_dist/2 * distance), p_sprite, damage_area)
		distance += 1

func _on_Area2D_mouse_entered():
	mouse_on = true

func _on_Area2D_mouse_exited():
	mouse_on = false

func _input(event):
	if event.is_action_pressed("weapon"):
		clean_area()
		show_damage_area()
	if event.is_action_pressed("click") and area_on:
		clean_area()
	elif event.is_action_pressed("click") and mouse_on and not area_on:
		show_area()
		Globals.player = self
