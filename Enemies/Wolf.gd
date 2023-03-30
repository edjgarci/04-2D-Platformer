extends KinematicBody2D

onready var SM = $StateMachine

export var walking = 500
export var running = 500
export var jump = 1200
var velocity = Vector2.ZERO
var direction = 1

func _ready():
	velocity.x = running
	SM.set_state("Move")

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if direction < 0 and not $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = true
	if direction > 0 and $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = false
	$Attack.cast_to.x = direction*abs($Attack.cast_to.x)
	$See.cast_to.x = direction*abs($See.cast_to.x)
	$Can_Jump.cast_to.x = direction*abs($Can_Jump.cast_to.x)
	
func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func damage():
	if SM.state_name != "Die":
		SM.set_state("Die")


func should_attack():
	if $Attack.is_colliding() and $Attack.get_collider().name == "Player":
		return true
	return false

func attack_target():
	if $Attack.is_colliding():
		return $Attack.get_collider()
	return null

func _on_AnimatedSprite_animation_finished():
	if SM.state_name == "Attack":
		SM.set_state("Move")
	if SM.state_name == "Die":
		queue_free()


func _on_Above_and_Below_body_entered(body):
	if body.name == "Player" and SM.state_name != "Die":
		body.die()
