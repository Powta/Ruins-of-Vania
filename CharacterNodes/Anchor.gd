extends Marker2D

@onready var player=$"."

func _process(delta):
	var target=player.global_position
	var target_posx
	var target_posy
	target_posx=(lerp(global_position.x,target.x,0.2*delta))
	target_posy=(lerp(global_position.y,target.y,0.2*delta))
	global_position=Vector2(target_posx,target_posy)
