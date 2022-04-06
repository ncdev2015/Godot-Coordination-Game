extends Node2D

var SPEED = 50
var size = Vector2()
var leftDirection = true
var isInLine = false

func _ready():
	size = $Sprite.texture.get_size()

func _process(delta):
	position.y += SPEED * delta
	
	print(isInLine)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
