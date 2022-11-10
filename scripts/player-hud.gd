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

func dies():
	queue_free()

func take_damage():
	var last = life_box.get_child(0)
	life_box.remove_child(last)
	var t = TextureRect.new()
	t.texture = life_empty
	life_box.add_child(t)

func use_stamina():
	var last = stamina_box.get_child(0)
	stamina_box.remove_child(last)
	var t = TextureRect.new()
	t.texture = stamina_empty
	stamina_box.add_child(t)

func refill_stamina():
	for i in stamina_box.get_children():
		stamina_box.remove_child(i)
	for i in range(stamina):
		var t = TextureRect.new()
		t.texture = stamina_full
		stamina_box.add_child(t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
