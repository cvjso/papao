extends CanvasLayer

export(Array, NodePath) var players
export(Array, NodePath) var enemies

var player_hud = preload("res://scenes/player-hud.tscn")
onready var container = $VBoxContainer
var done = false

func _ready():
	for i in range(len(players)):
		var t = player_hud.instance()
		t.life = get_node(players[i]).life
		t.stamina = get_node(players[i]).stamina
		t.icon = get_node(players[i]).icon
		t.nome = get_node(players[i]).nome
		container.add_child(t)
		get_node(players[i]).connect("taken_damage", t, "take_damage")
		get_node(players[i]).connect("used_stamina", t, "use_stamina")
		get_node(players[i]).connect("dead", t, "dies")

func _process(delta):
	if get_node(enemies[0]) == null and !done:
		done = true
		Globals.change_scene("res://scenes/Vitoria.tscn")
	if container.get_child_count() == 0 and !done:
		done = true
		Globals.change_scene("res://scenes/derrota.tscn")

func _on_Button_pressed():
	for i in range(len(players)):
		var p = get_node(players[i])
		if p != null:
			if p.life <= 0:
				p.die()
			p.stamina = p.max_stamina
	for i in container.get_children():
		i.refill_stamina()
	for i in range(len(enemies)):
		var e = get_node(enemies[i])
		e.turn()
