var fill_percentage;

if (obj_Player.state == "in_trick") {
    fill_percentage = 0;
} else if (obj_Player.trick_cooldown) {
    var total_cooldown_time = game_get_speed(gamespeed_fps) * 3;
    var elapsed_time = total_cooldown_time - obj_Game_Controller.alarm[2];
    fill_percentage = clamp(elapsed_time / total_cooldown_time, 0, 1);
} else {
    fill_percentage = 1;
}

var draw_x = x;
var draw_y = y;

draw_sprite(spr_boot_black, 0, draw_x, draw_y);

if (fill_percentage > 0) {
    var boot_width = sprite_get_width(spr_boot_filled);
    var boot_height = sprite_get_height(spr_boot_filled);
    var fill_width = boot_width * fill_percentage;
    
    draw_sprite_part(spr_boot_filled, 0, 0, 0, fill_width, boot_height, draw_x, draw_y);
}