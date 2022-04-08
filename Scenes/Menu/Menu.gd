extends Node2D

func _ready():
	$BestMark.text += str(Globals.bestMark)

func _on_Button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Tutorial/Tutorial.tscn")
