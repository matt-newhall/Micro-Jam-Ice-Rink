// Cleaner Dog spawns
if (obj_Game_Controller.score_value >= 500 && state == CleanerState.INACTIVE) {
	state = CleanerState.SPAWNING;
}

if (state == CleanerState.SPAWNING) {
	if !(alarm[0]) {
		alarm[0] = game_get_speed(gamespeed_fps) * 1;
	}
	x -= 2;
}


if (state == CleanerState.IDLE) {
    if (!alarm[2]) {
        alarm[2] = game_get_speed(gamespeed_fps) * (1 + random(5));
    }
} else if (state == CleanerState.MOVING) {
    // Move towards the target position
    var dir = point_direction(x, y, target_x, target_y);
    var dist = point_distance(x, y, target_x, target_y);
    var move_speed = 5;
    
    if (dist > move_speed) {
        x += lengthdir_x(move_speed, dir);
        y += lengthdir_y(move_speed, dir);
    } else {
        // Reached target position, start fixing animation
        x = target_x;
        y = target_y;
        state = CleanerState.CLEANING;
        if (!alarm[1]) {
            alarm[1] = game_get_speed(gamespeed_fps) * 3;
        }
    }
}

// Player collision detection
if (place_meeting(x, y, obj_Player) && !obj_Player.is_player_invuln && obj_Player.state != PlayerState.JUMP) {
    obj_Game_Controller.handle_score_event("bd_cleaner_collision");
    obj_Player.state = PlayerState.HIT;
} else if (place_meeting(x, y, obj_Player) && !obj_Player.is_player_invuln && !given_jump_bonus) {
    given_jump_bonus = true;
    obj_Game_Controller.handle_score_event("gd_dodge_success");
}


// Updates player sprite based on state
switch (state) {
	case CleanerState.CLEANING:
		sprite_index = spr_cleaner_dog_fix;
		break;
	case CleanerState.SPAWNING:
	case CleanerState.MOVING:
		sprite_index = spr_cleaner_dog_walk;
		break;
	case CleanerState.INACTIVE:
	case CleanerState.IDLE:
	default:
		sprite_index = spr_cleaner_dog_idle;
		break;
}