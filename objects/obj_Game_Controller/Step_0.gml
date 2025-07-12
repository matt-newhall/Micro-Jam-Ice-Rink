// TODO: check game end state

if (!alarm[1]) {
	if (score_value >= 2000) {
		alarm[1] = game_get_speed(gamespeed_fps) * 3;
	} else if (score_value >= 500) {
		alarm[1] = game_get_speed(gamespeed_fps) * 5;
	} else if (score_value >= 0) {
		alarm[1] = game_get_speed(gamespeed_fps) * 10;
	}
}

if (obj_Player.trick_cooldown && obj_Player.state == "idle" && !alarm[2]) {
	alarm[2] = game_get_speed(gamespeed_fps) * 3;
}
