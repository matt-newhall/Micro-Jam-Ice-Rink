// TODO: check game end state

// Rabbid Fan Spawns
if (score_value >= 50 && !is_initial_fan_spawned) {
	is_initial_fan_spawned = true;
	alarm[1] = game_get_speed(gamespeed_fps) * 0.05
}

// Trick cooldown
if (obj_Player.trick_cooldown && obj_Player.is_player_idle && !alarm[2]) {
	alarm[2] = game_get_speed(gamespeed_fps) * 3;
}
