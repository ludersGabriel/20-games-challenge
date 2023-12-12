extends CharacterBody2D

@onready var animatedSprites: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity: float = 200.00

func _ready() -> void:
	animatedSprites.play('default')

func _physics_process(delta: float) -> void:
	self.velocity.y += delta * gravity
	
	var motion: Vector2 = velocity * delta
	
	move_and_collide(motion)
