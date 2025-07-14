if (state == PlayerState.TRICK) {
	state = PlayerState.NORMAL;
	if (obj_Game_Controller.is_trick_spotlight_bonus) {
		obj_Game_Controller.handle_rose_creation(3);
	} else {
		obj_Game_Controller.handle_rose_creation(1);
	}
	obj_Game_Controller.handle_score_event("gd_trick_success");
}

if (state == PlayerState.SPECIAL) {
	state = PlayerState.NORMAL;
	if (obj_Game_Controller.is_trick_spotlight_bonus) {
		obj_Game_Controller.handle_rose_creation(10);
	} else {
		obj_Game_Controller.handle_rose_creation(5);
	}
	obj_Game_Controller.handle_score_event("gd_special_success");
}