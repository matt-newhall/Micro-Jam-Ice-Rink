var fill_percentage = clamp(obj_Game_Controller.meter_value / 200, 0, 1);
var visible_width = sprite_width * fill_percentage;

// Draw thick border using filled rectangles
var spr_height = 0.55*sprite_get_height(spr_Audience_Meter_Bar);
var border_radius = 8;
var border_thickness = 3;

draw_set_color(c_black);
// Outer border (filled)
draw_roundrect_ext(x - border_thickness, y - border_thickness, 
                  x + sprite_width + border_thickness, y + spr_height + border_thickness, 
                  border_radius, border_radius, false);
// Inner cutout (to create hollow effect)
draw_set_color($5a4451); // or whatever your background color is
draw_roundrect_ext(x, y, x + sprite_width, y + spr_height, 
                  border_radius, border_radius, false);

// Draw the cropped sprite from the left side
draw_sprite_part(spr_Audience_Meter_Bar, 1, 0, 0, visible_width, 0.55*sprite_get_height(spr_Audience_Meter_Bar), x, y);
