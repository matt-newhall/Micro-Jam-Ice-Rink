var max_digits = 7;
var length = string_length(string(score_value));
var new_val = (max_digits-length)*"0" + string(score_value);

draw_set_font(font_Large);
draw_set_color(c_black);
draw_text(x, y, new_val);

// Draw fade overlay
if (game_over && fade_started) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
