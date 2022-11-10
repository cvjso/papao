extends Node2D

export var stamina = 3
export var vision = 3
export var life = 2
export var damage = 2
export var range_weapon = 4
export var icon:String
export var nome:String

onready var max_stamina = stamina

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

signal taken_damage
signal used_stamina
signal dead

func _ready():
	light.texture_scale = vision + 1

func move_player(pos:Vector2):
	var TW = create_tween()
	anim.play("walk")
	TW.tween_property(self, "global_position", pos, 0.6)
	yield(anim, "animation_finished")
	anim.play("idle")
	clean_area()
	stamina -= 1
	emit_signal("used_stamina")

func attack():
	anim.play("attack")
	yield(anim, "animation_finished")
	anim.play("idle")
	stamina -= 1
	emit_signal("used_stamina")

func take_damage(value):
	life -= value
	anim.play("damage")
	yield(anim, "animation_finished")
	anim.play("idle")
	emit_signal("taken_damage")
	if life <= 0:
		emit_signal("dead")
		visible = false
		#queue_free()

func add_area(pos:Vector2, target:Node2D, area_n, dam):
	var area_inst = area_n.instance()
	target.add_child(area_inst)
	if dam:
		area_inst.damage = damage
		area_inst.connect("spoted", self, "attack")
	area_inst.position = pos
	if pos.y < 0:
		area_inst.show_behind_parent = true

func clean_area():
	area_on = false
	while p_sprite.get_child_count() > 0:
		var n = p_sprite.get_child(0)
		p_sprite.remove_child(n)
		n.queue_free()

func die():
	emit_signal("dead")
	queue_free()

func show_area():
	clean_area()
	area_on = true
	var distance = 1
	var area_target = Node2D.new()
	p_sprite.add_child(area_target)
	for i in range(stamina):
		# downs
		add_area(Vector2(-base_dist * distance + padding_x, base_dist/2 * distance + padding_y), p_sprite, area_node, false)
		add_area(Vector2(base_dist * distance + padding_x, base_dist/2 * distance + padding_y), p_sprite, area_node, false)
		# ups
		add_area(Vector2(-base_dist * distance, -base_dist/2 * distance), p_sprite, area_node, false)
		add_area(Vector2(base_dist * distance, -base_dist/2 * distance), p_sprite, area_node, false)
		distance += 1

func show_damage_area():
	area_on = true
	var distance = 1
	var area_target = Node2D.new()
	p_sprite.add_child(area_target)
	for i in range(range_weapon):
		# downs
		add_area(Vector2(-base_dist * distance + padding_x, base_dist/2 * distance + padding_y), p_sprite, damage_area, true)
		add_area(Vector2(base_dist * distance + padding_x, base_dist/2 * distance + padding_y), p_sprite, damage_area, true)
		# ups
		add_area(Vector2(-base_dist * distance, -base_dist/2 * distance), p_sprite, damage_area, true)
		add_area(Vector2(base_dist * distance, -base_dist/2 * distance), p_sprite, damage_area, true)
		distance += 1

func _on_Area2D_mouse_entered():
	mouse_on = true

func _on_Area2D_mouse_exited():
	mouse_on = false

func _input(event):
	if event.is_action_pressed("weapon") and stamina > 0:
		clean_area()
		show_damage_area()
	if event.is_action_pressed("click") and area_on:
		clean_area()
	elif event.is_action_pressed("click") and mouse_on and not area_on:
		show_area()
		Globals.player = self
