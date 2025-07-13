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

if (score_value >= 1500 && !is_first_tonya_spawned && !alarm[4]) {
	is_first_tonya_spawned = true;
	alarm[4] = game_get_speed(gamespeed_fps) * 0.05;
}

if (score_value >= 3000 && !is_second_tonya_spawned && !alarm[5]) {
	is_second_tonya_spawned = true;
	alarm[5] = game_get_speed(gamespeed_fps) * 0.05;
}


if (score_value >= 100 && !spotlight_triggered) {
    spotlight_triggered = true;

    var location_index = irandom(3);
    var spawn_x = spotlight_locations[location_index].x;
    var spawn_y = spotlight_locations[location_index].y;

    instance_create_layer(spawn_x, spawn_y, layer, obj_Spotlight);
}
