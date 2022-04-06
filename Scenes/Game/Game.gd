extends Node2D

var arrowScene = preload("res://Scenes/Game/Arrow/Arrow.tscn")

var level = 0
var wait_time = 2
var currentTime = 0
var arrow_speed = 100

signal hitArrow(arrow)

func _ready():
	randomize()
	$RespawnTimer.wait_time = wait_time

func _process(delta):
	currentTime += delta
	
	if Input.is_action_just_pressed("ui_left"):
		print( $Arrows.get_child(0).is_in_group("left_arrow") )
		pass
		
	if Input.is_action_just_pressed("ui_right"):
		pass

func _on_TimerRespawn_timeout():
	var arrow = arrowScene.instance()
	arrow.SPEED = arrow_speed
	arrow.position.x = rand_range(arrow.size.x/2 + 20, 341-arrow.size.x-20)
	
	if randf() > 0.5:
		arrow.rotation_degrees = 180
		arrow.leftDirection = false
		arrow.remove_from_group("left_arrow")
		arrow.add_to_group("right_arrow")
	
	$Arrows.add_child(arrow)


func _on_Game_hitArrow(arrow):
	if arrow.leftDirection:
		print("<-")
	else:
		print("->")
