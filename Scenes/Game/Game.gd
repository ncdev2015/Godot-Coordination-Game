extends Node2D

var arrowScene = preload("res://Scenes/Game/Arrow/Arrow.tscn")

var currentTime = 0
var timeLeft = 30

var previousLevel = 0
var level = 0
var wait_time = 2
var arrow_speed = 150
var points = 0

var lives = 3

var gameOver = false
var levelIncreased = false

signal hitArrow(arrow)
signal decreaseLives

func _ready():
	randomize()
	$RespawnTimer.wait_time = wait_time
	level = 1
	previousLevel = level

func _process(delta):
	currentTime += delta
	
	if timeLeft > 0:
		timeLeft -= delta
	
	if Input.is_action_just_pressed("ui_left"):
		if $Arrows.get_child(0).is_in_group("left_arrow") and $Arrows.get_child(0).isInLine and not $Arrows.get_child(0).isHited:
			$Arrows.get_child(0).isHited = true
			$Arrows.get_child(0).changeColor(Color("#00FF00"))
			points+=1
			
			if $Arrows.get_child(0).isFast:
				points += 1
				
			if points % 10 == 0 or (points > 0 and points % 11 == 0):
				increaseLevel()
			
		else:
			if points > 0:
				points-=1
	
	if Input.is_action_just_pressed("ui_right"):
		if $Arrows.get_child(0).is_in_group("right_arrow") and $Arrows.get_child(0).isInLine and not $Arrows.get_child(0).isHited:
			$Arrows.get_child(0).isHited = true
			$Arrows.get_child(0).changeColor(Color("#00FF00"))
			points+=1
			
			if $Arrows.get_child(0).isFast:
				points += 1
				
			if points % 10 == 0 or (points > 0 and points % 11 == 0):
				increaseLevel()
		else:
			if points > 0:
				points-=1
	
	if lives <= 0:
		if points > Globals.bestMark:
			Globals.bestMark = points
		
		get_tree().paused = true
		$GameOver.visible = true
		$GameOver/PointsEarned.visible = true
		$GameOver/PointsEarned.text += str(points)
		
		$TryAgain.visible = true
		$GoToMenu.visible = true
		
		#get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
				
	$Lives.text = str(lives)
	$Points.text = str(points)
	
	"""	
	$TimeLeft.text = str(int(timeLeft+1))
	
	if timeLeft <= 0:
		$TimeOver.visible = true
		$TimeOver/PointsEarned.visible = true
		$TimeOver/PointsEarned.text += str(points)
		get_tree().paused = true
	"""

func _on_TimerRespawn_timeout():
	var arrow = arrowScene.instance()
	
	if randf() <= 0.1:
		arrow.SPEED = arrow_speed * 1.25
		arrow.changeColor(Color("#5492FF"))
		arrow.isFast = true
	else:
		arrow.SPEED = arrow_speed
	
	arrow.position.x = rand_range(arrow.size.x/2 + 20, 341-arrow.size.x-20)
	
	if randf() > 0.5:
		arrow.rotation_degrees = 180
		arrow.leftDirection = false
		arrow.remove_from_group("left_arrow")
		arrow.add_to_group("right_arrow")
	
	$Arrows.add_child(arrow)

func _on_Game_hitArrow(arrow):
	pass

func increaseLevel():
	level += 1
	$Level.text = "Level " + str(level)
	arrow_speed += 25
	
	if $RespawnTimer.wait_time > 0:
		$RespawnTimer.wait_time -= 0.2


func _on_Game_decreaseLives():
	if lives > 0:
		lives -=1


func _on_TryAgain_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Game/Game.tscn")


func _on_GoToMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
