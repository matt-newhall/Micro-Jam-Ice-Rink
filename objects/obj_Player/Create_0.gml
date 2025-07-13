// Constants for player movement
accel = 0.2;
max_speed = 5;
frict = 0.06;


// Generic Player State
enum PlayerState {
    NORMAL,
    HAS_ROSE,
	JUMP,
	TRICK,
	HIT
}

state = PlayerState.NORMAL;

is_player_idle = true;
is_player_actionable = true;

is_player_invuln = false;
invuln_flash = 0;

trick_cooldown = false;
