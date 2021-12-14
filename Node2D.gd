extends Node2D

const PSPEED = 450
const INIT_BSPEED = 100

var ballDirection = Vector2(-1.0, 0.0)
var ballSpeed = INIT_BSPEED
var padSize

# Called when the node enters the scene tree for the first time.
func _ready():
	padSize = get_node("leftplayer").get_texture().get_size()
	print(padSize)
	print(get_node("rightplayer").get_texture().get_size())
	set_process(true)


func _process(delta):
	var leftCollider = Rect2(get_node("leftplayer").get_position()-padSize*0.5, padSize)
	var rightCollider = Rect2(get_node("rightplayer").get_position()-padSize*0.5, padSize)
	
	var ballPos =get_node("ball").get_position()
	print("ball")
	print(ballPos)
	
	ballPos += ballDirection * ballSpeed * delta
	
	

	var rightPPos = get_node("rightplayer").get_position()
	var leftPPos = get_node("leftplayer").get_position()
	if(leftPPos.y < get_viewport_rect().size.y and Input.is_action_pressed("left_down")):
		leftPPos.y += PSPEED * delta;
	if(leftPPos.y > 0 and Input.is_action_pressed("left_up")):
		leftPPos.y -= PSPEED * delta;
	if(rightPPos.y < get_viewport_rect().size.y and Input.is_action_pressed("right_down")):
		rightPPos.y += PSPEED * delta;
	if(rightPPos.y > 0 and Input.is_action_pressed("right_up")):
		rightPPos.y -= PSPEED * delta;

	#print("before weird if")
	#if(leftCollider.has_point(ballPos)):
	#	print("left triggers")
	#if(rightCollider.has_point(ballPos)):
	#	print("right triggers")
	if(leftCollider.has_point(ballPos) or rightCollider.has_point(ballPos)):
	#	print("in weird if")
		ballDirection.x = -ballDirection.x
		ballDirection.y = randf() * 2 - 1
		ballDirection = ballDirection.normalized()
		if(ballSpeed < 300):
			ballSpeed *= 1.2


	get_node("leftplayer").global_position = leftPPos
	get_node("rightplayer").global_position = rightPPos
	get_node("ball").global_position = ballPos
