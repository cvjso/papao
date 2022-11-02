extends Control

var stamina = 0
var life = 0

var stamina_empty = preload("res://sprites/HUD/BURACO STAMINA HUD.png")
var stamina_full = preload("res://sprites/HUD/STAMINA.png")

var life_empty = preload("res://sprites/HUD/BURACO VIDA HUD.png")
var life_full = preload("res://sprites/HUD/VIDA HUD.png")

onready var stamina_box = $stats/stamina
onready var life_box = $stats/life

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(stamina):
		var t = TextureRect.new()
		t.texture = stamina_full
		stamina_box.add_child(t)
		
	for i in range(life):
		var t = TextureRect.new()
		t.texture = life_full
		life_box.add_child(t)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
