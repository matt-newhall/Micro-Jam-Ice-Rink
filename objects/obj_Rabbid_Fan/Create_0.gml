alarm[0] = game_get_speed(gamespeed_fps) * 2;
moving = false;

current_x = 0;
target_x = 0;
current_y = 0;
target_y = 0;

if (!obj_Game_Controller.game_over) {
	audio_play_sound(snd_Fan_Enters, 100, false);
}

given_jump_bonus = false;

image_speed = 0;

invuln_flash = 0;
