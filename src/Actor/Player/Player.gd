extends KinematicBody2D


const SPEED = 500
const GRAVITY = 60
const JUMP_POWER = -1500
const FLOOR = Vector2(0,-1)

signal gameOver

const FIREBALL = preload("res://src/attack/Fireball.tscn")

var velocity = Vector2()

var on_ground = false

var key = 0

var is_dead = false

var is_attacking = false 

func _ready():
		$AnimPlayer.play("Setup")
		
func _physics_process(delta):

	if is_dead == false:
		
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false:
				velocity.x = SPEED
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = false
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
		
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false:
				velocity.x = -SPEED
				$AnimatedSprite.play("run")
				$AnimatedSprite.flip_h = true
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
		
		else:
			velocity.x = 0
			if on_ground == true && is_attacking == false :
				$AnimatedSprite.play("idle")
	
		if Input.is_action_pressed("ui_up"):
			if is_attacking == false:
				if on_ground == true:
					velocity.y = JUMP_POWER
					on_ground = false
					
	
		if Input.is_action_just_pressed("ui_accept") && is_attacking == false:
			is_attacking = true
			$AnimatedSprite.play("attack")
			$AudioStreamPlayer2D .play()
			var fireball = FIREBALL.instance()
			$AnimatedSprite.play("attack")
			$AudioStreamPlayer2D .play()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			
		velocity.y = velocity.y + GRAVITY

		if is_on_floor():
			on_ground = true
		else:
			if is_attacking == false:
				on_ground =false
				if velocity.y < 0:
					$AnimatedSprite.play("jump")

	
		velocity = move_and_slide(velocity, FLOOR)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					dead()
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Sultan" in get_slide_collision(i).collider.name:
					dead()


func add_key(amount):
	key += amount

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	$Timer.start()


func walk_in(door):

	
	door.open_ani()
	
	door.next_level()
	
func _on_Timer_timeout():
	
	get_node("AnimPlayer").play("GameOver")

func _on_FallZone_body_entered(body):
	get_node("AnimPlayer").play("GameOver")

func _on_Fallzone2_body_entered(body):
	get_node("AnimPlayer").play("GameOver")

func _on_Fallzone3_body_entered(body):
	get_node("AnimPlayer").play("GameOver")

func _on_Dialog_body_entered(body):
	if "Player" in body.name:
		visible = true

func _on_AnimatedSprite_animation_finished():
	is_attacking = false







