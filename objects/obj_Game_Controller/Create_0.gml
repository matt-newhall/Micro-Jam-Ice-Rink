alarm[0] = game_get_speed(gamespeed_fps);

score_value = 0;
meter_value = 100;

randomise()

function add_score(points) {
    score_value += points;
}

function change_meter(amount) {
    meter_value += amount;
    meter_value = clamp(meter_value, 0, 200);
}

function handle_rose_creation(amount) {
	var y_pos = random_range(global.play_bottom-20, global.play_top+20)
	var x_pos = random_range(global.play_left+20, global.play_right-20)

	instance_create_layer(x_pos, y_pos, layer, obj_Rose);
}

function handle_score_event(event_type) {
	amount = 0;
    switch(event_type) {
        case "gd_trick_success":
			amount = 25;
            break;
        case "gd_rose_collision":
			amount = 10;
            break;
        case "gd_special_success":
			amount = 50;
            break;
		case "gd_dodge_success":
			amount = 10;
			break;
		case "bd_time_decrement":
			amount = -5;
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
	
	// TODO: add spotlight (*2 score)
	change_meter(amount)
	if (amount > 0) {
		obj_Emoji_Yay.start_popup();
		add_score(amount)
	} else if (amount < 0 && event_type != "bd_time_decrement") {
		obj_Emoji_Nay.start_popup();
	}
}

var play_width = 1290;
var play_height = 945;

global.play_left = 383;
global.play_top = 112;
global.play_right = global.play_left + play_width;
global.play_bottom = global.play_top + play_height;

is_initial_fan_spawned = false;
