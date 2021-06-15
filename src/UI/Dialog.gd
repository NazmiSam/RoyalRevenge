extends Area2D


func _ready():
	hide()
	pause_mode
	

func _physics_process(delta):
	pass


func _on_Dialog_body_entered(body):
	if "Player" in body.name:
		show()
	else:
		hide()
	
