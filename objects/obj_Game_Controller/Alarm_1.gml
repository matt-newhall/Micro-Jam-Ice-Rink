var rnd_x = random_range(0, 1);
var rnd_y = random_range(0, 1);
var rnd_top_bottom = random_range(0, 1);

if (rnd_x > 0.5) {
	x_pos = global.play_right-100;
} else {
	x_pos = global.play_left;
}

if (rnd_y > 0.5) {
	y_pos = global.play_top;
} else {
	y_pos = global.play_bottom-100;
}

if (rnd_top_bottom > 0.5) {
	pos = random_range(global.play_top, global.play_bottom-100);
	instance_create_layer(x_pos, pos, layer, obj_Rabbid_Fan);
} else {
	pos = random_range(global.play_left, global.play_right-100);
	instance_create_layer(pos, y_pos, layer, obj_Rabbid_Fan);
}