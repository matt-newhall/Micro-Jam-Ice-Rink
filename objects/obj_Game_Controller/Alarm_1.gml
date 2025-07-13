var rnd_x = random_range(0, 1);
var rnd_y = random_range(0, 1);
var rnd_top_bottom = random_range(0, 1);

var x_pos;
var y_pos;
var pos;

if (rnd_x > 0.5) {
	x_pos = global.play_right-50;
} else {
	x_pos = global.play_left;
}

if (rnd_y > 0.5) {
	y_pos = global.play_top;
} else {
	y_pos = global.play_bottom-70;
}

if (rnd_top_bottom > 0.5) {
	pos = random_range(global.play_top, global.play_bottom-70);
	instance_create_layer(x_pos, pos, layer, obj_Rabbid_Fan);
} else {
	pos = random_range(global.play_left, global.play_right-50);
	instance_create_layer(pos, y_pos, layer, obj_Rabbid_Fan);
}

var amount = 0;
if (score_value >= 1000) {
	amount = game_get_speed(gamespeed_fps) * 3
} else if (score_value >= 250) {
	amount = game_get_speed(gamespeed_fps) * 5;
} else if (score_value >= 50) {
	amount = game_get_speed(gamespeed_fps) * 10;
}

alarm[1] = amount;
