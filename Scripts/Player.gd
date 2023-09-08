extends KinematicBody2D

const ACCELERATION = 500
const SPEED = 150
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02

var jump_height = 64
var jump_peak_time = 0.4
onready var gravity = (2*jump_height)/(pow(jump_peak_time,2))
onready var jump_velocity = gravity*jump_peak_time


var knockback_amount = 150

var grounded

var is_jumping : bool

var velocity = Vector2.ZERO

var terminal_vertical_speed = 300

var health = 3

var is_alive = true


onready var coyote_timer = $CoyoteTimer
onready var jump_buffer_timer = $JumpBufferTimer
onready var invincible_timer = $InvincibleTimer
onready var sprite = $Sprite
onready var effect_player = $EffectPlayer
onready var camera = $PlayerCamera
onready var health_indicator = $HealthIndicator
onready var attack_timer = $AttackTimer
onready var animation_player = $AnimationPlayer
onready var melee_weapon = $MeleeWeapon
onready var slash_sprite = $MeleeWeapon/Sprite
onready var right_attack = $RightAttackPosition
onready var left_attack = $LeftAttackPosition
onready var hurt_sound = $HurtSound


func _physics_process(delta):
	if is_alive:
		var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
		if x_input != 0:
			velocity.x += x_input * ACCELERATION * delta
			velocity.x = clamp(velocity.x, -SPEED, SPEED)
			sprite.flip_h = x_input < 0
			if(x_input<0):
				if !animation_player.is_playing():
					melee_weapon.position.x=left_attack.position.x
					slash_sprite.flip_h = true
				sprite.rotation_degrees = lerp(rotation_degrees, -30, 0.2)
			if(x_input>0):
				if !animation_player.is_playing():
					melee_weapon.position.x=right_attack.position.x
					slash_sprite.flip_h = false
				sprite.rotation_degrees = lerp(rotation_degrees, 30, 0.2)
		if x_input == 0:
			sprite.rotation_degrees = lerp(rotation_degrees, 0, 0.2)

		velocity.y += gravity*delta
		if velocity.y > terminal_vertical_speed: 
			velocity.y = terminal_vertical_speed
		if is_jumping && velocity.y >=0:
			is_jumping = false
		
		if is_on_floor():
			if x_input == 0:
				velocity.x = lerp(velocity.x, 0, FRICTION)
		
		if !is_on_floor():
			if x_input == 0:
				velocity.x = lerp(velocity.x, 0, AIR_RESISTANCE)
		
		if Input.is_action_just_pressed("jump"):
			if is_on_floor() || !coyote_timer.is_stopped():
				coyote_timer.stop()
				jump()
			else:
				jump_buffer_timer.start()


		if is_jumping && !Input.is_action_pressed("jump"):
			if velocity.y < 0:
				velocity.y = velocity.y/1.3

		var was_grounded = is_on_floor()

		if Input.is_action_just_pressed("attack"):
			if attack_timer.is_stopped():
				attack_timer.start()
				attack()


		velocity = move_and_slide(velocity, Vector2.UP)

		if !is_on_floor() && was_grounded && !is_jumping:
			coyote_timer.start()
		if is_on_floor() && !jump_buffer_timer.is_stopped():
			jump_buffer_timer.stop()
			jump()

func jump():
	velocity.y = -jump_velocity
	is_jumping = true

func bounce():
	velocity.y = 0.5*-jump_velocity

func get_hurt(damage_pos, damage_amount):
	if invincible_timer.is_stopped():
		invincible_timer.start()
		disable_hurt_collisions()
		damage(damage_amount)
		knockback(damage_pos)
		effect_player.play("flash")

func knockback(knockback_origin):
	if knockback_origin.x >= position.x:
		velocity.x = -knockback_amount
		bounce()
	if knockback_origin.x < position.x:
		velocity.x = knockback_amount
		bounce()

func kill():
	is_alive = false
	SceneChanger.reload_scene()

func damage(amount):
	health -= amount
	health_indicator.update_health_indicator(health)
	camera.shake(1.5)
	hurt_sound.play()
	if health <=0:
		kill()


func _on_InvincibleTimer_timeout():
	effect_player.play("idle")
	enable_hurt_collisions()


func _on_StompArea_stomped():
	bounce()
	camera.shake(1)

func disable_hurt_collisions():
	set_collision_mask_bit(6, false)
	set_collision_mask_bit(7, false)

func enable_hurt_collisions():
	set_collision_mask_bit(6, true)
	set_collision_mask_bit(7, true)

func increase_health():
	if health<3:
		health+=1
		health_indicator.update_health_indicator(health)

func attack():
	if !animation_player.is_playing():
		animation_player.play("slash")


func _on_MeleeWeapon_area_entered(area):
	camera.shake(1)
