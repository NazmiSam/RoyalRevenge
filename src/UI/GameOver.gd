extends Control


func _ready():
	$HBoxContainer/TextureButton.grab_focus()

func _physics_process(delta):
	if $HBoxContainer/TextureButton.is_hovered() == true:
		$HBoxContainer/TextureButton.grab_focus()
	if $HBoxContainer/TextureButton2.is_hovered() == true:
		$HBoxContainer/TextureButton2.grab_focus()

func _on_TextureButton_pressed():
	get_tree().reload_current_scene()

func _on_TextureButton2_pressed():
	get_tree().change_scene("res://src/Main menu/MainMenu.tscn")



