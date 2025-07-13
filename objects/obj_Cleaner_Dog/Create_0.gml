// Generic Cleaner State
enum CleanerState {
    INACTIVE,
	SPAWNING,
	IDLE,
	MOVING,
	CLEANING
}

state = CleanerState.INACTIVE;
given_jump_bonus = false;

target_x = x;
target_y = y;
