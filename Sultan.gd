extends KinematicBody2D


const ATTACK = preload("res://src/Actor/SultanWeapon.tscn")
const GRAVITY = 10
const FLOOR = Vector2(0, 1)

var velocity = Vector2()
var direction = 1
var is_dead = false
export(int)var speed = 100
export(int)var hp = 1
export(Vector2) var size = Vector2(1, 1)

func _ready():
	scale = size 
	pass

func dead():
	hp -= 1
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0, 0)
		$AnimatedSprite.play("dead")
		$CollisionShape2D.set_deferred("disabled",true) 
		$Timer.start()

func _physics_process(delta):
	if is_dead == false:
		velocity.x = speed * direction
	
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	
		$AnimatedSprite.play("walk")

		velocity.y += GRAVITY

		velocity = move_and_slide(velocity, FLOOR)

	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
  
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1

	if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()

func shoot():
	var attack = ATTACK.instance()
	if sign($Position2D.position.x) == 1:
		attack.set_attack_direction(1)
	else:
		attack.set_attack_direction(-1)
		get_parent().add_child(attack)
		attack.position = $Position2D.global_position
		
func _on_Timer_timeout():
	get_tree().change_scene("res://src/UI/Final Scene.tscn")


func _on_shooting_body_entered(body):
	if "Player" in body.name:
		shoot()
