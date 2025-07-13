// Player collision detection
if (place_meeting(x, y, obj_Player) && !obj_Player.is_player_invuln && obj_Player.state != PlayerState.JUMP) {
    obj_Game_Controller.handle_score_event("bd_cleaner_collision");
    obj_Player.state = PlayerState.HIT;
} else if (place_meeting(x, y, obj_Player) && !obj_Player.is_player_invuln && !given_jump_bonus) {
    given_jump_bonus = true;
    obj_Game_Controller.handle_score_event("gd_dodge_success");
}