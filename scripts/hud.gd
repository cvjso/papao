extends CanvasLayer

export(Array, NodePath) var players

var player_hud = preload("res://scenes/player-hud.tscn")

func _ready():
	for i in range(len(players)):
		var t = player_hud.instance()
		t.life = get_node(players[i]).life
		t.stamina = get_node(players[i]).stamina
		$VBoxContainer.add_child(t)
	pass
