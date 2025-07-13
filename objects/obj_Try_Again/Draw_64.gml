if (global.restarting) {
    draw_set_alpha(global.restart_fade_alpha);
    draw_set_color(c_white);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}