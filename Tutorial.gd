extends Control

var text = [
	'hello '
]

var text_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dialog()



	
func load_dialog():

	if text_index < text.size():
		
		$RichTextLabel.bbcode_text = text[text_index]
		$RichTextLabel.percent_visible = 1
#	pass
