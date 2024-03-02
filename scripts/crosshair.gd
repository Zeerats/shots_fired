# TODO: clamp stuff. Right now the crosshair will spread infinitely with the player's velocity.
extends CenterContainer

@export var color = Color.WHITE
var dot_radius = 1.0
var line_width = 2.0
var line_length = 20.0
var spread_distance = 2.0
var spread_speed = 0.25
var line_separation = 5.0

func _ready():
	for line in [$Top, $Right, $Bottom, $Left]:
		line.width = line_width
		line.default_color = color

	update_line_length_and_position()
	queue_redraw()
	
func _process(delta):
	update_line_spread()

func _draw():
	draw_circle(Vector2(0,0), dot_radius, color)

func update_line_length_and_position():
	$Top.points = [Vector2(0, -line_separation), Vector2(0, -line_separation - line_length)]
	$Right.points = [Vector2(line_separation, 0), Vector2(line_separation + line_length, 0)]
	$Bottom.points = [Vector2(0, line_separation), Vector2(0, line_separation + line_length)]
	$Left.points = [Vector2(-line_separation, 0), Vector2(-line_separation - line_length, 0)]

func update_line_spread():
	var player_velocity = GameManager.player.get_real_velocity()
	var center = Vector2.ZERO
	var speed = player_velocity.length()
	
	$Top.position = lerp($Top.position, center + Vector2(0, -speed * spread_distance - line_separation), spread_speed)
	$Right.position = lerp($Right.position, center + Vector2(speed * spread_distance + line_separation, 0), spread_speed)
	$Bottom.position = lerp($Bottom.position, center + Vector2(0, speed * spread_distance + line_separation), spread_speed)
	$Left.position = lerp($Left.position, center + Vector2(-speed * spread_distance - line_separation, 0), spread_speed)

