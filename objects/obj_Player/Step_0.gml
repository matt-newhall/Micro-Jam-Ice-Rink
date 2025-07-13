// Read player inputs
var pressingV = keyboard_check(vk_up) || keyboard_check(vk_down);
var pressingH = keyboard_check(vk_left) || keyboard_check(vk_right);

// Trick state
if (!trick_cooldown && is_player_actionable && keyboard_check(ord("E"))) {
	state = PlayerState.TRICK;
	trick_cooldown = true;
}

// Jump state
if (is_player_actionable && keyboard_check(vk_space)) {
	state = PlayerState.JUMP;
}

// Collect rose state
if (place_meeting(x, y, obj_Rose) && is_player_idle) {
	state = PlayerState.HAS_ROSE;
}


// Movement Flow
if (is_player_idle) {
	if (keyboard_check(vk_up)) {
	    vspeed -= accel;
	    if (vspeed < -max_speed) vspeed = -max_speed;
	} else if (keyboard_check(vk_down)) {
	    vspeed += accel;
	    if (vspeed > max_speed) vspeed = max_speed;
	} else if (abs(vspeed) > 0 && wasPressingV && !pressingV) {
	    vspeed = vspeed / 2;
	}

	if (keyboard_check(vk_left)) {
	    hspeed -= accel;
	    if (hspeed < -max_speed) hspeed = -max_speed;
	} else if (keyboard_check(vk_right)) {
	    hspeed += accel;
	    if (hspeed > max_speed) hspeed = max_speed;
	} else if (abs(hspeed) > 0 && wasPressingH && !pressingH) {
	    target_speed_x = hspeed / 2;
	    is_decelerating_x = true;
	}
	
	if (is_decelerating_x) {
	    hspeed = lerp(hspeed, target_speed_x, 0.1);
    
	    // Stop when close enough to target
	    if (abs(hspeed - target_speed_x) < 0.1) {
	        hspeed = target_speed_x;
	        is_decelerating_x = false;
	    }
	}
	
	if (is_decelerating_y) {
	    hspeed = lerp(hspeed, target_speed_y, 0.1);
    
	    // Stop when close enough to target
	    if (abs(hspeed - target_speed_y) < 0.1) {
	        hspeed = target_speed_y;
	        is_decelerating_y = false;
	    }
	}
}

wasPressingV = pressingV;
wasPressingH = pressingH;


// Change Player Sprite based on speed
var dir_speed = sqrt(power(hspeed, 2) + power(vspeed, 2));
if (is_player_idle) {
	if (!keyboard_check(vk_left) && !keyboard_check(vk_right) && !keyboard_check(vk_up) && !keyboard_check(vk_down)) {
	    image_speed = 0;
	} else if (dir_speed < 2.5) {
	    image_speed = 0.5;
	} else {
	    image_speed = 1;
	}
} else {
	image_speed = 1;
}


// Collisions with wall
if (x <= global.play_left || x + sprite_width >= global.play_right) {
    x = clamp(x, global.play_left, global.play_right - sprite_width);
	hspeed = -(hspeed / 2);
}

if (y <= global.play_top || y + sprite_height >= global.play_bottom) {
    y = clamp(y, global.play_top, global.play_bottom - sprite_height);
	vspeed = -(vspeed / 2);
}

if ((x <= global.play_left || x + sprite_width >= global.play_right) ||
	(y <= global.play_top || y + sprite_height >= (global.play_bottom))) {
	obj_Game_Controller.handle_score_event("bd_wall_collision");
	is_decelerating_x = false;
	is_decelerating_y = false;
	target_speed_x = 0;
	target_speed_y = 0;
	state = PlayerState.HIT;
}

if (place_meeting(x, y, obj_Rabbid_Fan) && obj_Rabbid_Fan.moving && !is_player_invuln && state != PlayerState.JUMP) {
	hspeed = -(hspeed / 2);
	vspeed = -(vspeed / 2);
}

if (place_meeting(x, y, obj_Cleaner_Dog) && !is_player_invuln && state != PlayerState.JUMP) {
	hspeed = -(hspeed / 2);
	vspeed = -(vspeed / 2);
}

if (place_meeting(x, y, obj_Tonya) && !is_player_invuln && state != PlayerState.JUMP) {
	hspeed = -(hspeed / 2);
	vspeed = -(vspeed / 2);
}


// Player was hit, trigger flashing for 1.5s
if (state == PlayerState.HIT && !alarm[0]) {
	alarm[0] = game_get_speed(gamespeed_fps) * 1.5;
}

// If player has iframes, flash player
if (alarm[0]) {
    invuln_flash += 1;
    
    // Flash every few frames
    if (invuln_flash mod 8 < 4) {
        image_alpha = 0.5;
    } else {
        image_alpha = 1.0;
    }
} else {
    image_alpha = 1.0;
}


// Updates player sprite based on state
switch (state) {
	case PlayerState.HAS_ROSE:
		sprite_index = spr_player_rose_catch;
		if (!alarm[3]) {
			alarm[3] = game_get_speed(gamespeed_fps) * 0.5;
		}
		break;
	case PlayerState.JUMP:
		sprite_index = spr_player_jump;
		if (!alarm[2]) {
			alarm[2] = game_get_speed(gamespeed_fps) * 0.5;
		}
		break;
	case PlayerState.TRICK:
		sprite_index = spr_player_trick;
		if (!alarm[1]) {
			alarm[1] = game_get_speed(gamespeed_fps);
		}
		break;
	case PlayerState.HIT:
		sprite_index = spr_player_hit;
		break;
	default:
	case PlayerState.NORMAL:
		sprite_index = spr_player_down;
		break;
}


// PLayer bool checks for simplicity checking elsewhere/next frame
is_player_invuln = obj_Player.alarm[0];
is_player_idle = state == PlayerState.NORMAL || state == PlayerState.HAS_ROSE || state == PlayerState.HIT;
is_player_actionable = state == PlayerState.NORMAL || state == PlayerState.HAS_ROSE
