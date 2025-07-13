if (keyboard_check(vk_space) || keyboard_check(ord("E"))) {
	restart_game();
}

if (global.restarting) {
    switch(global.restart_phase) {
        case "fade_out":
            global.restart_fade_alpha += 1/30;
            global.restart_fade_timer--;
            
            if (global.restart_fade_timer <= 0) {
                room_goto(Room1);
				audio_sound_gain(snd_Theme, 1, 0);
                global.restart_phase = "fade_in";
                global.restart_fade_timer = 30;
            }
            break;
            
        case "fade_in":
            global.restart_fade_alpha -= 1/30;
            global.restart_fade_timer--;
            
            if (global.restart_fade_timer <= 0) {
                global.restart_fade_alpha = 0;
                global.restarting = false;
                global.restart_phase = "none";
            }
            break;
    }
}