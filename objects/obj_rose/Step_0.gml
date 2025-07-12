if (place_meeting(x, y, obj_Player)) {
	obj_Game_Controller.handle_score_event("gd_rose_collision");
	instance_destroy();
}