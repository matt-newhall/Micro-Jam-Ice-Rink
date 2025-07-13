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

if (meter_value <= 0 && !game_over) {
    game_over = true;
	
	obj_Player.state = PlayerState.LOSS;

    instance_deactivate_all(true);
    instance_activate_object(object_index);
    instance_activate_object(obj_Player);

    instance_activate_object(obj_Audience_Left);
	instance_activate_object(obj_Audience_Top);
	instance_activate_object(obj_Judges);

    instance_activate_object(obj_Audience_Meter);
	instance_activate_object(obj_Audience_Meter_Bar);

	instance_activate_object(obj_Text_Score);
	instance_activate_object(obj_Text_Hype);
	
    
    game_over_timer = 120;
    fade_alpha = 0;
    fade_started = false;
}

if (game_over) {
    game_over_timer--;
	
	if (music_volume > 0) {
        music_volume -= music_fade_speed;
        music_volume = max(0, music_volume);
        audio_sound_gain(snd_Theme, music_volume, 0);
    } else {
		audio_stop_sound(snd_Theme)
	}
    
    if (game_over_timer <= 0 && !fade_started) {
        fade_started = true;
        fade_timer = 60;
    }

    if (fade_started) {
        fade_alpha = min(1, fade_alpha + (1/60));
        fade_timer--;
        
        if (fade_timer <= 0) {
            room_goto(rm_Game_Over);
        }
    }
}
