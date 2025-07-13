var move_speed = 5;

var dir_to_player = point_direction(current_x, current_y, target_x, target_y);

if (moving) {
    x += lengthdir_x(move_speed, dir_to_player);
    y += lengthdir_y(move_speed, dir_to_player);
}

if (x < global.play_left || x + sprite_width > global.play_right) {
	instance_destroy();
}

if (y < global.play_top || y + sprite_height > global.play_bottom) {
    instance_destroy();
}


if (place_meeting(x, y, obj_Player) && !obj_Player.is_player_invuln && obj_Player.state != PlayerState.JUMP) {
	obj_Game_Controller.handle_score_event("bd_fan_collision");
	obj_Player.state = PlayerState.HIT;
} else if (place_meeting(x, y, obj_Player) && !obj_Player.is_player_invuln && !given_jump_bonus) {
	given_jump_bonus = true;
	obj_Game_Controller.handle_score_event("gd_dodge_success");
}
