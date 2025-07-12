var accel = 0.2;
var max_speed = 5;
var frict = 0.06;
var wasPressingV = false;
var wasPressingH = false;

var pressingV = keyboard_check(vk_up) || keyboard_check(vk_down);
var pressingH = keyboard_check(vk_left) || keyboard_check(vk_right);

if (!trick_cooldown && state == "idle" && keyboard_check(ord("E"))) {
	state = "in_trick";
	trick_cooldown = true;
}

if (state == "idle" && keyboard_check(vk_space)) {
	state = "in_jump";
}

if (keyboard_check(vk_up) && state == "idle") {
    vspeed -= accel;
    if (vspeed < -max_speed) vspeed = -max_speed;
} else if (keyboard_check(vk_down) && state == "idle") {
    vspeed += accel;
    if (vspeed > max_speed) vspeed = max_speed;
} else if (abs(vspeed) > 0 && wasPressingV && !pressingV) {
    vspeed = vspeed / 2;
}

if (keyboard_check(vk_left) && state == "idle") {
    hspeed -= accel;
    if (hspeed < -max_speed) hspeed = -max_speed;
} else if (keyboard_check(vk_right) && state == "idle") {
    hspeed += accel;
    if (hspeed > max_speed) hspeed = max_speed;
} else if (abs(hspeed) > 0 && wasPressingH && !pressingH) {
    hspeed = hspeed / 2;
}

wasPressingV = pressingV;
wasPressingH = pressingH;

var dir_speed = sqrt(power(hspeed, 2) + power(vspeed, 2));
if (!keyboard_check(vk_left) && !keyboard_check(vk_right) && !keyboard_check(vk_up) && !keyboard_check(vk_down)) {
    image_speed = 0;
} else if (dir_speed < 2.5) {
    image_speed = 0.5;
} else {
    image_speed = 1;
}

if (x <= global.play_left || x + sprite_width >= global.play_right) {
    x = clamp(x, global.play_left, global.play_right - sprite_width);
	hspeed = -(hspeed / 2);
}

if (y <= global.play_top || y + sprite_height >= global.play_bottom) {
    y = clamp(y, global.play_top, global.play_bottom - sprite_height);
	vspeed = -(vspeed / 2);
}

if ((x <= global.play_left || x + sprite_width >= global.play_right) ||
	(y <= global.play_top || y + sprite_height >= (global.play_bottom))) {
	obj_Game_Controller.handle_score_event("bd_wall_collision");
	invuln = true;
}

if (invuln && !alarm[0]) {
	alarm[0] = game_get_speed(gamespeed_fps) * 1.5;
}

if (invuln) {
    invuln_flash += 1;
    
    // Flash every few frames
    if (invuln_flash mod 8 < 4) {
        image_alpha = 0.5;
    } else {
        image_alpha = 1.0;
    }
} else {
    image_alpha = 1.0;
}

if (state == "in_trick" && !alarm[1]) {
	alarm[1] = game_get_speed(gamespeed_fps);
}

if (state == "in_jump" && !alarm[2]) {
	alarm[2] = game_get_speed(gamespeed_fps) * 0.35;
}
