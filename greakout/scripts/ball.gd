extends KinematicBody2D

var direction = Vector2()
var velocity = Vector2()
var speed = 500
var extent 

func _ready():
	randomize()
	var angle = deg2rad(randi()%90)+45
	print(angle)
	velocity = Vector2(cos(angle), sin(angle))*speed
	set_fixed_process(true)
	extent = get_node("ball_sprite").get_texture().get_size()
	
func _fixed_process(delta):
	move(velocity * delta)
	
	
