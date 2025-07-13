var max_digits = 7;
var length = string_length(string(score_value));
var new_val = (max_digits-length)*"0" + string(score_value);

draw_set_font(font_Large);
draw_set_color(c_black);
draw_text(x, y, new_val);
