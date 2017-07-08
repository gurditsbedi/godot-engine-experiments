extends Node2D


var green_brick_sprite = preload("res://images/element_green_rectangle.png")
var yellow_brick_sprite = preload("res://images/element_yellow_rectangle.png")
var blue_brick_sprite = preload("res://images/element_blue_rectangle.png")


func _ready():
	colorBricks("green_bricks", green_brick_sprite)
	colorBricks("yellow_bricks", yellow_brick_sprite)
	colorBricks("blue_bricks", blue_brick_sprite)
	pass
	
func colorBricks(parent_name, sprite):
	var gb = get_node(parent_name)
	for b in gb.get_children():
		var sprt = b.get_node("brick_sprite")
		sprt.set_texture(sprite)

