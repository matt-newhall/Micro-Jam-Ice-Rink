if (state == "in_trick") {
	state = "idle";
	obj_Game_Controller.handle_score_event("gd_trick_success");
	obj_Game_Controller.handle_rose_creation(1);
}