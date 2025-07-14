if (place_meeting(x, y, obj_Player)) {
    if (obj_Player.state == PlayerState.TRICK) {
		if (obj_Player.image_index >= 16) {
			obj_Game_Controller.is_trick_spotlight_bonus = true;
	        close_spotlight();
		}
    }
	
	if (obj_Player.state == PlayerState.SPECIAL) {
		obj_Game_Controller.is_trick_spotlight_bonus = true;
	    close_spotlight();
    }
}