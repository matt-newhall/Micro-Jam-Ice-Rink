global.restarting = false;
global.restart_fade_alpha = 0;
global.restart_fade_timer = 0;
global.restart_phase = "none";

function restart_game() {
	audio_stop_sound(snd_Menu);
    global.restarting = true;
    global.restart_fade_alpha = 0;
    global.restart_fade_timer = 30;
    global.restart_phase = "fade_out";
}
