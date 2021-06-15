extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("SETUP")

func _physics_process(delta):
	pass






func _on_Button_pressed():
	get_tree().change_scene("res://src/Main menu/MainMenu.tscn")
