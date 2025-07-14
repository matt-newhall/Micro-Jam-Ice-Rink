alarm[0] = game_get_speed(gamespeed_fps) * 4;

image_alpha = 0.7;

function close_special() {   
    obj_Game_Controller.reset_special_system();
    instance_destroy();
}
