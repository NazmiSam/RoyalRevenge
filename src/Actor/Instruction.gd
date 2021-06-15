extends Area2D


func _ready():
	hide()




func _on_Instruction_body_entered(body):
	
	if "Player" in body.name:
		show()
