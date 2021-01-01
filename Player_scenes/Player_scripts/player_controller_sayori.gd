# This is to tell the code that 
# we are using a KinematicBody2D.
# This way we get the correct functions.
extends KinematicBody2D

# Defining the variable, there are a few different
# ways to do this.
# export means we can change it in the editor, the
# "speed : int = 2000" is just defining the var as an
# int. We could technically just use
# "export var speed = 1200", but this tells the code
# to only worry about numbers
export var speed : int = 1200
export var jump_speed : int = -2600
export var gravity : int = 4000

# Doing the same here, but not defining the variable 
# as a Vector2 before hand.
# Vector2 is essentially a list that holds two
# integers, x and y, made for 2d.
var velocity = Vector2.ZERO

# Here we define a new function, called "get_input"
# This is so we can handle input, only when we want,
# which will be nice for menus
# What happens here should be self-explanatory, but 
# Imma explain it anyway
# We are just setting out x velovity to 0, we can
# change this later to a formula for friction.
# We are then getting what they are pressing, and 
# setting velocity based on that
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("Left"):
		velocity.x -= speed
	if Input.is_action_pressed("Right"):
		velocity.x += speed

# Here is where it gets weird
# This is a built-in function, as seen by the "_"
# This is only ran 60 times per second, or at the 
# rate we specified (60 fps)
# This is independent of computer framerate so we 
# can keep gameplay similar across different devices
func _physics_process(delta):
	# Here we call our custom function, and 
	# get the input... duh
	get_input()
	# Here we are changing the y velocity by
	# the gravity we stored above, and the 
	# time since the last frame
	# This acts as our "Gravity"
	velocity.y += gravity * delta
	# Here we apply all the changes we have done 
	# to the velocity so far
	velocity = move_and_slide(velocity, Vector2.UP)
	# And now we jump, as you can probably see
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = jump_speed
			print("Jumping")
			
