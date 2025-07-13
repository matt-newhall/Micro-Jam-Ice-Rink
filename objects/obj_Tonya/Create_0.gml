enum TonyaState {
	IDLE,
	PREPARING,
	SKATING,
	ANGRY
}

path_history = ds_list_create();
if (obj_Game_Controller.score_value < 2000) {
	follow_delay = 120;
} else {
	follow_delay = 240;
}

state = TonyaState.PREPARING;

// Movement variables
move_speed = 1;
preparation_target_x = room_width - 50;
preparation_target_y = 50;

// Smooth transition variables
transition_timer = 0;
transition_duration = 60;

// Anger state variables
anger_timer = 0;
anger_duration = 120;
frozen_x = x;
frozen_y = y;
catch_up_speed = 4;
normal_follow_speed = 1;

given_jump_bonus = false;
