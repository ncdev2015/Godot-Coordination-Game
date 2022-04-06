extends Node2D

var defaultColor = Color()
var arrowsLosed = 0

func _ready():
	defaultColor = $ArrowZone/Line2D.default_color

func _on_DangerZone_area_entered(area):
	arrowsLosed += 1
		
	area.get_parent().get_node("Sprite").modulate = Color(0.5,0.5,1)
	
func _on_ArrowZone_area_entered(area):
	$ArrowZone/Line2D.default_color = Color("#6721FF")
	get_parent().emit_signal("hitArrow", area.get_parent())
	$ArrowsInLine.arrows.append(area.get_parent())
	area.get_parent().isInLine = true

func _on_ArrowZone_area_exited(area):
	$ArrowZone/Line2D.default_color = defaultColor
	$ArrowsInLine.arrows.erase(area.get_parent())
	
	area.get_parent().isInLine = false
