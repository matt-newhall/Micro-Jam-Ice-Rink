alarm[0] = game_get_speed(gamespeed_fps) * 4;

audio_play_sound(snd_Spotlight, 100, false);

image_alpha = 0.5;

function close_spotlight() {   
    obj_Game_Controller.reset_spotlight_system();
    instance_destroy();
}
