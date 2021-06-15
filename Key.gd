extends Area2D


func _on_Key_body_entered(body):
	call_deferred("add_key", body)

func add_key(body):
	$CollisionShape2D.disabled = true
	$Anim.play("Hit")
	body.add_key(1)
	
func _ready():
	pass 







