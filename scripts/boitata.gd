extends Node2D

var snake_pos
var life = 5
var damage = 1
var stamina = 3
var max_stamina = 3

signal moved
signal attacked


onready var anim = $AnimationPlayer

func _ready():
	snake_pos = Globals.populate_snake()
	self.global_position = Globals.get_map_to_world_pos(snake_pos)

func move():
	snake_pos = Globals.move_snake(snake_pos)
	anim.play("teleport out")
	yield(anim, "animation_finished")
	self.global_position = Globals.get_map_to_world_pos(snake_pos)
	anim.play("teleport")
	yield(anim, "animation_finished")
	anim.play("idle")
	emit_signal("moved")

func _input(event):
	if event.is_action_pressed("debug"):
		turn()

func take_damage(value):
	life -= value
	if life < 0:
		self.queue_free()

func turn():
	while(stamina > 0):
		stamina -= 1
		move()
		yield(self, "moved")
	stamina = max_stamina

func attack(player, invert):
	stamina -= 1
	anim.play("attack")
	if invert == "back":
		$cabeca.scale.x = -1
	player.take_damage(damage)
	yield(anim, "animation_finished")
	anim.play("RESET")
	yield(anim, "animation_finished")
	if invert == "back":
		$cabeca.scale.x = 1
	anim.play("idle")
	emit_signal("attacked")


func _on_damagebox_area_entered(area, invert):
	if area.is_in_group("player") and stamina > 0:
		var player = area.get_parent()
		while(stamina > 0):
			attack(player, invert)
			yield(self, "attacked")
