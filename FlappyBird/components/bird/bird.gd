extends CharacterBody2D

@onready var animatedSprites: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity: float = 1600.00
@export var maxFallSped: float = 600.00
@export var flap: float = -450.00

var isFlying: bool = true 
var canFall: bool = false

func reset() -> void:
	animatedSprites.play('default')
	self.position = Vector2(100, 250)
	isFlying = true

func _ready() -> void:
	reset()

func _physics_process(delta: float) -> void:
	applyGravity(delta)
	reactToInput()
	
	set_rotation(deg_to_rad(self.velocity.y * 0.05))
	
	var body: KinematicCollision2D = move_and_collide(self.velocity * delta)
	isFlying = body == null
	
	if body:
		animatedSprites.stop()
		set_rotation(deg_to_rad(0))
	else:
		animatedSprites.play('default')
		
func applyGravity(delta: float) -> void:
	if not isFlying or not canFall:
		return
	
	self.velocity.y += gravity * delta
	if self.velocity.y > maxFallSped:
		self.velocity.y = maxFallSped

func reactToInput() -> void:
	if Input.is_action_just_pressed('tap'):
		self.velocity.y = flap
		canFall = true
		
