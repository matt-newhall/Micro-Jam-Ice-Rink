alarm[0] = game_get_speed(gamespeed_fps);

score_value = 0;
meter_value = 100;

randomise()

audio_play_sound(snd_Theme, 100, true);
audio_play_sound(snd_Game_start, 100, false);

function add_score(points) {
    score_value += points;
}

function change_meter(amount) {
    meter_value += amount;
    meter_value = clamp(meter_value, 0, 200);
}

function handle_rose_creation(amount) {
    var min_distance = 80;
    
    repeat(amount) {
        var attempts = 0;
        var valid_position = false;
        var x_pos, y_pos;
        
        while (!valid_position && attempts < 50) {
            x_pos = random_range(global.play_left+40, global.play_right-40);
            y_pos = random_range(global.play_bottom-40, global.play_top+40);
            
            var nearest_rose = instance_nearest(x_pos, y_pos, obj_Rose);
            if (nearest_rose == noone || point_distance(x_pos, y_pos, nearest_rose.x, nearest_rose.y) >= min_distance) {
                valid_position = true;
            }
            attempts++;
        }
        
        instance_create_layer(x_pos, y_pos, layer, obj_Rose);
    }
}

function handle_score_event(event_type) {
	amount = 0;
    switch(event_type) {
        case "gd_trick_success":
			var mul = 1;
			if (is_trick_spotlight_bonus) {
				mul = 2;
				is_trick_spotlight_bonus = false;
				audio_play_sound(snd_Trick_Spotlight_Cheer, 100, false);
			} else {
				audio_play_sound(snd_Trick_Cheer, 100, false);
			}
			amount = 25 * mul;
            break;
        case "gd_rose_collision":
			amount = 10;
            break;
        case "gd_special_success":
			if (is_trick_spotlight_bonus) {
				mul = 2;
				is_trick_spotlight_bonus = false;
				audio_play_sound(snd_Special_Spotlight_Cheer, 100, false);
			} else {
				audio_play_sound(snd_Special_Cheer, 100, false);
			}
			amount = 50;
            break;
		case "gd_dodge_success":
			audio_play_sound(snd_Dodge_Success, 100, false);
			amount = 10;
			break;
		case "bd_time_decrement":
			amount = -1;
			break;
		case "bd_wall_collision":
			amount = -15;
			break;
		case "bd_construction_collision":
			if (!obj_Player.is_player_invuln && obj_Player.state != PlayerState.JUMP) {
				obj_Player.state = PlayerState.HIT;
				amount = -15;
			}
			break;
		case "bd_fan_collision":
			if (!obj_Player.is_player_invuln && obj_Player.state != PlayerState.JUMP) {
				obj_Player.state = PlayerState.HIT
				amount = -20;
			}
			break;
		case "bd_cleaner_collision":
			if (!obj_Player.is_player_invuln && obj_Player.state != PlayerState.JUMP) {
				obj_Player.state = PlayerState.HIT;
				amount = -30;
			}
			break;
		case "bd_tonya_collision":
			if (!obj_Player.is_player_invuln && obj_Player.state != PlayerState.JUMP) {
				obj_Player.state = PlayerState.HIT;
				amount = -50;
			}
			break;
    }

	change_meter(amount)
	if (amount > 0) {
		obj_Emoji_Yay.start_popup();
		add_score(amount)
	} else if (amount < 0 && event_type != "bd_time_decrement") {
		obj_Emoji_Nay.start_popup();
	}
}

function reset_spotlight_system() {
    alarm[3] = game_get_speed(gamespeed_fps) * (8 + random(10));
}

function reset_special_system() {
	alarm[8] = game_get_speed(gamespeed_fps) * (10 + random(15));
}

var play_width = 1290;
var play_height = 945;

global.play_left = 383;
global.play_top = 112;
global.play_right = global.play_left + play_width;
global.play_bottom = global.play_top + play_height;

is_initial_fan_spawned = false;
spotlight_triggered = false;
is_trick_spotlight_bonus = false;
is_first_tonya_spawned = false;
is_second_tonya_spawned = false;

special_triggered = false;



var arena_width = global.play_right - global.play_left;
var arena_height = global.play_bottom - global.play_top;
var center_x = global.play_left + (arena_width / 2);
var center_y = global.play_top + (arena_height / 2);

var padding = 100;
var quarter_x = (arena_width - padding * 2) / 4;
var quarter_y = (arena_height - padding * 2) / 4;

spotlight_locations = [
    {x: global.play_left + padding + quarter_x, y: global.play_top + padding + quarter_y},
    {x: global.play_left + padding + quarter_x * 3, y: global.play_top + padding + quarter_y},
    {x: global.play_left + padding + quarter_x, y: global.play_top + padding + quarter_y * 3},
    {x: global.play_left + padding + quarter_x * 3, y: global.play_top + padding + quarter_y * 3}
];

game_over = false;
game_over_timer = 0;
fade_alpha = 0;
fade_started = false;
fade_timer = 0;
music_volume = 1;
music_fade_speed = 0.01;

has_fan_increase_1_played = false;
has_fan_increase_2_played = false;
