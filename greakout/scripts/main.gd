extends Node2D

onready var paddle = get_node("paddle")
onready var ball = get_node("ball")
onready var score_label = get_node("score")
onready var game_end_status = get_node("game_end_status")
onready var bricks = get_node("bricks")
onready var final_status = get_node("game_end_status/final_status")

var screen_size
var move_speed = 10
var score = 0

func _ready():
	
	screen_size = get_viewport_rect().size
	paddle.set_pos(Vector2(screen_size.width/2, screen_size.height*0.9))
	ball.set_pos(Vector2(screen_size.width/2, screen_size.height*0.8))
		
	#score_label.set_pos(Vector2(screen_size.width/2, screen_size.height/100))
	score_label.set_margin(MARGIN_LEFT, screen_size.width/2-score_label.get_size().x/2)
	#Vector2(screen_size.width/2, screen_size.height/100))
	score_label.set_text("Score: "+str(score))
	print(score_label.get_size())
	
	
	#bricks.set_pos(Vector2(screen_size.width, screen_size.height))
	for br in bricks.get_children():
		for b in br.get_children():
			b.add_to_group("bricks")

	set_fixed_process(true)
	
func _fixed_process(delta):
	if Input.is_action_pressed("ui_right"):
		paddle.move(Vector2(move_speed, 0))
	if Input.is_action_pressed("ui_left"):
		paddle.move(Vector2(-move_speed, 0))
	
	if ball.is_colliding():
		var c = ball.get_collider()
		if c.is_in_group("bricks"):
			c.queue_free()
			score += 1
			score_label.set_text("Score: "+str(score))

		ball.velocity = ball.get_collision_normal().reflect(ball.velocity)
	
	# no bricks left
	
	if not get_tree().get_nodes_in_group("bricks").size():
		ball.velocity = Vector2(0,0)
		final_status.set_text("Score: "+str(score))
		game_end_status.set_hidden(false)

	# ball gone to the bottom
	if ball.get_pos().y > screen_size.height + ball.extent.y:
		ball.velocity = Vector2(0,0)
		final_status.set_text("Game Over")
		game_end_status.set_hidden(false)

func _on_restart_button_pressed():
	get_tree().reload_current_scene()
	
#func _draw():
#    draw_line(Vector2(screen_size.width/2, screen_size.height/100),Vector2(screen_size.width/2, screen_size.height), Color(255,0,0))
#    draw_line(Vector2(screen_size.width/100, screen_size.height/2),Vector2(screen_size.width, screen_size.height/2), Color(255,0,0))
