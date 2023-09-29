extends CharacterBody2D

@onready var player= $".."
const SPEED = 450.0 #Max Speed
const ACCELERATION=3000
const FRICTION=1000
const JUMP_VELOCITY = -400.0

var dPadRelease=false
var prevDir=1
var numOfJumpInputsMidAir=0 #Use this to prevent falling from being floaty when you mash jump button in midair
var changed_scale=true

#Timers for buffering
var bufferTime=0.2
var bufferTimer=0
var coyoteBufferTime=0.2
var coyoteBufferTimer=0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	bufferTimer-=delta
	coyoteBufferTimer-=delta

func _physics_process(delta):
	#Add gravity
	if not is_on_floor():
		#If you're going upwards
		if(velocity.y<0):
			velocity.y += gravity * delta
		
		#If you're going downward
		else:
			velocity.y += gravity * delta *1.5
			

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		bufferTimer=bufferTime
		
	if is_on_floor():
		coyoteBufferTimer=coyoteBufferTime
		
	#check if the player pressed the button within the last 0.5 secs	
	if bufferTimer>0 and coyoteBufferTimer>0 :
		bufferTimer=0
		coyoteBufferTimer=0
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("ui_accept"):
		if velocity.y<0: #Don't half the velocity when you're falling
			velocity.y*=0.5 #Half the vertical velocity when you let go of the jump button	

	#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
		
	if direction!=0:
		if abs(velocity.x)<=SPEED/3:
			velocity.x=move_toward(velocity.x,SPEED/3*direction,ACCELERATION*delta)
#		velocity.x = move_toward(velocity.x,SPEED*direction,ACCELERATION*delta)
		else:
			velocity.x=SPEED*direction
			
		if direction>0:
			if(!changed_scale):
				scale.x*=-1
				changed_scale=true
	
		elif direction<0:
			if(changed_scale):
				scale.x*=-1
				changed_scale=false
			
			
	else:
		velocity.x =move_toward(velocity.x,0,FRICTION*delta)
	
	
#	if inputAxis==1:
#		scale.x=1
#	else:
#		scale.x=-1

	move_and_slide() #takes our velocity and moves character by that velocity
	
func flipPlayer(dir):
	if dir>0:
		scale.x=1
	else:
		scale.x=-1
	
