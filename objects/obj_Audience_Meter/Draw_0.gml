var inner_width = 200;
var inner_height = 50;
var fill_percentage = clamp(obj_Game_Controller.meter_value / 200, 0, 1);
var green_width = inner_width * fill_percentage;

draw_set_color(c_green);
draw_roundrect_ext(x + 4, y + 3, x + 6 + green_width, y + 44, 25, 25, false);

draw_set_color(c_red);
draw_roundrect_ext(x + 4 + green_width, y + 3, x + 185, y + 44, 25, 25, false);

draw_self();