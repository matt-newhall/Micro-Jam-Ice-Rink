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
    var min_distance = 80; // Adjust this value for spacing
    
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
			}
			amount = 25 * mul;
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
	
	// TODO: add spotlight (*2 score)
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

var play_width = 1290;
var play_height = 945;

global.play_left = 383;
global.play_top = 112;
global.play_right = global.play_left + play_width;
global.play_bottom = global.play_top + play_height;

is_initial_fan_spawned = false;
spotlight_triggered = false;
is_trick_spotlight_bonus = false;



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
