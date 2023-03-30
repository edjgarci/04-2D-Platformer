extends Node

onready var SM = get_parent()
onready var enemy = get_node("../..")

func _ready():
	yield(enemy, "ready")

func start():
	enemy.velocity = Vector2.ZERO
	$Timer.start()
	enemy.set_animation("Attack")

func physics_process(_delta):
	pass


func _on_Timer_timeout():
	if SM.state_name == "Attack":
		var target = enemy.attack_target()
		if target != null and target.name == "Player":
			target.die()
